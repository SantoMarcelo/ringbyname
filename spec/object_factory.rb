
module Pages
  def login_page; Login.new end
  def reset; Reset_Password.new end
  def home; Home.new end
  def admin_dashboard; Dashboard.new end
  def users; User.new end
  def contact; Contact.new end
  def config; Config.new end
  def crm; CrmMiniApp.new end
  def crm_admin; Crm.new end
  def quick_call; QuickCall.new end
  def activity; Activity.new end
  def depto; Department.new end
end
