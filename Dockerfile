# set up the base image
FROM python:3.12-slim

# set the working directory
WORKDIR /app/

# copy the requirements file to workdir
COPY requirements.txt .

# install the requirements
RUN pip install --no-cache-dir -r requirements.txt
#RUN pip install -r requirements.txt

# Copy all required data files at once
COPY ./data/collab_filtered_data.csv \
     ./data/interaction_matrix.npz \
     ./data/track_ids.npy \
     ./data/cleaned_data.csv \
     ./data/transformed_data.npz \
     ./data/transformed_hybrid_data.npz \
     ./data/

# Copy all required Python scripts at once
COPY src/ ./src/
# Copy app.py file into docker directory
COPY app.py .

# expose the port on the container
EXPOSE 8000

# run the streamlit app
CMD [ "streamlit", "run", "app.py", "--server.port" ,"8000" ]