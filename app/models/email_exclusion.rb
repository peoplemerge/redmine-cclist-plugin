class EmailExclusion < Enumeration

  validates_length_of :name, :maximum => 255

  OptionName = :cclist_exclusion
  # Backwards compatiblity.  Can be removed post-0.9
  OptName = 'CXCL'
  
  def option_name
    OptionName
  end

  def objects_count
    1
  end

  def transfer_relations(to)
    
  end

end