Given(/^there are some interesting posts$/) do
  3.times { step "there is a post entitled \"#{Faker::Company.bs}\"" }
end

Given(/^there is a post entitled "(.*?)"$/) do |title|
  question = Post.create!(title: title, body: Faker::Lorem.paragraph)
  answer = Post.create!(body: Faker::Lorem.paragraph, parent_id: question.id)
end

Given(/^the sphinx index has been updated$/) do
  ThinkingSphinx::Test.start index: true
end

Given(/^she is looking at the homepage$/) do
  visit root_path
end

When(/^they search for "(.*?)"$/) do |search_term|
  fill_in "search_term", with: search_term
  click_on "Search"
end

When(/^they search for that alternative$/) do
 # step "they search for \"Ruby\""
  click_on "Ruby"
end

Then(/^they should see an alternative search suggestion for "(.*?)"$/) do |alternative|
  expect(page).to have_content("Did you mean #{alternative}?")
end

Then(/^they see a post entitled "(.*?)"$/) do |title|
  within(".search-results") do
    expect(page).to have_content(title)
  end
end

Then(/^there should be (\d+) result\.$/) do |results|
  within(".search-results") do
    expect(all("article.post").length).to eq(results.to_i)
  end
end

