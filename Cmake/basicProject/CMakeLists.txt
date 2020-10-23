cmake_minimum_required(VERSION 3.2)

# set the project name
project(MyProject VERSION 0.0.0 LANGUAGES CXX)

set(test oqu)
set(oque "hahaha")
message(STATUS "Wow, this project is very good, uhn? ${${test}e}")
message(STATUS "Using semantic versioning - https://semver.org/")

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

message("---------- End ----------")
# Set executable output location
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${MyProject_SOURCE_DIR}/bin)

add_subdirectory(src)

# add the executable
add_executable(
	program
	#EXCLUDE_FROM_ALL 
	src/main.cpp)
target_link_libraries(program PRIVATE maths)
