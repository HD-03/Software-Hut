class BasetenRequestsController < ApplicationController
  before_action :authenticate_user!

  def create
    student = User.find_by(id: baseten_request_params[:student_id])
    puts student.username
    request = BasetenRequest.new(user_id: student.id)
    not_cooler_avatars = "playful cartoon style, "
    pre_prompt_setup = "closeup portrait, 32-bit pixel art, colorful, vibrant"
    pre_prompt_setup = not_cooler_avatars + pre_prompt_setup if !student.old_enough_for_cooler_avatars

    prompt = [pre_prompt_setup,
              params[:background] + " background",
              params[:weather] + " weather",
              params[:character] + " character",
               params[:expression] + " facial expression",
              params[:facial_hair], params[:time_period],
              params[:accessory]].compact.join(', ')

    # # Call the generate_avatar method and assign the returned request_id
    # request.request_id = request.generate_avatar(baseten_api_key, model_id, prompt) # pass string prompt
    request.request_id = request.generate_avatar("dummy_api_key", "dummy_model_id", prompt)

    if request.save
      redirect_to students_path, notice: 'Avatar was successfully requested.'
    else
      puts request.errors.full_messages
      redirect_to students_path, notice: 'Oops! something went wrong', status: :unprocessable_entity
    end
  end

  private
  # Only allow a list of trusted parameters through.
  def baseten_request_params 
    # Create a new parameters object with only the permitted attributes
    params.permit(:student_id, :authenticity_token, :background, :weather, :character, :expression, :facial_hair, :time_period, :accessory)
    #params.permit(:student_id, :_method, :authenticity_token, :prompt) # add string prompt
  end

  def baseten_api_key
    Rails.application.credentials.api_key
  end

  def model_id
    Rails.application.credentials.model_id
  end
end
