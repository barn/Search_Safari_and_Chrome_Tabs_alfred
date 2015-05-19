module BrowserTabs
  class Processes
    attr_accessor :ps

    def app_running?(app_name)
      ps.include?(process_name(app_name))
    end

    def ps
      @ps || retrieve_processes
    end

    # Refresh list of processes
    def ps!
      retrieve_processes
    end

    private

    def retrieve_processes
      @ps = `ps ax`
    end

    def process_name(app_name)
      if app_name == 'WebKit'
        "Safari.app/Contents/MacOS/SafariForWebKitDevelopment"
      elsif app_name == 'Google Chrome Beta'
        ps.match(%r{Google Chrome Beta.app/Contents/Versions/[\d\.]+/Google Chrome Helper.app/Contents/MacOS/Google Chrome Helper})[0]
        # 'Google Chrome Beta.app/Contents/Versions/43.0.2357.65/Google Chrome Helper.app/Contents/MacOS/Google Chrome Helper'
      else
        "#{app_name}.app/Contents/MacOS/#{app_name}"
      end
    end
  end
end
