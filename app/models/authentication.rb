# coding: utf-8
class Authentication < ActiveRecord::Base
  validates_presence_of :provider, :uid
  attr_accessible :user_id, :provider, :uid, :name, :email

  belongs_to :user

  xss_terminate

  class << self
    def providers
      [
        ["facebook", "Facebook"],
        ["vkontakte", "Vkontakte"],
        ["odnoklassniki", "Odnoklassniki"]
        # ['twitter', 'Twitter'],
        # ['github', 'Github'],
        # ['google_oauth2', 'Google']
      ]
    end
  end
end
