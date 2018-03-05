#!/opt/puppetlabs/puppet/bin/ruby
#
# Wrapper for executing puppet inside of a cron job since
# we will want to add some extra logic around installing
# modules. We will also want to add some logic around switching
# the branch based on info from collins.


class Runner

  def initialize(manifest, path, lp)
    @manifest_path = manifest
    @puppet_path = path
    @librarian_puppet = lp
  end

  # Apply puppet at the path that was provided to
  # us in the initializer. Runs contains the amount of
  # times we should try to apply puppet before we call
  # this a failure.
  def apply
    run_cmd "#{@puppet_path} apply #{@manifest_path}"
    exit $?.exitstatus
  end

  # Make sure that all dependencies needed for the library
  # to run are installed before calling apply.
  def installer
    run_cmd "cd #{@manifest_path} && #{@librarian_puppet} install"
    exit $?.exitstatus if $?.exitstatus != 0
  end

  def run_cmd cmd
    puts cmd # write to log
    system cmd
  end

  def run
    installer
    apply
  end

end

mpath = '/etc/puppetlabs/code/environments/production'
ppath = '/opt/puppetlabs/bin/puppet'
lp = '/opt/puppetlabs/puppet/bin/librarian-puppet'

runner = Runner.new(mpath, ppath, lp)

runner.run
