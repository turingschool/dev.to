class MachineCollectionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :tag_list
end
