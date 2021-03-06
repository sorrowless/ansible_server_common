require 'irb'
require 'irb/xmp'
require 'irb/ext/save-history'
require 'irb/completion'

unless defined?(IRBDIR)
  IRBDIR = "/var/log/irb/#{`whoami`.gsub("\n",'')}"
  SCRIPT_LINES__ ||= {}

  module Readline
    PERMLOG = "#{IRBDIR}.permlog.rb"
    HISTORYLOG = "#{IRBDIR}.history.rb"
    HISTIGNORE = /^(exit|)$/
    SCRIPT_LINES__['(irb)'] = []
  end
end

module Readline
  def write_log_line(line)
    line.tap do
      if line !~ HISTIGNORE
        File.open(PERMLOG, 'a', 0600) {|f| f << "PID#{Process.pid} #{Time.now.gmtime.strftime("%Y-%m-%dT%k:%M:%S.%L UTC")} #{Dir.pwd.sub(ENV['HOME']+'/', '')}> #{line}\n"}
      end
      SCRIPT_LINES__['(irb)'] << "#{line}\n"
    end
  end

  module_function :write_log_line
end

class IRB::ReidlineInputMethod
  prepend(Module.new.tap do |m|
    m.module_eval do
      define_method(:gets) do |*args|
        Readline.write_log_line(super(*args))
      end
    end
  end)
end

class IRB::ReadlineInputMethod
  prepend(Module.new.tap do |m|
    m.module_eval do
      define_method(:gets) do |*args|
        Readline.write_log_line(super(*args))
      end
    end
  end)
end

class IRB::FileInputMethod
  prepend(Module.new.tap do |m|
    m.module_eval do
      define_method(:gets) do |*args|
        Readline.write_log_line(super(*args))
      end
    end
  end)
end

class IRB::StdioInputMethod
  prepend(Module.new.tap do |m|
    m.module_eval do
      define_method(:gets) do |*args|
        Readline.write_log_line(super(*args))
      end
    end
  end)
end

class XMP::StringInputMethod
  prepend(Module.new.tap do |m|
    m.module_eval do
      define_method(:gets) do |*args|
        Readline.write_log_line(super(*args))
      end
    end
  end)
end

IRB.conf[:SAVE_HISTORY] = 10000
IRB.conf[:HISTORY_FILE] = Readline::HISTORYLOG
