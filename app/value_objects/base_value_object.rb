class BaseValueObject
  def self.calculate(**arguments)
    new(arguments).value
  end
end
