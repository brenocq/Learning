sudo apt-get install -y libglfw3-dev libglfw3
sudo apt-get install -y libglm-dev
sudo apt-get install -y libglew-dev

Install assimp:
https://stackoverflow.com/questions/25886122/assimp-undefined-reference-to-importer-ubuntu-opengl
```
    Download assimp

        http://sourceforge.net/projects/assimp/files/assimp-3.1/assimp-3.1.1.zip/download

    Open the archive and extract the assimp folder somewhere

    Open a terminal in the assimp directory

    Type

        ~$ cmake -G 'Unix Makefiles'
        ~$ make
        ~$ make install
```
