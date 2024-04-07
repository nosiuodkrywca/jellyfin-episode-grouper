# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
#RUN pip install --no-cache-dir -r requirements.txt
RUN pip install requests

# Set environment variables
ENV JF_URL=value1
ENV JF_USER=value2
ENV JF_KEY=value3

# Install cron
RUN apt-get update && apt-get -y install cron

# Add cron job with environment variables as arguments to the Python script
RUN echo "0 * * * * root /app/jellyfin-episode-grouper.py $JF_URL $JF_KEY $JF_USER" >> /etc/crontab

# Run the cron service
CMD ["cron", "-f"]
