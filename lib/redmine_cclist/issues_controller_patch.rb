
module RedmineCclist
  # Patches Redmine's IssuesController dynamically
  module IssuesControllerPatch
    def self.included(base) # :nodoc:
      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)
      # Same as typing in the class 
      base.class_eval do 
        unloadable # Send unloadable so it will not be unloaded in development
        alias_method_chain :show, :cclist
      end 

    end
  end

  module ClassMethods
  end

  module InstanceMethods

    def show_with_cclist
      @cclist = Cclist.find(:all, :conditions => { :issue_id => @issue.id } )
      show_without_cclist()
    end

  end
end

