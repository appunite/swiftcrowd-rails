class Api::BaseController  < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :force_json, :skip_trackable
  before_filter :authenticate!
  
  rescue_from Errors::ApiError, with: :render_api_error
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  attr_reader :current_user
  
  protected

  def require_params(*args)
    args.each do |arg|
      bad_request!("missing #{arg} parameter") if params[arg].blank?
    end
  end

  def require_one_of_params(*args)
    args.any? { |a| !params[a].blank? } or 
      bad_request!("must include one of the following parameters #{args.join(',')}")
  end
  
  def api_error!(code, description = nil)
    raise Errors::ApiError.new(code, description), description
  end
  
  def auth_token
    params[:auth_token] || request.headers['X-AUTH-TOKEN']
  end
  
  def require_image(key)
    require_file(key, '.jpg', '.jpeg', '.png', '.gif')
  end
  
  def require_file(key, *allowable_extensions)
    params[key].respond_to?(:tempfile) or 
      api_error!(:invalid_request, "#{key} must be a file")
    extension = File.extname(params[key].original_filename)
    allowable_extensions.include?(extension) or 
      api_error!(:invalid_request, "File must be of type #{allowable_extensions.join(',')}")
  end

  private

  def render_server_error(e)
    raise e if Rails.env.development?
    logger.error(e)
    respond_to do |format|
      format.any do
        error_id = env['airbrake.error_id'] = notify_airbrake(e)

        error = { 
          code:     :internal_server,
          message:  e.message, 
          number:   error_id }
        render status: :internal_server_error, json: { error: error }
      end
    end
  end
  
  def render_api_error(e)
    render status: e.response_status, json: e.as_json
  end

  def force_json
    request.format = :json
  end

  def skip_trackable
    request.env['devise.skip_trackable'] = true
  end  

  def current_user
    @current_user ||= auth_token ? User.find_by_authentication_token(auth_token) : nil
  end

  def authenticate!
    auth_token or api_error!(:invalid_request, 'missing auth token')
    current_user or api_error!(:invalid_token)
  end
  
end