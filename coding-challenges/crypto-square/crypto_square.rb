class Crypto
  DUMMY_CHAR = '!'

  def initialize(plaintext)
    @plaintext = plaintext
  end

  def normalize_plaintext
    @plaintext.gsub(/[^a-z0-9]/i, '').downcase
  end

  def size
    columns = (normalize_plaintext.size)**(0.5)
    columns.to_s =~ /./ ? columns.ceil : columns
  end

  def plaintext_segments
    segment_text normalize_plaintext, size
  end

  def ciphertext
    padded_ciphertext.gsub(DUMMY_CHAR, '')
  end

  def normalize_ciphertext
    segmented = segment_text(padded_ciphertext, plaintext_segments.size)
    segmented.join(' ').gsub(DUMMY_CHAR, '')
  end

  private

  def pad_text text
    text += DUMMY_CHAR until text.size == size
    text
  end

  def segment_text text, num_segments
    text.chars.each_slice(num_segments)
      .each_with_object([]) { |slice, result| result << slice.join }
  end

  def padded_ciphertext
    padded = plaintext_segments.map { |segment| pad_text segment }
    padded.map(&:chars).transpose.join
  end
end
