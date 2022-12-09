json.call(
  company,
  :id,
  :name,
  :number,
  :detail,
  :images_path,
  :hp_link,
  :twitter_link,
  :instagram_link,
  :company_category
)
json.athletic do
  json.partial! 'athletics/athletic', athletic: company.athletic
end
json.art do
  json.partial! 'arts/art', art: company.art
end
json.culture do
  json.partial! 'cultures/culture', culture: company.culture
end
keywords = company.keyword
json.keywords keywords.uniq.map do |keyword|
  json.merge! keyword
end

json.places company.company_places.map do |place|
  json.merge! place
end
json.activity_day company.company_activity_days.map do |day|
  json.merge! day
end

json.member company.users
