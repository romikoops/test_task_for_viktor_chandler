def serial_gen
  rand(99999)
end

def get_path_to_test_data
  File.join(File.dirname(__FILE__), 'test_data')
end

def prepare_path_for_attachment(path)
  path = path.gsub(File::SEPARATOR, File::ALT_SEPARATOR) unless File::ALT_SEPARATOR.nil?
  path
end