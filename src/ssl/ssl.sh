## Documentation
# https://letsencrypt.org/docs/certificates-for-localhost/
# https://superuser.com/questions/226192/avoid-password-prompt-for-keys-and-prompts-for-dn-information

mkdir -p /etc/nginx/ssl

openssl req \
  -new \
  -newkey rsa:4096 \
  -days 365 \
  -nodes \
  -x509 \
  -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=localhost" \
  -keyout /etc/nginx/ssl/nginx-selfsigned.key \
  -out /etc/nginx/ssl/nginx-selfsigned.crt

# openssl dhparam -out /etc/nginx/ssl/dhparam.pem 2048


# https://www.namecheap.com/support/knowledgebase/article.aspx/807/2223/firefox-error-code-sslerrorrxrecordtoolong
# You can test the cert via the following:
# openssl s_client -connect localhost:7000