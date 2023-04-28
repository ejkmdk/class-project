class ApplicationController < ActionController::Base

    before_action :set_project, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[ new edit create update destroy]
  
end
