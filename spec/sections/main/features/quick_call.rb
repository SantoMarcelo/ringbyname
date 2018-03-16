module Sections
    
    class QuickCall < SitePrism::Section
        elements :call_list, 'ul[data-show-more="extensionCallLoadRecords"] > li > ul > li'
        element :link_show_more, 'li.show-more'
        element :btn_dial_box, '.rbn-icon-common-dialer'
        element :txt_phone_dial, '.dial-pad-container input[data-ng-model="phoneNumber"]'
        elements :dial_pad_numbers, '.dial-pad-container .ng-pristine > ul > li'
        element :btn_eraser, '.glyphicon.glyphicon-arrow-left'
        element :btn_dial, '.glyphicon.glyphicon-earphone'
    end
    
    
    
end