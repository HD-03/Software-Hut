# spec/controllers/tasks_controller_spec.rb
require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:teacher) { create(:user, role: 1) }
  let(:student) { create(:user, role: 0) }
  let(:task) { create(:task, name: "Science Project", teacher: teacher, student: student) }





  before do
    allow(controller).to receive(:authenticate_user!).and_return(true)
  end



  describe "PATCH #update_status_to_pending" do
    before do
      sign_in student
      patch :update_status_to_pending, params: { id: task.id, task: { student_text: "Completed" } }
    end

    it "updates the task's status to pending and assigns reward XP" do
      task.reload
      expect(task.status).to eq('pending')
      expect(task.student_text).to eq('Completed')
    end
  end

  describe "DELETE #destroy" do
    before do
      sign_in teacher
      task
    end

    it "destroys the requested task" do
      expect {
        delete :destroy, params: { id: task.id }
      }.to change(Task, :count).by(-1)
    end

    it "redirects to the teachers path with a notice" do
      delete :destroy, params: { id: task.id }
      expect(response).to redirect_to(teachers_path)
      expect(flash[:notice]).to match(/successfully deleted/)
    end
  end




end
