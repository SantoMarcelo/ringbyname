module Sections
  class FeaturesMenu < SitePrism::Section
    element :crm, '.quick-launcher-option.list.crm-top'
    element :quick_call, 'div.rbn-icon-common-quick-call'
    element :notes, '.rbn-icon-common-quick-notes'
    element :note_counter, '.rbn-icon-common-quick-notes[data-notifications-before="1"]'
  end
end
