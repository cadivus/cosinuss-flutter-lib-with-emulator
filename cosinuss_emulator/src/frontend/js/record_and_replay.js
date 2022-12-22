/* eslint-disable no-undef */

let isRecording = false;
let isReplaying = false;

let replayingIndex = 0;
let recording = [];

let replayingTimeout;
let recordingAutostopTimeout;

function displayRecordingLength() {
  let result = "no recording";

  if (recording.length !== 0) {
    const time = (recording[recording.length - 1]["timestamp"] - recording[0]["timestamp"]) / 1000;
    result = time + " s";
  }

  document.getElementById("record-and-replay-recording-length").innerText = result;
}

function downloadText(filename, text) {
  const element = document.createElement("a");
  element.setAttribute("href", "data:text/plain;charset=utf-8," + encodeURIComponent(text));
  element.setAttribute("download", filename);

  element.style.display = "none";
  document.body.appendChild(element);

  element.click();

  document.body.removeChild(element);
}

function sendNextRecordingData() {
  if (recording.length === 0) {
    replayingIndex = 0;
    setUiPlayingMode(false);
    return;
  }

  if (replayingIndex >= recording.length) {
    replayingIndex = 0;
  }

  websocket.send(JSON.stringify(recording[replayingIndex]));
  ++replayingIndex;

  if (replayingIndex >= recording.length) {
    replayingIndex = recording.length;
    setUiPlayingMode(false);
    return;
  }

  const intervalMilliseconds = recording[replayingIndex]["timestamp"] - recording[replayingIndex - 1]["timestamp"];
  replayingTimeout = setTimeout(sendNextRecordingData, intervalMilliseconds);
}

function onLoadButtonPress(event) {
  recording = [];

  const input = event.target;
  const reader = new FileReader();
  reader.onload = function () {
    const fileContentArray = reader.result.split(/\r\n|\n/);
    for (let i = 0; i < fileContentArray.length - 1; i++) {
      const json = JSON.parse(fileContentArray[i]);
      recording.push(json);
    }
    document.getElementById("record-and-replay-play-pause-button").disabled = !(recording.length > 0);
    document.getElementById("record-and-replay-save-button").disabled = !(recording.length > 0);
    displayRecordingLength();
  };
  reader.readAsText(input.files[0]);
}

function onSaveButtonPress() {
  const asText = recording.reduce((text, e) => text + JSON.stringify(e) + "\n", "");
  const filename = "cosinuss_recording";
  downloadText(filename, asText);
}

function setUiRecordingMode(active) {
  if (active) {
    displayRecordingLength();
    document.getElementById("record-and-replay-play-pause-button").disabled = true;
    document.getElementById("record-and-replay-save-button").disabled = true;
    setRecordingDurationElementEnabled(false);
    newLabel = "Stop";
  } else {
    newLabel = "Record";
    document.getElementById("record-and-replay-play-pause-button").disabled = !(recording.length > 0);
    document.getElementById("record-and-replay-save-button").disabled = !(recording.length > 0);
    setRecordingDurationElementEnabled(true);
  }
  document.getElementById("record-and-replay-record-button").value = newLabel;
}

function onRecordButtonPress() {
  isRecording = !isRecording;
  setUiRecordingMode(isRecording);

  if (isRecording) {
    recording = [];
    const timeoutMilliseconds = parseInt(document.getElementById("record-and-replay-recording-duration-input").value) * 60000;
    recordingAutostopTimeout = setTimeout(function () {
      isRecording = false;
      setUiRecordingMode(false);
    }, timeoutMilliseconds);
  } else {
    clearTimeout(recordingAutostopTimeout);
  }
}

function setUiPlayingMode(active) {
  isReplaying = active;

  let newLabel;
  if (isReplaying) {
    document.getElementById("record-and-replay-record-button").disabled = true;
    document.getElementById("record-and-replay-load-button").disabled = true;
    newLabel = "Stop";
  } else {
    document.getElementById("record-and-replay-record-button").disabled = false;
    document.getElementById("record-and-replay-load-button").disabled = false;
    newLabel = "Play";
  }
  document.getElementById("record-and-replay-play-pause-button").value = newLabel;
}

function onPlayPauseButtonPress() {
  isReplaying = !isReplaying;
  setUiPlayingMode(isReplaying);
  if (isReplaying) {
    sendNextRecordingData();
  } else {
    clearTimeout(replayingTimeout);
  }
}

function setRecordingDurationElementEnabled(enabled) {
  document.getElementById("record-and-replay-spinner-button-m100").disabled = !enabled;
  document.getElementById("record-and-replay-spinner-button-m10").disabled = !enabled;
  document.getElementById("record-and-replay-recording-duration-input").disabled = !enabled;
  document.getElementById("record-and-replay-spinner-button-p10").disabled = !enabled;
  document.getElementById("record-and-replay-spinner-button-p100").disabled = !enabled;
}

window.addEventListener("load", function () {
  document.getElementById("record-and-replay-save-button").onclick = onSaveButtonPress;
  document.getElementById("record-and-replay-record-button").onclick = onRecordButtonPress;
  document.getElementById("record-and-replay-play-pause-button").onclick = onPlayPauseButtonPress;
  document.getElementById("record-and-replay-load-input").onchange = onLoadButtonPress;

  document.getElementById("record-and-replay-save-button").disabled = true;
  document.getElementById("record-and-replay-play-pause-button").disabled = true;
});


websocket.onmessage = function (event) {
  if (!isRecording) {
    return;
  }

  const samplingRate = parseInt(document.getElementById("record-and-replay-sampling-rate-input").value);
  if (recording.length !== 0 && (Date.now() - recording[recording.length - 1]["timestamp"]) < samplingRate) {
    return;
  }

  const json = JSON.parse(event.data);
  if (!json["recTimestamp"]) {
    json["timestamp"] = Date.now();
  }

  recording.push(json);
  displayRecordingLength();
};
