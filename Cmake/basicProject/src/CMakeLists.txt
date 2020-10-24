add_library(
	maths
	math/sum.h
	$<IF:$<CONFIG:Debug>,math/sumDebug.cpp,math/sum.cpp>)

# Same as -I
target_include_directories(maths INTERFACE "${CMAKE_CURRENT_SOURCE_DIR}/math")

# Uncomment to define SUM_H -> error
#target_compile_definitions(maths PUBLIC SUM_H)

# Uncomment to show warnings
target_compile_options(maths PRIVATE "-std=c++11" $<$<CONFIG:Debug>:-Wall>)

# Add definition to all targets created in this directory
#add_compile_definitions(SUM_H) # Only 3.12
