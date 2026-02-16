# frozen_string_literal: true

# ApplicationRecord serves as the base class for all models in the application.
# It inherits from ActiveRecord::Base and is marked as an abstract class, meaning
# it is not intended to be instantiated directly. Instead, it provides shared
# behavior and configurations for all model classes.
class ApplicationRecord < ActiveRecord::Base
  # Marks this class as a primary abstract class, ensuring it is only used
  # as a superclass for other models and not instantiated directly.
  primary_abstract_class
end
