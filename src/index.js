import './main.css';
import { Main } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';

var storedState = localStorage.getItem('model');
var startingState = storedState ? JSON.parse(storedState) : null;

var elmApp = Main.embed(document.getElementById('root'), startingState);

elmApp.ports.setStorage.subscribe(function(state) {
    localStorage.setItem('model', JSON.stringify(state));
});

elmApp.ports.removeStorage.subscribe(function() {
    localStorage.removeItem('model');
});

registerServiceWorker();
