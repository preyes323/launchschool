UUID_PATTERN = [8, 4, 4, 4, 12]
def generate_uuid
  chars = []
  ('a'..'z').each { |letter| chars << letter }
  ('0'..'9').each { |digit| chars << digit }

  uuid = ''
  UUID_PATTERN.each_with_index do |pattern, idx|
    pattern.times { uuid += chars.sample }
    uuid += '-' unless idx == UUID_PATTERN.length - 1
  end

  uuid
end

p generate_uuid
