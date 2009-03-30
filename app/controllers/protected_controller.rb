class ProtectedController < ApplicationController
  before_filter :login_required

  def index
  end

end
