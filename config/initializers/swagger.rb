GrapeSwaggerRails.options.url = "api/swagger_doc"
GrapeSwaggerRails.options.app_name = 'Sample Api'
GrapeSwaggerRails.options.app_url  = '/'
GrapeSwaggerRails.options.api_key_name = 'X-User-Auth-Token'
GrapeSwaggerRails.options.api_key_type = 'header'

GrapeSwaggerRails.options.before_action do |request|
  # Uncomment if you want to only allow admin access to api docs
  unless true #current_user # && current_user.admin?
    redirect_to Rails.application.routes.url_helpers.root_path
  end
end
