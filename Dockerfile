# Use Python Image
FROM python:3.6
# Install apt dependencies 
# Copy contents into image
COPY . . 
# Run pip dependencies
RUN pip3 install flask 
# Expose the correct port
EXPOSE 5000
# Create an entrypoint
ENTRYPOINT ["python3", "app.py"]

