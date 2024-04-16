class Feature < ApplicationRecord
    self.per_page = 30
    has_many :comment
end
