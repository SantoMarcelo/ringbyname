module Sections
    
    class QuickCall < SitePrism::Section
        element :call_list, 'ul[data-show-more="extensionCallLoadRecords"] > li > ul > li'
        #element :link_show_more, 
    end
    
    
end