#
class CreateInviteesOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :invitees_orders do |t|
      t.references :user, foreign_key: true
      t.references :order, foreign_key: true
    end
  end
end
