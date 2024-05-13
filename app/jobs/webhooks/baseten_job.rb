# Webhook job to save generated image from Baseten server

class Webhooks::BasetenJob < ApplicationJob
  queue_as :default

  def perform(payload)
    webhook_payload  = JSON.parse(payload, symbolize_names: true)
    
    # Decode
    base64_data =  webhook_payload[:data][:result].first[:data]
    decoded_image = Base64.decode64(base64_data)

    # Save image to Active Storage
    student = BasetenRequest.find_by(request_id: webhook_payload[:request_id]).student
    student.avatar.attach(io: StringIO.new(decoded_image), filename: "avatar.png", content_type: "image/png")
    student.save

    # TODO: delete when deploy
    temp_file_path = Rails.root.join('tmp', 'temp_avatar.png')
    File.open(temp_file_path, "wb") do |file|
      file.write(decoded_image)
    end
  end
end
