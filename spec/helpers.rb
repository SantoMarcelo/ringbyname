
module Helpers

    def get_screenshot
        target = 'log/reports/screenshots/temp.png'
        sleep(1)
        return File.new(page.save_screenshot(File.join(Dir.pwd, target)))
    end

end