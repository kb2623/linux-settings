# linux-settings

Nastavitve za linux programe.

# Installation

```bash
wget https://raw.githubusercontent.com/kb2623/linux-settings/master/configure
bash configure
make
```

# Git navodila

## Git global setup

```bash
git config --global user.name "user"
git config --global user.email "user@mail.com"
```

## Git user home dir

```bash
git init
git remote add origin https://github.com/kb2623/linux-settings.git 
git fetch
git submodule update --init --recursive
```

## Git ukaz za podmodule

### Inicializacija in prenos

```bash
git submodule update --init --recursive
```

### Prenos inicializiranih

```bash
git submodule update --recursive --remote
```

### Prenos master brancha

```bash
git submodule foreach git merge origin master
```

# Dodatne nastavitve

## Firefox

### How to disable WebRTC in Firefox?

In short: Set `media.peerconnection.enabled` to `false` in `about:config`.

* Explained:
 1. Enter `about:config` in the firefox address bar and press enter.
 2. Press the button "I'll be careful, I promise!"
 3. Search for `media.peerconnection.enabled`
 4. Double click the entry, the column `Value` should now be `false`
 5. Done. Do the WebRTC leak test again.
* If you want to make sure every single WebRTC related setting is really disabled change these settings:
 * `media.peerconnection.turn.disable = true`
 * `media.peerconnection.use_document_iceservers = false`
 * `media.peerconnection.video.enabled = false`
 * `media.peerconnection.identity.timeout = 1`

Now you can be 100% sure WebRTC is disabled.

### Privacy Related "about:config" Tweaks

