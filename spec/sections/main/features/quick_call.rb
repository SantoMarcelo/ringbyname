module Sections
    
    class QuickCall < SitePrism::Section
        element :page_title, '.page-title'
        elements :call_list, 'page-content page-calls div.call'
        elements :mark_as_read, 'i.call__action_mark_as_read'
        elements :call_icon, 'i.call__action_dial'

        element :btn_dial_box, '.dialpad .icon-fontello-dialer'
        element :txt_phone_dial, '.dialpad__container .number'
        elements :dial_pad_numbers, '.dialpad__container .keys'
        element :btn_eraser, '.dialpad__container .backspace'
        element :btn_dial, '.dialpad__container .phone'
    end
end