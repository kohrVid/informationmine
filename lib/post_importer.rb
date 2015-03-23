require 'nokogiri'

class PostImporter < Nokogiri::XML::SAX::Document
  # A logger to output to the screen
  attr_accessor :logger

  # A counter to increment each time you find a page
  attr_accessor :post_count

  # The output SQL file
  attr_accessor :sql

  # The contents of the last page as a hash
  attr_accessor :last_post

  def initialize(logger)
    self.logger = logger
    self.post_count = 0
    self.last_post = { :parent_id => :NULL }
  end

  def start_document
    logger.debug "Start document"
  end

  def end_document
    logger.debug "End document"
  end

  def characters(c)
    logger.debug c.strip.chomp if c
  end

  def start_element(name, attrs)
    logger.debug "Found element #{name}"
  end

  def end_element(name)
    logger.debug "Finished element #{name}"
  end

  protected
  # Remove any unwanted whitespace and escape single quotes for use in PSQL
  #
  def clean(s)
    s.strip.gsub("'", "''")
  end

  def handle_end_element
  end

  # Build an output SQL filename based on the current file count. Increment
  # @output_file_count every 50k results to spread the statements into smaller
  # chunks.
  #
  def output_file_name
  end
end