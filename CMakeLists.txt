cmake_minimum_required(VERSION 3.22)

set(VCPKG_ROOT "vcpkg")
set(CMAKE_TOOLCHAIN_FILE "${VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake" CACHE STRING "")

project(example VERSION 0.0.1)

add_executable(${CMAKE_PROJECT_NAME} main.cpp foo_library.cpp)
target_compile_features(${CMAKE_PROJECT_NAME} PRIVATE cxx_std_17)
target_compile_options(${CMAKE_PROJECT_NAME} PRIVATE -Wno-deprecated-declarations)

find_package(opentelemetry-cpp CONFIG REQUIRED)
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE 
	opentelemetry-cpp::api
	opentelemetry-cpp::common
	opentelemetry-cpp::ext
	opentelemetry-cpp::http_client_curl
	opentelemetry-cpp::in_memory_span_exporter
	opentelemetry-cpp::ostream_log_record_exporter
	opentelemetry-cpp::ostream_metrics_exporter
	opentelemetry-cpp::ostream_span_exporter
	opentelemetry-cpp::otlp_grpc_exporter
	opentelemetry-cpp::otlp_http_client
	opentelemetry-cpp::otlp_http_exporter
	opentelemetry-cpp::otlp_http_log_record_exporter
	opentelemetry-cpp::otlp_http_metric_exporter
	opentelemetry-cpp::otlp_recordable
	opentelemetry-cpp::proto
	opentelemetry-cpp::resources
	opentelemetry-cpp::sdk
	opentelemetry-cpp::trace
	opentelemetry-cpp::version
)

# find_package(Protobuf CONFIG REQUIRED) # doesn't link
find_package(Protobuf CONFIG REQUIRED) # links
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE protobuf::libprotobuf)

find_package(gRPC CONFIG REQUIRED)
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE gRPC::grpc++)

find_package(nlohmann_json CONFIG REQUIRED)
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE nlohmann_json::nlohmann_json)

find_package(CURL REQUIRED)
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE CURL::libcurl)
