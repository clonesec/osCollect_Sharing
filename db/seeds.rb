admin = User.where(username: 'admin').first
if admin
  puts "admin found: id: #{admin.id}"
else
  puts "admin not found, so creating it!"
  # create at least one admin user:
  # u = User.create!(username: 'admin', email: 'change_me@gmail.com', password: 'change_me', password_confirmation: 'change_me')
  u = User.create!(username: 'admin', email: 'cleesmith2006@gmail.com', password: 'mollydog', password_confirmation: 'mollydog')
end
