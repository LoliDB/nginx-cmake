cmake_minimum_required(VERSION 3.17)

project(nginx-cmake LANGUAGES C)

list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")

include(fetch_repos)
include(auto_group_files)

set_property(GLOBAL PROPERTY USE_FOLDERS ON)

# from makefile
include_directories(
	${CMAKE_CURRENT_SOURCE_DIR}
	nginx/src/core
	nginx/src/event
	nginx/src/event/modules
	nginx/src/event/quic
	nginx/src/os/win32
	pcre
	openssl-3.4/include
	zlib
	nginx/src/http
	nginx/src/http/modules
	nginx/src/http/v2
	nginx/src/mail
	nginx/src/stream
	${pcre_BINARY_DIR}
	${zlib_BINARY_DIR}
)

file(GLOB_RECURSE nginx_HEADERS "nginx/*.h")

set(nginx_SOURCES
    nginx/src/core/nginx.c 
	nginx/src/core/ngx_log.c 
	nginx/src/core/ngx_palloc.c 
	nginx/src/core/ngx_array.c 
	nginx/src/core/ngx_list.c 
	nginx/src/core/ngx_hash.c 
	nginx/src/core/ngx_buf.c 
	nginx/src/core/ngx_queue.c 
	nginx/src/core/ngx_output_chain.c 
	nginx/src/core/ngx_string.c 
	nginx/src/core/ngx_parse.c 
	nginx/src/core/ngx_parse_time.c 
	nginx/src/core/ngx_inet.c 
	nginx/src/core/ngx_file.c 
	nginx/src/core/ngx_crc32.c 
	nginx/src/core/ngx_murmurhash.c 
	nginx/src/core/ngx_md5.c 
	nginx/src/core/ngx_sha1.c 
	nginx/src/core/ngx_rbtree.c 
	nginx/src/core/ngx_radix_tree.c 
	nginx/src/core/ngx_slab.c 
	nginx/src/core/ngx_times.c 
	nginx/src/core/ngx_shmtx.c 
	nginx/src/core/ngx_connection.c 
	nginx/src/core/ngx_cycle.c 
	nginx/src/core/ngx_spinlock.c 
	nginx/src/core/ngx_rwlock.c 
	nginx/src/core/ngx_cpuinfo.c 
	nginx/src/core/ngx_conf_file.c 
	nginx/src/core/ngx_module.c 
	nginx/src/core/ngx_resolver.c 
	nginx/src/core/ngx_open_file_cache.c 
	nginx/src/core/ngx_crypt.c 
	nginx/src/core/ngx_proxy_protocol.c 
	nginx/src/core/ngx_syslog.c 
	nginx/src/event/ngx_event.c 
	nginx/src/event/ngx_event_timer.c 
	nginx/src/event/ngx_event_posted.c 
	nginx/src/event/ngx_event_accept.c 
	nginx/src/event/ngx_event_udp.c 
	nginx/src/event/ngx_event_connect.c 
	nginx/src/event/ngx_event_pipe.c 
	nginx/src/os/win32/ngx_errno.c 
	nginx/src/os/win32/ngx_alloc.c 
	nginx/src/os/win32/ngx_files.c 
	nginx/src/os/win32/ngx_shmem.c 
	nginx/src/os/win32/ngx_time.c 
	nginx/src/os/win32/ngx_process.c 
	nginx/src/os/win32/ngx_thread.c 
	nginx/src/os/win32/ngx_socket.c 
	nginx/src/os/win32/ngx_wsarecv.c 
	nginx/src/os/win32/ngx_wsarecv_chain.c 
	nginx/src/os/win32/ngx_udp_wsarecv.c 
	nginx/src/os/win32/ngx_wsasend.c 
	nginx/src/os/win32/ngx_wsasend_chain.c 
	nginx/src/os/win32/ngx_win32_init.c 
	nginx/src/os/win32/ngx_user.c 
	nginx/src/os/win32/ngx_dlopen.c 
	nginx/src/os/win32/ngx_event_log.c 
	nginx/src/os/win32/ngx_process_cycle.c 
	nginx/src/event/ngx_event_acceptex.c 
	nginx/src/event/modules/ngx_iocp_module.c 
	nginx/src/event/modules/ngx_win32_select_module.c 
	nginx/src/event/modules/ngx_win32_poll_module.c 
	nginx/src/event/ngx_event_openssl.c 
	nginx/src/event/ngx_event_openssl_stapling.c 
	nginx/src/core/ngx_regex.c 
	nginx/src/http/ngx_http.c 
	nginx/src/http/ngx_http_core_module.c 
	nginx/src/http/ngx_http_special_response.c 
	nginx/src/http/ngx_http_request.c 
	nginx/src/http/ngx_http_parse.c 
	nginx/src/http/modules/ngx_http_log_module.c 
	nginx/src/http/ngx_http_request_body.c 
	nginx/src/http/ngx_http_variables.c 
	nginx/src/http/ngx_http_script.c 
	nginx/src/http/ngx_http_upstream.c 
	nginx/src/http/ngx_http_upstream_round_robin.c 
	nginx/src/http/ngx_http_file_cache.c 
	nginx/src/http/ngx_http_huff_decode.c 
	nginx/src/http/ngx_http_huff_encode.c 
	nginx/src/http/ngx_http_write_filter_module.c 
	nginx/src/http/ngx_http_header_filter_module.c 
	nginx/src/http/modules/ngx_http_chunked_filter_module.c 
	nginx/src/http/v2/ngx_http_v2_filter_module.c 
	nginx/src/http/modules/ngx_http_range_filter_module.c 
	nginx/src/http/modules/ngx_http_gzip_filter_module.c 
	nginx/src/http/ngx_http_postpone_filter_module.c 
	nginx/src/http/modules/ngx_http_ssi_filter_module.c 
	nginx/src/http/modules/ngx_http_charset_filter_module.c 
	nginx/src/http/modules/ngx_http_sub_filter_module.c 
	nginx/src/http/modules/ngx_http_addition_filter_module.c 
	nginx/src/http/modules/ngx_http_gunzip_filter_module.c 
	nginx/src/http/modules/ngx_http_userid_filter_module.c 
	nginx/src/http/modules/ngx_http_headers_filter_module.c 
	nginx/src/http/ngx_http_copy_filter_module.c 
	nginx/src/http/modules/ngx_http_not_modified_filter_module.c 
	nginx/src/http/modules/ngx_http_slice_filter_module.c 
	nginx/src/http/v2/ngx_http_v2.c 
	nginx/src/http/v2/ngx_http_v2_table.c 
	nginx/src/http/v2/ngx_http_v2_encode.c 
	nginx/src/http/v2/ngx_http_v2_module.c 
	nginx/src/http/modules/ngx_http_static_module.c 
	nginx/src/http/modules/ngx_http_gzip_static_module.c 
	nginx/src/http/modules/ngx_http_dav_module.c 
	nginx/src/http/modules/ngx_http_autoindex_module.c 
	nginx/src/http/modules/ngx_http_index_module.c 
	nginx/src/http/modules/ngx_http_random_index_module.c 
	nginx/src/http/modules/ngx_http_mirror_module.c 
	nginx/src/http/modules/ngx_http_try_files_module.c 
	nginx/src/http/modules/ngx_http_auth_request_module.c 
	nginx/src/http/modules/ngx_http_auth_basic_module.c 
	nginx/src/http/modules/ngx_http_access_module.c 
	nginx/src/http/modules/ngx_http_limit_conn_module.c 
	nginx/src/http/modules/ngx_http_limit_req_module.c 
	nginx/src/http/modules/ngx_http_realip_module.c 
	nginx/src/http/modules/ngx_http_geo_module.c 
	nginx/src/http/modules/ngx_http_map_module.c 
	nginx/src/http/modules/ngx_http_split_clients_module.c 
	nginx/src/http/modules/ngx_http_referer_module.c 
	nginx/src/http/modules/ngx_http_rewrite_module.c 
	nginx/src/http/modules/ngx_http_ssl_module.c 
	nginx/src/http/modules/ngx_http_proxy_module.c 
	nginx/src/http/modules/ngx_http_fastcgi_module.c 
	nginx/src/http/modules/ngx_http_uwsgi_module.c 
	nginx/src/http/modules/ngx_http_scgi_module.c 
	nginx/src/http/modules/ngx_http_grpc_module.c 
	nginx/src/http/modules/ngx_http_memcached_module.c 
	nginx/src/http/modules/ngx_http_empty_gif_module.c 
	nginx/src/http/modules/ngx_http_browser_module.c 
	nginx/src/http/modules/ngx_http_secure_link_module.c 
	nginx/src/http/modules/ngx_http_flv_module.c 
	nginx/src/http/modules/ngx_http_mp4_module.c 
	nginx/src/http/modules/ngx_http_upstream_hash_module.c 
	nginx/src/http/modules/ngx_http_upstream_ip_hash_module.c 
	nginx/src/http/modules/ngx_http_upstream_least_conn_module.c 
	nginx/src/http/modules/ngx_http_upstream_random_module.c 
	nginx/src/http/modules/ngx_http_upstream_keepalive_module.c 
	nginx/src/http/modules/ngx_http_upstream_zone_module.c 
	nginx/src/http/modules/ngx_http_stub_status_module.c 
	nginx/src/mail/ngx_mail.c 
	nginx/src/mail/ngx_mail_core_module.c 
	nginx/src/mail/ngx_mail_handler.c 
	nginx/src/mail/ngx_mail_parse.c 
	nginx/src/mail/ngx_mail_ssl_module.c 
	nginx/src/mail/ngx_mail_pop3_module.c 
	nginx/src/mail/ngx_mail_pop3_handler.c 
	nginx/src/mail/ngx_mail_imap_module.c 
	nginx/src/mail/ngx_mail_imap_handler.c 
	nginx/src/mail/ngx_mail_smtp_module.c 
	nginx/src/mail/ngx_mail_smtp_handler.c 
	nginx/src/mail/ngx_mail_auth_http_module.c 
	nginx/src/mail/ngx_mail_proxy_module.c 
	nginx/src/mail/ngx_mail_realip_module.c 
	nginx/src/stream/ngx_stream.c 
	nginx/src/stream/ngx_stream_variables.c 
	nginx/src/stream/ngx_stream_script.c 
	nginx/src/stream/ngx_stream_handler.c 
	nginx/src/stream/ngx_stream_core_module.c 
	nginx/src/stream/ngx_stream_log_module.c 
	nginx/src/stream/ngx_stream_proxy_module.c 
	nginx/src/stream/ngx_stream_upstream.c 
	nginx/src/stream/ngx_stream_upstream_round_robin.c 
	nginx/src/stream/ngx_stream_write_filter_module.c 
	nginx/src/stream/ngx_stream_ssl_module.c 
	nginx/src/stream/ngx_stream_limit_conn_module.c 
	nginx/src/stream/ngx_stream_access_module.c 
	nginx/src/stream/ngx_stream_geo_module.c 
	nginx/src/stream/ngx_stream_map_module.c 
	nginx/src/stream/ngx_stream_split_clients_module.c 
	nginx/src/stream/ngx_stream_return_module.c 
	nginx/src/stream/ngx_stream_pass_module.c 
	nginx/src/stream/ngx_stream_set_module.c 
	nginx/src/stream/ngx_stream_upstream_hash_module.c 
	nginx/src/stream/ngx_stream_upstream_least_conn_module.c 
	nginx/src/stream/ngx_stream_upstream_random_module.c 
	nginx/src/stream/ngx_stream_upstream_zone_module.c 
	nginx/src/stream/ngx_stream_ssl_preread_module.c
    ngx_modules.c
)

