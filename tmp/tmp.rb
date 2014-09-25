class Date
  Monkeypatch.add do # <= functionality provided by the gem
    def self.safe_parse(value, default: nil) # <= new method in foreign class
      Date.parse(value.to_s)
    rescue ArgumentError
      default
    end
  end
end

class BigDecimal
  Monkeypatch.override do # <= functionality provided by the gem
    def inspect # <= existing method in external class
      "#<BigDecimal #{to_f}>"
    end
  end
end
