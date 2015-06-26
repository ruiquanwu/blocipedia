class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators
  has_many :associate_users, through: :collaborators, :source => 'user'
  
  scope :publicly_viewable, -> { where(private: false) }
  
  def public?
    !self.private
  end
  
end
