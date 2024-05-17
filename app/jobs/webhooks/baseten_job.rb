# Webhook job to save generated image from Baseten server

class Webhooks::BasetenJob < ApplicationJob
  queue_as :default

  def perform(payload)
    webhook_payload  = JSON.parse(payload, symbolize_names: true)
    
    # Decode
    base64_data =  webhook_payload[:data][:result].first[:data]
    decoded_image = Base64.decode64(base64_data)

    # Save image to Active Storage
    request_id = webhook_payload[:request_id]
    student = BasetenRequest.find_by(request_id: request_id).student

    student.avatar.attach(io: StringIO.new(decoded_image), filename: "#{request_id}.png", content_type: "image/png")
    
    if student.save
      student.generate_tokens -= 1
      student.save
    end
  end
end
