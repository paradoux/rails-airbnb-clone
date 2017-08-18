class PagesController < ApplicationController

  # CGN: à activer + tard : skip login for home page
  skip_before_action :authenticate_user!, only: :home

  def home
  end

  def concept
  end
end
