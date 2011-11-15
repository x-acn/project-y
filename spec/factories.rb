FactoryGirl.define do
  
  factory :user do
    email 'andrey@test.com'
    password 'test'
  end
  
  factory :site do
    subdomain 'hello'
    after_create do |s| 
      Factory(:domain, :site => s)
      Factory(:page, :site => s)
    end
  end
  
  factory :domain do
    domain 'world.com'
    association :site
  end
  
  factory :page do
    title 'Hello World'
    association :site
  end
  
#  factory :site_with_associations, :parent => :site do |site|
#    
#  end
  
end
