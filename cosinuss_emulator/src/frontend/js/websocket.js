/* eslint-disable no-undef */

let host = location.hostname ?? "localhost";
if (host.length === 0) {
    host = "localhost";
}
if (location.port.length > 0) {
    host += ":" + location.port;
} else if (location.host.length === 0) {
    host += ":3000";
}
// eslint-disable-next-line no-unused-vars
const websocket = new WebSocket("ws://" + host + "/websocket/");
