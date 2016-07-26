Given(/^a number of posts already exist$/) do
  40.times do |i|
    instance_variable_set :"@post#{i + 1}", 
      Post.create!(id: i+1, title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph)
  end
end

Given(/^that a user has visited the index page$/) do
  visit posts_path
end

Given(/^that a user has visited page (\d+) of the posts on the index page$/) do |arg1|
  visit posts_path(page_size: 20, page: 2)
end

When(/^they click the Next button$/) do
  save_and_open_page
  click_on "Next"
end

When(/^they click the Previous button$/) do
  click_on "Previous"
end

Then(/^they should be able to see the next (\d+) posts by default$/) do |arg1|
  expect(page).to have_content(@post40.body)
end

Then(/^they should be able to see the previous (\d+) posts by default$/) do |arg1|
  expect(page).to have_content(@post1.body)
end

