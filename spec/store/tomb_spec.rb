require "seth/store/tomb"

RSpec.describe Seth::Store::Tomb do
  it "can watch tomb store" do
    File.open('/tmp/tomb', 'w') { |f| f.puts("test=val") }
    tomb = Seth::Store::Tomb.new({path: "/tmp/tomb"})
    expect(tomb.get("test")).to eq "val"
    File.open('/tmp/tomb', 'w') { |f| f.puts "test=val2" }
    sleep 0.1
    expect(tomb.get("test")).to eq "val2"
  end
end
