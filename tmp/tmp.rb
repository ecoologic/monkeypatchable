
class Date
  Monkeypatch.add do # <= functionality provided by the gem
    def self.safe_parse(value, default: :unparsable_date) # <= new method in foreign class
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







module FooModule
  def self.included(base)
    puts "Class eval"
    class_eval do
      puts self.inspect
      puts inspect
    end

    puts "Instance eval"
    instance_eval do
      puts self.inspect
      puts inspect
    end
  end
end

class Klass

  def self.bar
    puts 'class'
  end

end
Klass.send(:include, FooModule)
