FactoryBot.define do
  factory :item do
    description      {Faker::Lorem.sentence}
    price            { rand(100..9999999) }
    item_name        {Faker::Name.initials(number: 2)}
    category         { Category.all.sample }
    item_status      { ItemStatus.all.sample }
    shipping_fee     { ShippingFee.all.sample }
    prefecture       { Prefecture.all.sample }
    shipping_date    { ShippingDate.all.sample }

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
