# Add some error handling in this to make it nicer when
# I go back to set this up later and forget everything about
# how it should work... or don't read this comment and 
# be mad at yourself.

$site = $facts['collins']['site']
$nodeclass = $facts['collins']['nodeclass']

# Nothing else works unless this is run in this repo unless
# you manage to not need any password management at all.
# include vault::consul_template
include vault::consul_template

# Now you can do everything you would expect
include base
include $site
include $nodeclass

Class[vault::consul_template] -> Class[base] -> Class[$site] -> Class[$nodeclass]
