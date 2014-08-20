platform :ios, '7.0'

# Add Application pods here

pod 'Mantle', '~> 1.5'
pod 'AFNetworking', '~> 2.0'
pod 'ViewUtils', '~> 1.1'

target :unit_tests, :exclusive => true do
  link_with 'UnitTests'
  pod 'Specta'
  pod 'Expecta'
  pod 'OCMock'
  pod 'OHHTTPStubs'
end
