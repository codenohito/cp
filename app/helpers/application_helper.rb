module ApplicationHelper

  def formatted_worktime(time_in_minutes = 0)
    "#{time_in_minutes / 60}:" + "%02d" % (time_in_minutes % 60)
  end


end
