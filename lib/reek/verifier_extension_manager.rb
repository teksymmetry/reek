require 'rubygems'
require 'activesupport'

module Reek
  #
  # Manage verifier extention
  # Load new verifier extention and keep the instance, so later when we need
  # the same extention we can recall from cache.
  #
  class VerifierExtensionManager
    @@verifier_extensions = {}

    def self.accepted?(p_extension_scripts, p_context, p_variable)
      p_extension_scripts.each do |extension_script|
        extension = find_or_initiate_extension(extension_script)
        if extension
          accepted, message = extension.accepted?(p_context, p_variable)
          if !accepted
            return false, message
          end
        end
      end

      return true, nil
    end

    def self.find_or_initiate_extension(p_extension_script)
      if !exists?(p_extension_script)
        initiate_extension!(p_extension_script)
      end

      return find(p_extension_script)
    end

    def self.find(p_extension_script)
      @@verifier_extensions[p_extension_script]
    end

    def self.exists?(p_extension_script)
      @@verifier_extensions.include?(p_extension_script)
    end

    def self.initiate_extension!(p_extension_script)
      require p_extension_script

      # detect class name
      extension_class = p_extension_script.split(File::SEPARATOR).
                        last.split(".").first.camelize.constantize
      @@verifier_extensions[p_extension_script] = extension_class.new
    end
  end

end