add_library (libpython ../main.c)

target_include_directories (libpython PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
