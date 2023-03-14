# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Pundit
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[firstname lastname])
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || post_index_path
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def record_not_found
    render file: Rails.root.join('app/views/error_page/record_not_found_error'), layout: false, status: :not_found
  end

  def user_not_authorized
    flash[:notice] = 'You are not authorized to perform this action.'
    redirect_to(request.referer || post_index_path)
  end
end
