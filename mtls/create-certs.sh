#!/bin/bash

# domain for server/client cert. Normally server certs are * certs
domain="local.api"
# subdomain for client cert
sub_domain="my"
# The entity authorized to use the private key associated with the public key in the certificate.
subject="/CN=me-for-my-local"

certs_dir="certs"
ca_dir="${certs_dir}/ca"
server_dir="${certs_dir}/server"
client_dir="${certs_dir}/client"

rm -rf "${certs_dir}"
mkdir -p "${ca_dir}" "${server_dir}" "${client_dir}"

# Generate the CA Key and Certificate
openssl req -x509 -sha256 -newkey rsa:4096 -keyout "${ca_dir}/ca.key" -out "${ca_dir}/ca.crt" -days 1095 -nodes -subj "${subject}"

# Generate the Server Key, and Certificate and Sign with the CA Certificate
openssl req -new -newkey rsa:4096 -keyout "${server_dir}/server.key" -out "${server_dir}/server.csr" -nodes -subj "/CN=*.${domain}"
openssl x509 -req -sha256 -days 1095 -in "${server_dir}/server.csr" -CA "${ca_dir}/ca.crt" -CAkey "${ca_dir}/ca.key" -set_serial 1 -out "${server_dir}/server.crt"

# Generate the Client Key, and Certificate and Sign with the CA Certificate
openssl req -new -newkey rsa:4096 -keyout "${client_dir}/client.key" -out  "${client_dir}/client.csr" -nodes -subj "/CN=${sub_domain}.${domain}"
openssl x509 -req -sha256 -days 1095 -in  "${client_dir}/client.csr" -CA "${ca_dir}/ca.crt" -CAkey "${ca_dir}/ca.key" -set_serial 2 -out "${client_dir}/client.crt"

# Verify server certificate
openssl x509 -in "${server_dir}/server.crt" -text -noout
openssl verify -CAfile "${ca_dir}/ca.crt" "${server_dir}/server.crt"

# verify client certificate
openssl x509 -in "${client_dir}/client.crt" -noout -purpose | grep 'SSL client :'
openssl verify -CAfile "${ca_dir}/ca.crt" "${client_dir}/client.crt"
