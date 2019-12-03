Dir[Rails.root.join(__dir__).join("queries/**/*.rb")].each do |file|
  load file
end
