require 'opml_saw'

module Weighted
  class OpmlParser

    # Parses an OPML formatted file and extract entries
    #
    # @params string [String]
    # @return [Array] A collection of hashes
    # @example
    #
    #   OpmlParser.parse('subscriptions.xml')
    #   =>
    #    {
    #        :text => "Lifehacker: Top",
    #       :title => "Lifehacker: Top",
    #        :type => "rss",
    #     :xml_url => "http://lifehacker.com/tag/top/index.xml",
    #    :html_url => "http://lifehacker.com/tag/top",
    #         :tag => "Autres"
    #    }
    #
    def self.parse(string)
      @file = File.open(string)
      @opml = OpmlSaw::Parser.new(@file.read)

      @opml.parse
      @opml.feeds
    end
  end
end
