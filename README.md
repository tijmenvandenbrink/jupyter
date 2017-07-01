# Jupyter
This is a simple Jupyter image, including SSL support. In order to use this image effectively, you'll need to mount:

* /somepath/on/host/notebooks for your site content (e.g. using "-v /home/jdoe/notebooks/:/notebooks")
* /somepath/on/host/config, optionally, if you want to store your customized config and/or SSL keys outside the container (e.g. using "-v /home/jdoe/config/:/config")
* optionally, if you wish to use SSL with real keys you can create a directory config/ssl and place your real keys there

Run a Jupyter notebook docker container in seconds. Enable SSL and use custom config for jupyter.

# Build the image
```
docker build -t jupyter:latest .
```
# Run the container
## On linux
```
docker run -p 8888:8888 -v "<ABSOLUTEPATH_ON_HOST>/notebooks:/notebooks" -v "<ABSOLUTEPATH_ON_HOST>/config:/config" jupyter:latest
```

## On windows
```
docker run -p 8888:8888 -v "<ABSOLUTEPATH_ON_HOST>\notebooks:/notebooks" -v "<ABSOLUTEPATH_ON_HOST>\config:/config" jupyter:latest
```

# Secure your container by enabling SSL
Place a certfile and privkey in the ./config/ssl directory and pass the following arguments when running the container:

```
-e certfile_arg="--certfile=/config/ssl/fullchain.pem" -e keyfile_arg="--keyfile=/config/ssl/privkey.pem"
```

# Use a custom config file and set a password
## Generate config using a temporary container

```
docker run --name tmp-jupyter-container -d jupyter:latest
docker exec tmp-jupyter-container jupyter notebook --allow-root --generate-config
docker cp tmp-jupyter-container:/root/.jupyter /<ABSOLUTEPATH_ON_HOST>/config/
```

## Hashed password to use for web authentication.

To generate, type in a python/IPython shell:
```
from notebook.auth import passwd; passwd()
```
The string should be of the form type:salt:hashed-password.

You can store this string in the config file

## 
Pass the following env variable when running the container to ensure jupyter uses the alternative config file:
```
-e configfile_arg="--config=/config/.jupyter/jupyter_notebook_config.py"
```
