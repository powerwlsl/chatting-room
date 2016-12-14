module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      logger.add_tags 'ActionCable', current_user.email
      # to display debugging information in the console, so you will see output similar to this:
    end

    protected

    def find_verified_user # this checks whether a user is authenticated with devise
      if verified_user = env['warden'].user
        # tries to fetch the currently logged-in user. If it is not found, reject_unauthorized_connection forbids broadcasting.
        verified_user
      else
        reject_unauthorized_connection
      end
    end
  end
end