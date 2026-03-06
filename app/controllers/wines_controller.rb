class WinesController < ApplicationController
  def show
    @wine = Wine.find(params[:id])
  end
  def destroy
    @wine = Wine.find(params[:id])
    @wine.destroy
    redirect_to wines_path, status: :see_other
  end

  def index
    @wines = current_user.wines
    @available_categories = current_user.wines.pluck(:categories).flatten.uniq.sort
    prices = current_user.wines.pluck(:price_range).compact.filter_map { |pr| (m = pr.match(/(\d+)/)) && m[1].to_i }
    @price_min = prices.any? ? (prices.min / 5) * 5 : 0
    @price_max = prices.any? ? ((prices.max / 5.0).ceil * 5) : 150
    @price_max = [@price_max, @price_min + 10].max
    @wines = @wines.where(color: params[:color]) if params[:color].present?
    @wines = @wines.where("? = ANY(categories)", params[:category]) if params[:category].present?
    if params[:min_price].present? || params[:max_price].present?
      min = params[:min_price].to_i
      max = params[:max_price].present? ? params[:max_price].to_i : 150
      @wines = @wines.to_a.select do |wine|
        next true if wine.price_range.blank?
        match = wine.price_range.match(/(\d+)/)
        next false unless match
        price = match[1].to_i
        price >= min && price <= max
      end
    end
  end
end
