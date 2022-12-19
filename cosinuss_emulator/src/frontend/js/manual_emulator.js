/* eslint-disable no-undef */

window.addEventListener("load", function () {
  const cosinussData = new Map();

  function sendManualEmulatorData() {
    if (websocket.readyState === websocket.OPEN) {
      websocket.send(JSON.stringify(cosinussData));
    }
  }

  function onInputChange() {
    const heartRate = parseInt(document.getElementById("manual-emulator-heart-rate-input").value);
    cosinussData["heartRate"] = {"value": heartRate};

    const bodyTemperature = parseFloat(document.getElementById("manual-emulator-body-temperature-input").value);
    cosinussData["bodyTemperature"] = {"value": bodyTemperature};

    const accelerometerX = parseInt(document.getElementById("manual-emulator-accelerometer-input-x").value);
    const accelerometerY = parseInt(document.getElementById("manual-emulator-accelerometer-input-y").value);
    const accelerometerZ = parseInt(document.getElementById("manual-emulator-accelerometer-input-z").value);
    cosinussData["accelerometer"] = {"x": accelerometerX, "y": accelerometerY, "z": accelerometerZ};

    const ppgRawRed = parseFloat(document.getElementById("manual-emulator-ppg-raw-input-red").value);
    const ppgRawGreen = parseFloat(document.getElementById("manual-emulator-ppg-raw-input-green").value);
    const ppgRawAmbient = parseFloat(document.getElementById("manual-emulator-ppg-raw-input-ambient").value);
    cosinussData["ppgRaw"] = {"ppgRed": ppgRawRed, "ppgGreen": ppgRawGreen, "ppgAmbient": ppgRawAmbient};

    document.getElementById("manual-emulator-heart-rate-value").innerHTML = heartRate + " bpm";
    document.getElementById("manual-emulator-body-temperature-value").innerHTML = bodyTemperature + " &#8451;"
    document.getElementById("manual-emulator-accelerometer-value").innerHTML = "(" + accelerometerX + " &#124; " + accelerometerY + " &#124; " + accelerometerZ + ")";
    document.getElementById("manual-emulator-ppg-raw-value").innerHTML = "(" + ppgRawRed + ", " + ppgRawGreen + ", " + ppgRawAmbient + ")";

    const checkbox = document.getElementById("manual-emulator-auto-update-checkbox");
    if (!checkbox.checked) {
      return;
    }

    sendManualEmulatorData();
  }

  function setChangeListener(id) {
    document.getElementById(id).oninput = onInputChange;
  }

  setChangeListener("manual-emulator-heart-rate-input");
  setChangeListener("manual-emulator-body-temperature-input");

  setChangeListener("manual-emulator-accelerometer-input-x");
  setChangeListener("manual-emulator-accelerometer-input-y");
  setChangeListener("manual-emulator-accelerometer-input-z");

  setChangeListener("manual-emulator-ppg-raw-input-red");
  setChangeListener("manual-emulator-ppg-raw-input-green");
  setChangeListener("manual-emulator-ppg-raw-input-ambient");

  onInputChange();

  const button = document.getElementById("manual-emulator-send-button");
  button.onclick = sendManualEmulatorData;
});
