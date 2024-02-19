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
  end

  def setup_irbtools!
    require "irbtools/configure"

    Irbtools.welcome_message = nil
    Irbtools.start
  rescue LoadError
  end

  def setup_theme!
    Reline::Face.config(:completion_dialog) do |conf|
      conf.define(:default, foreground: "#f8f8f2", background: "#282a36")
      conf.define(:enhanced, foreground: "#f8f8f2", background: "#44475a")
      conf.define(:scrollbar, foreground: "#ffb86c", background: "#6272a4")
    end
  rescue StandardError
    IRB.conf[:USE_AUTOCOMPLETE] = false
  end
end

# rubocop:enable Lint/SuppressedException

MyIrb.start!
