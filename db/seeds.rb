admin = User.new(
  name: "Admin User",
  email: "admin@example.com",
  password: "helloworld",
  role: "admin"
  )
admin.skip_confirmation!
admin.save!

premium = User.new(
  name: "Premium User",
  email: "premium@gmail.com",
  password: "helloworld",
  role: "premium"
  )
premium.skip_confirmation!
premium.save!

standard = User.new(
  name: "Member",
  email: "member@example.com",
  password: "helloworld",
  )
standard.skip_confirmation!
standard.save!

users = User.all

10.times do
  Wiki.create!(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph,
    user: users.sample,
    private: false
    )
end
  