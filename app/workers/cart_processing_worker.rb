class CartProcessingWorker
  include Sidekiq::Worker
  def perform(id)
    Cart.find(id).finish
  end
end