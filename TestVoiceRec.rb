ruby require google/cloud/speech

speech = Google::cloud::speech.new
audio = speech.audio "Audio source location here"
stream = audio.stream encoding: :raw, sample_rate: 16000

stream.on_result do |results|
  result = results.first
  puts result.transcript
end

5.times.do
  stream.send MicrophoneInput.read(32000)
end

stream.stop



