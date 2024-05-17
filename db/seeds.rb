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
    level: rand(10..20),
    xp_points: rand(30..200),
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

# Instruments
instruments = [
  "Flute",
  "Recorder",
  "Oboe",
  "Clarinet",
  "Saxophone",
  "Bassoon",
  "French Horn",
  "Trumpet",
  "Trombone",
  "Tuba",
  "Percussion",
  "Guitar",
  "Harp",
  "Voice",
  "Violin",
  "Viola",
  "'Cello",
  "Double Bass",
  "Piano",
  "Organ",
  "Harpsichord"
]

instruments.each do |instrument_name|
  Instrument.find_or_create_by(name: instrument_name)
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
        deadline: Date.today,
        status: 0,
        description: 'Practice the C major scale and arpeggio patterns for 30 minutes.',
        instrument_id: 1
      ))
    when 1
      Task.create!(task_attributes.merge(
        name: 'Learn a new song',
        reward_xp: 80,
        deadline: 1.days.from_now,
        status: 1,
        description: 'Learn to play the song "Imagine" by John Lennon on your instrument.',
        instrument_id: 3
      ))
    when 2
      Task.create!(task_attributes.merge(
        name: 'Prepare for recital',
        reward_xp: 100,
        deadline: 2.days.from_now,
        status: 2,
        description: 'Practice and memorize your pieces for the upcoming recital performance.',
        instrument_id: 5
      ))
    end
  end
end