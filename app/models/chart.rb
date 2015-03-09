class Chart
  attr_accessor :data, :title, :average, :success, :options, :goal

  def initialize(category)
    self.title = category.title
    self.data = get_data(category)
    self.average = get_average(category)
    self.success = get_success(category)
    self.options = get_options
    self.goal = get_goal(category)
  end

  private
    def get_data(category)
      records = category.records_for_last_week.order(:created_at)

      {
        labels: records.collect { |record| record.created_at.strftime("%a %e") },
        datasets: [
          {
            label: "Goal Amount",
            fillColor: "rgba(220,220,220,0)",
            strokeColor: "rgba(220,220,220,1)",
            pointColor: "rgba(220,220,220,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(220,220,220,1)",
            data: records.count.times.collect { category.amount }
          },
          {
            label: "Actual Amount",
            fillColor: "rgba(51, 96, 158, 0.2)",
            strokeColor: "rgba(51, 96, 158, 1)",
            pointColor: "rgba(51, 96, 158, 1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(151,187,205,1)",
            data: records.collect { |record| record.amount.round(2) }
          }
        ]
      }
    end

    def get_average(category)
      records = category.records_for_last_week
      average = (records.collect(&:amount).inject(0, :+) / records.count.to_f).round(1)

      {
        data: average,
        level: level_for_goal(average, category.amount)
      }
    end

    def get_success(category)
      records = category.records_for_last_week
      percentage = records.select { |record| record.amount >= category.amount }.count / records.count.to_f

      {
        data: (percentage*100),
        level: level_for_goal((percentage*100), 100)
      }
    end

    def get_goal(category)
      {
        data: category.amount
      }
    end

    def get_options
      {
        scaleShowGridLines: false
      }
    end

    def level_for_goal(level, goal)
      if level >= goal
        "excellent"
      elsif level >= goal * 0.75
        "good"
      elsif level >= goal * 0.5
        "average"
      else
        "poor"
      end
    end
end