VULKAN_SDK_PATH = /home/breno/Programs/VulkanSDK/1.2.135.0/x86_64
CFLAGS = -std=c++17 -I$(VULKAN_SDK_PATH)/include
LDFLAGS = -L$(VULKAN_SDK_PATH)/lib `pkg-config --static --libs glfw3` -lvulkan

FILES = VulkanRenderer
OBJ = obj/

SOURCES=$(patsubst %, %.cpp, ${FILES})
HEADERS=$(patsubst %, %.h, ${FILES})
OBJECTS=$(patsubst %, ${OBJ}%.o, ${FILES})
DEPENDENCIES=Utilities.h

all: main.cpp ${OBJECTS} ${DEPENDENCIES} 
	g++ $(CFLAGS) -o run main.cpp $(LDFLAGS) ${OBJECTS}

# Compile project files
${OBJ}%.o: %.cpp
	g++ ${CFLAGS} -c $< -o $@ ${LDFLAGS} 

.PHONY: test clean

test: all
	LD_LIBRARY_PATH=$(VULKAN_SDK_PATH)/lib VK_LAYER_PATH=$(VULKAN_SDK_PATH)/etc/vulkan/explicit_layer.d ./run	

clean:
	rm -f run
