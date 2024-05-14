let completedRecordings = 0;
let recordingIndex = 1;
let chunks = [];
let mediaRecorder;

window.handleRecording = function(button) {
  const recordingSet = button.closest('.recording-set');
  const playRecordingBtn = recordingSet.querySelector('.play-recording-btn');

  if (button.textContent.includes('Start')) {
    console.log("YEY")
    startRecording(button, playRecordingBtn);
  } else {
    console.log("NEY")
    stopRecording(button, playRecordingBtn);
  }
}

window.startRecording = function(recordBtn, playBtn) {
  recordBtn.textContent = 'Stop Recording';
  recordBtn.classList.replace('btn-success', 'btn-danger');

  navigator.mediaDevices.getUserMedia({ audio: true })
    .then(stream => {
      mediaRecorder = new MediaRecorder(stream);
      mediaRecorder.start();

      mediaRecorder.addEventListener('dataavailable', event => {
        chunks.push(event.data);
      });

      mediaRecorder.addEventListener('stop', () => {
        const blob = new Blob(chunks, { type: 'audio/wav' });

        const audioInput = document.createElement('input');
        audioInput.type = 'file';
        audioInput.name = 'task[recordings][]';
        audioInput.style.display = 'none';

        const dataTransfer = new DataTransfer();
        dataTransfer.items.add(new File([blob], `recording_${completedRecordings}.wav`, { type: 'audio/wav' }));
        audioInput.files = dataTransfer.files;

        document.getElementById('audio-inputs').appendChild(audioInput);

        chunks = [];
        const audioURL = URL.createObjectURL(blob);
        playBtn.setAttribute('data-audio-url', audioURL);
      });
    })
    .catch(error => {
      console.error('Error accessing media devices:', error);
    });
}

window.stopRecording = function(recordBtn, playBtn) {
  recordBtn.textContent = 'Recording Done';
  recordBtn.classList.replace('btn-danger', 'btn-secondary');
  playBtn.disabled = false;

  mediaRecorder.stop();

  completedRecordings++;
  if (completedRecordings >= 2) {
    document.getElementById('complete-task').style.display = 'block';
  }
}

window.playRecording = function(button) {
  const audioURL = button.getAttribute('data-audio-url');
  const audio = new Audio(audioURL);
  audio.play();
}

window.addRecording = function() {
  recordingIndex++;

  const newSet = document.createElement('div');
  newSet.className = 'recording-set border p-3 rounded-4 mt-2';
  newSet.innerHTML = `
    <p class="d-block font-weight-bold">Recording ${recordingIndex}</p>
    <button class="record-btn btn btn-success border-0 rounded-5 shadow-lg py-2 px-3" type="button" onclick="handleRecording(this)">Start Recording</button>
    <button class="play-recording-btn btn btn-secondary border-0 rounded-5 shadow-lg py-2 px-3 ml-2" type="button" disabled onclick="playRecording(this)">Play Recording</button>
  `;

  document.getElementById('recording-controls').appendChild(newSet);
}