require File.dirname(__FILE__) + '/config/boot.rb'

run Rack::URLMap.new({
  "/"    => CCS::V1,
  "/version1" => CCS::V1,
  "/version2" => CCS::V2
})
