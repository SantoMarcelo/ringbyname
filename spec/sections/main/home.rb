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
    element :date_oppo_follow_up, '.control input.ng-touched' 
    element :date_close_date, '.control input.ng-untouched'
    element :txt_oppo_comment, 'textarea[data-ng-model="record.comments"]'
    element :btn_oppo_save, 'button[data-ng-click="submit()"]'
    element :btn_oppo_cancel, 'button[data-ng-click="cancel()"]'
end

class HomeMenu < SitePrism::Section
    element :menu, '.profile-media-content'
    element :receives_call_at, 'a[data-ui-sref="app.receive-calls-at"]'
    element :my_caller_id, 'a[data-ui-sref="app.my-outgoing-caller-id"]'
    element :my_profile, 'a[data-ui-sref="app.profile"]'
    element :goto_admin, 'a[data-ui-sref="admin.dashboard"]'
    element :languages, 'a[data-ui-sref="app.language-settings"]'
    element :home_page, 'a[data-ui-sref="app.welcome-page"]'
    element :logout, 'a[data-ui-sref="auth.logout"]'
end


end
