cat << 'EOF' > docker-compose.yml
services:
  mongo:
    image: mongo:7
    container_name: mongo
    restart: always
    ports:
      - "27017:27017"
    environment:
      MONGO_INITDB_ROOT_USERNAME: root
      MONGO_INITDB_ROOT_PASSWORD: example
    volumes:
      - ./db_data:/data/db
EOF

docker compose up -d

docker ps

ocker exec -it mongo mongosh -u root -p example

test> use myapp
test> db.createCollection("users")
test> db.users.insertOne({ name: "Alice" })
test> show dbs
test> show collections
test> exit