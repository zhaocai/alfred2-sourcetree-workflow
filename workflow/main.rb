#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

# ============== = ===========================================================
# Description    : Alfred 2 Source Tree Workflow
# Author         : Zhao Cai <caizhaoff@gmail.com>
# HomePage       : https://github.com/zhaocai/alfred2-sourcetree-workflow
# Version        : 0.1
# Date Created   : Sun 10 Mar 2013 09:59:48 PM EDT
# Last Modified  : Mon 01 Apr 2013 05:56:01 AM EDT
# Tag            : [ ruby, alfred, workflow ]
# Copyright      : © 2013 by Zhao Cai,
#                  Released under current GPL license.
# ============== = ===========================================================
($LOAD_PATH << File.expand_path("..", __FILE__)).uniq!

require 'rubygems' unless defined? Gem # rubygems is only needed in 1.8

require "bundle/bundler/setup"
require "alfred"



class SourceTree < ::Alfred::Handler::Base
  def initialize(alfred, opts = {})
    super
    @settings = {
      :handler => 'SourceTree' ,
      :expire  => 7200         ,
    }.update(opts)

    feedback.use_cache_file :expire => @settings[:expire]
  end


  def generate_feedback
    sourcetree_bookmarks.uniq {|b| b[:name] + b[:path]}.each do |b|
      arg = xml_builder(
        :handler => @settings[:handler] ,
        :path => b[:path]
      )

      feedback.add_item({
        :uid      => b[:path]          ,
        :title    => b[:name]          ,
        :subtitle => b[:path]          ,
        :arg      => arg               ,
        :type     => 'file'            ,
        :match?   => :all_title_match? ,
      })
    end

    feedback.put_cached_feedback
  end


  def on_feedback
    if !options.should_reload_cached_feedback and fb = feedback.get_cached_feedback
      feedback.merge! fb
    else
      generate_feedback
    end
  end


  def on_action(arg)

    return unless action?(arg)

    case options.modifier
    when :command
      Alfred::Util.reveal_in_finder(arg[:path])
    when :none
      Alfred::Util.open_with('SourceTree', arg[:path])
    end
  end


  def sourcetree_bookmarks

    sourcetree_plist = File.expand_path(
      "~/Library/Application Support/SourceTree/browser.plist")
    raise IOError, "#{sourcetree_plist} does not exists." unless File.exist? sourcetree_plist

    bookmarks_plist = Plist::parse_xml(
      %x{plutil -convert xml1 -o - "#{sourcetree_plist}"})

    last_obj = ""
    bookmarks = []
    bookmarks_plist["$objects"].each do |o|
      if o.is_a?(String) && File.exist?(o)
        if last_obj.is_a?(String)
          bookmarks << { :name => last_obj, :path => o,}
        else
          bookmarks << { :name => File.basename(o), :path => o,}
        end
      end
      last_obj = o
    end
    bookmarks
  end

end



Alfred.with_friendly_error do |alfred|
  alfred.with_rescue_feedback = true
  alfred.with_help_feedback = true
  alfred.cached_feedback_reload_option[:use_reload_option] = true
  alfred.cached_feedback_reload_option[:use_exclamation_mark] = true

  SourceTree.new(alfred).register
end

# (#
# Modeline                                                                ⟨⟨⟨1
# #)
# vim: set ft=ruby ts=2 sw=2 tw=78 fdm=marker fmr=⟨⟨⟨,⟩⟩⟩ fdl=1 :
