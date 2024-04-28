# == Schema Information
#
# Table name: instruments
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_instruments_on_name  (name) UNIQUE
#
class Instrument < ApplicationRecord
  has_many :tasks
  validates :name, presence: true, uniqueness: true
end
