# frozen_string_literal: true

# ApplicationController serves as the base controller for all other controllers in the application.
# It includes configurations and methods that are shared across the entire application.
class ApplicationController < ActionController::Base
  # Restricts access to the application to modern browsers that support advanced features
  # such as webp images, web push notifications, badges, import maps, CSS nesting, and CSS :has selector.
  # This ensures a consistent user experience by leveraging the latest web technologies.
  allow_browser versions: :modern
end
