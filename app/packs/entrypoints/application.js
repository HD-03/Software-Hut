import Rails from "@rails/ujs";
import 'jquery';
import 'popper.js';
import "bootstrap";

import '../scripts/task_show.js'
import '../scripts/home_page.js'

import { Application, defaultSchema } from 'stimulus';
import VoiceController from "../controllers/voice_controller";

const customSchema = {
    ...defaultSchema,
    controllerAttribute: 'data-stimulus-controller',
    actionAttribute: 'data-stimulus-action',
    targetAttribute: 'data-stimulus-target'
}

window.Stimulus = Application.start(document.documentElement, customSchema)
Stimulus.register("voice", VoiceController)

Rails.start();