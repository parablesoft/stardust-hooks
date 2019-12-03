Dir[Rails.root.join(__dir__).join("mutations/**/*.rb")].each do |file|
  load file
end
