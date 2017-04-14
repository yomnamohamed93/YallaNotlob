class Notification < ApplicationRecord
  belongs_to :user
  after_create_commit { NotificationBroadcastJob.perform_later(current_user.notifications.count)}
end
