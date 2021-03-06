require 'etc'

Etc.passwd do |pw|
  user = pw.name.gsub(/[^a-zA-Z0-9_]/, '')
  homedir = pw.dir
  key = false

  if File.exists?("#{homedir}/.ssh/id_rsa.pub")
    file = IO.read("#{homedir}/.ssh/id_rsa.pub")
    key = file.split(" ")[1]
  elsif File.exists?("#{homedir}/.ssh/id_dsa.pub")
    file = IO.read("#{homedir}/.ssh/id_dsa.pub")
    key = file.split(" ")[1]
  end

  if key
    Facter.add("sshpubkey_#{user}") do
      setcode do
        key
      end
    end
  end
end
