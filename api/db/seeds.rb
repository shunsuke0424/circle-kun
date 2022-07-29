# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'
# 開発用のテストデータ

if Keyword.count.zero?
  instances = CSV.open('db/keyword.csv', headers: true).to_a.map do |row|
    {
      content: row['content'],
      created_at: Time.now,
      updated_at: Time.now
    }
  end
  Keyword.insert_all instances
end

if Athletic.count.zero?
  instances = CSV.open('db/athletic_category.csv', headers: true).to_a.map do |row|
    {
      name: row['name'],
      created_at: Time.now,
      updated_at: Time.now
    }
  end
  Athletic.insert_all instances
end

if Culture.count.zero?
  instances = CSV.open('db/culture_category.csv', headers: true).to_a.map do |row|
    {
      name: row['name'],
      created_at: Time.now,
      updated_at: Time.now
    }
  end
  Culture.insert_all instances
end

if Art.count.zero?
  instances = CSV.open('db/art_category.csv', headers: true).to_a.map do |row|
    {
      name: row['name'],
      created_at: Time.now,
      updated_at: Time.now
    }
  end
  Art.insert_all instances
end

if Rails.env.development?
  athletics = Athletic.all.index_by(&:name)
  cultures = Culture.all.index_by(&:name)
  arts = Art.all.index_by(&:name)

  company_hashes = CSV.open('db/circle_database5.csv', headers: true,liberal_parsing: true).to_a.map do |row|
    {
      name: row['name'],
      company_category: row['company_category'],
      detail: row['detail'],
      images_path: row['images_path'],
      hp_link: row['hp_link'],
      twitter_link: row['twitter_link'],
      instagram_link: row['instagram_link'],
      number: row['number'],
      category_detail: row['category_detail'],
      places: row['places'],
      activity_day: row['activity_day'],
      keywords: row['keywords'],
      created_at: Time.now,
      updated_at: Time.now
    }
  end

  company_hashes.each do |hash|
    company = Company.find_or_initialize_by(name: hash[:name])
    if hash[:places]
      place_arry = hash[:places].split(',')
      company.company_places = place_arry.map do |place|
        company.company_places.build(place: place)
      end
    end
    if hash[:keywords]
      keyword_arry = hash[:keywords].to_s.split(/[[:space:]]/).reject(&:blank?).uniq
      company.company_keywords = keyword_arry.map do |content|
        keyword = Keyword.create_or_find_by(content: content)
        company.company_keywords.build(keyword: keyword)
      end
    end
    if hash[:activity_day]
      activity_day_arry = hash[:activity_day].split(',')
      company.company_activity_days = activity_day_arry.map do |day|
        company.company_activity_days.build(activity_day: day)
      end
    end
    if hash[:company_category] == 'athletic'
      company.update!(
        athletic: athletics[hash[:category_detail]],
        number: hash[:number],
        company_category: hash[:company_category],
        detail: hash[:detail],
        images_path: hash[:images_path],
        hp_link: hash[:hp_link],
        twitter_link: hash[:twitter_link],
        instagram_link: hash[:instagram_link],
      )
    elsif hash[:company_category] == 'culture'
      company.update!(
        culture: cultures[hash[:category_detail]],
        number: hash[:number],
        company_category: hash[:company_category],
        detail: hash[:detail],
        images_path: hash[:images_path],
        hp_link: hash[:hp_link],
        twitter_link: hash[:twitter_link],
        instagram_link: hash[:instagram_link],
      )
    else
      company.update!(
        art: arts[hash[:category_detail]],
        number: hash[:number],
        company_category: hash[:company_category],
        detail: hash[:detail],
        images_path: hash[:images_path],
        hp_link: hash[:hp_link],
        twitter_link: hash[:twitter_link],
        instagram_link: hash[:instagram_link],
      )
    end
  end
end