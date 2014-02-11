name              "haproxy"
maintainer        "Quagilis Andreas Simon"
maintainer_email  "a.simon(at)quagilis(DOT)de"
license           "Apache 2.0"
description       "Installs and configures haproxy"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.1.0"

recipe "haproxy", "Installs and configures haproxy for use as reverse proxy in blue/green deployment"

%w{ debian ubuntu centos redhat}.each do |os|
  supports os
end

depends           "haproxy"
