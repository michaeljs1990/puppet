# Add some error handling in this to make it nicer when
# I go back to set this up later and forget everything about
# how it should work... or don't read this comment and 
# be mad at yourself.

$site = $facts['collins']['site']
$nodeclass = $facts['collins']['nodeclass']

include base
include $site
include $nodeclass

Class[base] -> Class[$site] -> Class[$nodeclass]
