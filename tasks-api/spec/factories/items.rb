FactoryBot.define do
  factory :item do
    name { Faker::StarWars.character }
    done { false }
    task_id nil
  end
end