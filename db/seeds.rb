# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Dir.glob(Rails.root.join('db', 'seeds', '*.yml')).each do |yml|
  klass_name = File.basename(yml, '.yml')
  klass = klass_name.singularize.camelize.constantize
  klass.transaction do
    klass.destroy_all
    YAML.load_file(yml).reject {|key, _value| key.start_with?('default_')}.each_value do |value|
      record = klass.new
      record.attributes = value
      record.save!
    end
  end
  puts "#{klass} was loaded."
end
