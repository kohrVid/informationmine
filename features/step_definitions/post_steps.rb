Given(/^there are some posts tagged "(.*?)"$/) do |arg1|
  post = Post.new(title: title, body: Faker::Lorem.paragraph)
  post.author = Geek.create!(email: Faker::Internet.email,
				 name: Faker::Name.name)
  post.tag = Tag.create!(name: "Ruby")
  post.save!
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



Given(/^a geek has registered$/) do
  @geek = Geek.create!(email: Faker::Internet.email)
end

Given(/^is signed in$/) do
  Rails.logger.warn "This isn't gonna work in development. Replace with real Devise code"
class ApplicationController < ActionController::Base
    def current_geek
      Geek.last
    end
    def geek_signed_in?
      true
    end
  end
end

When(/^she insightfully answers the question$/) do
  @body = Faker::Lorem.paragraph
  fill_in "Body", with: @body
  click_on "Submit Answer"
end

Then(/^she should see confirmation that the question was saved$/) do
  expect(page).to have_content("Your answer was saved")
end

Then(/^her question appears at the bottom of the list$/) do
  expect(page).to have_content(@body)
end

Then(/^the questioner receives an email notification$/) do
  email = ActionMailer::Base.deliveries.last
  expect(email.subject).to match(/#{@geek.name}/)
  expect(email.subject).to match(/just answered your question/)
  #expect(email.subject).to match(/#{@answer.question.title}/)
  expect(email.subject).to match(/#{Post.questions.first.title}/)
  expect(email.to).to include(Post.questions.first.author.email)
  expect(email.from).to include("admin@information-mine.com")

  expect(email.body.encoded).to match(/Hello #{@geek.name}/)
  expect(email.body.encoded).to match(Regexp.new("<a href=\"http://test.host.information-mine.org/posts/1\">click here</a>"))
end
