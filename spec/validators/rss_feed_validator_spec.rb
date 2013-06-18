# encoding: UTF-8
require 'spec_helper'

class Validatable
  include ActiveModel::Validations
  attr_accessor :rss_feed
  validates :rss_feed, rss_feed: true
end

describe RssFeedValidator do

  subject { Validatable.new }

  context "with a valid rss_feed" do
    let(:rss_feeds) do
      [
        # @TODO Find a bunch of picky valid rss feeds
      ]
    end

    # @TODO Use fixtures

    it "validates the rss_feed" do
      rss_feeds.each do |rss_feed|
        subject.rss_feed = rss_feed
        should be_valid
      end
    end
  end

  context "with an invalid rss_feed" do
    let(:rss_feeds) do
      [
        # @TODO Find a bunch of picky invalid rss feeds
      ]
    end

    it "validates the rss_feed" do
      rss_feeds.each do |rss_feed|
        subject.rss_feed = rss_feed
        should_not be_valid
      end
    end

    it "adds an error to the model" do
      rss_feeds.each do |rss_feed|
        subject.rss_feed = rss_feed
        should have(1).error_on(:rss_feed)
      end
    end

  end
end
