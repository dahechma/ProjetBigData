FROM quay.io/jupyter/datascience-notebook

USER root

# Install system dependencies for Python packages with C extensions
RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    openjdk-11-jdk \
    ca-certificates-java \
    default-libmysqlclient-dev \
    build-essential \
    pkg-config \
    python3-dev \
    librdkafka-dev \
    libssl-dev \
    libsasl2-dev \
    gcc \
    g++ \
    cmake \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set JAVA_HOME environment variable
ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64
ENV PATH $JAVA_HOME/bin:$PATH

# Verify Java installation
RUN java -version

# Install essential packages first
RUN pip install --no-cache-dir --upgrade pip wheel setuptools

# Install pyarrow and confluent-kafka separately
RUN pip install --no-cache-dir pyarrow==11.0.0
RUN pip install --no-cache-dir confluent-kafka==1.9.2

# Copy requirements file without the problematic packages
COPY requirements.txt /tmp/requirements.txt

# Modify requirements to remove already installed packages
RUN sed -i '/pyarrow/d' /tmp/requirements.txt && \
    sed -i '/confluent-kafka/d' /tmp/requirements.txt

# Install the rest of the requirements
RUN pip install --no-cache-dir -r /tmp/requirements.txt && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Install findspark
RUN pip install findspark

# Create directory structure for notebooks
RUN mkdir -p /home/${NB_USER}/work/notebooks
RUN fix-permissions "/home/${NB_USER}"

# Switch back to jovyan user
USER ${NB_UID}

# Set working directory
WORKDIR /home/${NB_USER}/work