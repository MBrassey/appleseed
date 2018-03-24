# appleseed
 appleseed is a command line widget (CLW), designed for `macOS` and `iTerm2`

─── [Code Review](https://codereview.stackexchange.com/questions/190375/appleseed-is-a-command-line-widget-clw-macos-iterm2)

─── [reddit](https://www.reddit.com/r/unixporn/comments/86d0t4/macos_appleseed_clw/)

![appleseed](https://github.com/mattinclude/macOS/blob/master/img/appleseed.png)

#### To use, you will need:
        
    macOS (High Sierra)
    Homebrew
    Bash
    iTerm2 (enable shell integration)
    imgcat

#### What it does:


    function backup() {
    
    ... Makes sure the specified files exist, copies them to appleseed/backup/ ... 
    ... Reports on activities taken ...
    
    } 

    function macOS() {
    
    ... Runs 'softwareupdate -l' ...
    ... Reports on status of macOS updates ... 
    
    }

    function homebrew() {
    
    ... Runs 'brew update' ...
    ... Reports on activities taken ... 
    
    }

    function network() {
    
    ... Determines Public IP ...
    ... Determines Geo-Location ...
    ... If country is not US, VPN is considerd active ... 
    ... Reports these values to the panel ...
    
    }

    function graphix() {
    
    ... Chooses random image from appleseed/img/ ...
    ... Displays image within the terminal using imgcat ... 
    
    }

    function system() {
    
    ... Obtains % available resources on CPU and Disk1 ...
    ... Reports these values to the panel ... 
    
    }

Configuring the `minutes=""` variable controls how long appleseed will wait to relaunch, in this way it operates as a simple cron service for session based process automation.  

I use appleseed to backup my [macOS Desktop Configuration](https://github.com/mattinclude/macOS) files to `appleseed/backup/`, and other important files wherever I want them :].

#### Troubleshooting:

When using the updated versions of zsh (5.3 +) or Shell Integration in iTerm 2 (Build 2.9.20160313) or later, sometimes imgcat will stop working. Review [this](http://bit.ly/2psIiZL) to resolve the issue.  

#### Artwork

    "blue" • _render__anime_girl_by_miregg-d9m6fta
    "green" • valkyrie_crusade___high_elf_render_by_ennaliese-d8xwb5p
    "purple" • Anime_girl_purple_hair_render_by_schorch2812-d821xxe
    "cool" • [Original] Anime girl render by LCkiWi
    "wuf" • wolf_girl_swimsuit_render_by_sirkonata
    "sk8" • Anime_girl_render_60_by_dickywardhana-d7l8o5v
    "asuna" • asuna_render_by_codzocker00-d5kw2ld
    "tech" • render__10__by_maoyuu_maou-d90s16s
    "chain" • r_n03_by_maoyuu_maou-dbp0km0
    "united" • untitld_1_by_kougon01-d6xnags
    "gz1-gz9" • original_render_by_lckiw

Layer Effects: + 0.3 px outer glow, + 3D Effect.   

![appleseed](https://github.com/mattinclude/macOS/blob/master/img/appleseed_slides.png)

#### ToDo:
- [ ] Add option to upload `backup files` to [STORJ](https://storj.io). 
- [ ] Add argument "--sync" to pull down and apply configs from github repo.  
