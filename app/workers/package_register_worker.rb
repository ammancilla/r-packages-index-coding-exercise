class PackageRegisterWorker
  include Sidekiq::Worker

  sidekiq_options unique: :until_and_while_executing

  def perform(name, version)
    package_file = CranServer.fetch_package_file(name, version)

    return if package_file.blank?

    package_info = CranServer::Package.new(package_file).description

    Package.register(package_info)
  end
end
