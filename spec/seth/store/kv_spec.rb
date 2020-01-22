require "seth/store/kv"

RSpec.describe Seth::Store::KV do

  it "can watch kv store" do
    system('echo test=val > /tmp/tomb')
    tomb = Seth::Store::KV.new({path: "/tmp/tomb"})
    expect(tomb.get("test")).to eq "val"
    system('echo test=val2 > /tmp/tomb')
    sleep 0.1
    expect(tomb.get("test")).to eq "val2"
  end

end
