class ProjectsController < ApplicationController

  def show

    @project = Project.find(params[:id])

    @pages = Page.all

  end

  def index

    @projects = Project.all


  end

end
