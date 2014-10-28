#!/usr/bin/env ruby
RACES = ['dwarf', 'elf', 'halfling', 'human', 'dragonborn', 'gnome', 'half-elf', 'half-orc', 'tiefling']
CLASSES = ['barbarian', 'bard', 'cleric', 'druid', 'fighter', 'monk', 'paladin', 'ranger', 'rogue', 'sorcerer', 'warlock', 'wizard']
BACKGROUND = ['acolyte', 'charlatan', 'criminal', 'entertainer', 'folk hero', 'guild artisan', 'hermit', 'noble', 'outlander', 'sage', 'sailor', 'soldier', 'urchin']

@strength = nil
@dexterity = nil
@constitution = nil
@intelligence = nil
@wisdom = nil
@charisma = nil
@gold = nil


def roll_once
  4.times.map { rand(1..6) }.sort.drop(1).reduce(:+)
end

def roll(rolls=1)
  rolls.times.map { roll_once }
end

def prompt(rolls, stat)
  temp = nil
  
  loop do
    puts "What do you want for #{stat}?"
    temp = gets.chomp.to_i
    
    if rolls.include?(temp)
      break
    else
      puts "Try again"
    end
  end
  rolls.delete_at(rolls.index(temp))
  temp
end

def classprompt
  puts "Pick a class:"
  puts "#{CLASSES}"
  jobs = nil
  
  loop do
    puts "What class is your character?"
    jobs = gets.chomp.downcase
    
    if CLASSES.include?(jobs)
      break
    else
      puts "Try again"
    end
  end
  jobs
end

def raceprompt
  puts "Pick a race:"
  puts "#{RACES}"
  skin = nil
  
  loop do
    puts "What race is your character?"
    skin = gets.chomp.downcase
    
    if RACES.include?(skin)
      break
    else
      puts "Try again"
    end
  end
  skin
end

def backgroundprompt
  puts "Pick a background:"
  puts "#{BACKGROUND}"
  bg = nil
  
  loop do
    puts "What is your character's background?"
    bg = gets.chomp.downcase
    
    if BACKGROUND.include?(bg)
      break
    else
      puts "Try again"
    end
  end
  bg
end

def raceability(race)
  @speed = nil
  
  if race == 'dwarf'
    @constitution += 2
    @speed = 25
  elsif race == 'elf'
    @dexterity += 2
    @speed = 30
  elsif race == 'halfling'
    @dexterity += 2
    @speed = 25
  elsif race == 'human'
    @strength += 1
    @dexterity += 1
    @constitution += 1
    @intelligence += 1
    @wisdom += 1
    @charisma += 1
    @speed = 30
  elsif race == 'dragonborn'
    @strength += 2
    @charisma += 1
    @speed = 30
  elsif race == 'gnome'
    @intelligence += 2
    @speed = 25
  elsif race == 'half-elf'
    @charisma += 2
    halfelfloop
    
    @speed = 30
    

  elsif race == 'half-orc'
    @strength += 2
    @constitution +=1
    @speed = 30
  else
    @intelligence += 1
    @charisma += 2
    @speed = 30
  end
end

def halfelfloop
  resp = nil
  stats = 2
  
  loop do
    unless stats == 0
      puts "You have #{stats} abiity scores to increase of your choosing. Which stats would you like to increase?"
      puts "1 - strength"
      puts "2 - dexterity"
      puts "3 - constitution"
      puts "4 - intelligence"
      puts "5 - wisdom"
      puts "6 - charisma"
      resp = gets.chomp.to_i
      if resp < 7
        if resp == 1
          @strength += 1
        elsif resp == 2
          @dexterity += 1
        elsif resp == 3
          @constitution += 1
        elsif resp == 4
          @intelligence += 1
        elsif resp == 5
          @wisdom += 1
        else resp == 6
          @charisma +=1
        end
        stats -= 1
      else
        puts "That's not a valid command"
      end
    else
      break
    end
  end
end

def hitpoints(job,conbonus)
  hp = nil
  
  if job == 'barbarian'
    hp = 12 + conbonus
    @gold = 2.times.map { rand(1..4) * 10 }
  elsif job == 'bard'
    hp = 8 + conbonus
    @gold = 5.times.map { rand(1..4) * 10 }
  elsif job == 'cleric'
    hp = 8 + conbonus
    @gold = 5.times.map { rand(1..4) * 10 }
  elsif job == 'druid'
    hp = 8 + conbonus
    @gold = 2.times.map { rand(1..4) * 10 }
  elsif job == 'fighter'
    hp = 10 + conbonus
    @gold = 5.times.map { rand(1..4) * 10 }
  elsif job == 'monk'
    hp = 8 + conbonus
    @gold = 5.times.map { rand(1..4) }
  elsif job == 'paladin'
    hp = 10 + conbonus
    @gold = 5.times.map { rand(1..4) * 10 }
  elsif job == 'ranger'
    hp = 10 + conbonus
    @gold = 5.times.map { rand(1..4) * 10 }
  elsif job == 'rogue'
    hp = 8 + conbonus
    @gold = 4.times.map { rand(1..4) * 10 }
  elsif job == 'sorcerer'
    hp = 6 + conbonus
    @gold = 3.times.map { rand(1..4) * 10 }
  elsif job == 'warlock'
    hp = 8 + conbonus
    @gold = 4.times.map { rand(1..4) * 10 }
  else
    hp = 6 + conbonus
    @gold = 4.times.map { rand(1..4) * 10 }
  end
  hp
