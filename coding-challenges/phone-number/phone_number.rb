class PhoneNumber
  INVALID_NUM = '0000000000'

  def initialize(phone_number)
    @phone_number = clean(phone_number)
  end

  def number
    valid_phone_number? ? @phone_number[-10..-1] : INVALID_NUM
  end

  def area_code
    number[0, 3]
  end

  def to_s
    "(#{area_code})" + number.sub(/(\d{3})(\d{3})(\d{4})/, " \\2-\\3")
  end

  private

  def clean(phone_number)
    phone_number.gsub(/[^a-z^\d]/, '')
  end

  def valid_phone_number?
    return false if @phone_number =~ /[a-zA-z]/
    @phone_number.size == 11 ? @phone_number =~ /^1/ : @phone_number.size == 10
  end
end
