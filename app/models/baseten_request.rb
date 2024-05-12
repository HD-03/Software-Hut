# == Schema Information
#
# Table name: baseten_requests
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  request_id :string
#  user_id    :bigint           not null
#
# Indexes
#
#  index_baseten_requests_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class BasetenRequest < ApplicationRecord
  belongs_to :student, -> { where(role: 0) }, class_name: 'User', foreign_key: 'user_id'

  # method makes API call to Baseten server with Stable Diffusion XL
  def generate_avatar(baseten_api_key, model_id, prompt)
    # Set prompts and controlnet image
    values = {
      "seed" => rand(1..1000000000000000),
      "steps" => 30,
      "cfg" => 7,
      "positive_prompt" => prompt, #"cheerful smiling pirate, closeup portrait, 32-bit pixel art, beach background with palm trees, ocean, sand, colorful, vibrant, playful cartoon style, happy friendly expression, jaunty pirate hat, parrot on shoulder",
      "negative_prompt" => "bad quality, bad anatomy, worst quality, low quality, low resolution, extra fingers, blur, blurry, ugly, wrong proportions, watermark, image artifacts, lowres, jpeg artifacts, deformed, noisy image, deformation, corrupt image",
      "safety_sensitivity" => 0.7
    }

    webhook_endpoint = "https://team09.demo2.hut.shefcompsci.org.uk/webhooks/baseten"

    # Call model endpoint
    response = HTTParty.post(
      "https://model-#{model_id}.api.baseten.co/development/async_predict",
      headers: { "Authorization" => "Api-Key #{baseten_api_key}" },
      body: { 
        "model_input" => { "workflow_values" => values },
        "webhook_endpoint" => webhook_endpoint
      }.to_json,
      format: :plain
    )
    
    # Create request
    request_id = JSON.parse(response)["request_id"]
    request_id
  end
end
