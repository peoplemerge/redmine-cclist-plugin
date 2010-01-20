class CclistController < ApplicationController
  unloadable

  before_filter :find_issue
  
  def add
    @cc = Cclist.new()
    @cc.issue_id = params[:issue_id]
    @cc.email = params[:cc][:email]
    @cc.save if request.post?
    @cclist = Cclist.find(:all, :conditions => { :issue_id => params[:issue_id]} )
    respond_to do |format|
      format.html { redirect_to :controller => 'issues', :action => 'show', :id => params[:issue_id] }
      format.js do
        render :update do |page|
          page.replace_html "cclist", :partial => 'cclist/list'
        end
      end
    end
  end
  
  def destroy
    cc = Cclist.find(params[:id])
    cc.destroy
    @cclist = Cclist.find(:all, :conditions => { :issue_id => params[:issue_id]} )
    respond_to do |format|
      format.html { redirect_to :controller => 'issues', :action => 'show', :id => params[:issue_id] }
      format.js { render(:update) {|page| page.replace_html "cclist", :partial => 'cclist/list'} }
    end    
  end
  
  private
  def find_issue
    @issue = Issue.find(params[:issue_id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end
end
