p "--- Seeding users"
20.times do
  FactoryGirl.create(:user)
end

p "--- Seeding collections with contents"
40.times do
  FactoryGirl.create(:collection_with_contents)
end