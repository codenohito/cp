class ActionsLogger
  def self.add(act, obj, author)
    msg = "User##{author.id}"
    msg += "(#{author.nakama.name})" if author.nakama

    if act == 'create'
      msg += " created #{obj.class.name}##{obj.id}: "
      msg += obj.inspect
    elsif act == 'update'
      msg += " updated #{obj.class.name}##{obj.id}: "
      chngs = obj.previous_changes
      chngs.delete('updated_at')
      msg += chngs.inspect
    elsif act == 'destroy'
      msg += " destroyed #{obj.class.name}##{obj.id}"
    end

    Rails.application.config.actions_logger.info msg
  end
end
