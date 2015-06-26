class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
  has_many :wikis
  has_many :collaborators
  has_many :associate_wikis, through: :collaborators, :source => 'wiki'
  after_initialize :init_roles
  
  def init_roles
    self.role ||= "standard"
  end
  
  def admin?
    role == "admin"
  end
  
  def premium?
    role == "premium"
  end
  
  def standard?
    role == "standard"
  end
  
  def downgrade
    self.role = "standard"
    self.wikis.each do |wiki|
      if wiki.private
        wiki.private = false
        wiki.save
      end
    end
    self.save
  end
  
end
