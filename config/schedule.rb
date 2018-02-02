every 1.day, at: '12:00 pm' do
  runner "PackagesIndexWorker.new.perform"
end
