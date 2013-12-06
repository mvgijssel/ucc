require 'faker'

namespace :db do

  desc 'Fill database with sample data'

  task :populate => :environment do

    Rake::Task['db:reset'].invoke

    make_users

    make_projects

    make_pages

  end

end

def make_users

  100.times do |n|

    name = Faker::Name.first_name.downcase

    User.create!(:name => name)

  end

end

def make_projects

   4.times do

     Project.create!(:name => Faker::Company.name)

   end

end

def make_pages

  projects = Project.all

  projects.each do |project|

    4.times do

      Page.create!(:title => Faker::Lorem::words(5).join(' '), :content => Faker::Lorem::paragraphs(5).join(' '))

    end

  end

end