* `privacy.firstparty.isolate = true` -> A result of the Tor Uplift effort, this preference isolates all browser identifier sources (e.g. cookies) to the first party domain, with the goal of preventing tracking across different domains. (Don't do this if you are using the Firefox Addon "Cookie AutoDelete" with Firefox v58 or below.)
* `privacy.resistFingerprinting = true` -> A result of the Tor Uplift effort, this preference makes Firefox more resistant to browser fingerprinting.
* `privacy.trackingprotection.fingerprinting.enabled = true` -> Blocks Fingerprinting
* `privacy.trackingprotection.cryptomining.enabled = true` -> Blocks CryptoMining
* `privacy.trackingprotection.enabled = true` -> This is Mozilla's new built-in tracking protection. It uses Disconnect.me filter list, which is redundant if you are already using uBlock Origin 3rd party filters, therefore you should set it to false if you are using the add-on functionalities.
* `browser.cache.offline.enable = false` -> Disables offline cache.
* `browser.safebrowsing.malware.enabled = false` -> Disable Google Safe Browsing malware checks. Security risk, but privacy improvement.
* `browser.safebrowsing.phishing.enabled = false` -> Disable Google Safe Browsing and phishing protection. Security risk, but privacy improvement.
* `browser.send_pings = false` -> The attribute would be useful for letting websites track visitors' clicks.
* `browser.sessionstore.max_tabs_undo = 0` -> Even with Firefox set to not remember history, your closed tabs are stored temporarily at Menu -> History -> Recently Closed Tabs.
* `browser.urlbar.speculativeConnect.enabled = false` -> Disable preloading of autocomplete URLs. Firefox preloads URLs that autocomplete when a user types into the address bar, which is a concern if URLs are suggested that the user does not want to connect to Source
* `dom.battery.enabled = false` -> The battery status of your device could be tracked.
* `dom.event.clipboardevents.enabled = false` -> Disable that websites can get notifications if you copy, paste, or cut something from a web page, and it lets them know which part of the page had been selected.
* `geo.enabled = false` -> Disables geolocation.
* `media.eme.enabled = false` -> Disables playback of DRM-controlled HTML5 content, which, if enabled, automatically downloads the Widevine Content Decryption Module provided by Google Inc. Details DRM-controlled content that requires the Adobe Flash or Microsoft Silverlight NPAPI plugins will still play, if installed and enabled in Firefox.
* `media.gmp-widevinecdm.enabled = false` -> Disables the Widevine Content Decryption Module provided by Google Inc., used for the playback of DRM-controlled HTML5 content. Details
* `media.navigator.enabled = false` -> Websites can track the microphone and camera status of your device.
* `network.cookie.cookieBehavior = 1` -> Disable cookies
  * 0 = Accept all cookies by default
  * 1 = Only accept from the originating site (block third-party cookies)
  * 2 = Block all cookies by default
* `network.cookie.lifetimePolicy = 2` -> cookies are deleted at the end of the session
  * 0 = Accept cookies normally
  * 1 = Prompt for each cookie
  * 2 = Accept for current session only
  * 3 = Accept for N days
* `network.http.referer.trimmingPolicy = 2` -> Send only the scheme, host, and port in the Referer header
  * 0 = Send the full URL in the Referer header
  * 1 = Send the URL without its query string in the Referer header
  * 2 = Send only the scheme, host, and port in the Referer header
* `network.http.referer.XOriginPolicy = 2` -> Only send Referer header when the full hostnames match. (Note: if you notice significant breakage, you might try 1 combined with an XOriginTrimmingPolicy tweak below.) Source
  * 0 = Send Referer in all cases
  * 1 = Send Referer to same eTLD sites
  * 2 = Send Referer only when the full hostnames match
* `network.http.referer.XOriginTrimmingPolicy = 2` -> When sending Referer across origins, only send scheme, host, and port in the Referer header of cross-origin requests. Source
  * 0 = Send full url in Referer
  * 1 = Send url without query string in Referer
  * 2 = Only send scheme, host, and port in Referer
* `webgl.disabled = true` -> WebGL is a potential security risk. Source
* `browser.sessionstore.privacy_level = 2` -> This preference controls when to store extra information about a session: contents of forms, scrollbar positions, cookies, and POST data. Details
  * 0 = Store extra session data for any site. (Default starting with Firefox 4.)
  * 1 = Store extra session data for unencrypted (non-HTTPS) sites only. (Default before Firefox 4.)
  * 2 = Never store extra session data.
* `extensions.pocket.enabled = false` -> Disables Pocket completely.
* `network.IDN_show_punycode = true` -> Not rendering IDNs as their Punycode equivalent leaves you open to phishing attacks that can be very difficult to notice. Source
`extensions.blocklist.url = https://blocklists.settings.services.mozilla.com/v1/blocklist/3/%20/%20/`. Limit the amount of identifiable information sent when requesting the Mozilla harmful extension blocklist. 

### userChrome.css

```css
@namespace url("http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul"); /* only needed once */

#TabsToolbar { height:25px!important; margin-top:-1px!important; margin-bottom:1px!important; }
#tabbrowser-tabs { height:25px!important; min-height:25px!important; }

.tab-background-start[selected=true]::after,
.tab-background-start[selected=true]::before,
.tab-background-start,
.tab-background-end,
.tab-background-end[selected=true]::after,
.tab-background-end[selected=true]::before {
  min-height:25px!important;
}

#VimFxMarkersContainer .marker {
  font-size: 15px !important; /* Specific font size. */
  text-transform: uppercase !important; 
}
```

# Accessing vncserver via SSH tunnels

For servers offering SSH connection, an advantage of this method is that it is not necessary to open any other port than the already opened SSH port to the outside, since the VNC traffic is tunneled through the SSH port.

## On the server

On the server side, `vncserver` or `x0vncserver` must be run.

When running either one of these, it is recommended to use the -localhost switch way since it allows connections from the localhost only and by analogy, only from users ssh'ed and authenticated on the box. For example run a command such as:

```
$ vncserver -localhost
```

or for x0vncserver:

```
$ x0vncserver -localhost -SecurityTypes none
```

## On the client

The VNC server has been setup on the remote machine to only accept local connections. Now, the client must open a secure shell with the remote machine (`10.1.10.2` in this example) and create a tunnel from the client port, for instance `9901`, to the remote server `5901` port.

```
$ ssh 10.1.10.2 -L 9901:localhost:5901
```

Once connected via SSH, leave this shell window open since it is acting as the secured tunnel with the server. Alternatively, directly run SSH in the background using the `-f` option. On the client side, to connect via this encrypted tunnel, point the `vncviewer` to the forwarded client port on the **localhost**.

```
$ vncviewer localhost:9901
```

What happens in practice is that the vncviewer connects locally to port 9901 which is tunneled to the server's localhost port 5901. The connection is established to the right port within the secure shell.

### Tip

It is possible, with a one-liner, to keep the port forwarding active during the connection and close it right after:

```
$ ssh -fL 9901:localhost:5901 10.1.10.2 sleep 10; vncviewer localhost:9901
```

What it does is that the `-f` switch will make `ssh` go in the background, it will still be alive executing `sleep 10`. `vncviewer` is then executed and ssh remains open in the background as long as `vncviewer` makes use of the tunnel. ssh will close once the tunnel is dropped which is the wanted behavior.

## Connecting to a vncserver from Android devices over SSH

To connect to a VNC server over SSH using an Android device as a client, consider having the following setup: 

* SSH running on the server
* `vncserver` running on server (with `-localhost` flag for security)
* SSH client on the Android device: **ConnectBot** is a popular choice and will be used in this guide as an example
* VNC client on the Android device: **androidVNC** used here

In **ConnectBot**, connect to the desired machine. Tap the options key, select Port Forwards and add a port:

```
Type: Local
Source port: 5901
Destination: 127.0.0.1:5901
```

In **androidVNC** connect to the VNC port, this is the local address following the SSH connection:

```
Password: the vncserver password
Address: 127.0.0.1
Port: 5901
```

# tmux cheatsheet

As configured in [my dotfiles](https://github.com/henrik/dotfiles/blob/master/tmux.conf).

start new:

```bash
tmux
```

start new with session name:

```bash
tmux new -s myname
```

attach:

```bash
tmux a  #  (or at, or attach)
```

attach to named:

```bash
tmux a -t myname
```

list sessions:

```bash
tmux ls
```

kill session:

```bash
tmux kill-session -t myname
```

In tmux, hit the prefix `ctrl+b` and then:

## Sessions

```text
:new<CR>  new session
s  list sessions
$  name session
```

## Windows (tabs)

```text
c           new window
,           name window
w           list windows
f           find window
&           kill window
.           move window - prompted for a new number
:movew<CR>  move window to the next unused number
```

## Panes (splits)

```text
|  horizontal split
-  vertical split

o  swap panes
q  show pane numbers
x  kill pane
⍽  space - toggle between layouts
```

## Window/pane surgery

```text
:joinp -s :2<CR>  move window 2 into a new pane in the current window
:joinp -t :1<CR>  move the current pane into a new pane in window 1
```

* [Move window to pane](http://unix.stackexchange.com/questions/14300/tmux-move-window-to-pane)
* [How to reorder windows](http://superuser.com/questions/343572/tmux-how-do-i-reorder-my-windows)

## Misc

```text
d  detach
t  big clock
?  list shortcuts
:  prompt
```

Resources:

* [cheat sheet](http://cheat.errtheblog.com/s/tmux/)

Notes:

* You can cmd+click URLs to open in iTerm.

TODO:

* Conf copy mode to use system clipboard. See PragProg book.

# SSL

## Create key

```bash
openssl genrsa -des3 -out [file.key] 2048
```

## Decript key

```bash
openssl rsa -in [file1.key] -out [file2.key]
```

## Create certificat

```bash
openssl req -x509 -new -nodes -key [file.key] -sha256 -days 1024  -out [file.pem]
```

# Kitty

## xterm-kitty: unknown terminal type

n order to copy over a terminfo file to your remote host’s `~/.terminfo` folder, run the following:

```
kitty +kitten ssh "your.remote.server"
```
