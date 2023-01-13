# bash file to generate nginx based on set port for app and nginx in the .env file
echo "[INFO] Generating nginx configuration based on settings."
if [ ! -d nginx/ ]
then
    mkdir -p nginx
fi

rm -rf nginx/nginx.conf

# first set nginx settings
if [ -f .env ]
then
  # update nginx env var loading also
  export $(cat .env | sed 's/#.*//g' | xargs)
else
  # no .env file then quit
  echo "[ERROR] .env file not found for nginx! exiting.."
  exit 64
fi

# start
# from .env
cat << EOF >> nginx/nginx.conf
client_max_body_size $NGINX_MAX_FILE_SIZE;

server {
    listen $NGINX_CONTAINER_PORT;
EOF

# now add the application
cat << EOF >> nginx/nginx.conf

    location ${MOUNT} {
        proxy_pass http://${APP_NAME}:${APP_PORT};
        proxy_connect_timeout   ${TIMEOUT};
        proxy_send_timeout      ${TIMEOUT};
        proxy_read_timeout      ${TIMEOUT};
    }
EOF


# end
echo } >> nginx/nginx.conf
