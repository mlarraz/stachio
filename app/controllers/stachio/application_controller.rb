module Stachio
  class ApplicationController < ActionController::Base

    protected

    def readonly
      Stachio.readonly
    end

    def permission
      return true unless readonly
      flash[:notice] = "Templates are readonly"
      redirect_to :action => :index
    end

  end
end
