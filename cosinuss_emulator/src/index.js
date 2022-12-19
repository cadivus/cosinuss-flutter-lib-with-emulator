import http from "http";
import WebSocket from "ws";
import fs from "fs";
import {lookup} from "mime-types";

const port = process.env.PORT || 3000;

const  responseFile = (path, response) => {
    const mappedPath = path === "/" ? "/index.html" : path;
    const filesystemPath = __dirname + "/frontend" + mappedPath;

    const readStream = fs.createReadStream(filesystemPath);
    response.writeHead(200, {
        "Content-Type": lookup(filesystemPath),
    });

    readStream.on("error", function(err) {
        if (path === "/") {
            response.writeHead(404);
            response.end("404 File not found");
        } else {
            responseFile("/", response);
        }
    });

    readStream.pipe(response);
}

const server = http.createServer().listen(port);
server.on("request", (request, response) => {
    responseFile(request.url, response);
});

const wss = new WebSocket.Server({
    noServer: true,
})

server.on("upgrade", (request, socket, head) => {
    const {url} = request
    if (url.match(/.*\/websocket\/.*/gm)) {
        wss.handleUpgrade(request, socket, head, function done(ws) {
            console.log("Handle websocket upgrade for client");

            ws.on("message", function incoming(data) {
                wss.clients.forEach(function each(client) {
                    if (client !== ws && client.readyState === WebSocket.OPEN) {
                        client.send(data.toString());
                    }
                });
            });

        })
    }
})
