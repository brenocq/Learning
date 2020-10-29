cmake_minimum_required(VERSION 3.4)

# set the project name
project(MyProject VERSION 0.0.0 LANGUAGES CXX)

# Define 11 as minimum
set(CMAKE_CXX_STANDARD			11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS		ON)

set(test oqu)
set(oque "hahaha")
message(STATUS "Wow, this project is very good, uhn? ${${test}e}")
message(STATUS "Using semantic versioning - https://semver.org/")
#message(STATUS "${CMAKE_CXX_COMPILE_FEATURES}")

# cmake -D myVar=test .
variable_watch(myVar)
set(myVar bar CACHE STRING "")
message(STATUS ${myVar})# First time: bar, subequent runs: foo (last value assigned)
message("Testing options")
set(myVar foo)

set(x 3)
set(y 7)
math(EXPR z "(${x}+${y})/2")
message("Result = ${z}")

# !! Something it is better to test the generator than the platform
if(UNIX)
	message(STATUS "Unix being used")
elseif(APPLE)
	message(STATUS "Apple being used")
elseif(WIN32)
	message(STATUS "Win being used")
endif()

# Set executable output location
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${MyProject_SOURCE_DIR}/bin)

add_subdirectory(src)

# add the executable
add_executable(
	program
	#EXCLUDE_FROM_ALL 
	src/main.cpp)
target_link_libraries(program PRIVATE maths)


####################### LOOOOPS ####################### 
message("---------- Loops ----------")
set(list1 aa bb)
set(list2 bb cd)
foreach(var IN LISTS list1 list2 IN ITEMS a b)
	message(STATUS ${var})
endforeach()

########################  Function ####################### 
message("---------- Function ----------")
function(func)
	foreach(arg IN LISTS ARGN)
		message("Argument ${arg}")
	endforeach()
endfunction()

func(a b c test ${x})

####################### Return value ####################### 
message("---------- Return value ----------")
macro(test_res val)
	set(${val} testing)
endmacro()

function(test_res_fun val)
	set(${val} testing PARENT_SCOPE)
	return()
	message("Never printed")
endfunction()

test_res(myTest)
test_res_fun(myTestFun)
message("Response: ${myTest}")
message("Response: ${myTestFun}")

####################### Parse args ####################### 
message("---------- Parse args ----------")
function(test_parsing)
	# Define the supported set o keywords
	set(prefix			ARG)
	set(noValues		COOL_STUFF ENABLE_THING)
	set(singleValues	DIR_NAME)
	set(multiValues		SRCS IMGS)

	# Process the arguments passed in
	include(CMakeParseArguments)
	cmake_parse_arguments(
			${prefix}
			"${noValues}"
			"${singleValues}"
			"${multiValues}"
			${ARGN}
				)

	# Log details
	message("Option summary:")
	foreach(arg IN LISTS noValues)
		if(${${prefix}_${arg}})
			message("\t${arg} enabled")
		else()
			message("\t${arg} disabled")
		endif()
	endforeach()

	# Log single and multi values
	foreach(arg IN LISTS singleValues multiValues)
		message("\t${arg} = ${${prefix}_${arg}}")
	endforeach()
endfunction()

test_parsing(DIR_NAME folder SRCS test.cpp main.cpp IMGS 1.png 2.jpg COOL_STUFF) 
####################### Properties ####################### 
message("---------- Properties ----------")
get_cmake_property(res VARIABLES)
#message(${res})

# Property to directory

# Property to target
set_target_properties(program PROPERTIES testing1 haha) 
get_target_property(ress program testing1)
message(${ress})

####################### Generator ####################### 
message("---------- Generator expression ----------")

set(test $<CONFIG>)
message(STATUS ${test})
message(??)

####################### Modules ####################### 
message("---------- Modules ----------")

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")
include(coolModule)
include(myModule)

set(x oi)
set(y oi)
include(CMakePrintHelpers)
cmake_print_variables(x y CMAKE_VERSION)

include(TestBigEndian)
test_big_endian(isBigEndian)
message("Target system big endian: ${isBigEndian}")

####################### Policies ####################### 
message("---------- Policies ----------")

# Allow non-existent target with get_target_property
cmake_policy(SET CMP0045 OLD)
# Would halt an error without the policy change
get_target_property(outVar doesNotExist COMPILE_DEFINITIONS)

####################### Build type ####################### 
message("---------- Build type ----------")

# Should use generators instead
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
	#cmake -DCMAKE_BUILD_TYPE:STRING=Debug ..
	message("Building with Debug")
elseif(CMAKE_BUILD_TYPE STREQUAL "Release")
	#cmake -DCMAKE_BUILD_TYPE:STRING=Release ..
	message("Building with Release")
endif()

message("Config types: ${CMAKE_CONFIGURATION_TYPES}")

####################### Compiler and Linker ####################### 
message("---------- Build type ----------")

# Add definition to all targets created in this directory
# Uncomment to create an error
#add_definitions(-DSUM_H)

#------------- C++ compile flags ---------------#
# Appending flags when compiling to CXX (It creates a variable from the cache and append)
#string(APPEND CMAKE_CXX_FLAGS " -Wall")
#string(APPEND CMAKE_CXX_FLAGS " -Wsign-compare")
#string(APPEND CMAKE_CXX_FLAGS " -Werror=unused-variable -Werror=sign-compare")

# Another way
#set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall")

# Things will be built with the flags stored when this file ends

####################### Custom Targets ####################### 
message("---------- Custom Targets ----------")
add_custom_target(bar ALL)
add_custom_command(
	TARGET   bar
	COMMAND  echo Hello World!
  	COMMAND  echo oi!
  	COMMAND  cat run.sh
  	COMMAND  echo ${PROJECT_SOURCE_DIR}
  	WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
)

# Run on binary
add_custom_command(
	TARGET   bar
	COMMAND  touch testing-output.txt
)

# Run on binary without target
add_custom_command(
	OUTPUT   bar
	COMMAND  touch testing-output.txt
)

message("---------- End ----------")


