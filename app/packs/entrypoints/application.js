import Rails from "@rails/ujs";
import 'jquery'
import 'popper.js'
import "bootstrap";

import { Application, defaultSchema } from 'stimulus'
import VoiceController from '../controllers/voice_controller'

const customSchema = {
    ...defaultSchema,
    controllerAttribute: 'data-stimulus-controller',
    actionAttribute: 'data-stimulus-action',
    targetAttribute: 'data-stimulus-target'
}

window.Stimulus = Application.start(document.documentElement, customSchema)
Stimulus.register("voice", VoiceController)

// window.bootstrap = require('bootstrap/dist/js/bootstrap.bundle.js');
// window.bootstrap = require("bootstrap")

Rails.start();