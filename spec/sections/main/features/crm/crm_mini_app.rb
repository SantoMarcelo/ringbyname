module Sections

    class CrmFeature < SitePrism::Section
        element :txt_search, 'input[ng-model="crmCard.search.key"]'
        element :btn_apply, 'button[type="submit"]'
        element :select_filter, 'select[data-ng-model="crmCard.search.filter"]'
        element :title, 'h2'
        elements :opportunity_list, '.crm-card-list .table > tbody > tr'
        elements :opportunity_list_column, '.crm-card-list .table > tbody > tr > td.opportunity_contact'
        element :list_header_name, '.table .header-name .header-sort'
        element :list_header_followup, '.table .header-follow-up .header-sort'
        element :list_header_close_date, '.table .header-close-date .header-sort'
        element :list_header_cost, '.table .header-cost .header-sort' 
        elements :pagination, '.pagination li a'
        element :label_current_filter, 'div > p > strong.ng-binding'
        element :sort_asc_indicator, '.caret.active.asc'
        element :sort_desc_indicator, '.caret.active.up.desc'
        element :print_icon, '.icon-fontello-print_sticker'
        element :edit_icon, '.icon-fontello-edit'
    end
    
    class OpportunitDetails < CrmFeature
        element :title, '.crm-card-container__header h2'
        element :contact,  '.crm-card-container__contact'
        element :contact_image, '.crm-card-container__contact img'
        element :opportunity_name, '.item.opportunity-name .oppt-value'
        element :opportunity_status, '.item.opportunity-status .oppt-value'
        element :opportunity_close_date, '.item.opportunity-close-date .oppt-value'
        element :opportunity_source, '.item.opportunity-source .oppt-value'
        element :opportunity_probality, '.item.opportunity-probability .oppt-value'
        element :opportunity_product, '.item.opportunity-product-service .oppt-value'
        element :opportunity_price, '.item.opportunity-price-cost .oppt-value'
        element :opportunity_action, '.item.opportunity-action .oppt-value'
        element :opportunity_followup_date, '.item.opportunity-follow-up-date .oppt-value'
        element :opportunity_comments, '.item.opportunity-comments .oppt-value'
    end

    class OpportunityEdit < SitePrism::Section
        
        element :txt_oppo_name, 'input.opportunity_name'
        element :select_oppo_source, 'select.opportunity_source'
        element :select_oppo_status, 'select.opportunity_status'
        element :select_oppo_prob, 'select.opportunity_probabiity '
    
        element :txt_oppo_product, 'input.opportunity_product'
        element :txt_oppo_price, 'input.opportunity_cost'

        element :select_oppo_next_action, 'select.opportunity_action'
        element :date_oppo_follow_up, 'div[data-initial-date="crmEdit.record.date_follow_up"] input' 
        element :date_close_date, 'div[data-initial-date="crmEdit.record.date_close"] input'
        element :txt_oppo_comment, 'textarea.opportunity_comments'
        element :link_upload, '.fileinput-button'
        element :edit_info, '.last-edited'
        element :scroll, '.ps__scrollbar-y'
        element :btn_oppo_save, 'button.btn_save'
        element :btn_oppo_cancel, 'button.btn_cancel'
    end
    

end