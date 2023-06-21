# @summary A demo class that requires two Boolean params
#
# Tests whether a passed parameter is Boolean
#
# @example
#   include truthcon::booleans
#
# @param condition1 Whether condition1 is met
# @param condition2 Whether condition2 is met
class truthcon::booleans (
  Boolean $condition1 = false,
  Boolean $condition2 = false,
) {
  if $condition1 {
    notify { 'boolean good 1':
      message => "condition1 is ${condition1}.",
    }
  } else {
    notify { 'bad 1': }
  }

  if $condition2 {
    notify { 'boolean good 2':
      message => "condition2 is ${condition2}",
    }
  } else {
    notify { 'bad 2': }
  }
}
