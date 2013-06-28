require 'spec_helper'

describe Weighted::OpmlParser do
  let(:opml_file) { File.join(Weighted::Application.root, 'spec', 'support', 'opml.xml') }

  describe :ClassMethods do

    describe :parse do
      let(:feeds) { Weighted::OpmlParser.parse(opml_file) }

      it "returns feeds as Hashes" do
        feeds.first.should be_a(Hash)
      end

      it "finds all feeds" do
        feeds.should have(20).elements
      end

      describe 'feed_entry' do
        subject { feeds.first }

        it { should have_key(:text) }
        it { should have_key(:title) }
        it { should have_key(:type) }
        it { should have_key(:xml_url) }
        it { should have_key(:html_url) }
        it { should have_key(:tag) }
      end
    end
  end

end
