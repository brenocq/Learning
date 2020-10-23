add_library(
	maths
	math/sum.h
	math/sum.cpp)

# Same as -I
target_include_directories(maths PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/math")
