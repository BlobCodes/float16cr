class String
  # Same as `#to_f` but returns a Float16.
  def to_f16(whitespace : Bool = true, strict : Bool = true)
    to_f32?(whitespace: whitespace, strict: strict).try &.to_f16 || raise ArgumentError.new("Invalid Float16: #{self}")
  end

  # Same as `#to_f?` but returns a Float16.
  def to_f16?(whitespace : Bool = true, strict : Bool = true)
    to_f32?(whitespace, strict).try &.to_f16
  end
end