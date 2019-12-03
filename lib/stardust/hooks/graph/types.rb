Dir[Rails.root.join(__dir__).join("types/**/*.rb")].each do |file|
  load file
end
