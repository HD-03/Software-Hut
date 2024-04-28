FactoryBot.define do
  factory :task do
    name { "Task Name" }
    description { "Task Description" }
    deadline { Date.tomorrow }
    recording_boolean { false }
    reward_xp { 100 }
    time_set { Time.current }
    status { :todo }
    
    association :teacher, factory: :user, role: 1
    association :student, factory: :user, role: 0
    association :instrument
  end
end