describe package('mongodb-org') do
  it { should be_installed }
  its('version') { should cmp > '3.2.*' }
end

describe port('0.0.0.0', 27017) do
  it { should be_listening }
end

describe service "mongod" do
  it { should be_running}
  it { should be_enabled}
end
