# AutoWall

<p align="center">
<img src="https://github.com/SegoCode/AutoWall/blob/master/media/demo.gif">
<img src="https://img.shields.io/badge/core-weebp & mpv-red?style=flat-square"> <img src="https://img.shields.io/badge/-%20Made%20with%20Autoit%20❤-blue.svg?style=flat-square"> <img src="https://img.shields.io/badge/Platform%20%26%20Version%20Support-Windows%2010-green?style=flat-square"> <img src="https://img.shields.io/github/languages/code-size/segocode/autowall?style=flat-square">
</p>

## About

Turn videos, gifs and webs into windows live wallpapers. The most simple and useful [Weebp](src/weebp) implementation in autoit. 

## Features
- Portable.
- Browse your gif or video files.
- Reset button to reverse all and delete config files.
- Set your wallpaper on windows startup.

(1.2+)

- [Set web as wallpaper.](#web-wallpaper)

(1.3+)

- ~~[Direct download from steam workshop.](https://github.com/SegoCode/swd)~~

(1.8+)

- AutoWall will stop automatically when you play games.
- [Configure live wallpaper performance.](#configure-performance)

(1.9+)

- AutoWall videos will stop when wallpaper is not visible (even if not playing any games).

(1.10+)

- [Support for multiple screens (Beta)](#multiple-screens)


## Web wallpaper
 Set any web to wallpaper, copy url and paste on text field, also Youtube videos.
 
 - Set Youtube video as a wallpaper using this url format;

*https://www.youtube.com/embed/(VIDEO_ID)?autoplay=1&loop=1&mute=1&playlist=(VIDEO_ID)*

*For add sound change the mute value (&mute=1) to zero (&mute=0)*

 - Set  [shadertoy](https://www.shadertoy.com) as a wallpaper using this url format;
 
*https://www.shadertoy.com/embed/(ID)?gui=false&t=10&paused=false&muted=true*

 *For add sound change the mute value (&mute=true) to true (&mute=false)*


## Configure performance

AutoWall works with [mpv](src/mpv), the configuration is available in "/mpv/" folder with the name "mpv.conf" editing with notedpad you can, for example, play the music of your live wallpaper changing the value "volume" to "100". 

Follow the [official mpv documentation](https://mpv.io/manual/stable/#configuration-files) to configure all performance parameters.

## Multiple screens

Autowall from 1.10+ has implemented a very expected feature, multiscreen mode. When you have more than one screen Autowall detects it and show you the option to run it in mutiscreen mode, this still in Beta due to the number of use cases, [open an issue if you see something strange or something to improved](https://github.com/SegoCode/AutoWall/issues/new). Currently multiscreen mode doesnt support many of the singlescreen mode features such as "Stop when Wallpaper is not visible" or "Web wallpaper" . . .

## Lives wallpapers for AutoWall 
<details>
    <summary>List of sites to find and download the perfect live wallpaper for use in AutoWall;</summary>
 
    https://mylivewallpapers.com/

    https://wallpaperwaifu.com/

    https://moewalls.com/

    http://openings.moe/

    https://www.shadertoy.com/

    https://livewallpapers4free.com/

    https://gfycat.com/gifs/search/live+wallpaper/

    https://steamcommunity.com/workshop/browse/?appid=431960

    https://www.deviantart.com/rainwallpaper/gallery/
 
</details>

## Download

[https://github.com/SegoCode/AutoWall/releases/](https://github.com/SegoCode/AutoWall/releases/download/1.10/AutoWall.zip)

## Articles about AutoWall

[https://www.ghacks.net/2020/10/19/autowall-is-an-open-source . . . ](https://www.ghacks.net/2020/10/19/autowall-is-an-open-source-program-that-can-display-animated-gifs-and-videos-as-your-wallpaper/)

[https://www.genbeta.com/deskmod/esta-aplicacion-gratuita . . . ](https://www.genbeta.com/deskmod/esta-aplicacion-gratuita-puedes-poner-gif-video-como-fondo-pantalla-windows-10)

##
<p align="center">
<a href="https://github.com/SegoCode/AutoWall/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=SegoCode/AutoWall" />
</a>



