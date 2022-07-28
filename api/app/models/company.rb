class Company < ApplicationRecord
  has_one :company_athletic, dependent: :destroy
  has_one :athletic, through: :company_athletic
  has_one :company_art, dependent: :destroy
  has_one :art, through: :company_art
  has_one :company_culture, dependent: :destroy
  has_one :culture, through: :company_culture
  has_many :company_keywords, dependent: :destroy
  has_many :keyword, through: :company_keywords
  has_many :company_places, dependent: :destroy
  has_many :company_activity_days, dependent: :destroy

  scope :scope_by_user, ->(search_params) {
    company_category_filter(search_params[:company_category])
      .search_by_keyword(search_params[:keyword])
      .serch_by_places(search_params[:place])
      .serch_by_activity_day(search_params[:day])
      .category_filter(search_params[:company_category],search_params[:category_name])
  }
  scope :company_category_filter, ->(code) {
    case code
    when 'athletics'
      where(company_category: 'athletic')
    when 'cultures'
      where(company_category: 'culture')
    when 'arts'
      where(company_category: 'art')
    end
  }
  scope :category_filter, ->(category_type, category_name) {
    return if category_type.blank? || category_name.blank?

    case category_type
    when 'athletics'
      scope = joins(:company_athletic)
      target = Athletic.where(name: category_name).pluck(:id)
      scope.where(company_athletics: { athletic_id: target })
    when 'cultures'
      scope = joins(:company_culture)
      target = Culture.where(name: category_name).pluck(:id)
      scope.where(company_cultures: { culture_id: target })
    when 'arts'
      scope = joins(:company_art)
      target = Art.where(name: category_name).pluck(:id)
      scope.where(company_arts: { art_id: target })
    end
  }
  scope :search_by_keyword, ->(keyword) {
    return if keyword.blank?

    keywords = Keyword.where(content: keyword.split(/[[:space:]]/))
    company_ids = CompanyKeyword.where(keyword: keywords).pluck(:company_id)
    merge(where(id: company_ids))
      .or(where('name like ?', "%#{keyword}%"))
  }
  scope :serch_by_places, ->(place){
    return if place.blank?

    scope = left_joins(:company_places)
    places = CompanyPlace.where(place: place)
    scope.merge(places)
  }
  scope :serch_by_activity_day, ->(day){
    return if day.blank?

    scope = left_joins(:company_activity_days)
    activity_days = CompanyActivityDay.where(activity_day: day)
    scope.merge(activity_days)
  }

  enum activity_day: {
    sunday: 'sunday',
    monday: 'monday',
    tuesday: 'tuesday',
    wednesday: 'wednesday',
    thursday: 'thursday',
    friday: 'friday',
    saturday: 'saturday',
    other: 'other'
  }
  enum company_category: { athletic: 'athletic', culture: 'culture', art: 'art' }
end
