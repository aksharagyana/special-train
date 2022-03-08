server {
    listen 80;
    charset utf-8;
    access_log off;

    location / {
        proxy_pass http://app:8080;
        proxy_ssl_certificate         /etc/nginx/client.pem;
        proxy_ssl_certificate_key     /etc/nginx/client.key;
        proxy_ssl_protocols           TLSv1 TLSv1.1 TLSv1.2;
        proxy_ssl_ciphers             HIGH:!aNULL:!MD5;
        proxy_ssl_trusted_certificate /etc/nginx/trusted_ca_cert.crt;

        proxy_ssl_verify        on;
        proxy_ssl_verify_depth  2;
        proxy_ssl_session_reuse on;
    }

    location /static {
        access_log   off;
        expires      30d;

        alias /app/static;
    }
}
