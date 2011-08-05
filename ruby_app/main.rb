require 'erb'

##################################################################################
#                               TASK DESCRIPTION                                 #
##################################################################################
#
# Write a ruby script that:
#
# a. Receives a log as argument (webserver.log is provided)
#   e.g.: ./parser.rb webserver.log
#
# b. Returns the following:
#
#   > list of webpages with most page views ordered from most pages views to less page views
#      e.g.:
#          /home 90 visits
#          /index 80 visits
#          etc...
#   > list of webpages with most unique page views also ordered
#      e.g.:
#          /about/2   8 unique views
#          /index     5 unique views
#          etc...

##################################################################################
#                                   CONSTANTS                                    #
##################################################################################

INCORRECT_INPUT_ARGUMENT = 'Please specify log file as argument, and try again!'
FILE_NOT_FOUND = ' file was not found. Script will be interrupted.'

##################################################################################
#                                   HELPERS                                      #
##################################################################################

def get_argument
  log_file = ARGV.last
  if log_file.nil?
    puts INCORRECT_INPUT_ARGUMENT
    exit
  end
  log_file
end

def get_file_content(log_file)
  full_path = File.expand_path(log_file)
  unless File.exist?(full_path)
    puts full_path + FILE_NOT_FOUND
    exit
  end
  IO.read(full_path)
end

def get_webpages_with_most_page_views(raw_data)
  res = {}
  data = raw_data.map(&:first)
  data.uniq.each do |uniq_element|
    count = data.find_all {|element| element == uniq_element}.size
    res[uniq_element] = count
  end
  res.to_a.sort{|x,y| y.last <=> x.last }
end

##################################################################################
#                                   MAIN                                         #
##################################################################################

log_content = get_file_content(get_argument)
raw_data = log_content.split("\n").map {|el| el.split(/\s+/)}

most_pages = get_webpages_with_most_page_views(raw_data)
most_uniq_pages = get_webpages_with_most_page_views(raw_data.uniq)
puts ERB.new(IO.read(File.expand_path(File.dirname(__FILE__) + '/output.txt.erb')),  0, true).result(binding)















