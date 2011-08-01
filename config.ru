require File.dirname(__FILE__) + '/config/boot.rb'

run Rack::URLMap.new({
  "/"    => CCS::Version1,
  "/version1" => CCS::Version1,
  "/version2" => CCS::Version2
})
