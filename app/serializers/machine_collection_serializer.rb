class MachineCollectionSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :title, :cached_tag_list, :slug
end
