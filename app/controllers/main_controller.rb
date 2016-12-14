class MainController < ApplicationController
  def main
    render :main, :layout => false
  end
end
