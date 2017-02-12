class SummaryController < ApplicationController
  before_action :authenticate_user!

  def show_portfolio
    @portfolio = current_user.references :portfolio
  end

  def show_snapshot
  end

  def show_diff
  end

  private


end
