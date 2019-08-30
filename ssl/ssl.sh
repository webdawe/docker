## Documentation
# https://letsencrypt.org/docs/certificates-for-localhost/

mkdir /etc/nginx/ssl -p

openssl req -x509 -out /etc/nginx/ssl/localhost.crt -keyout /etc/nginx/ssl/localhost.key \
  -newkey rsa:2048 -nodes -sha256 \
  -subj '/CN=localhost' -extensions EXT -config <( \
   printf "[dn]\nCN=localhost\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:localhost\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")