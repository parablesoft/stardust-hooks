class Stardust::Hooks::Subscription


  def initialize(event_name: nil,model: nil)
    if model
      @model = model
      @event = event_name
    else
      @model,@event = event_name.split(".")
    end
  end



  def subscribe
    model_class.subscribe(event_as_symbol) do |event|
      yield event
    end
  end

  private

  def model_class
    model.is_a?(String) ? 
      model.classify.constantize :
      model
  end

  def event_as_symbol
    event.to_sym
  end

  attr_reader :model,
    :event
end
