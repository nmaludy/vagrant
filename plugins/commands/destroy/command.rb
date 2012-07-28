module VagrantPlugins
  module CommandDestroy
    class Command < Vagrant.plugin("1", :command)
      def execute
        options = {}

        opts = OptionParser.new do |opts|
          opts.banner = "Usage: vagrant destroy [vm-name]"
          opts.separator ""

          opts.on("-f", "--force", "Destroy without confirmation.") do |f|
            options[:force] = f
          end
        end

        # Parse the options
        argv = parse_options(opts)
        return if !argv

        @logger.debug("'Destroy' each target VM...")
        with_target_vms(argv, :reverse => true) do |vm|
          vm.action(:destroy)
        end

        # Success, exit status 0
        0
      end
    end
  end
end
