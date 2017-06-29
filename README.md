# Jupyter
Jupyter docker container.

# Build the image
'''
docker build -t jupyter:1.1 .
'''
# Run the container

"--certfile=/config/ssl/fullchain.pem", "--keyfile=/config/ssl/privkey.pem", "--config=/config/.jupyter/jupyter_notebook_config.py"

## On linux
'''
docker run -p 8888:8888 -v "<ABSOLUTEPATH_ON_HOST>/notebooks:/notebooks" -v "<ABSOLUTEPATH_ON_HOST>/config:/config jupyter:1.1
'''

## On windows
'''
docker run -p 8888:8888 -v "<ABSOLUTEPATH_ON_HOST>\notebooks:/notebooks" -v "<ABSOLUTEPATH_ON_HOST>\config:/config" jupyter:1.0
'''

# Secure your container by enabling SSL
Place a certfile and privkey in the ./config/ssl directory and pass the following arguments when running the container:

'''
-e certfile_arg="--certfile=/config/ssl/fullchain.pem" -e keyfile_arg="--keyfile=/config/ssl/privkey.pem"

# Use a custom config file and set a password
## Generate config

docker exec <container_id> jupyter notebook --generate-config 

## Hashed password to use for web authentication.

To generate, type in a python/IPython shell:
'''
    from notebook.auth import passwd; passwd()
'''
The string should be of the form type:salt:hashed-password.

You can store this string in the config file


config_arg="--config=/config/.jupyter/jupyter_notebook_config.py"

