# PicoDev-openvscodeserver
A Raspberry Pico development environment containerized with a Open VS Code Server Web IDE.  
See the gitpod-io [repo](https://github.com/gitpod-io/openvscode-server) for more info.

## Getting ready  
Start by downloading the Dockerfile in this repo locally to your environment and open the file location in your terminal.

## Build the image
Build the image using `docker build -t picodev .` (use *sudo* if needed)  
Where *picodev* is the name you give your image.  

## Start the container
Navigate to the directory you intend to develop in and start the container with:
```
sudo docker run -it --name picodevenv --init -p 3000:3000 -v "$(pwd):/home/workspace:cached" picodev
```
