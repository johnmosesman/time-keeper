class Api::ChartsController < Api::BaseController
  def index
    @charts = current_user.categories.collect { |category| Chart.new(category) }

    render json: @charts
  end
end