module DistanceCalculator
  extend ActiveSupport::Concern
  def self.distance(lat1, lng1, lat2, lng2)
    # convert to radian
    x1 = lat1.to_f * Math::PI / 180
    y1 = lng1.to_f * Math::PI / 180
    x2 = lat2.to_f * Math::PI / 180
    y2 = lng2.to_f * Math::PI / 180

    # earth radius (km)
    radius = 6378.137

    # absolute difference
    diff_y = (y1 - y2).abs

    calc1 = Math.cos(x2) * Math.sin(diff_y)
    calc2 = Math.cos(x1) * Math.sin(x2) - Math.sin(x1) * Math.cos(x2) * Math.cos(diff_y)

    numerator = Math.sqrt(calc1 ** 2 + calc2 ** 2)
    denominator = Math.sin(x1) * Math.sin(x2) + Math.cos(x1) * Math.cos(x2) * Math.cos(diff_y)

    # arc
    degree = Math.atan2(numerator, denominator)

    # great-cricular distance (km)
    (degree * radius).round(2)
  end
end
