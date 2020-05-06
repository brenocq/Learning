VULKAN_SDK_PATH = /home/breno/Programs/VulkanSDK/1.2.135.0/x86_64
CFLAGS = -std=c++17 -I$(VULKAN_SDK_PATH)/include
LDFLAGS = -L$(VULKAN_SDK_PATH)/lib `pkg-config --static --libs glfw3` -lvulkan

VulkanTest: main.cpp shaders/shader.vert shaders/shader.frag
	$(VULKAN_SDK_PATH)/bin/glslc shaders/shader.vert -o shaders/vert.spv
	$(VULKAN_SDK_PATH)/bin/glslc shaders/shader.frag -o shaders/frag.spv
	g++ $(CFLAGS) -o VulkanTest main.cpp $(LDFLAGS)

.PHONY: test clean

test: VulkanTest
	LD_LIBRARY_PATH=$(VULKAN_SDK_PATH)/lib VK_LAYER_PATH=$(VULKAN_SDK_PATH)/etc/vulkan/explicit_layer.d ./VulkanTest	

clean:
	rm -f VulkanTest
