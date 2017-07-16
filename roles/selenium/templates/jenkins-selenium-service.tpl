[Unit]
Description=Selenium Server

[Service]
Type=simple
User=jenkins
Group=jenkins
EnvironmentFile=-/etc/default/jenkins-selenium
EnvironmentFile=-/etc/sysconfig/jenkins-selenium
ExecStart=/usr/local/bin/jenkins-selenium
Restart=always
WorkingDirectory=/

[Install]
WantedBy=multi-user.target
