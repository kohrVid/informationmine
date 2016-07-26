require 'nokogiri'
require "active_record"
require "./app/models/post"

class PostImporter < Nokogiri::XML::SAX::Document
  # A logger to output to the screen
  attr_accessor :logger

  # A counter to increment each time you find a page
  attr_accessor :post_count

  # The output SQL file
  attr_accessor :sql

  # The contents of the last page as a hash
  attr_accessor :last_post

  attr_accessor :output_file_count

  def initialize(logger)
    @logger = logger
    @post_count = 0
    @output_file_count = 0
    @last_post = { :parent_id => :NULL }
  end

  def start_document
    logger.debug "start_document"
  end

  def characters(c)
    logger.debug c.strip.chomp if c
  end

  def start_element(name, attrs)
    attrs.each do |k, v|
      if k == "Id"
	@last_post[:id] = v.to_i
      elsif k == "AcceptedAnswerId"
	@last_post[:accepted_answer_id] = v.to_i
      elsif k == "Score"
	@last_post[:score] = v.to_i
      elsif k == "ViewCount"
	@last_post[:view_count] = v.to_i
      elsif k == "Body"
	@last_post[:body] = clean(v)
      elsif k == "Title"
	@last_post[:title] = clean(v)
      elsif k == "AnswerCount"
	@last_post[:answer_count] = v.to_i
      elsif k == "Tags"
	@last_post[:tags] = v.gsub("><", " ").gsub(/<|>/, "").split(" ")
      elsif k == "CreationDate"
	@last_post[:created_at] = v.gsub(/\..*/, "")
      elsif k == "LastEditDate"
	@last_post[:updated_at] = v.gsub(/\..*/, "")
      end
    end
    logger.debug 'start_element("#{name}", attrs)'
  end

  def end_element(name)
    handle_end_element(name)
    if name == "row"
      @post_count += 1
      sql_statement = "INSERT INTO posts (id, parent_id, created_at, updated_at, title, body, accepted_answer_id, score, view_count, answer_count) VALUES (#{@last_post[:id]}, #{@last_post[:parent_id]}, '#{@last_post[:created_at]}', '#{@last_post[:updated_at]}', '#{@last_post[:title]}', '#{@last_post[:body]}', #{@last_post[:accepted_answer_id]}, #{@last_post[:score]}, #{@last_post[:view_count]}, #{@last_post[:answer_count]});"
      @sql_file = File.open(output_file_name(@post_count), "a+")
      @sql_file.write(sql_statement + "\n")
    end
    logger.debug 'end_element("#{name}")'
  end

  def end_document
    @sql_file.close
    logger.debug "end_document"
  end

  protected
  # Remove any unwanted whitespace and escape single quotes for use in PSQL
  
    def clean(s)
      s.strip.gsub("'", "\''").gsub(/^\R/, "\ ") unless s.nil?
    end

    def handle_end_element(s)
      if s =~ /<\//.nil? 
	s.gsub!(/>\s*/, ">")
      end
    end

    # Build an output SQL filename based on the current file count. Increment
    # @output_file_count every 50k results to spread the statements into smaller
    # chunks.
    #
    def output_file_name(count)
      if count % 50000 == 0
        @output_file_count += 1
      end
      "./tmp/posts-#{@output_file_count}.sql"
    end
end
