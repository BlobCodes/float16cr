{% for convert_type in ["Float32", "Float64", "UInt8", "Int8", "UInt16", "Int16", "UInt32", "Int32", "UInt64", "Int64", "UInt128", "Int128"] %}
  struct {{convert_type.id}}
    def to_f16 : Float16
      Float16.new(self)
    end

    def to_f16! : Float16
      Float16.new!(self)
    end

    {% for op, desc in {
                         "==" => "equal to",
                         "!=" => "not equal to",
                         "<"  => "less than",
                         "<=" => "less than or equal to",
                         ">"  => "greater than",
                         ">=" => "greater than or equal to",
                       } %}
      # Returns `true` if `self` is {{desc.id}} *other*.
      def {{op.id}}(other : Float16) : Bool
        self {{op.id}} other.to_f32
      end
    {% end %}

    {% if convert_type.starts_with?("F") %}
      # Returns the float division of `self` and *other*.
      def fdiv(other : Float16) : self
        self.fdiv(other.to_f32)
      end
    {% end %}

    {% for op, desc in {"+" => "adding", "-" => "subtracting", "*" => "multiplying"} %}
      {% if convert_type.starts_with?("F") %}
        # Returns the result of {{desc.id}} `self` and *other*.
        def {{op.id}}(other : Float16) : self
          self {{op.id}} other.to_f32
        end
      {% else %}
        # Returns the result of {{desc.id}} `self` and *other*.
        def {{op.id}}(other : Float16) : Float16
          (self {{op.id}} other.to_f32).to_f16
        end
      {% end %}
    {% end %}

    Number.expand_div [Float16], {{convert_type.starts_with?("F") ? convert_type.id : "Float16".id}}
  end
{% end %}

{% for convert_type in ["BigDecimal", "BigFloat", "BigInt", "BigRational", "Complex"] %}
  def to_f16 : Float16
    Float16.new(self)
  end
{% end %}
