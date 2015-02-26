class Api::ChartsController < Api::BaseController
  def index
    @charts = Category.all.collect { |category| Chart.new(category) }

    render json: @charts
  end
end