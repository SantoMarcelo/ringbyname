
class User < SitePrism::Page

    element :txt_search, '.input'
    element :btn_search, '.button'
    element :grid_user_list, '.flex-table'
    element :select_number_pages, 'select[class^="option.value"]'
    element :info_total_records, 'strong[class="ng-binding"]'
    element :link_outbound_caller, 'a[ui-sref="admin.setup.user.outbound"]'
    element :link_multiple_password, 'a[ui-sref="admin.setup.user.password"]'
    element :tool_tip_search, 'i[tag="ADMIN_TOOLTIP_00069"]'
    element :tool_tip_users_extension, 'i[tag="ADMIN_TOOLTIP_00070"]'



end
