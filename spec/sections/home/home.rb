module Sections

class CRM < SitePrism::Section
    element :txt_search, 'input[ng-model="crmCard.search.key"]'
    element :btn_apply, 'button[type="submit"]'
    elements :grid_opportunity_list, '.crm-card-list'

end

class Contact < SitePrism::Section
    elements :contact_list, 'li[id^="contacts_grouped"] > ul:nth-child(2) > li'
end


end
