import http from "http";

const port = process.env.PORT || 3000

const server = http.createServer().listen(port);
server.on('request', (request, response) => {
    response.end("Test");
});
