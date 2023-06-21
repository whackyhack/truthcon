# @summary Demonstrates cases when Puppet Boolean conversion
#
# Performs a first task if $metext matches $merex1.
# Performs a second task if $metext matches either $merex1 or $merex2.
#
# @example
#   include truthcon
#
# @param metext any string
# @param merex1 a regex to test metext
# @param merex2 another regex to test metext
#
class truthcon (
  String $metext = 'test is good. more testing is better.',
  Regexp $merex1 = /^$/,
  Regexp $merex2 = /^$/,
) {
  $action1 = $metext.match($merex1)
  $action2 = $action1 or $metext.match($merex2)

  # These are sanity tests, not real actions
  if $action1 {
    notify { 'condition 1':
      message => "${metext} matches ${merex1}! (${metext.match($merex2)})",
    }
  } else {
    notify { 'no go 1': }
  }

  if $action2 {
    notify { 'condition 2':
      message => "${metext} matches either ${merex1} or ${merex2}. (${action2})",
    }
  } else {
    notify { 'no go 2': }
  }

  # Real action begins
  Class { 'truthcon::booleans':
    condition1 => $action1,
    condition2 => $action2,
  }
}
