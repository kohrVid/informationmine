Feature: Posts

  Background:
    Given there are some interesting posts
    And a geek has registered
    And is signed in

  Scenario: A geek views a question
    Given she is looking at the homepage
    When she reads more about a question
    Then she should see some answers
  
  Scenario: A geek views questions about a given tag
    Given there are some posts tagged "Ruby"
    And she is looking at the homepage
    When she selects the "Ruby" category
    Then she sees only the posts about "Ruby"

  @wip
  Scenario: A geek answers a question
    Given she is looking at the homepage
    When she reads more about a question
    And she insightfully answers the question
    Then she should see confirmation that the question was saved
    And her question appears at the bottom of the list
    And the questioner receives an email notification
