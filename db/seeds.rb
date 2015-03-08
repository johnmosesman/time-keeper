user = User.find_by_email("johnmosesman@gmail.com")

user.categories.destroy_all

categories = [
  { title: "Sleep", amount: 8 },
  { title: "Read", amount: 0.5 },
  { title: "Housework", amount: 0.5 },
  { title: "Program", amount: 1 },
]

categories.each { |category| user.categories.create(category) }

user.categories.each do |category|
  start_date = Date.parse(4.weeks.ago.strftime("%Y-%m-%d"))
  end_date = Date.parse(Date.today.strftime("%Y-%m-%d"))

  start_date.upto(end_date).each do |date_string|
    value = rand(category.amount*3/4..category.amount*1.25).round(1)
    Record.create(amount: value, category_id: category.id, created_at: date_string)
  end
end
