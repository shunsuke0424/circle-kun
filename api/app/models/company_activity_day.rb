class CompanyActivityDay < ApplicationRecord
  belongs_to :company
  enum activity_day: ActivityDay.enum_hash
end