# Resolv

resolv properly sets the dns server that should be used for the resolv.conf
file on your system. It will also do some sanity checks to make sure that this
file is not a symlink which would cause any change to be removed on reboot.
