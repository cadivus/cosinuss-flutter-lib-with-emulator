/* eslint-disable no-undef */

// eslint-disable-next-line no-unused-vars
function numberSpinnerAdd(id, addend) {
    let newValue = parseInt(document.getElementById(id).value) + addend;
 
    if (!!document.getElementById(id).min && newValue < parseInt(document.getElementById(id).min)) {
        newValue = parseInt(document.getElementById(id).min);
    }

    if (!!document.getElementById(id).max && newValue > parseInt(document.getElementById(id).max)) {
        newValue = parseInt(document.getElementById(id).max);
    }

    document.getElementById(id).value = newValue.toString();
}
