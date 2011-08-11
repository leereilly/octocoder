require File.dirname(__FILE__) + '/config/boot.rb'

run Rack::URLMap.new({
  "/"    => CCS::V2,
  "/v1" => CCS::V1,
  "/v2" => CCS::V2,
  "/v3" => CCS::V3
})
