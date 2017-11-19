class Container
  extend Dry::Container::Mixin

  register :shapeshift_client do
    ShapeShiftRuby::Client.new
  end
end
