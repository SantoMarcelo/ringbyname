module Sections
    
    class QuickCall < SitePrism::Section
        element :page_title, '.page-title'
        elements :call_list, 'page-content page-calls div.call'
        elements :mark_as_read, 'i.call__action_mark_as_read'
        element :btn_dial_box, '.rbn-icon-common-dialer'
        element :txt_phone_dial, '.dial-pad-container input[data-ng-model="phoneNumber"]'
        elements :dial_pad_numbers, '.dial-pad-container .ng-pristine > ul > li'
        element :btn_eraser, '.glyphicon.glyphicon-arrow-left'
        element :btn_dial, '.glyphicon.glyphicon-earphone'
        elements :incoming_missed_call, 'i[class*="incoming-external-call"]'
        element :incoming_call, '.rbn-icon-activity-small-cdr_incoming_external_call'
        element :outgoing_call, '.rbn-icon-activity-small-cdr_outgoing_external_call'
        element :outgoing_missed_call, '.rbn-icon-activity-small-cdr_outgoing_missed_call'
        element :callback_call, 'i[class*="department-callback-insert"]'
        element :voicemail_call, '.rbn-icon-activity-small-voicemail_insert'


        # elements :call_list, '.calls-page .call-page_list article'
        # element :call_list_title, '.calls-page h1'
        # elements :icons_list, 'ul[data-show-more="extensionCallLoadRecords"] > li > ul > li > div.separator-right > div > i[class*="rbn-icon-activity-small-cdr_"]'
        # element :link_show_more, 'li.show-more'
        # element :btn_dial_box, '.rbn-icon-common-dialer'
        # element :txt_phone_dial, '.dial-pad-container input[data-ng-model="phoneNumber"]'
        # elements :dial_pad_numbers, '.dial-pad-container .ng-pristine > ul > li'
        # element :btn_eraser, '.glyphicon.glyphicon-arrow-left'
        # element :btn_dial, '.glyphicon.glyphicon-earphone'

        # element :incoming_missed_call, '.rbn-icon-activity-small-cdr_incoming_missed_call'
        # element :incoming_call, '.rbn-icon-activity-small-cdr_incoming_external_call'
        # element :outgoing_call, '.rbn-icon-activity-small-cdr_outgoing_external_call'
        # element :outgoing_missed_call, '.rbn-icon-activity-small-cdr_outgoing_missed_call'
        # element :callback_call, '.rbn-icon-activity-small-callback_insert'
        # element :voicemail_call, '.rbn-icon-activity-small-voicemail_insert'
    end
end