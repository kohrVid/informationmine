Feature: Posts

  Background:
    Given there are some interesting posts

  Scenario: A geek views a question
    Given she is looking at the homepage
    When she reads more about a question
    Then she should see some answers
  
  @wip
  Scenario: A geek views questions about a given tag
    Given there are some posts tagged "Ruby"
    And she is looking at the homepage
    When she selects the "Ruby" category
    Then she sees only the posts about "Ruby"
