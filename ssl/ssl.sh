## Documentation
# https://letsencrypt.org/docs/certificates-for-localhost/

# openssl req -x509 -out /etc/ssl/certs/nginx-selfsigned.crt -keyout /etc/ssl/private/nginx-selfsigned.key \
#   -newkey rsa:2048 -nodes -sha256 \
#   -subj '/CN=localhost' -extensions EXT -config <( \
#    printf "[dn]\nCN=localhost\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:localhost\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")

openssl req -subj '/CN=localhost' -x509 -newkey rsa:4096 -nodes -keyout /etc/ssl/certs/nginx-selfsigned.crt -out /etc/ssl/certs/nginx-selfsigned.crt -days 365

openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048

