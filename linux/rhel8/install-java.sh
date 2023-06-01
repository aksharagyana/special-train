#!/bin/bash

# Update the system
sudo dnf update -y

# Install the OpenJDK 8 package
sudo dnf install -y java-1.8.0-openjdk-devel

# Verify Java installation
java -version

# Optionally, set Java environment variables
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk
export PATH=$JAVA_HOME/bin:$PATH

# Print installation status
echo "Java 8 installation complete."
