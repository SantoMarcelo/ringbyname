module Sections
  class FeaturesMenu < SitePrism::Section
    element :crm, 'div[data-ui-sref="app.crm"]'
    element :quick_call, 'div.rbn-icon-common-quick-call'
  end
end
