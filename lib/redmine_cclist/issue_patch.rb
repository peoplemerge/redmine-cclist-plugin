
module RedmineCclist
  # Patches Redmine's IssuesController dynamically
  module IssuePatch
    def self.included(base) # :nodoc:
      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)
      # Same as typing in the class 
      base.class_eval do 
        unloadable # Send unloadable so it will not be unloaded in development
        alias_method_chain :recipients, :cclist

      end 

    end
  end

  module ClassMethods
  end

  module InstanceMethods

    def recipients_with_cclist
      recipient_list = recipients_without_cclist
      cclist = Cclist.find(:all, :conditions => { :issue_id => id } ).collect {|m| m.email}
      recipient_list << cclist
      return recipient_list
    end


  end
end

