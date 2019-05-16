require 'fog/linode/paginated_collection'

module Fog
  module Linode
    class Compute
      # Collection class for loading Disk models from Linode instance disk data
      class Disks < Fog::Collection
        model Disk

        def all(linode_id, options = {})
          disks = service.list_disks(linode_id, options)
          load(disks.map { |disk| add_linode_id(linode_id, disk) })
        end

        def get(linode_id, disk_id)
          disk = service.view_disk(linode_id, disk_id)
          new add_linode_id(linode_id, disk)
        end

        private

        def add_linode_id(linode_id, disk)
          disk['linode_id'] = linode_id
          disk
        end
      end
    end
  end
end
