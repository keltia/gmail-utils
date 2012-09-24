# @abstract Index-specific specs
#
# @author Ollivier Robert <roberto@keltia.net>
#
# $Id: index_spec.rb,v e005048b8a29 2012/09/24 23:25:43 roberto $

require "rspec"
require "mail"
require "maildir"

require "gmail"

describe GMail::Index do

  before(:all) do
    @md = Maildir.new(File.expand_path(File.dirname(__FILE__) + '/../test/Perso-Foo'))
    @ind = GMail::Index.new(File.expand_path(File.dirname(__FILE__) + '/../test/Perso-Foo'))
    @mail = GMail::Entity.new(File.expand_path(File.dirname(__FILE__) + '/../test/1412679471642059988.meta'))
  end

  describe "#initialize" do
    it "should have the required attributes" do
      @ind.path.should be_an_instance_of(String)
      @ind.db.should be_an_instance_of(Rufus::Tokyo::Cabinet)
      @ind.path.should_not be_nil
      @ind.path.should_not eq("")
      @ind.db.should_not be_nil
    end
  end

  describe "#[]=" do
    it "should save the given message-id in the db" do
      @mail.gm_id.should_not be_nil
      @ind[@mail.gm_id] = "new/1348045599.M364547P44602Q2.roberto-aw.eurocontrol.fr"
      @ind[@mail.gm_id].should_not be_nil
      @ind.db[@mail.gm_id].should_not be_nil
    end
  end

  describe "#[]" do
    it "should return nil if nil is asked for" do
      foo = @ind[nil]
      foo.should be_nil
    end

    it "should return nil if not present" do
      foo = @ind["should-not-be-there"]
      foo.should be_nil
    end

    it "should return a unique key if present" do
      foo = @ind["1412679471642059988"]
      foo.should eq("new/1348045599.M364547P44602Q2.roberto-aw.eurocontrol.fr")
    end
  end

  describe "#present?" do
    it "should return nothing with nil" do
      @ind.present?(nil).should be_false
    end

    it "should return false if not present" do
      @ind.present?("foo-bar-baz").should be_false
    end

    it "should return true if present" do
      @ind[@mail.gm_id] = true
      @ind.present?(@mail.gm_id).should be_true
    end
  end

  describe "#last_id" do
    it "should return the 'last_id' property from db" do
      @ind.last_id.should_not be_nil
      @ind.last_id.should_not eq(0)
      @ind.last_id.should eq(@ind.db["last_id"])
    end
  end

  describe "#last_id=" do
    it "should update the 'last_id' property in the db" do
      @ind.last_id = 2
      @ind.last_id.to_i.should eq(2)
      @ind.db["last_id"].should eq(@ind.last_id)
    end
  end
end