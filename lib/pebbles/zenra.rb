# -*- coding: utf-8 -*-
$: << File.join(File.dirname(File.expand_path(__FILE__)))
require 'pebbles'
require 'yahoo_api_da_service'

def z sentence
  Pebbles::Zenra.new.zenrize sentence
end

class Pebbles::Zenra
  VERSION = '0.1.1'
  @@app_id = ENV['YAHOO_APPID']

  def self.app_id
    @@app_id
  end

  def self.app_id= app_id
    @@app_id = app_id
  end

  def initialize
    raise RuntimeError, 'Yahoo API was not given.' unless Zenra.app_id
  end

  def zenrize sentence, opts = {}
    opts = { :pos => '動詞', :add => '全裸で' }.merge(opts)
    YahooApiDAService.new(Zenra.app_id, sentence).parsed_array.inject('') do |r, v|
      r += opts[:add] if v['POS'].eql? opts[:pos]
      r += v['Surface']
    end
  end
end
