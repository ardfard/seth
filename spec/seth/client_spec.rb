require 'seth'

RSpec.describe Seth::Client do
  it "can listen to kv store" do
    system('echo test=val > /tmp/seth_kv')
    seth = Seth::Client.new do |config|
      config[:store] = :kv
      config[:path] = '/tmp/seth_kv'
    end
    system('echo test=valnot1 > /tmp/seth_kv')
    sleep 0.1
    expect(seth.fetch("test", "val")).to eq "valnot1"
  end
end
