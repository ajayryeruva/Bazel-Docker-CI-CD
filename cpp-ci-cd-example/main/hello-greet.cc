#include "main/hello-greet.h"
#include <string>

/* printing Hello */

std::string get_greet(const std::string& who) {
  return "Hello " + who;
}
