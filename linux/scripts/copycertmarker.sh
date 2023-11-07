#!/bin/bash

# Specify the marker text
start_marker="-----BEGIN CERTIFICATE-----"
end_marker="-----END CERTIFICATE-----"

# Use sed to extract the content between the markers
sed -n "/$start_marker/,/$end_marker/p" certificates.txt



# To copy multiple lines between and including a "begin" and "end" certificate marker in a text 
