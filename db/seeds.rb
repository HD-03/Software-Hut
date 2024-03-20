students = [
  { username: "student1", hashed_password: "hashedpassword1", full_name: "Student One", email: "student1@example.com", avatar_id: 1, background_id: 1, unchecked_background: false, level: 1, xp_points: 10, reward_points: 5, membership: true },
  { username: "student2", hashed_password: "hashedpassword2", full_name: "Student Two", email: "student2@example.com", avatar_id: 2, background_id: 1, unchecked_background: true, level: 2, xp_points: 20, reward_points: 10, membership: false },
  { username: "student3", hashed_password: "hashedpassword3", full_name: "Student Three", email: "student3@example.com", avatar_id: 1, background_id: 2, unchecked_background: false, level: 1, xp_points: 15, reward_points: 7, membership: true },
  { username: "student4", hashed_password: "hashedpassword4", full_name: "Student Four", email: "student4@example.com", avatar_id: 2, background_id: 2, unchecked_background: true, level: 3, xp_points: 30, reward_points: 20, membership: false },
  { username: "student5", hashed_password: "hashedpassword5", full_name: "Student Five", email: "student5@example.com", avatar_id: 1, background_id: 1, unchecked_background: false, level: 2, xp_points: 25, reward_points: 15, membership: true }
]

teachers = [
  { username: "teacher1", hashed_password: "securepassword", full_name: "Teacher One", email: "teacher1@example.com" },
]

teacher_records = teachers.map do |teacher_params|
  Teacher.create!(teacher_params)
end

first_teacher_id = teacher_records.first.id

student_records = students.map do |student_params|
  Student.create!(student_params)
end

tasks = [
  { teacher_user_id: 1, name: "Task A", time_set: Time.current, deadline: 1.week.from_now, base_experience_points: 100, status: 0 },
  { teacher_user_id: 1, name: "Task B", time_set: Time.current, deadline: 1.week.from_now, base_experience_points: 200, status: 0 },
]

task_records = tasks.map do |task_params|
  Task.create!(task_params)
end

student_records.each do |student|
  # Randomly assign 1-3 tasks to each student
  task_records.sample(rand(1..3)).each do |task|
    StudentsTask.create!(student: student, task: task)
  end
end