# 添加可执行文件 
add_executable(nginx 
    ${nginx_HEADERS} 
    ${nginx_SOURCES}
	nginx/conf/nginx.conf
) 

# # 添加配置文件
# add_custom_target(conf SOURCES nginx/conf/nginx.conf)
# source_group("conf" FILES nginx/conf/nginx.conf)

# 链接库
target_link_libraries(nginx
    PRIVATE
    kernel32.lib
    user32.lib
    advapi32.lib
    ws2_32.lib

    pcre
	${CMAKE_SOURCE_DIR}/openssl-3.4/lib/libssl.lib
	${CMAKE_SOURCE_DIR}/openssl-3.4/lib/libcrypto.lib 
	gdi32.lib 
	crypt32.lib 
	zlibstatic
	#objs/nginx.res 
)

# 调用自动化分组函数
AUTO_GROUP_FILES(
	TARGET nginx 
	BASE_DIR ${CMAKE_SOURCE_DIR}/nginx/src
	FILES ${nginx_HEADERS} ${nginx_SOURCES}
)

# 设置生成位置
set_target_properties(nginx PROPERTIES 
	RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/nginx
	RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_SOURCE_DIR}/nginx
	RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_SOURCE_DIR}/nginx
	RUNTIME_OUTPUT_DIRECTORY_RELWITHDEBINFO ${CMAKE_SOURCE_DIR}/nginx
	VS_DEBUGGER_WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/nginx
)

# 构建调试启动时需要的目录
set(check_directories
	${CMAKE_SOURCE_DIR}/nginx/logs
	${CMAKE_SOURCE_DIR}/nginx/temp/scgi_temp
	${CMAKE_SOURCE_DIR}/nginx/temp/proxy_temp
	${CMAKE_SOURCE_DIR}/nginx/temp/fastcgi_temp
	${CMAKE_SOURCE_DIR}/nginx/temp/client_body_temp
)
foreach(dir ${check_directories})
	if(NOT EXISTS ${dir})
		file(MAKE_DIRECTORY ${dir})
	endif()
endforeach()