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
  return [r, g, b]

# get_hour_rgb = (hour) =>
#   i = hour
#   h = (i % 24) / 24
#   s = v = 1
#   hsv_to_rgb(h, s, v)



# get_hour_rgb = (hour) =>
#   hour = hour % 24
#   if hour < 0
#     hour += 24
#
#   if 6 <= hour <= 18
#     v = 0.5 + (hour - 6) / 24
#     hsv_to_rgb((hour - 6) / 12, 1, )
#   else
#     if hour < 6
#       x = hour / 6
#     else
#       x = (24 - hour) / 6
#     hsv_to_rgb(
#       (hour - 18) / 12,
#       x,
#       Math.pow(x / 2, 1.5)
#     )


mid_point = (x, y, r) =>
  x * (1 - r) + y * r

get_mid_rgb = (rgb1, rgb2, r) =>
  rgb1[i] * (1 - r) + rgb2[i] * r for i in [0, 1, 2]

style_from_rgb = (rgb) =>
  f = Math.floor
  "rgb(#{f(255 * rgb[0])},#{f(255 * rgb[1])},#{f(255 * rgb[2])})"


get_hour_rgb = (hour) =>
  hour %= 24

  rgb = (ir, ig, ib) => [ir / 255, ig / 255, ib / 255]

  colors = [
    [0, rgb(32, 32, 32)],
    [3, rgb(44, 62, 80)],
    [7,rgb(52, 152, 219) ],
    [9, rgb(46, 204, 113)], # emerald
    [12, rgb(236, 240, 241)], # cloud
    [16, rgb(241, 196, 15)], # sun flower
    [18, rgb(231, 76, 60)], # alizarin
    # [21, rgb(22, 160, 133)], # green sea
  ]

  if hour < colors[0][0]
    hour += 24

  for i in [0...colors.length - 1]
    [prev_hour, prev_color] = colors[i]
    [next_hour, next_color] = colors[(i + 1) % colors.length]

    if prev_hour <= hour < next_hour
      r = (hour - prev_hour) / (next_hour - prev_hour)
      return get_mid_rgb(prev_color, next_color, r)

  [prev_hour, prev_color] = colors[colors.length - 1]
  [next_hour, next_color] = colors[0]
  next_hour += 24
  r = (hour - prev_hour) / (next_hour - prev_hour)
  return get_mid_rgb(prev_color, next_color, r)


_get_hour_rgb = (hour) =>
  rgb_hex1 = [
    [22, 21, 26], # くろ
    [54, 50, 142], # むらさき
    [149, 26, 107], # あかむらさき
    [84, 27, 134], # すみれいろ
    [1, 106, 184], # あお
    [15, 92, 170], # ぐんじょういろ
    [110, 185, 43], # きみどり
    [0, 155, 98], # みどり
    [0, 94, 102], # ふかみどり
    [99, 181, 217], # みずいろ
    [255, 255, 255], # しろ
    [124, 132, 135], # ねずみいろ
    [212, 212, 214], # ぎんいろ
  ]
  rgb_hex1.sort (a, b) =>
     (a[0] + a[1] + a[2]) - (b[0] + b[1] + b[2])

  rgb_hex2 = [
    [195, 153, 105], # きんいろ
    [255, 223, 1], # きいろ
    [249, 190, 0], # やまぶきいろ
    [208, 143, 8], # おうどいろ
    [236, 108, 165], # ももいろ
    [231, 0, 18], # あか
    [230, 53, 47], # しゅいろ
    [241, 130, 0], # だいだいいろ
    [248, 196, 132], # うすだいだい
    [129, 62, 46], # ちゃいろ
    [82, 60, 49], # こげちゃいろ
  ]

  rgb_hex2.sort (a, b) =>
    (b[0] + b[1] + b[2]) - (a[0] + a[1] + a[2])

  rgb_hex = rgb_hex1.concat(rgb_hex2)[hour % 24]

  [rgb_hex[0] / 255, rgb_hex[1] / 255, rgb_hex[2] / 255]

