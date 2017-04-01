class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details
  has_many :participated_users, through: :order_details,
                                class_name: 'User',
                                foreign_key: 'user_id'
  has_attached_file :menu_img,
                    styles: { medium: '300x300>', thumb: '100x100>' },
                    default_url: '/images/:style/missing.png'
  validates_attachment_content_type :menu_img, content_type: %r{\Aimage\/.*\z}
end
