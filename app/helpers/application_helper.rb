module ApplicationHelper
  def render_notices
    render partial: 'partials/notices'
  end

  def candle_latest_time(candle)
    candle ? candle.time : '(なし)'
  end
end
