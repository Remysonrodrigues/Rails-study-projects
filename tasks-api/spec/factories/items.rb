FactoryBot.define do
  factory :item do
    name { Faker::Movies::StarWars.character }
    done { false }
    task_id { nil }
  end
end