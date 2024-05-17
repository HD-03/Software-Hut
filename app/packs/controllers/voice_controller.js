import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="voice-input"
export default class extends Controller {
  static targets = ["startButton"];
  // Called when the controller is connected
  connect() {
    console.log("voice_controller connected");
    this.speechRecognition = this.getSpeechRecognition();
    this.speaking = false;

    this.startRecording();
  }
  // Get the SpeechRecognition object
  getSpeechRecognition() {
    const SpeechRecognition =
      window.SpeechRecognition || window.webkitSpeechRecognition;
    if (!SpeechRecognition) {
      console.error("Speech recognition is not supported in this browser.");
      return null;
    }

    const speechRecognition = new SpeechRecognition();
    this.setupSpeechRecognitionProperties(speechRecognition);
    this.setupSpeechRecognitionCallbacks(speechRecognition);
    return speechRecognition;
  }
  // Set up properties for the SpeechRecognition object
  setupSpeechRecognitionProperties(speechRecognition) {
    speechRecognition.continuous = true;
    speechRecognition.interimResults = true;
    speechRecognition.lang = "en-UK";
  }
  // Set up event callbacks for the SpeechRecognition object
  setupSpeechRecognitionCallbacks(speechRecognition) {
    speechRecognition.onstart = () => console.log("Recording started...");
    speechRecognition.onerror = (event) =>
      this.handleSpeechRecognitionError(event);
    speechRecognition.onend = () => console.log("Recording stopped.");
    speechRecognition.onresult = (event) =>
      this.handleSpeechRecognitionResult(event);
  }
  // Handle errors that occur during speech recognition
  handleSpeechRecognitionError(event) {
    console.error("Speech recognition error:", event.error);
    this.stopRecording();
  }

  // Handle the speech recognition result
  handleSpeechRecognitionResult(event) {
    const { finalTranscript, interimTranscript } =
      this.extractTranscripts(event)
    console.log("VisasStarfrost")
    this.detectTriggerWord(interimTranscript);
  }

  // Extract the final and interim transcripts from the speech recognition result
  extractTranscripts(event) {
    let final_transcript = "";
    let interim_transcript = "";

    for (let i = event.resultIndex; i < event.results.length; ++i) {
      if (event.results[i].isFinal) {
        final_transcript += event.results[i][0].transcript;
      } else {
        interim_transcript += event.results[i][0].transcript;
      }
    }

    return {
      finalTranscript: final_transcript,
      interimTranscript: interim_transcript,
    };
  }

  // detect trigger word to begin
  detectTriggerWord(interimTranscript) {
    // const triggers = ["start", "begin"]
    // let triggerLength = triggers.length

    // for (let i = 0; i < triggerLength; i++){
    //   if (finalTranscript.includes(triggers[i]) == true || interimTranscript.includes(triggers[i]) == true) {
    //     console.log("Trigger Detected")
    //     this.stopRecording()

    //     window.handleRecording(this.element);
    //     // Begin the actual recording of the music lesson
    //   }

    // }

    const triggers = [/\bstart\w*/i, /\bbegin\w*/i];
    let triggerLength = triggers.length;

    for (let i = 0; i < triggerLength; i++) {
      if (
        interimTranscript.match(triggers[i]) !== null
      ) {
          console.log("Trigger Detected");
          this.stopRecording();
          window.handleRecording(this.element);
          break;
      }
    }

    
  }

  // Handle the click event on the start button
  record() {
    if (!this.speechRecognition) {
      console.error("Speech recognition is not available.");
      return;
    }

    const startButton = this.startButtonTarget;
    if (this.speaking) {
      console.log("Already recording")
    } else {
      this.startRecording();
      console.log("testtesttest")
    }
  }

  // Start recording
  startRecording() {
    this.speechRecognition.start();
    this.speaking = true;
    console.log("Recording...");
  }

  // Stop recording
  stopRecording() {
    this.speechRecognition.stop();
    this.speaking = false;
    console.log("Stopped recording.");
  }
}