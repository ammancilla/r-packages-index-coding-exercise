class PackagesIndexWorker
  include Sidekiq::Worker

  def perform
    CranServer.new.package_list.each_with_index do |package, i|
      name = package['Package']
      version = package['Version']

      next if name.blank? || version.blank?

      PackageRegisterWorker.perform_async(name, version)
    end
  end
end
