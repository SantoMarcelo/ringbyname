module Sections

    class ContactCard < SitePrism::Section
        element :txt_contact_name, '.contact-card > .row > div> h1'
        
        #element :contact_notes
        element :contact_crm_icon, 'div[class="ng-isolate-scope"] > ul > li[class^="crm-tab"]'
        elements :contact_opportunity_list, '.crm__history > table > tbody > tr'
    end 

    class ContactOpportunityForm < SitePrism::Section
        
        element :txt_oppo_name, 'input[data-ng-model="opportunity.name"]'
        element :select_oppo_source, 'select[data-ng-model="opportunity.source.id"]'
        element :select_oppo_status, 'select[data-ng-model="opportunity.status.id"]'
        element :select_oppo_prob, 'select[data-ng-model="opportunity.probability.id"]'

        element :txt_oppo_product, 'input[data-ng-model="opportunity.product"]'
        element :txt_oppo_price, 'input[data-ng-model="opportunity.cost"]'

        element :select_oppo_next_action, 'select[data-ng-model="opportunity.action.id"]'
        element :date_oppo_follow_up, 'div[data-initial-date="filters.date"] > input[data-ng-model="useless"]' 
        element :date_close_date, 'div[data-initial-date="filters.dateClose"]> input'
        element :txt_oppo_comment, 'textarea[data-ng-model="opportunity.comments"]'
        element :btn_oppo_save, 'button[data-ng-click="submit()"]'
        element :btn_oppo_cancel, 'button[data-ng-click="cancel()"]'
    end

end