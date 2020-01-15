FLAGS= -lGL -lGLU -lglfw -lGLEW -lassimp

export LD_LIBRARY_PATH=/usr/local/lib

all: main.o mesh.o shader.o window.o camera.o texture.o light.o directionalLight.o pointLight.o spotLight.o material.o parameters.h model.o
	g++ -g main.o mesh.o shader.o window.o camera.o texture.o light.o directionalLight.o pointLight.o spotLight.o material.o model.o -o run $(FLAGS)

run: all
	./run

main.o: main.cpp
	g++ -c main.cpp

mesh.o: mesh.cpp mesh.h
	g++ -c mesh.cpp

shader.o: shader.cpp shader.h
	g++ -c shader.cpp

window.o: window.cpp window.h
	g++ -c window.cpp

camera.o: camera.cpp camera.h
	g++ -c camera.cpp

texture.o: texture.cpp texture.h
	g++ -c texture.cpp

light.o: light.cpp light.h
	g++ -c light.cpp

directionalLight.o: directionalLight.cpp directionalLight.h
	g++ -c directionalLight.cpp

pointLight.o: pointLight.cpp pointLight.h
	g++ -c pointLight.cpp

spotLight.o: spotLight.cpp spotLight.h
	g++ -c spotLight.cpp

material.o: material.cpp material.h
	g++ -c material.cpp

model.o: model.cpp model.h
	g++ -c model.cpp

clean:
	rm *.o run
