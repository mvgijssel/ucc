require 'faker'

namespace :db do

  desc 'Fill the database with sample data'


  task :populate => :environment do

    Rake::Task['db:reset'].invoke

    make_accommodations

    Rake::Task['db:test:prepare'].invoke

  end

end

def make_accommodations

  # 100 times
  100.times do

    # create title based on 5 words
    title = Faker::Lorem.sentence(5)

    # create content based on 3 paragraphs
    content = Faker::Lorem.paragraphs(3)

    # create the accommodation in the database
    Accommodation.create!(:title => title, :content => :content)

  end

end