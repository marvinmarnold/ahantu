class CartProcessingWorker
  include Sidekiq::Worker
  def perform(id)
    Cart.find(id)
  end
end