require 'rubygems'
require 'nokogiri'

require_relative 'config/boot'
require_relative 'models/team'
require_relative 'models/game'
require_relative 'models/drive'
require_relative 'models/play'
require_relative 'models/punt'
require_relative 'models/goforit'
require_relative 'models/field_goal'


def normalize(str)
  return str.gsub(/(\n\r)|\s+/, ' ').strip
end

def processPlayByPlay(filename)
  page = Nokogiri::HTML(open(filename))

  puts page.class
  # extract the names of the teams
  roadteam, hometeam = page.css('div.align-center')[0].css('div')[0].text.split(' vs. ')
  puts "#{roadteam} at #{hometeam}"
  home = Team.find_or_create_by(school: hometeam)

  road = Team.find_or_create_by(school: roadteam)

  # filename = filename.split(" ")

  a = filename.to_s

  #date = filename.to_enum(:scan, /\d+{5}/).map{Regexp.last_match}
  date = a.match(/\d+{5}/)
  date = date.to_s
  puts date

  #code = filename.to_enum(:scan, /_(\w+)/).map{Regexp.last_match}
  gamescode = a.match(/_(\w+)/i)
  code = gamescode.captures.to_s
  code =  code[2,4]


  # extract the score
  roadscore = page.css('span.stats-header')[1].text
  homescore = page.css('span.stats-header')[3].text
  puts "roadscore: #{roadscore}, homescore: #{homescore}"
  # extract the shortened team names
  roadteamshort = page.css('span.stats-header')[0].text
  hometeamshort = page.css('span.stats-header')[2].text
  puts "shortened: #{roadteamshort} at #{hometeamshort}"

  # first, try to look up by the gamecode, which is unique for each game (I think?)

  game = Game.find_by(gamecode: code)
  if game == nil
    # if we can't find the record, then create it!
    game = Game.find_or_create_by(home_id: home.id, road_id: road.id, home_score: homescore, road_score: roadscore, date: date, gamecode: code)
  end

  #search for the quarters

  # search for the table rows using a JQuery-like syntax
  quarterz = '1st'
  drive = nil
  touch = nil
  play1 = nil

  page.css('tr.odd, tr.even').each do |e|
    # check if there is a "summary bold" class
    summary = e.css('td[class="summary bold"]')
    if summary.length == 1
      # This happens at the end of a drive!
      puts  summary.text
    else
      # get first td, which is down/distance
      # then second td, which is event
      downdist=normalize(e.css('td')[0].text)
      puts "Downdist is: " + downdist

      event=normalize(e.css('td')[1].text)
      puts "Event is: " + event


      printf("%s => %s\n", downdist, event)
      # TODO: all of the work processing the down-and-distance
      # and the event and convert it into model classes to put into
      # the database.
      #
      # Example of regex matching to find the down and distance
      # 1st and 10 at KC25
      m = downdist.match(/(^.*) and (\d+) at ([A-Z]+\d+)/i)
      timer = event.match(/drive start at(.*)./)

      quarters = event.match(/Start of (.*) quarter/)
      teams = event.match(/(.*)drive start at/i)
      touch = event.match(/(TOUCHDOWN)/i)


      if teams != nil
        teamed = teams.captures
        teamz = teamed.join(" ")
        puts "Teams are: " + teamz

      end

      if touch != nil && drive !=nil
        drive.update(points: 7)
      end


      if quarters !=nil

        quarter = quarters.captures

        quarterz = quarter.join(" ")
      end






      if timer != nil
        time  = timer.captures.to_s
        time = time[3,5]
      end


      if m!= nil
        down, dist, loc = m.captures
        downs = down.to_i
        dists = dist.to_i
        loc = loc.to_s
            # puts "Down is " + downs
            #puts "Dists is " + dists
        puts "Loc is " + loc

      end


      if m != nil && timer != nil && teamz!=nil
        down, dist, loc = m.captures
        locationss = loc.to_s
        locations = locationss.match(/\d+/)
        locationz = locations.to_s
        locate = locationz.to_i




        #puts "Location is " + location[2,3]
        puts "Time and location " +  time + " " +  locationz
        # puts "Teams are " + teams
        teamzcomp = teamz.downcase
        homecomp = hometeam.downcase


        compare = teamzcomp <=> homecomp
        if(compare == 1)
          teamname = home
        elsif
        teamname = road
        end


        drive = Drive.find_by(game: game, team: teamname, quarter: quarterz, starttime: time, location: locate)
        if drive == nil
          drive = Drive.find_or_create_by(game: game, team: teamname, quarter: quarterz, starttime: time, location: locate, points: 0)
        end

        if drive.invalid?
          p drive.errors.messages
          exit
        end

        #p down, dist, loc

      end


      # OK, now process all of the events, such as:
      # N. Edlund rush for 3 yards to the KC28 (Dakotah Jones).
      # We are going to try to match them with a regexp, one at a time
      if (m = event.match(/.* rush for (\d+) yards? to the ([A-Z]+\d+).*/i)) != nil

        yards, location = m.captures

        puts "MATCH: #{yards} #{location}"
      elsif (m = event.match(/.* pass complete to .* for loss of (\d+) yard .*/)) != nil
        # M. McCaffrey pass complete to B. Powers for loss of 3 yards to the KC48 (Dyllan Bailey).
        yards = -m.captures[0].to_i
        puts "MATCH: #{yards}"
      elsif (m = event.match(/.* rush for no gain.*/)) != nil
        # N. Edlund rush for no gain to the KC48 (Adam Jackson).
        locator = event.match(/to the ([A-Z]+\d+)/)
        location = locator.captures
        location = location.join(" ")
        yards = 0
        puts "MATCH: #{yards}"
      elsif (m = event.match(/.* punt (\d+) yards to the ([A-Z]+\d+)./)) != nil
        # M. McCaffrey punt 22 yards to the IC32, fair catch by Kyle Obertino.
        # punt with no return
        yards, location = m.captures
        net = yards
        puts "MATCH: #{yards}"
      elsif (m = event.match(/ pass complete to .* for (\d+) yards to the ([A-Z]+\d+)/)) != nil
        # Blake Matson pass complete to Kyle Obertino for 6 yards to the IC38 (E. Economos).
        yards = m.captures[0]
        location = m.captures[1]


        puts "MATCH: #{yards}"
      elsif (m = event.match(/ .* kick attempt /)) != nil
        # Blake Matson pass complete to Kyle Obertino for 6 yards to the IC38 (E. Economos).

        puts "Event nil is " + event
        yard = 3
        location = 'KC14'


        puts "MATCH: #{yards}"

      else
        puts "\n#{event}"
      end
      yards = yards.to_i
      if location != nil
        location = location.match(/(\d+)/i)
        location = location.captures
        location = location.join(" ")
        puts "The quarter in this place is " + quarterz
        puts "The distance in this place is " + dists.to_s
        puts "The event in this place is " + event
        puts "The location in this place is " + location.to_s
        puts "The yards in this location is " + yards.to_s
        puts "The downs in this location is " + downs.to_s
        puts "The quarters in this location is " + quarterz.to_s

      end

      if drive != nil
        play1 = Play.find_or_create_by(drive: drive, playnum: 1, down: downs, distance: dists, quarter: quarterz, location: location, result: yards, description: event)
      end
      if drive != nil && net != nil
        punt = Punt.find_or_create_by(play: play1, distance: dists, net: yards)
      end
    #  if drive != nil && succ != nil
     #   goforit = Goforit.find_or_create_by(play: play1, success: succ)
      #end

    end
  end

end



def main
  root='play-by-play'
  Dir[root+'/2016/*'].each do |team|
    puts team
  end
  ['2016', '2015', '2014', '2013', '2012', '2011'].each do |year|
    puts year
    Dir[root+'/'+year].each do |team|
      puts team
      Dir[root+'/'+year+'/'+team].each do |file|
        puts file
        processPlayByPlay(root+'/'+year+'/'+team+'/'+file)
      end
    end
  end

end

if __FILE__ == $0
  # test on only ony play-by-play record at a time
  # comment this out when you want to process records in bulk
  processPlayByPlay('play-by-play/2016/Knox/20161015_m72v.xml')

  # Use main to run through all data that we have
  #main
end

