
module Helpers
  def get_screenshot
    target = 'log/reports/screenshots/temp.png'
    sleep(1)
    File.new(page.save_screenshot(File.join(Dir.pwd, target)))
  end

  def wait_for_ajax
    Timeout.timeout(Capybara.default_wait_time) do
      active = page.evaluate_script('jQuery.active')
      active = page.evaluate_script('jQuery.active') until active == 0
    end
    end

  
end
