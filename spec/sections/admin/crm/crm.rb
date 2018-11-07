module Sections

    class CrmMenu < SitePrism::Section
        element :opportunities, 'a[ui-sref="admin.crm.opportunities"]'
        element :analytics, 'a[ui-sref="admin.crm.analytics"]'
        element :souces, 'a[ui-sref="admin.crm.sources"]'
    end

    class Opportunities < SitePrism::Section
        element :title, '.main-title'
        element :follow_update_from, 'div.control[data-initial-date*="date_follow_up_from"] input'
        element :follow_update_to, 'div.control[data-initial-date*="date_follow_up_to"] input'
        element :close_date_from, 'div.control[data-initial-date*="date_closed_from"] input'
        element :close_date_to, 'div.control[data-initial-date*="date_closed_to"] input'

        element :select_owner,'.control select[data-ng-model*="filters.owner_id"]'
        element :select_status, '.control select[data-ng-model*="filters.status"]'
        element :select_source, '.control select[data-ng-model*="filters.source"]'

        element :btn_reset, '.control button[type="button"]'
        element :btn_search, '.control button[type="submit"]'

        elements :oppo_grid_rows, '.flex-table section article.ng-scope'
        elements :oppo_select_grid_item, '.flex-table section article.ng-scope .column-select'
        element :select_number_pages, '.control .select select'
        elements :select_number_page_options, '.control .select select option'
        element :info_total_records, 'strong[class="ng-binding"]'
        elements :btn_page_number, 'ul.pagination li' 

    end

    class Analytics < SitePrism::Section
        

    end

    class Sources < SitePrism::Section
        

    end
end