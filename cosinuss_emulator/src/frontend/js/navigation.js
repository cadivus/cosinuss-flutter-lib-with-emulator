/* eslint-disable no-undef */

// eslint-disable-next-line no-unused-vars
function openManualEmulator() {
  document.getElementById("manual-emulator").style.display = "block";
  document.getElementById("record-and-replay").style.display = "none";

  document.getElementById("manual-emulator-href").style.fontWeight = "bold";
  document.getElementById("manual-emulator-href-mobile").style.fontWeight = "bold";

  document.getElementById("record-and-replay-href").style.fontWeight = "normal";
  document.getElementById("record-and-replay-href-mobile").style.fontWeight = "normal";

  closeMobileMenu();
}

// eslint-disable-next-line no-unused-vars
function openRecordAndReplay() {
  document.getElementById("manual-emulator").style.display = "none";
  document.getElementById("record-and-replay").style.display = "block";

  document.getElementById("manual-emulator-href").style.fontWeight = "normal";
  document.getElementById("manual-emulator-href-mobile").style.fontWeight = "normal";

  document.getElementById("record-and-replay-href").style.fontWeight = "bold";
  document.getElementById("record-and-replay-href-mobile").style.fontWeight = "bold";

  closeMobileMenu();
}

function closeMobileMenu() {
  document.getElementById("menu-mobile").style.display = "none";
  document.getElementById("menu-mobile-button-open-area").style.display = "block";
  document.getElementById("menu-mobile-button-close-area").style.display = "none";
  document.getElementById("back-blur").style.filter = "blur(0px)";
}

function openMobileMenu() {
  document.getElementById("menu-mobile").style.display = "block";
  document.getElementById("menu-mobile-button-open-area").style.display = "none";
  document.getElementById("menu-mobile-button-close-area").style.display = "block";
  document.getElementById("back-blur").style.filter = "blur(5px)";
}

window.addEventListener("resize", function () {
  closeMobileMenu();
});

window.addEventListener("load", function () {
  let button = document.getElementById("menu-mobile-button-open-area");
  button.onclick = openMobileMenu;

  button = document.getElementById("menu-mobile-button-close-area");
  button.onclick = closeMobileMenu;
});
