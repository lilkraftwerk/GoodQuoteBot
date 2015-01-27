require 'stamp'
require 'twitter'

class EmojiHoroscope
  def initialize
    configure_twitter_client
    make_emoji
    make_sentences
    make_signs
    set_date_format
    replace_all_sentences
    @all_scopes = {}
    make_all_scopes
    check_for_length
    all_scopes
  end

def make_emoji
    @collected_emoji = {
        emotion: ["😄", "😃", "😀", "😊", "☺", "😉", "😍", "😘", "😚", "😗", "😙", "😜", "😝", "😛", "😳", "😁", "😔", "😌", "😒", "😞", "😣", "😢", "😂", "😭", "😪", "😥", "😰", "😅", "😓", "😩", "😫", "😨", "😱", "😠", "😡", "😤", "😖", "😆", "😋", "😷", "😎", "😴", "😵", "😲", "😟", "😦", "😧", "😈", "👿", "😮", "😬", "😐", "😕", "😯", "😶", "😇", "😏", "😑", "🆗", "🆕", "🆒", "🆓"],
        person: ["👲", "👳", "👮", "👷", "💂", "👶", "👦", "👧", "👨", "👩", "👴", "👵", "👱", "👼", "👸", "😺", "😸", "😻", "😽", "😼", "🙀", "😿", "😹", "😾", "👹", "👺", "🙈", "🙉", "🙊", "💀", "👽", "🚶", "🏃", "💃", "👫", "👪", "👬", "👭", "💏", "💑", "👯", "🙆", "🙅", "💁", "🙋", "💆", "💇"],
        animal: ["🐶", "🐺", "🐱", "🐭", "🐹", "🐰", "🐸", "🐯", "🐨", "🐻", "🐷", "🐽", "🐮", "🐗", "🐵", "🐒", "🐴", "🐑", "🐘", "🐼", "🐧", "🐦", "🐤", "🐥", "🐣", "🐔", "🐍", "🐢", "🐛", "🐝", "🐜", "🐞", "🐌", "🐙", "🐚", "🐠", "🐟", "🐬", "🐳", "🐋", "🐄", "🐏", "🐀", "🐃", "🐅", "🐇", "🐉", "🐎", "🐐", "🐓", "🐕", "🐖", "🐁", "🐂", "🐲", "🐡", "🐊", "🐫", "🐪", "🐆", "🐈", "🐩"],
        location: ["🏠", "🏡", "🏫", "🏢", "🏣", "🏥", "🏦", "🏪", "🏩", "🏨", "💒", "⛪", "🏬", "🏤", "🌇", "🌆", "🏯", "🏰", "⛺", "🏭", "🗼", "🗾", "🗻", "🌄", "🌅", "🌃", "🗽", "🌉", "🎠", "🎡", "⛲", "🎢", "🚢"],
        food: ["☕", "🍵", "🍶", "🍼", "🍺", "🍻", "🍸", "🍹", "🍷", "🍴", "🍕", "🍔", "🍟", "🍗", "🍖", "🍝", "🍛", "🍤", "🍱", "🍣", "🍥", "🍙", "🍘", "🍚", "🍜", "🍲", "🍢", "🍡", "🍳", "🍞", "🍩", "🍮", "🍦", "🍨", "🍧", "🎂", "🍰", "🍪", "🍫", "🍬", "🍭", "🍯", "🍎", "🍏", "🍊", "🍋", "🍒", "🍇", "🍉", "🍓", "🍑", "🍈", "🍌", "🍐", "🍍", "🍠", "🍆", "🍅", "🌽"],
        time: ["🕛", "🕧", "🕐", "🕜", "🕑", "🕝", "🕒", "🕞", "🕓", "🕟", "🕔", "🕠", "🕕", "🕖", "🕗", "🕘", "🕙", "🕚", "🕡", "🕢", "🕣", "🕤", "🕥", "🕦"],
        transportation: ["⛵", "🚤", "🚣", "⚓", "🚀", "✈", "💺", "🚁", "🚂", "🚊", "🚉", "🚞", "🚆", "🚄", "🚅", "🚈", "🚇", "🚝", "🚋", "🚃", "🚎", "🚌", "🚍", "🚙", "🚘", "🚗", "🚕", "🚖", "🚛", "🚚", "🚨", "🚓", "🚔", "🚒", "🚑", "🚐", "🚲", "🚡", "🚟", "🚠", "🚜"],
        sign: ["♈", "♉", "♊", "♋", "♌", "♍", "♎", "♏", "♐", "♑", "♒", "♓"],
        clothes: ["🎩", "👑", "👒", "👟", "👞", "👡", "👠", "👢", "👕", "👔", "👚", "👗", "🎽", "👖", "👘", "👙", "💼", "👜", "👝", "👛", "👓", "🎀", "💄", "🎓"],
        weather: ["☀", "⛅", "☁", "⚡", "☔", "❄", "⛄"],
        nature: ["💐", "🌸", "🌷", "🍀", "🌹", "🌻", "🌺", "🍁", "🍃", "🍂", "🌿", "🌾", "🍄", "🌵", "🌴", "🌲", "🌳", "🌰", "🌱", "🌼"],
        moon: ["🌞", "🌝", "🌚", "🌑", "🌒", "🌓", "🌔", "🌕", "🌖", "🌗", "🌘", "🌜", "🌛", "🌙"],
        danger: ["🚬", "💣", "🔫", "🔪", "💊", "💉", "💰"],
        direction: ["🆙", "↗", "↖", "↘", "↙", "↔", "↕", "🔄", "◀", "▶", "🔼", "🔽", "↩", "↪", "ℹ", "⏪", "⏩", "⏫", "⏬", "⤵", "⤴"],
        hobby: ["🔬", "🔭", "📰", "🎨", "🎬", "🎤", "🎧", "🎼", "🎵", "🎶", "🎹", "🎻", "🎺", "🎷", "🎸", "👾", "🎮", "🃏", "🎴", "🀄", "🎲", "🎯", "🏈", "🏀", "⚽", "⚾", "🎾", "🎱", "🏉", "🎳", "⛳", "🚵", "🚴", "🏁", "🏇", "🏆", "🎿", "🏂", "🏊", "🏄", "🎣"],
    }
    @collected_emoji.map {|k,v| v.shuffle!}
  end

  def make_signs
    @signs = ["♈", "♉", "♊", "♋", "♌", "♍", "♎", "♏", "♐", "♑", "♒", "♓"]
    @sign_names = %w( Aries Taurus Gemini Cancer Leo Virgo Libra Scorpio Sagittarius Capricorn Aquarius Pisces )
    @all_signs = @sign_names.zip(@signs)
  end

  def all_scopes
    @all_scopes.each do |k, v|
      puts v
      puts
    end
  end

  def set_date_format
    date = Date.today
    @stamped = date.stamp("June 1st")
  end

  def return_emoji(collection)
      array = @collected_emoji[collection.to_sym]
      array.rotate!(1).first
  end

  def translate_sentence(sentence)
      matches = sentence.match(/@(\w+)\W/)
      if matches
          matches.captures.each do |match|
              sentence.sub!("@#{match}", return_emoji(match))
          end
      end
      sentence
  end
