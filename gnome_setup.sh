

# Make sure maximize and minimize options are availble for windows! c'mon!
gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"

# Filesystem become amnesiac
gsettings set org.gnome.desktop.privacy remember-recent-files false

# I prefer a clean desktop, no icons
gsettings set org.gnome.desktop.background show-desktop-icons false

# Show the day of the week 
gsettings set org.gnome.desktop.calendar show-weekdate false

# Use 24-hour style clock
gsettings set org.gnome.desktop.interface clock-format '24h'

# more privacy settings
gsettings set org.gnome.desktop.privacy remember-recent-files false
gsettings set org.gnome.desktop.privacy remove-old-temp-files true
gsettings set org.gnome.desktop.privacy remove-old-trash-files true
gsettings set org.gnome.desktop.privacy hide-identity true
gsettings set org.gnome.desktop.privacy remember-app-usage false
gsettings set org.gnome.desktop.privacy send-software-usage-stats false

# Idle to lockscreen in 8 minutes
gsettings set org.gnome.desktop.lockdown disable-lock-screen false
gsettings set org.gnome.desktop.session idle-delay 480

# Make sure to check with me before closing term, so no accidents
gsettings set org.gnome.Terminal.Legacy.Settings confirm-close true

# STFU with the feedback noises on applications
gsettings set org.gnome.desktop.sound input-feedback-sounds false

# Lockscreen settings
gsettings set org.gnome.login-screen enable-fingerprint-authentication false
gsettings set org.gnome.login-screen enable-smartcard-authentication true

# Nautilus settings
gsettings set org.gnome.nautilus.preferences show-delete-permanently false
gsettings set org.gnome.nautilus.preferences show-hidden-files true
gsettings set org.gnome.nautilus.preferences show-image-thumbnails 'local-only'


# Terminal keybindings
gsettings set org.gnome.Terminal.Legacy.Keybindings close-tab '<Control><Shift>w'
gsettings set org.gnome.Terminal.Legacy.Keybindings close-window '<Control><Shift>q'
gsettings set org.gnome.Terminal.Legacy.Keybindings copy '<Control><Shift>c'
gsettings set org.gnome.Terminal.Legacy.Keybindings copy-html 'disabled'
gsettings set org.gnome.Terminal.Legacy.Keybindings detach-tab 'disabled'
gsettings set org.gnome.Terminal.Legacy.Keybindings export 'disabled'
gsettings set org.gnome.Terminal.Legacy.Keybindings find '<Control><Shift>F'
gsettings set org.gnome.Terminal.Legacy.Keybindings find-clear '<Control><Shift>J'
gsettings set org.gnome.Terminal.Legacy.Keybindings find-next '<Control><Shift>G'
gsettings set org.gnome.Terminal.Legacy.Keybindings find-previous '<Control><Shift>H'
gsettings set org.gnome.Terminal.Legacy.Keybindings full-screen 'F11'
gsettings set org.gnome.Terminal.Legacy.Keybindings header-menu 'disabled'
gsettings set org.gnome.Terminal.Legacy.Keybindings help 'disabled'
gsettings set org.gnome.Terminal.Legacy.Keybindings move-tab-left '<Control><Shift>Page_Up'
gsettings set org.gnome.Terminal.Legacy.Keybindings move-tab-right '<Control><Shift>Page_Down'
gsettings set org.gnome.Terminal.Legacy.Keybindings new-tab '<Control><Shift>t'
gsettings set org.gnome.Terminal.Legacy.Keybindings new-window '<Control><Shift>n'
gsettings set org.gnome.Terminal.Legacy.Keybindings next-tab '<Control>Page_Down'
gsettings set org.gnome.Terminal.Legacy.Keybindings paste '<Control>v'

# PGP settings
#gsettings set org.gnome.crypto.pgp ascii-armor true
#gsettings set org.gnome.crypto.pgp encrypt-to-self true
#gsettings set org.gnome.crypto.pgp keyservers ['ldap://keyserver.pgp.com', 'hkps://keys.openpgp.org', 'hkps://pgp.mit.edu']
#gsettings set org.gnome.crypto.pgp sort-recipients-by 'name'

# Optional output of all yoru current gnome settings
#gsettings list-recursively
