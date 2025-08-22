#!/bin/bash
#---
# Excerpted from "Hotwire Native for Rails Developers",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/jmnative for more book information.
#---

# Gain root access
adb root

# Remove internet icon
adb shell settings put global airplane_mode_on 1

# Disable automatic time updates
adb shell settings put global auto_time 0

# Set time to 9:41
adb shell date 092109412024.00