end

def backgroundstuff(bg)
  if bg == 'folk hero'
    @gold.push(10)
  elsif bg == 'hermit'
    @gold.push(5)
  elsif bg == 'noble'
    @gold.push(25)
  elsif bg == 'outlander'
    @gold.push(10)
  elsif bg == 'sage'
    @gold.push(10)
  elsif bg == 'soldier'
    @gold.push(10)
  elsif bg == 'urchin'
    @gold.push(10)
  else
    @gold.push(15)
  end
end

puts "What is your name?"
name = gets.chomp
plr_race = raceprompt
plr_class = classprompt
plr_background = backgroundprompt
playerrolls = roll(6)
puts "Your rolls are #{playerrolls}"
@strength = prompt(playerrolls, "@strength")
puts "#{playerrolls}"
@dexterity = prompt(playerrolls, "@dexterity")
puts "#{playerrolls}"
@constitution = prompt(playerrolls, "@constitution")
puts "#{playerrolls}"
@intelligence = prompt(playerrolls, "@intelligence")
puts "#{playerrolls}"
@wisdom = prompt(playerrolls, "@wisdom")
puts "#{playerrolls}"
@charisma = prompt(playerrolls, "@charisma")

raceability(plr_race)

strbonus = (@strength - 10) / 2
dexbonus = (@dexterity - 10) / 2
conbonus = (@constitution - 10) / 2
intbonus = (@intelligence - 10) / 2
wisbonus = (@wisdom - 10) / 2
chabonus = (@charisma - 10) / 2

athletics = strbonus
acrobatics = dexbonus 
sleightofhand = dexbonus 
stealth = dexbonus
animalhandling = wisbonus
insight = wisbonus 
medicine = wisbonus 
perception = wisbonus 
survival = wisbonus
arcana = intbonus 
history = intbonus 
investigation = intbonus 
nature = intbonus 
religion = intbonus
deception = chabonus 
intimidation = chabonus 
performance = chabonus 
persuasion = chabonus

meleebonus = strbonus + 2
rangedbonus = dexbonus + 2

armorclass = 10 + dexbonus

passivewisdom = 10 + perception

plr_hit = hitpoints(plr_class,conbonus)
backgroundstuff(plr_background)

race_feat = File.read("data/races/#{plr_race}.txt")

output = File.new("characters/#{name.split.map(&:capitalize).join(' ')}-#{plr_class.capitalize}.txt", "w")
output.write("Name: #{name.split.map(&:capitalize).join(' ')}
Race: #{plr_race.capitalize}
Class: #{plr_class.capitalize}
Background: #{plr_background.capitalize}

-------------------
Stats:
Strength: #{@strength}, Dexterity: #{@dexterity}, Constitution: #{@constitution}, Intelligence: #{@intelligence}, Wisdom: #{@wisdom}, Charisma: #{@charisma}.
Stat Bonuses:
STR: #{strbonus}, DEX: #{dexbonus}, CON: #{conbonus}, INT: #{intbonus}, WIS: #{wisbonus}, CHA: #{chabonus}
Hit ponts: #{plr_hit}
Base Speed: #{@speed}
AC: #{armorclass}
Passive Wisdom: #{passivewisdom}
Melee Bonus: #{meleebonus}
Ranged Bonus: #{rangedbonus}
Starting gold: #{@gold.reduce(:+)}

-------------------
Skill Bonuses:
Acrobatics: #{acrobatics} 
Animal Handling: #{animalhandling}
Arcana #{arcana}
Athletics: #{athletics}
Deception: #{deception}
History: #{history}
Insight: #{insight}
Intimidation #{intimidation}
Investigation #{investigation}
Medicine: #{medicine}
Nature: #{nature}
Perception: #{perception}
Performance: #{performance}
Persuasion: #{persuasion}
Religion: #{religion}
Sleight of Hand: #{sleightofhand}
Stealth: #{stealth}
Survival: #{survival}

-------------------
Racial Features:
#{race_feat}

-------------------
Class Features:")
puts "Output saved to: characters/#{name.split.map(&:capitalize).join(' ')}-#{plr_class.capitalize}.txt"