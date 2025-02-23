# Use a lightweight Python image
FROM python:3.12-slim

# Install pipenv so that run.sh can use it
RUN pip install pipenv

# Set the working directory in the container
WORKDIR /app

# Install Tkinter (python3-tk) and clean up to keep the image lean
RUN apt-get update && apt-get install -y python3-tk && rm -rf /var/lib/apt/lists/*

# Copy Pipfile and Pipfile.lock into the container
COPY Pipfile Pipfile.lock ./

# Install dependencies using pipenv
RUN pipenv install --deploy --ignore-pipfile

# Copy the rest of your application code into the container
COPY . .

# Set the default command to run the scraper script
CMD ["./run.sh"]