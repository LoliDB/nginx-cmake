

### 说明

nginx-cmake是用于在windows平台下调试(构建)nginx的一个工程，无需复杂的依赖安装处理和相关三方库配置，
直接使用cmake构建工程，进行调试即可。

整个工程cmake脚本构建来源对nginx库在Windows下编译中生成Makefile的翻译。

### 构建流程

目前支持平台:
- windows vs2019 x64

构建生成Makefile的配置(nginx模块)如下:

```shell
auto/configure \
  --with-cc=cl \
  --prefix= \
  --conf-path=conf/nginx.conf \
  --pid-path=logs/nginx.pid \
  --http-log-path=logs/access.log \
  --error-log-path=logs/error.log \
  --sbin-path=nginx.exe \
  --http-client-body-temp-path=temp/client_body_temp \
  --http-proxy-temp-path=temp/proxy_temp \
  --http-fastcgi-temp-path=temp/fastcgi_temp \
  --http-scgi-temp-path=temp/scgi_temp \
  --http-uwsgi-temp-path=temp/uwsgi_temp \
  --with-cc-opt=-DFD_SETSIZE=1024 \
  --with-http_ssl_module \
  --with-http_v2_module \
  --with-http_realip_module \
  --with-http_addition_module \
  --with-http_sub_module \
  --with-http_stub_status_module \
  --with-http_dav_module \
  --with-http_flv_module \
  --with-http_mp4_module \
  --with-http_gunzip_module \
  --with-http_gzip_static_module \
  --with-http_auth_request_module \
  --with-http_random_index_module \
  --with-http_secure_link_module \
  --with-http_slice_module \
  --with-mail \
  --with-mail_ssl_module \
  --with-stream \
  --with-stream_ssl_module \
  --with-stream_ssl_preread_module
```

相关依赖的库如下：

- [nginx](https://github.com/nginx/nginx.git): tag stable-1.26
- [pcre](https://github.com/luvit/pcre.git)-8.45: 使用了Github的镜像库，cmake自动处理
- [zlib](https://github.com/madler/zlib.git)-1.3.1: zlib Github库，cmake自动处理
- [openssl](https://github.com/openssl/openssl.git)-3.4: 使用了本人之前编译好的版本(vs2019x64)

**直接使用cmake构建**，会自动创建nginx临时(日志)文件夹。调试直接**修改配置文件**，
并在解决方案启动`nginx`即可。

*(注意，仅仅在vs2019下完成测试)*
