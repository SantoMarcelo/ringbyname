require_relative '../admin'


class Setup < Admin
    section :menu, Sections::SetupMenu, '.navigation-left'
    section :message, Sections::Messages, '.swal2-container'
    section :setup, Sections::SetupMain, '.page-main'
    element :load_icon, '#loading-bar'

    def wait_for_message
        i=0
        while has_message? == false || i == 100do
            puts "waiting for message.."
            i+=1
        end
    end
end 