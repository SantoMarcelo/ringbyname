require_relative '../admin'


class Setup < Admin
    section :menu, Sections::SetupMenu, '.navigation-left'
    section :message, Sections::Messages, '.swal2-container'
    section :setup, Sections::SetupMain, '.page-main'
    
end