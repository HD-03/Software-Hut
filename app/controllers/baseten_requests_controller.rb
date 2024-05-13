class BasetenRequestsController < ApplicationController
  before_action :authenticate_user!

  def create
    student = User.find_by(id: baseten_request_params[:student_id])
    puts student.username
    request = BasetenRequest.new(user_id: student.id)

    # # Call the generate_avatar method and assign the returned request_id
    request.request_id = request.generate_avatar(baseten_api_key, model_id) # pass string prompt
    

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
    params.permit(:student_id, :_method, :authenticity_token) # add string prompt
  end

  def baseten_api_key
    Rails.application.credentials.api_key
  end

  def model_id
    Rails.application.credentials.model_id
  end
end