# [255, 255, 255], # しろ
# [255, 223, 1], # きいろ
# [249, 190, 0], # やまぶきいろ
# [208, 143, 8], # おうどいろ
# [110, 185, 43], # きみどり
# [0, 155, 98], # みどり
# [0, 94, 102], # ふかみどり
# [99, 181, 217], # みずいろ
# [1, 106, 184], # あお
# [15, 92, 170], # ぐんじょういろ
# [54, 50, 142], # むらさき
# [84, 27, 134], # すみれいろ
# [236, 108, 165], # ももいろ
# [149, 26, 107], # あかむらさき
# [231, 0, 18], # あか
# [230, 53, 47], # しゅいろ
# [241, 130, 0], # だいだいいろ
# [248, 196, 132], # うすだいだい
# [129, 62, 46], # ちゃいろ
# [82, 60, 49], # こげちゃいろ
# [22, 21, 26], # くろ
# [124, 132, 135], # ねずみいろ
# [212, 212, 214], # ぎんいろ
# [195, 153, 105], # きんいろ

_get_hour_rgb = (hour) =>
  i = hour
  h = (i % 24) / 24
  s = 0.8
  v = 0.8
  hsv_to_rgb(h, s, v)

jQuery ($) =>
  canvas = $('#clock').get(0)

  width = canvas.width = $(document).width()
  height = canvas.height = $(document).height()

  row_count = 6
  col_count = 8

  margin = height / (row_count + 1) / (row_count + 3)
  bheight = height / (row_count + 1)
  bwidth = (width - margin * (col_count + 3)) / col_count


  bg_hour = bg_minute = null
  bg_canvas = $("<canvas></canvas>")
    .attr({width: width, height: height})
    .get(0)

  redrawBgCanvas = () =>
    context = bg_canvas.getContext('2d')

    now = new Date
    hour = now.getHours()
    minute = now.getMinutes()
    now = new Date

    # context.fillStyle = style_from_rgb(get_mid_rgb(
    #   get_hour_rgb(hour),
    #   get_hour_rgb((hour + 1) % 24),
    #   minute / 60
    # ))
    [r, g, b] = get_mid_rgb(
      get_hour_rgb(hour),
      get_hour_rgb((hour + 1) % 24),
      minute / 60
    )
    v = (r + g + b) / 3
    r = v / 2 + r / 3
    g = v / 2 + g / 3
    b = v / 2 + b / 3

    context.fillStyle = style_from_rgb([r, g, b])

    context.fillRect(0, 0, width, height)

    for i in [0...24]
      if 0 <= i < col_count
        row = 0
        col = i
      else if col_count <= i < 12
        row = i - col_count + 1
        col = col_count - 1
      else if 12 <= i < 12 + col_count
        row = row_count - 1
        col = (col_count - 1) - (i - 12)
      else
        row = 24 - i
        col = 0

      context.fillStyle = style_from_rgb(get_hour_rgb(i % 24))
      context.fillRect(
        col * bwidth + (col + 2) * margin,
        row * bheight + (row + 2) * margin,
        bwidth,
        bheight,
      )


  drawClock = () =>
    context = canvas.getContext('2d')

    now = new Date
    hour = now.getHours()
    minute = now.getMinutes()
    seconds = now.getSeconds() + now.getMilliseconds() / 1000

    if [hour, minute] != [bg_hour, bg_minute]
      [bg_hour, bg_minute] = [hour, minute]
      redrawBgCanvas()

    context.drawImage(bg_canvas, 0, 0)

    curr = seconds / 2.5
    prev = Math.floor(curr)
    next = Math.ceil(curr)
    context.fillStyle = style_from_rgb(get_mid_rgb(
      get_hour_rgb(prev),
      get_hour_rgb(next),
      curr - prev,
    ))

    s = (seconds % 30) / 2.5
    if 0 <= s <= 1
      dx = 0
      dy = 0
    else if 1 <= s <= 6
      dx = (s - 1) / 5
      dy = 0
    else if 6 <= s <= 8
      dx = 1
      dy = 0
    else if 8 <= s <= 11
      dx = 1
      dy = (s - 8) / 3
    else
      dx = dy = 1
    if seconds > 30
      dx = 1 - dx
      dy = 1 - dy

    x = margin * 2 + (bwidth + margin) * mid_point(1, col_count - 2, dx)
    y = margin * 2 + (bheight + margin) * mid_point(1, row_count - 2, dy)

    # context.strokeStyle = style_from_rgb(get_mid_rgb(
    #   get_hour_rgb((hour + 12) % 24),
    #   get_hour_rgb((hour + 13) % 24),
    #   minute / 60
    # ))
    # context.lineWidth = 4
    # context.strokeRect(x, y, bwidth, bheight)
    context.fillRect(x, y, bwidth, bheight)

  setInterval(drawClock, 50)
