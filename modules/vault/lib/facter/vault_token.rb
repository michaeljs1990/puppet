# This could just as well be a function in puppet so the path is not hard coded.
# However I am not a big fan of the idea that we have a puppet function that
# makes it easy to cat any file on the filesystem and use that for automation.

Facter.add(:vault_token) do
  setcode do
    token = ''

    token_path = '/root/.vault_token'
    File.open("#{token_path}", "r") do |f|
      f.each_line do |line|
        token = line.strip
      end
    end

    token
  end
end
