ActionController::Routing::Routes.draw do |map|
  map.with_options  :controller => 'cclist', :conditions => {:method => :post} do |cc|
    cc.connect 'issues/:issue_id/cclist/:id', :action => 'new'
    cc.connect 'issues/:issue_id/cclist/:id/destroy', :action => 'destroy'
    cc.connect 'issues/cclist/:id', :action => 'new'
    cc.connect 'issues/cclist/:id/destroy', :action => 'destroy'
  end
end

