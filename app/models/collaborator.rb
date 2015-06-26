class Collaborator < ActiveRecord::Base
  belongs_to :user
  belongs_to :wiki
  validates_uniqueness_of :wiki_id, :scope => :user_id
end