
module Sections
  
class SetupMenu < SitePrism::Section
    element :users, 'a[ui-sref="admin.setup.user"]'
    element :departments, 'a[ui-sref="admin.setup.department"]'
    element :menu, 'a[ui-sref="admin.setup.menu"]'
    element :phone_number, 'a[ui-sref="admin.setup.phone-number"]'
  end

  

end