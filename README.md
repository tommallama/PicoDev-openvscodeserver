# PicoDev-openvscodeserver
A Raspberry Pico development environment containerized with a Open VS Code Server Web IDE.  
See the gitpod-io [repo](https://github.com/gitpod-io/openvscode-server) for more info.

**Note:** These instructions assume you are running a Linux version based on Debian.

## Build the image
Start by downloading the Dockerfile in this repo locally to your environment and open the file location in your terminal.  
`wget https://raw.githubusercontent.com/tommallama/PicoDev-openvscodeserver/main/Dockerfile` or similar approach.  
Build the image using `docker build -t picodev .` (use *sudo* if needed)  

## Fetch the Raspberry Pico SDK and associated libraries
- Navigate into the folder you intend to develop in
- Copy the fetch script into this development folder  
- Make the script executable  
- Run the script
- Clean up the script.
The snippet below does all the things.
```
wget https://raw.githubusercontent.com/tommallama/PicoDev-openvscodeserver/main/fetchandprep.sh \
&& chmod +x fetchandprep.sh \
&& ./fetchandprep.sh \
&& rm -f ./fetchandprep.sh 
```

## Start the container
Navigate to the directory you intend to develop in and start the container with:
```
sudo docker run -d --init \
--name picodevenv \
-p 3000:3000 \
-v "$(pwd):/home/workspace:cached" picodev
```

## Enjoy 
Navigate to http://localhost:3000 if running locally or the appropriate address and port as configured
