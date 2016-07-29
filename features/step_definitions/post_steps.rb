Given(/^there are some posts tagged "(.*?)"$/) do |arg1|
  post = Post.create!(title: title, body: Faker::Lorem.paragraph)
  post.tag = Tag.create!(name: "Ruby")
end

When(/^she reads more about a question$/) do
  Capybara.match = :first
  click_on "Read more"
end

When(/^she selects the "(.*?)" category$/) do |tag|
  click_on tag
end

Then(/^she sees only the posts about "(.*?)"$/) do |topic|
  tag = Tag.find_by(name: topic)
  within("ol.posts") do
    expect(page).to have_content(topic)
    expect(page).to have_css("li", count: 1)
  end
end

Then(/^she should see some answers$/) do
  within("ol.answers") do
    expect(page).to have_css("li", count: 1)
  end
end
