# coding: utf-8
module DeviseRussian
  module Controllers
    module Base
      def authenticate_user!
        permission_denied if current_user.nil?
      end

      def permission_denied
        flash[:error] = I18n.t(:permission_denied)
        redirect_to devise_russian.new_user_session_url
      end
    end
  end
end
