class CompanyPlace < ApplicationRecord
  belongs_to :company
  enum place: Place.enum_hash
end