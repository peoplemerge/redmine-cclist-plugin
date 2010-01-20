require 'redmine'

# Patches to the Redmine core.
require 'dispatcher'
Dispatcher.to_prepare :redmine_cclist do
  require_dependency 'issue'
  require_dependency 'mail_handler'
  # Guards against including the module multiple time (like in tests)
  # and registering multiple callbacks
  unless Issue.included_modules.include? RedmineCclist::IssuePatch
    Issue.send(:include, RedmineCclist::IssuePatch)
  end
  unless IssuesController.included_modules.include? RedmineCclist::IssuesControllerPatch
    IssuesController.send(:include, RedmineCclist::IssuesControllerPatch)
  end
  unless MailHandler.included_modules.include? RedmineCclist::MailHandlerPatch
    MailHandler.send(:include, RedmineCclist::MailHandlerPatch)
  end
  unless Enumeration.included_modules.include? RedmineCclist::EnumerationPatch
    Enumeration.send(:include, RedmineCclist::EnumerationPatch)
  end
end


Redmine::Plugin.register :redmine_cclist do
  name 'Redmine Cclist plugin'
  author 'Joe Anthony & Dave Thomas'
  description 'Allow a CC list of non-registered users per issue'
  version '0.0.2'
end
