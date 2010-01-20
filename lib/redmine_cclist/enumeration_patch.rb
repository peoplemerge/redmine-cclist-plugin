require_dependency 'email_exclusion'

module RedmineCclist
  # Patches Redmine's IssuesController dynamically
  module EnumerationPatch
    def self.included(base) # :nodoc:
      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)
      # Same as typing in the class 
      base.class_eval do 
        unloadable # Send unloadable so it will not be unloaded in development

      end 

    end
  end

  module ClassMethods
    def get_subclasses
      (@@subclasses[Enumeration]+[EmailExclusion])
    end
  end

  module InstanceMethods



  end
end

