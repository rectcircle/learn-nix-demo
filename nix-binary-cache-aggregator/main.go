package main

import (
	"io"
	"log"
	"net/http"
	"net/url"
	"os"
	"strings"
)

type upstream struct {
	URL      string
	UseProxy bool
}

func newHandle(httpProxy string, upstreams []upstream) (func(w http.ResponseWriter, r *http.Request), error) {
	client := http.DefaultClient
	proxyClient := http.DefaultClient
	if httpProxy != "" {
		httpProxyURL, err := url.Parse(httpProxy)
		if err != nil {
			return nil, err
		}
		proxyClient = &http.Client{Transport: &http.Transport{Proxy: http.ProxyURL(httpProxyURL)}}
	}

	return func(w http.ResponseWriter, r *http.Request) {
		// 打印访问日志
		log.Printf("path: %s", r.URL.Path)
		// TODO 优先从缓存中读取。
		// 尝试从 upstream 中获取
		var resp *http.Response
		for i, u := range upstreams {
			targetPath := strings.TrimSuffix(u.URL, "/") + r.URL.Path
			c := client
			if u.UseProxy {
				c = proxyClient
			}
			_resp, err := c.Get(targetPath)
			if err != nil {
				log.Printf("  try upstream[%d]: %s, error: %s", i, targetPath, err)
				continue
			}
			if _resp.StatusCode != 200 {
				log.Printf("  try upstream[%d]: %s, status code is: %d", i, targetPath, _resp.StatusCode)
				_resp.Body.Close()
				continue
			}
			log.Printf("  try upstream[%d]: %s, success", i, targetPath)
			resp = _resp
			break
		}
		if resp == nil {
			log.Printf("  all upstream not found")
			w.WriteHeader(404)
			return
		}
		defer resp.Body.Close()
		w.WriteHeader(resp.StatusCode)
		_, _ = io.Copy(w, resp.Body)
		// TODO 起一个协程写入缓存中。
	}, nil
}

func main() {
	upstreams := []upstream{
		{
			URL:      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store",
			UseProxy: false,
		},
		{
			URL:      "https://cache.nixos.org",
			UseProxy: true,
		},
	}
	httpProxy := os.Getenv("HTTP_PROXY")
	os.Unsetenv("HTTP_PROXY")
	handle, err := newHandle(httpProxy, upstreams)
	if err != nil {
		panic(err)
	}
	http.HandleFunc("/", handle)
	if err := http.ListenAndServe(":8000", nil); err != nil {
		panic(err)
	}
}
