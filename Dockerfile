# Use an official Python runtime as a base image
FROM python:2

LABEL maintainer "Tijmen van den Brink"

# BUILD ARGS
ENV certfile_arg
ENV keyfile_arg
ENV configfile_arg

# Set the working directory to /notebooks
WORKDIR /notebooks

# Copy the current directory contents into the container at /notebooks
#ADD . /notebooks
COPY requirements.txt .

# Install any needed packages specified in requirements.txt
RUN pip install -r requirements.txt

# Make port 80 available to the world outside this container
EXPOSE 8888

VOLUME /notebooks
VOLUME /config

# Run jupyter when the container launches
#CMD ["jupyter", "notebook", "--allow-root", "--no-browser", "--ip=0.0.0.0", "--certfile=/config/ssl/fullchain.pem", "--keyfile=/config/ssl/privkey.pem", "--config=/config/.jupyter/jupyter_notebook_config.py"]
CMD ["jupyter", "notebook", "--allow-root", "--no-browser", "--ip=0.0.0.0", ${certfile_arg}, ${keyfile_arg}, ${configfile_arg}]
