# Base image
FROM hashicorp/terraform:1.9.8

# Install dependencies
RUN apk add --no-cache curl bash python3 py3-pip

# Install Google Cloud SDK
RUN curl -sSL https://sdk.cloud.google.com | bash -s -- --disable-prompts && \
    ln -s /root/google-cloud-sdk/bin/gcloud /usr/local/bin/gcloud && \
    ln -s /root/google-cloud-sdk/bin/gsutil /usr/local/bin/gsutil

# Set PATH to include the Google Cloud SDK
ENV PATH="/root/google-cloud-sdk/bin:${PATH}"

# Create and activate a Python virtual environment
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Install Python dependencies in the virtual environment
RUN pip install --upgrade pip && pip install google-auth

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/

# Install gke-gcloud-auth-plugin
RUN gcloud components install gke-gcloud-auth-plugin --quiet

# Set working directory
WORKDIR /workspace

# Copy entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
