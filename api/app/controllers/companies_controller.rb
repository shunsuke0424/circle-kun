class CompaniesController < ApplicationController
  def index
    scope = Company.all
    filter_params = params.slice(:company_category, :keyword, :place, :day, :category_name)
    scope = scope.scope_by_user(filter_params).order("RANDOM()")
    @companies = scope
  end

  def show
    @company = Company.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'ページが見つかりません' }, status: 404
  end

  def create
    @company = Company.new(company_params)
    set_association

    if @company.save
      render :show, status: 201
    else
      render json: { message: '更新に失敗しました' }, status: 400
    end
  end

  def company_params
    params.permit(
      :name,
      :number,
      :detail,
      :images_path,
      :hp_link,
      :twitter_link,
      :instagram_link,
      :company_category
    )
  end

  def set_association
    @company.company_places = params[:places].to_a.map do |place|
      @company.company_places.build(place: place)
    end
    @company.company_activity_days = params[:activity_days].to_a.map do |day|
      @company.company_activity_days.build(activity_day: day)
    end
    # keywords = params.permit(:keywords)[:keywords]
    @company.company_keywords = params[:keywords].to_a.map do |content|
      keyword = Keyword.find_by(content: content)
      @company.company_keywords.build(keyword: keyword)
    end
    @company.art = Art.where(name: params[:category_name]).first
    @company.athletic = Athletic.where(name: params[:category_name]).first
    @company.culture = Culture.where(name: params[:category_name]).first
  end
end
