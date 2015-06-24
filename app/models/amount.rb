class Amount < ActiveRecord::Base
  attr_accessor :premium
  
  def initialize
    premium = 15_00
  end
  
  def self.default
    15_00
  end
end