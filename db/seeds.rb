# seeds.rb

# User
# Create an admin user
User.where(email: 'admin@example.com').first_or_create(
  password: 'Password1234',
  password_confirmation: 'Password1234',
  role: 2, # Admin role
  username: 'admin_username',
  full_name: 'Admin Full Name'
)

# Create 5 student users
5.times do |n|
  User.where(email: "student#{n + 1}@example.com").first_or_create(
    password: 'Password1234',
    password_confirmation: 'Password1234',
    role: 0, # Student role
    username: "student_username#{n + 1}",
    full_name: "Student Full Name #{n + 1}",
    avatar_id: 1,
    level: 1,
    xp_points: 0,
    xp_needed_for_next_level: 0,
    old_enough_for_cooler_avatars: false
  )
end

# Create 3 teacher users
3.times do |n|
  User.where(email: "teacher#{n + 1}@example.com").first_or_create(
    password: 'Password1234',
    password_confirmation: 'Password1234',
    role: 1, # Teacher role
    username: "teacher_username#{n + 1}",
    full_name: "Teacher Full Name #{n + 1}"
  )
end

# Tasks
students = User.where(role: 'student')
teachers = User.where(role: 'teacher')

# Assign each task to a different teacher
students.each do |student|
  3.times do |i|
    teacher = teachers[i]
    
    task_attributes = {
      student: student,
      teacher: teacher,
      time_set: Time.now
    }

    case i
    when 0
      Task.create!(task_attributes.merge(
        name: 'Practice scales and arpeggios',
        reward_xp: 30,
        deadline: 1.week.from_now,
        status: 0,
        description: 'Practice the C major scale and arpeggio patterns for 30 minutes.'
      ))
    when 1
      Task.create!(task_attributes.merge(
        name: 'Learn a new song',
        reward_xp: 80,
        deadline: 1.days.from_now,
        status: 1,
        description: 'Learn to play the song "Imagine" by John Lennon on your instrument.'
      ))
    when 2
      Task.create!(task_attributes.merge(
        name: 'Prepare for recital',
        reward_xp: 100,
        deadline: 6.days.from_now,
        status: 2,
        description: 'Practice and memorize your pieces for the upcoming recital performance.'
      ))
    end
  end
end