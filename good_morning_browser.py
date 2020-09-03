# For booting up the sites you need to work with first thing in the moorning (after coffee, of course)
# Idea shamelessly copied from https://dev.to/dmahely/one-bash-command-to-start-the-day-2fni

import webbrowser

websites = [
            '<https://office.com>>',
            '<https://portal.azure.com>',
            '<https://cloud.digitalocean.com>',
            '<https://github.com>',
            '<https://id.atlassian.com>',
            '<https://reddit.com/r/sysadmin>',
            '<https://news.ycombinator.com>',
            '<https://lobste.rs/>'
            ]

for website in websites:
    webbrowser.open_new(website)
