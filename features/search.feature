Feature: Searching Posts
  Background:
    Given there are some interesting posts
      And there is a post entitled "Ruby"
      And the sphinx index has been updated
      Given she is looking at the homepage

  @sphinx
  Scenario: A geek searches for a post
    When they search for "Ruby"
    Then they see a post entitled "Ruby"
      And there should be 1 result.

  @sphinx
  Scenario: A geek searches for a post by partial match
    When they search for "uby"
    Then they see a post entitled "Ruby"
    And there should be 1 result.

  @sphinx
  Scenario: a geek searched for a post with a spelling error
    When they search for "Tuby"
    Then they should see an alternative search suggestion for "Ruby"
    When they search for that alternative
    Then they see a post entitled "Ruby"
    And there should be 1 result.

  @sphinx
  Scenario: A geek searches for a plural
    When they search for "Rubies"
    Then they see a post entitled "Ruby"
      And there should be 1 result.

