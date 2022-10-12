require 'optparse'


class PasswordCreator

  @@listuppercase = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']
  @@listlowercase = @@listuppercase.map{|c| c.downcase}
  @@listdigit = ['0','1','2','3','4','5','6','7','8','9']
    
  def initialize(length, lowercase, uppercase, digit)
    @length = length.to_i
    @lowercase = lowercase
    @uppercase = uppercase
    @digit = digit

    @listchar = []
    @listchar.concat @@listuppercase if @uppercase
    @listchar.concat @@listlowercase if @lowercase
    @listchar.concat @@listdigit if @digit
    if @listchar.empty? then
      @listchar.concat @@listuppercase
      @listchar.concat @@listlowercase
      @listchar.concat @@listdigit
    end
  end

  def create
    list = []
    list.push @@listuppercase[rand(@@listuppercase.size)] if @uppercase
    list.push @@listlowercase[rand(@@listlowercase.size)] if @lowercase
    list.push @@listdigit[rand(@@listdigit.size)] if @digit
    while list.size < @length do
      list.push @listchar[rand(@listchar.size)]
    end

    list.shuffle!
    list.join
  end
end


parser = OptionParser.new

parser.on('-n NUM', 'length', Integer)
parser.on('-l', '--lowercase', 'One or more lowercases required')
parser.on('-u', '--uppercase', 'One or more uppercases required')
parser.on('-d', '--digit', 'One or more digits required')

params = {:n => 8 , :lowercase => false, :uppercase => false, :digit => false}
parser.parse!(ARGV, into: params)


pc = PasswordCreator.new(params[:n], params[:lowercase], params[:uppercase], params[:digit])
puts pc.create

