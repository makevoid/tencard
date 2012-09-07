class String

  def blank?
    self == ""
  end

  def nilblank
    return nil if self == ""
    self
  end

end

class NilClass
  alias :blank? :nil?

  def nilblank
    self
  end
end

class DateTime
  def formatted
    strftime "%H:%M - %d %b %Y"
  end
end