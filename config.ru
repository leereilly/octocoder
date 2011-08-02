require File.dirname(__FILE__) + '/config/boot.rb'

run Rack::URLMap.new({
  "/"    => CCS::V1,
  "/v1" => CCS::V1,
  "/v2" => CCS::V2
})
