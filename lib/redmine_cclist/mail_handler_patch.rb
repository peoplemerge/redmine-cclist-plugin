
module RedmineCclist
  # Patches Redmine's MailHandler dynamically
  module MailHandlerPatch
    def self.included(base) # :nodoc:
      #base.extend(ClassMethods)
      base.send(:include, InstanceMethods)
      # Same as typing in the class 
      base.class_eval do 
        unloadable # Send unloadable so it will not be unloaded in development
        alias_method_chain :receive_issue, :cclist
      end 

    end
  end

  module ClassMethods
  end

  module InstanceMethods

    def build_cc(issue, email)
      cc = Cclist.new()
      cc.issue_id = issue.id
      cc.email = email.to_a.first.to_s.strip
      cc.save unless @email_exclusions.include?(cc.email.downcase)
    end

    def receive_issue_with_cclist
      @email_exclusions = EmailExclusion.find(:all).collect {|m| m.name.downcase}
      issue = receive_issue_without_cclist
      if @user == User.anonymous
        build_cc(issue, @email.from)
        newissue_cc(issue)
      end
      # If the author also CC'd people, loop them in too
      also_included = []
      also_included << @email.cc unless @email.cc.nil?
      also_included << @email.to_addrs.collect{|m| m.address} unless @email.to_addrs.nil?
      also_included.each do |n|
        user = User.find_by_mail(n.to_a.first.to_s.strip)
        if user.nil?
          build_cc(issue, n)
        else
          # bypass security of MailHandler.add_watchers()
          issue.add_watcher(user) unless issue.watched_by?(user)
        end
      end
      issue
    end
    
    # Adapted (shamelessly and cowardly swiped) from the NewIssueAlerts plug-in
    def newissue_cc(issue)
      cclist = Cclist.find(:all, :conditions => { :issue_id => issue.id })
      cclist.each do |n|
        logger.debug "CCLIST_E: #{n.email}"
        CclistMailer.deliver_cc_mail(n.email, issue)
      end 
    end

  end
end

