all:
	g++ -c stb_image.cpp
	g++ -c glad.c
	g++ -c learnopengl/mesh.cpp
	g++ -c learnopengl/camera.cpp
	g++ -c learnopengl/shader_m.cpp
	g++ main.cpp glad.c shader_m.o mesh.o shader_m.o stb_image.cpp -lglfw -lGL -lX11 -lpthread -lXrandr -lXi -ldl -o run
	./run
