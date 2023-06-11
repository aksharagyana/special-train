openssl genrsa -out private.key 2048
openssl req -new -sha256 -key private.key -out csr.csr -config csr.cnf
