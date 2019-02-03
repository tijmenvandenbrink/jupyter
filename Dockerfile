# Use an official Python runtime as a base image
FROM python:2

LABEL maintainer "Tijmen van den Brink"

RUN groupadd -g 1000 jupyter && \
    useradd -r -m -u 1000 -g jupyter jupyter

# BUILD ARGS
ENV certfile_arg=${certfile_arg:-""} \
 keyfile_arg=${keyfile_arg:-""} \
 configfile_arg=${configfile_arg:-""}


# Copy the current directory contents into the container at /notebooks
#ADD . /notebooks
COPY requirements.txt .

# Install any needed packages specified in requirements.txt
RUN pip install -r requirements.txt

# Make port 80 available to the world outside this container
EXPOSE 8888

VOLUME /notebooks
VOLUME /config

USER jupyter

# Set the working directory to /notebooks
WORKDIR /home/jupyter

# Run jupyter when the container launches
#CMD ["jupyter", "notebook", "--allow-root", "--no-browser", "--ip=0.0.0.0", "--certfile=/config/ssl/fullchain.pem", "--keyfile=/config/ssl/privkey.pem", "--config=/config/.jupyter/jupyter_notebook_config.py"]

CMD jupyter notebook --no-browser --ip=0.0.0.0 ${certfile_arg} ${keyfile_arg} ${configfile_arg}
#CMD ["jupyter", "notebook", "--allow-root", "--no-browser", "--ip=0.0.0.0"]
