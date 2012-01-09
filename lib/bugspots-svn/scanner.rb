require 'rainbow'
require 'svn/client'

module BugspotsSvn
  Fix = Struct.new(:message, :date, :files)
  Spot = Struct.new(:file, :score)

  def self.scan(repo, rstart = 1, rend = "HEAD", limit = 500, words = nil)
    fixes = []

    if words
      message_matchers = /#{words.split(',').join('|')}/
    else
      message_matchers = /ref(s|d)?|fix(es|ed)?|close(s|d)?/i
    end
    
    ctx = Svn::Client::Context.new
    
    ctx.log(repo, rstart, rend, limit, true, true) do |changed_paths, rev, author, date, message|
      if message =~ message_matchers
        fixes << Fix.new(message, date, changed_paths)
      end
    end
    
    hotspots = Hash.new(0)
    fixes.each do |fix|
      fix.files.each do |path, changed_path|
        t = 1 - ((Time.now - fix.date).to_f / (Time.now - fixes.last.date))
        hotspots[path] += 1/(1+Math.exp((-12*t)+12))
      end
    end
    
    spots = hotspots.sort_by {|k,v| v}.reverse.collect do |spot|
      Spot.new(spot.first, sprintf('%.4f', spot.last))
    end

    return fixes, spots
  end
end
