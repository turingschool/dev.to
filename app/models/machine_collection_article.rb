class MachineCollectionArticle < ApplicationRecord
  belongs_to :article
  belongs_to :machine_collection
end
