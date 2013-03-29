#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

# ============== = ===========================================================
# Description    : Alfred 2 Source Tree Workflow
# Author         : Zhao Cai <caizhaoff@gmail.com>
# HomePage       : https://github.com/zhaocai/alfred2-sourcetree-workflow
# Version        : 0.1
# Date Created   : Sun 10 Mar 2013 09:59:48 PM EDT
# Last Modified  : Fri 29 Mar 2013 04:54:19 AM EDT
# Tag            : [ ruby, alfred, workflow ]
# Copyright      : © 2013 by Zhao Cai,
#                  Released under current GPL license.
# ============== = ===========================================================
($LOAD_PATH << File.expand_path("..", __FILE__)).uniq!

require 'rubygems' unless defined? Gem # rubygems is only needed in 1.8

require "bundle/bundler/setup"
require "alfred"


def sourcetree_bookmarks

  sourcetree_plist = File.expand_path(
    "~/Library/Application Support/SourceTree/browser.plist")
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

# (#
# Feedback                                                                [[[1
# #)

def generate_feedback(alfred, query)

  feedback = alfred.feedback

  sourcetree_bookmarks.uniq {|b| b[:name] + b[:path]}.each { |b|
    feedback.add_item({
      :uid      => b[:path],
      :title    => b[:name],
      :subtitle => b[:path],
      :arg      => b[:path],
    })
  }

  puts feedback.to_alfred(query)
end

# overwrite default query matcher
module Alfred
  class Feedback::Item
    def match?(query)
      all_title_match?(query)
    end
  end
end

if __FILE__ == $PROGRAM_NAME

  Alfred.with_friendly_error do |alfred|
    alfred.with_rescue_feedback = true
    query = ARGV.join(" ").strip
    generate_feedback(alfred, query)
  end
end


# (#
# Modeline                                                                [[[1
# #)
# vim: set ft=ruby ts=2 sw=2 tw=78 fdm=marker fmr=[[[,]]] fdl=1 :
