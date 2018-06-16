class DjHostBio {

  Map<String, String> bios = Map();

  DjHostBio() {
    bios.putIfAbsent("Ryan Seacrest", ()=>"Ryan is quite simply one of the most influential, well-regarded, and well-known names in Hollywood. He is the quintessential Hollywood insider who always manages to have the biggest scoops and the most sought after access to top events and celebrities. Ryan is known for both his trusted friendship with fellow members of the Hollywood elite and his personal connection with his fans, and for featuring the hottest pop acts, actors, and celebrity icons, but Ryan also prides himself on bridging the gap between celebrity and fan. At the end of the day, Ryan's a normal guy who relates to his listeners just like any other fan of music, entertainment, and radio!");
    bios.putIfAbsent("Rich Kaminski", ()=>"Rich Kaminski has been your constant companion in the afternoon on Lite-FM for over a decade now. As a kid, Rich's life was similar to the life of many other suburban Jersey boys \"kind of ordinary\" summers working in the snack bar at the local pool and weekends at the deli counter making sandwiches. But throughout his life, there was one constant: music. A light (LITE) bulb went off in his head and the idea to pursue on-air broadcasting was born.Upon graduation from William Paterson University, Rich ignited his broadcast career with on-air shifts across the northeast landing in various markets including: Philadelphia and New Jersey, and the biggest radio market of them all: New York. Lucky for us, Rich's home, besides the one he shares with his wife, daughter and their Basset Hound, is 106.7 Lite FM. After a long day at work, Rich helps make the afternoon/evening commute (weekdays 3p-8p) a little easier.When Rich isn't being heard over the airwaves, you'll likely find him with his daughter and dog at the park and playground. Rich Kaminski is like the brother you always want to have around: and thankfully for us, he's here to stay.");
    bios.putIfAbsent("Delilah", ()=>"Delilah is the most-listened-to-woman on radio in the U.S. Delilah’s soothing voice, open heart and love of music have expanded her audience to more than eight million weekly listeners on approximately 160 radio stations in the U.S.  Delilah, who celebrated the 30-year anniversary of her nighttime radio program in 2016, was honored with the radio industry’s highest accolades– an induction into the National Radio Hall of Fame in 2016, the 2017 National Association of Broadcasters (NAB) Broadcast Hall of Fame induction, marking the first time in 35 years that a woman would receive such a distinction. As well, the NAB honored her with a prestigious Marconi Award for “Network/Syndicated Personality of the Year” in 2016. In addition, there are yearly honors by Radio Ink as one of the “Most Influential Women in Radio”. Delilah took home the trophy for “Outstanding Host Entertainment/Information” at the Alliance of Women in Media’s 37th Annual Gracie Awards Gala.");
  }

  String getBio(String host) {
    if (bios[host] == null) {
      return bios["Ryan Seacrest"];
    } else {
      return bios[host];
    }
  }
}