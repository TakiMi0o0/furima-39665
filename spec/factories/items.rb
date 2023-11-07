FactoryBot.define do
  factory :item do
    description      {Faker::Lorem.sentence}
    price            { rand(100..9999999) }
    item_name        {Faker::Name.name}
    category_id      { 1 }
    item_status_id   { 1 }
    shipping_fee_id  { 1 }
    prefecture_id    { 1 }
    shipping_date_id { 1 }
    association :user 

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
