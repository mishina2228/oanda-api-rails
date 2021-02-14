module ApplicationHelper
  def render_notices
    render partial: 'partials/notices'
  end

  def candle_latest_time(candle)
    candle ? candle.time : '(No data)'
  end

  def check_icon(boolean)
    icon = boolean ? 'fa-check-square' : 'fa-square'
    tag.span class: ['far', icon]
  end
end
