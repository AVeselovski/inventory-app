module ApplicationHelper
  # helper for 'active' class routes
  def current_class?(test_path)
    'active' if request.path == test_path
  end
end
