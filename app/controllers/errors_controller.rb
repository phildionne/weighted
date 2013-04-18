class ErrorsController < ApplicationController

  # Only triggered by routing errors, other exceptions are handled
  # in ApplicationController
  def not_found
    render_error(404)
  end
end
