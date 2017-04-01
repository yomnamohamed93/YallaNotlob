class AddAttachmentMenuImgToOrders < ActiveRecord::Migration
  def self.up
    change_table :orders do |t|
      t.attachment :menu_img
    end
  end

  def self.down
    remove_attachment :orders, :menu_img
  end
end
