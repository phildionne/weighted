p "--- Seeding users"
5.times do
  FactoryGirl.create(:user)
end

p "--- Seeding collections with sources and contents"
40.times do
  FactoryGirl.create(:collection_with_sources_and_contents)
end

p "--- Making users following collections"
User.order('RANDOM()').each do |user|
  Collection.order('RANDOM()').limit([4, 8, 12].sample).each do |collection|
    user.follow!(collection)
  end
end
