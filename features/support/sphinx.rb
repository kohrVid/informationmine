Before('@sphinx') do
  ThinkingSphinx::Test.init
end

After('@sphinx') do
  ThinkingSphinx::Test.stop
  ThinkingSphinx::Test.clear
end
