class base {

  # likely want DNS setup before we let everything else go to town
  # or we will end up masking the issue with multiple puppet runs anyways.
  require resolv

  include utils

}
