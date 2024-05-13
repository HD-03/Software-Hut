# Webhook to receive API request with generated image from Baseten server

class Webhooks::BasetenController < ApplicationController
  skip_forgery_protection
  skip_before_action :authenticate_user!, only: [:create]

  before_action :verify_request

  def create
    Webhooks::BasetenJob.perform_later(payload)

    head :ok
  end

  private

  def verify_request
    puts "====================================================================="
    puts ""
    puts ""
    puts "====================================================================="
  end

  def payload
    @payload ||= request.body.read
  end
end
