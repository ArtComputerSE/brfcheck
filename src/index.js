import './main.css';
import {Elm} from './Main.elm';
import registerServiceWorker from './registerServiceWorker';
import Clipboard from "./clipboard.js"

var storedState = localStorage.getItem('model');
var startingState = storedState ? JSON.parse(storedState) : "";

const elmApp = Elm.Main.init({
    node: document.getElementById('root'),
    flags: startingState
});

elmApp.ports.setStorage.subscribe(function (state) {
    localStorage.setItem('model', JSON.stringify(state));
});


registerServiceWorker();

var clipboard = new Clipboard('.copy-button');
