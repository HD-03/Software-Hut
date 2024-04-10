# seeds.rb

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
