class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
  has_many :wikis
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
    current_user.role = "standard"
    current_user.save
  end
end
