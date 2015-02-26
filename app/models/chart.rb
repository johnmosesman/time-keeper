class Chart
  attr_accessor :data, :title, :average, :success_percentage

  def initialize(category)
    self.title = category.title
    self.data = get_data(category)
    self.average = get_average(category)
    self.success_percentage = get_success_percentage(category)
  end

  private
    def get_data(category)
      records = category.records_for_last_week.order(:created_at)

      self.data = {
        labels: records.collect { |record| record.created_at.strftime("%a %e") },
        datasets: [
          {
            label: "My First dataset",
            fillColor: "rgba(151,187,205,0.2)",
            strokeColor: "rgba(151,187,205,1)",
            pointColor: "rgba(151,187,205,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(151,187,205,1)",
            data: records.collect { |record| record.amount.round(1) }
          },
          {
            label: "My First dataset",
            fillColor: "rgba(220,220,220,0.2)",
            strokeColor: "rgba(220,220,220,1)",
            pointColor: "rgba(220,220,220,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(220,220,220,1)",
            data: records.count.times.collect { category.amount }
          },
        ]
      }
    end

    def get_average(category)
      records = category.records_for_last_week
      (records.collect(&:amount).inject(0, :+) / records.count).round(1)
    end

    def get_success_percentage(category)
      records = category.records_for_last_week
      percentage = records.select { |record| record.amount >= category.amount }.count / records.count.to_f
      (percentage*100).to_s + "%"
    end
end