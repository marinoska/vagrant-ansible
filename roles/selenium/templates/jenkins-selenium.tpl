#!/bin/bash

DISPLAY=":1" xvfb-run java -Dwebdriver.chrome.driver=/var/selenium/chromedriver -jar /var/selenium/selenium-server-standalone.jar -Djava.security.egd=file:///dev/urandom
