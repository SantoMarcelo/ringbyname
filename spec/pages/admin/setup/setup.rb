require_relative '../admin'


class Setup < Admin
    section :menu, Sections::SetupMenu, '.navigation-left'
    section :message, Sections::Messages, '.swal2-container'

    # search elements
     element :txt_search, '.input'
    element :btn_search, '.button'

end