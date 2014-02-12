circle = (context, x, y, radius) =>
  context.arc(x, y, radius, 0, 2*Math.PI, false)

hsv_to_rgb = (h, s, v) =>
  h = h % 1
  if h < 0
    h += 1
  i = Math.floor h * 6
  f = h * 6 - i;
  p = v * (1 - s);
  q = v * (1 - f * s);
  t = v * (1 - (1 - f) * s);
  switch i % 6
    when 0 then r = v; g = t; b = p
    when 1 then r = q; g = v; b = p
    when 2 then r = p; g = v; b = t
    when 3 then r = p; g = q; b = v
    when 4 then r = t; g = p; b = v
    when 5 then r = v; g = p; b = q
  return [Math.floor(r * 255), Math.floor(g * 255), Math.floor(b * 255)]

get_hour_rgb = (hour) =>
  i = hour

  h = (i % 12) / 12
  s = v = 1
  hsv_to_rgb(h, s, v)

get_hour_rgb = (hour) =>
  hour = hour % 24
  if hour < 0
    hour += 24
  if 6 <= hour <= 18
    hsv_to_rgb((18 - hour) / 12, 1, 1)
  else
    if hour < 6
      x = hour / 6
    else
      x = (24 - hour) / 6
    hsv_to_rgb(
      (6 - hour) / 12,
      x,
      x / 2
    )



get_mid_rgb = (rgb1, rgb2, r) =>
  Math.floor(rgb1[i] * (1 - r) + rgb2[i] * r) for i in [0, 1, 2]

style_from_rgb = (rgb) =>
  "rgb(#{rgb[0]},#{rgb[1]},#{rgb[2]})"

jQuery ($) =>
  drawClock = () =>
    canvas = $('#clock').get(0)
    width = canvas.width = $(document).width()
    height = canvas.height = $(document).height()
    size = Math.min(width, height)
    R = size * 0.4
    radius = R * Math.sin(Math.PI / 24)

    context = canvas.getContext('2d')

    now = new Date
    hour = now.getHours()
    minute = now.getMinutes()
    seconds = now.getSeconds() #+ now.getMilliseconds() / 1000

    get_background_style = () =>
      style_from_rgb(get_mid_rgb(
        get_hour_rgb(hour),
        get_hour_rgb((hour + 1) % 24),
        minute / 60
      ))

    get_center_style = () =>
      curr = seconds / 2.5
      prev = Math.floor(curr)
      next = Math.ceil(curr)

      style_from_rgb(get_mid_rgb(
        get_hour_rgb(prev),
        get_hour_rgb(next),
        curr - prev,
      ))

    # Flood background
    context.fillStyle = get_background_style()
    context.fillRect(0, 0, width, height)

    # Flood center Large circle
    context.fillStyle = get_center_style()
    context.beginPath()
    circle(context, width / 2, height / 2, R)
    context.fill()

    # Draw small circles
    for i in [0...24]
      rgb = get_hour_rgb(i % 24)
      angle = Math.PI * i / 12

      context.fillStyle = "rgb(#{rgb[0]}, #{rgb[1]}, #{rgb[2]})"

      context.save()
      context.translate(width / 2, height / 2)
      context.rotate(angle)
      context.translate(0, -R)
      context.beginPath()
      circle(context, 0, 0, radius)
      context.fill()
      context.restore()

  setInterval(drawClock, 250)
