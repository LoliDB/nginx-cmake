include(FetchContent)

FetchContent_Declare(
  nginx
  GIT_REPOSITORY https://github.com/nginx/nginx.git
  GIT_TAG        stable-1.26
  SOURCE_DIR     ${CMAKE_SOURCE_DIR}/nginx
)
FetchContent_MakeAvailable(nginx)


FetchContent_Declare(
  zlib
  GIT_REPOSITORY https://github.com/madler/zlib.git
  GIT_TAG        v1.3.1
  SOURCE_DIR     ${CMAKE_SOURCE_DIR}/zlib
)
FetchContent_MakeAvailable(zlib)


# FetchContent_Declare(
#   openssl
#   GIT_REPOSITORY https://github.com/openssl/openssl.git
#   GIT_TAG        openssl-3.4.0
#   SOURCE_DIR     ${CMAKE_SOURCE_DIR}/openssl
# )
# FetchContent_MakeAvailable(openssl)


FetchContent_Declare(
  pcre
  GIT_REPOSITORY https://github.com/luvit/pcre.git
  SOURCE_DIR     ${CMAKE_SOURCE_DIR}/pcre
)
FetchContent_MakeAvailable(pcre)