# Just to silence the linter
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :groups
  has_many :orders
  has_many :order_details, dependent: :destroy
  has_many :participated_orders, through: :order_details,
                                 class_name: 'Order',
                                 foreign_key: 'order_id'
  has_and_belongs_to_many :participated_groups, class_name: 'Group',
                                                foreign_key: 'group_id',
                                                join_table: :groups_members
  has_friendship
  has_attached_file :avatar,
                    styles: { medium: '300x300>', thumb: '100x100>' },
                    default_url: '/images/:style/missing.png'
  validates_attachment_content_type :avatar, content_type: %r{\Aimage\/.*\z}
end
