module MyIrb
  extend self

  def start!
    setup_irb_conf!
    setup_irbtools!
  end

  private

  def setup_irb_conf!
    IRB.conf[:SAVE_HISTORY] ||= 1000
    IRB.conf[:HISTORY_FILE] ||= File.join(ENV["XDG_DATA_HOME"], "irb", "history")
    IRB.conf[:USE_AUTOCOMPLETE] = false
  end

  def setup_irbtools!
    require 'irbtools/configure'

    Irbtools.welcome_message = nil
    Irbtools.start
  rescue LoadError
  end
end

MyIrb.start!
