all:
	g++ -c stb_image.cpp
	g++ -c shader.cpp
	g++ main.cpp glad.c -lglfw -lGL -lX11 -lpthread -lXrandr -lXi -ldl -o run
	./run
