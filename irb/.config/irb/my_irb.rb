# frozen_string_literal: true

# rubocop:disable Lint/SuppressedException

module MyIrb
  extend self

  def start!
    setup_irb_conf!
    setup_irbtools!
    setup_theme!
  end

  private

  def setup_irb_conf!
    IRB.conf[:SAVE_HISTORY] ||= 1000
    IRB.conf[:HISTORY_FILE] ||= File.join(ENV.fetch("XDG_DATA_HOME", nil), "irb", "history")
    IRB.conf[:USE_AUTOCOMPLETE] = false
  end

  def setup_irbtools!
    require "irbtools/configure"

    Irbtools.welcome_message = nil
    Irbtools.start
  rescue LoadError
  end

  def setup_theme!
    require "irb/theme/dracula/dark"
    IRB.conf[:USE_AUTOCOMPLETE] = true
  rescue LoadError
  end
end

# rubocop:enable Lint/SuppressedException

MyIrb.start!
