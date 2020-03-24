class ErrorsController < ApplicationController
  def not_found
    respond_to do |format|
      format.html { render status: 404, layout: false }
    end
  end

  def internal_error
    respond_to do |format|
      format.html { render status: 500, layout: false }
    end
  end
end