def make_sentences
  @opening_sentences = [
    "Surf's up, according to @person.",
    "Look sexy in @clothes today.",
    "Rendesvouz at @location today.",
    "You will change your mind about @person today.",
    "@person may show up uninvited.",
    "Work harder on @hobby today.",
    "@person will take center stage today.",
    "@person may help you break out of a rut.",
    "You will discuss @hobby with @person.",
    "You've been lied to about @clothes.",
    "When you see @moon, watch out for @animal.",
    "Try to accomplish @hobby today.",
    "Don't be afraid of @sign today.",
    "Don't be afraid of @animal today.",
    "Don't accept @nature at face value today.",
    "Learn to @hobby today.",
    "Today, @sign will take center stage.",
    "Take a trip to @location today.",
    "Give @person a call today.",
    "@clothes will look great on you today.",
    "@person may become an enemy.",
    "Investments in @hobby will pay off today.",
    "@food will make you @emotion today."
  ].shuffle

  @middle_sentences = [
    "@moon will come into play.",
    "If you feel @emotion, talk to @animal.",
    "If you're feeling @emotion, try some @food.",
    "Take some time to enjoy @nature.",
    "Don't forget your @clothes.",
    "Let your @animal side come out.",
    "@animal will help you at work.",
    "Don't let @sign get you down.",
    "Don't be afraid to move @direction.",
    "Don't give up on @sign.",
    "Share your feelings with @person.",
    "Enjoy @hobby with @person.",
    "Let @hobby happen naturally.",
    "@sign may make you feel @emotion.",
    "Don't be afraid to splurge on @transportation.",
    "Treat yourself to some @food.",
    "@food will be illegal soon.",
    "@sign may invite you to @hobby.",
    "Connect with @sign.",
    "A @animal might make a good pet.",
    "Share responsibilities with @sign.",
    "Feel free to act like an @animal.",
    "Stay away from @danger.",
    "Don't pick up if @sign calls.",
    "It's okay to trust @person.",
    "@person makes you feel like a @animal.",
    "@person may have some news about @animal.",
    "Have some @danger. Why not?"
  ].shuffle

  @closing_sentences = [
    "You'll feel @emotion around @time.",
    "Something will happen at @time.",
    "@time may be important.",
    "Indulge yourself with some @food.",
    "Feeling @emotion is just fine.",
    "Grab your @animal, and sieze the day.",
    "You're better off avoiding @person.",
    "Turn your swag up to @person levels.",
    "@food may be able to help you with @person.",
    "Trust in @animal will reveal inner @emotion.",
    "@person's intentions will become clear.",
    "To @animal is human, to @food is divine.",
    "Remember to check on @person.",
    "@person may throw a @animal in your plans.",
    "@danger will bring you great joy.",
    "Praise @animal.",
    "@moon demands a ritual sacrifice... lol.",
    "You'll be tempted with @danger.",
    "Be careful around @danger.",
    "@person and @danger don't mix.",
    "Share your @danger with @animal.",
    "@moon will bring good vibes.",
  ].shuffle
