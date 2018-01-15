module Sections

class CRM < SitePrism::Section
    element :txt_search, 'input[ng-model="crmCard.search.key"]'
    element :btn_apply, 'button[type="submit"]'
    element :select_filter, 'select[data-ng-model="crmCard.search.filter"]'
    
end

class Contact < SitePrism::Section
    elements :contact_list, 'li[id^="contacts_grouped"] > ul:nth-child(2) > li'
end

class MiniAppOpportunityForm < SitePrism::Section
        
    element :txt_oppo_name, 'input[data-ng-model="record.name"'
    element :select_oppo_source, 'select[data-ng-model="record.source.id"]'
    element :select_oppo_status, 'select[data-ng-model="record.status.id"]'
    element :select_oppo_prob, 'select[data-ng-model="record.probability.id"]'

    element :txt_oppo_product, 'input[data-ng-model="record.product"]'
    element :txt_oppo_price, 'input[data-ng-model="record.cost"]'

    element :select_oppo_next_action, 'select[data-ng-model="record.action.id"]'
    element :date_oppo_follow_up, 'div[data-initial-date="filters.date"] > input[data-ng-model="useless"]' 
    element :date_close_date, 'div[data-initial-date="filters.dateClose"]> input'
    element :txt_oppo_comment, 'textarea[data-ng-model="record.comments"]'
    element :btn_oppo_save, 'button[data-ng-click="submit()"]'
    element :btn_oppo_cancel, 'button[data-ng-click="cancel()"]'

    
end

end
