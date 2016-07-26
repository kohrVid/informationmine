require 'rubygems'
require 'nokogiri'
require 'logger'
require_relative 'post_importer'
require 'pry'

logger = Logger.new(STDOUT)
logger.level = Logger::INFO

document = PostImporter.new(logger)
parser = Nokogiri::XML::SAX::Parser.new(document)

begin
  parser.parse(File.open(ARGV[0]))

rescue Exception => e

  logger.error "Problem saving file: #{e.message}"
  logger.error e.backtrace
end

puts "Found #{document.post_count} posts"

Dir["./tmp"].each do |file|
#  ActiveRecord::Base.execute File.open(file, "r")
  exec("psql -d InformationMine_development -a -f #{file}")
end

