require "google/cloud/speech"

class VoiceRecognition
  def initialize
    @speech = Google::Cloud::Speech.new
    
    @stream = speech.stream encoding: :raw, sample_rate: 16000
  end

  


  stream.on_result do |results|
    result = results.first 
    puts result.transcript
  end

  5.times.do stream.send MicrophoneInput.read(32000)

  stream.stop
end



