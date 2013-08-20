# coding: utf-8
module DeviseRussian
  module Models
    module Base
      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def omniauthable
          has_many :authentications, :dependent => :destroy

          def omniauth_enabled
            true
          end

          unless included_modules.include? InstanceMethods
            include InstanceMethods
          end
        end
      end

      module InstanceMethods
        def apply_omniauth(omniauth, with_self=false)
          provider = omniauth['provider']
          uid = omniauth['uid']
          user_email = omniauth['extra']['raw_info']['email'] rescue nil
          user_name = omniauth['extra']['raw_info']['first_name'] rescue nil

          if with_self
            self.email = user_email if user_email && self.email.blank?
            self.name = user_name if user_name && self.name.blank?
          end

          self.authentications.new(
            :provider => provider,
            :uid => uid,
            :email => user_email,
            :name => user_name
          )
        end

        def password_required?
          (authentications.empty? || !password.blank?) && super
        end
      end
    end
  end
end
