require_relative '../../../sections/main/activities/activity'

# activity class
class Activity < Home
  section :my_activity, Sections::Activity, '.activities'
  section :team_activity, Sections::Activity, '.activities'

  def select_filter(option)
    my_activity.filters_options.each do |u|
      u.click if u.text.include?(option)
    end
  end
end
