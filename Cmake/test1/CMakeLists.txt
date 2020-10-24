cmake_minimum_required(VERSION 3.1)

# set the project name
project(Tutorial VERSION 0.0)
configure_file(tutorialConfig.h.in tutorialConfig.h)

# add the executable
add_executable(Tutorial tutorial.cpp)

target_include_directories(Tutorial PUBLIC
                           "bin"
                           )
