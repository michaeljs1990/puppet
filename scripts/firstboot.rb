#!/opt/puppetlabs/puppet/bin/ruby
#
# This script is only run once when the system is first booted
# it should not be run again after that.

class Firstboot

  def initialize(manifest, path, log, service)
    @manifest_path = manifest
    @puppet_path = path
    @firstboot_log = log
    @systemd_service = service
  end
 
  # Insure that vault is setup before we continue or
  # the first run will fail anyway since hiera data doesn't
  # get reloaded unless a new puppet run starts. 
  def init_vault
    run_cmd "#{@puppet_path} apply #{@manifest_path} -e 'include vault'"
  end

  # Apply puppet at the path that was provided to
  # us in the initializer. Runs contains the amount of
  # times we should try to apply puppet before we call
  # this a failure.
  def apply runs
    runs.times do
      run_cmd "#{@puppet_path} apply #{@manifest_path}"
    end
  end

  def run_cmd cmd
    puts cmd # write to log
    system cmd
    break if check_exit $?
  end

  # Given the following process ensure that the exit code
  # is one that we care about and write out some info
  # for the user.
  #
  # * --detailed-exitcodes:
  #   Provide extra information about the run via exit codes. If enabled, 'puppet
  #   apply' will use the following exit codes:
  # 
  #   0: The run succeeded with no changes or failures; the system was already in
  #   the desired state.
  # 
  #   1: The run failed.
  # 
  #   2: The run succeeded, and some resources were changed.
  # 
  #   4: The run succeeded, and some resources failed.
  # 
  #   6: The run succeeded, and included both changes and failures.
  def check_exit process
    ecode = process.exitstatus
    puts "puppet exited with a status of #{ecode}"
    ecode == 2 || ecode == 0 
  end

  # Run this method to start off the process
  def kickstart
    init_vault
    apply 3
  end

end

mpath = '/etc/puppetlabs/code/environments/production'
ppath = '/opt/puppetlabs/bin/puppet'
log = '/var/log/firstboot.log'
runner = Firstboot.new(mpath, ppath, log, 'firstboot')
runner.kickstart()