end

  def replace_all_sentences
    until @closing_sentences.none? {|x| x.match(/@(\w+)\W/)}
      @closing_sentences.map!{|x| translate_sentence(x)}
    end
    until @opening_sentences.none? {|x| x.match(/@(\w+)\W/)}
      @opening_sentences.map!{|x| translate_sentence(x)}
    end
    until @middle_sentences.none? {|x| x.match(/@(\w+)\W/)}
      @middle_sentences.map!{|x| translate_sentence(x)}
    end
  end

  def format_sentences
      potential_array = [@opening_sentences.rotate!(1).first, @middle_sentences.rotate!(1).first, @closing_sentences.rotate!(1).first]
      potential_array.join(' ')
  end

  def format_horoscope(sign_array)
     [
       "#{sign_array[1]}  \##{sign_array[0]} #EmojiHoroscope #{sign_array[1]}",
       "🔮 #{@stamped} 🔮\n",
       "#{format_sentences}"
     ].join("\n")
   end

   def make_all_scopes
    @all_signs.each do |sign|
        @all_scopes[sign] = format_horoscope(sign)
    end
  end

  def check_for_length
    @all_scopes.each do |key, value|
      this_scope = value
      while this_scope.length > 140
        this_scope = format_horoscope(key)
      end
      @all_scopes[key] = this_scope
    end
  end

  def configure_twitter_client
     @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["TWITTER_KEY"]
      config.consumer_secret = ENV["TWITTER_SECRET"]
      config.access_token = ENV["ACCESS_TOKEN"]
      config.access_token_secret = ENV["ACCESS_SECRET"]
    end
  end

  def tweet_then_delay(scope)
    delay = 300
    @client.update(scope)
    puts "Waiting "
    1..delay.times do |x|
      puts "#{x} / #{delay} seconds till next tweet ;)"
      sleep 1
    end
  end

  def tweet_all
    @all_scopes.each do |key, scope|
      tweet_then_delay(scope)
    end
  end
end

def make_tweet
  emoji = EmojiHoroscope.new
  emoji.tweet_all
end