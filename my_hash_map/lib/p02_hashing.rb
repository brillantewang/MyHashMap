class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    result = map { |el| el.hash.abs }.join('')
    puts result.inspect
    result.to_i.hash
  end
end

class String
  def hash
    result = chars.map(&:ord).join('')
    result.to_i.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    sort_by { |k, v| k }.hash
  end
end
