#!/bin/bash

# Authenticate with gcloud using the service account key file
gcloud auth activate-service-account --key-file=${GOOGLE_APPLICATION_CREDENTIALS}

# Keep the container running
tail -f /dev/null
