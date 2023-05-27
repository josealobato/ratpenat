
task :default do
  puts "Run `rake -T` to learn about the available actions."
end

desc "Generate mocks. Needs `brew install sourcery`."
task :mocks do
  # $ ./bin/sourcery --sources <sources path> --templates <templates path> --output <output path>
  command = <<-eos
    sourcery \
      --sources ./Ratpenat/Packages/QueueManagementService/Sources \
      --sources ./Ratpenat/Packages/RData/Sources \
      --templates ./Ratpenat/Templates/AutoMockable.stencil \
      --args testimports="@testable import QueueManagementService; import Entities; import RData;" \
      --output ./Ratpenat/Packages/QueueManagementService/Tests/QueueManagementServiceTests/Generated/AutoMockable.generated.swift
    eos
    system(command)
end

desc "Run Unit Test on packages (WIP)."
task :ut do
  packages = ["QueueManagementService", "QueueManagementService"]
  packages.each do |package|
    puts package
    command = <<-eos
    set -oe pipefail && xcodebuild test -workspace #{package} -scheme $$scheme  -configuration Debug -destination $(destination) | xcpretty ; 
    xcodebuild test -scheme #{package} -sdk iphonesimulator15.0 -destination "OS=15.0,name=iPhone 13 Mini"
    eos
    system(command)
  end
end

