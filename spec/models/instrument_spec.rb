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
require 'rails_helper'

RSpec.describe Instrument, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
