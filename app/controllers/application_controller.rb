class ApplicationController < ActionController::Base
  protect_from_forgery

  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception,                            with: lambda { |exception| render_error(500, exception) }
    rescue_from ActiveRecord::RecordNotFound,
                ActionController::RoutingError,
                ActionController::UnknownController,
                ActionController::UnknownAction,      with: lambda { |exception| render_error(404, exception) }
  end

  private

  def load_collection
    @collection = Collection.find_by_id(params[:collection_id])
  end

  def load_source
    @source = Source.find_by_id(params[:source_id])
  end

  # Errors
  def render_error(status, exception=nil)
    if status.eql?(500)
      ExceptionNotifier.notify_exception(exception, env: request.env)
    end

    respond_to do |format|
      format.html { render template: "errors/#{status}", layout: 'layouts/application', status: status }
      format.all  { render nothing: true, status: status }
    end
  end
end
