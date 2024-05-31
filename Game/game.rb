module GameMain

  @time = 60 # タイマー用
  
  @key_maker = Image.load("Image_game/key_marker.png") # テスト用
  @dec_logo = Image.load("Image_home/dec_logo.png")  # 終了ボタン
  @back_blue = Image.new(1920, 500, [151, 170, 212]) # 背景
  @dec_bar = Image.load("Image_game/dec_bar.png") # バー
  @button_end = Image.load("Image_menu/button_end.png") # 終了ボタン

  # タイムバー
  @time_font = Font.new(25) # 書式設定
  @time_bars = (1..10).map { |i| Image.load("Image_game/time_bar_#{i}.png") }
  @timer_started = false # カウントダウン開始フラグ

  # キーボード座標設定
  @key_xy = {}

  # a ~ zの画像ファイル読み込み
  @key_data = ('a'..'z').map.with_index do |char, index|{ 
    image_up: Image.load("Image_game/key_#{char}_1.png"),
    image_down_suc: Image.load("Image_game/key_#{char}_2.png"),
    image_down_err: Image.load("Image_game/key_#{char}_3.png"),
    xy = @key_xy[index] # @key_xy から座標を取得
  }
  end

  module_function

  # タイムバー
  def time_bar

    # カウントダウン開始
    unless @timer_started
      @start_time = Time.now
      @timer_started = true
    end

    Window.draw_font(30, 105, "< 田中文雄", @time_font,color:[255,255,255])
    Window.draw_font(1200, 105, "残り時間", @time_font,color:[255,255,255])

    # 経過時間を計算
    elapsed_time = Time.now - @start_time

    # 現在の表示すべき画像のインデックスを計算
    current_index = [(elapsed_time / (@time / 10)).floor, 9].min

    # 画像の描画
    Window.draw(1330, 105, @time_bars[current_index])

    # 残り時間表示
    Window.draw_font(1830, 105, "#{(@time - elapsed_time).floor} 秒", @time_font,color:[255,255,255])

    # 経過時間が@timeを超えたらループを終了
    if elapsed_time >= @time
      $scene = 4
    end

  end

  # ボタン実装
  def button(button_x,button_y)

    # 終了ボタンの座標とサイズ
    button_width = @button_end.width
    button_height = @button_end.height

    # マウスの位置を取得
    mouse_x = Input.mouse_pos_x
    mouse_y = Input.mouse_pos_y

    # ボタンの上にカーソルがあるとき
    if mouse_x >= button_x && mouse_x <= button_x + button_width &&
      mouse_y >= button_y && mouse_y <= button_y + button_height

      Input.set_cursor(IDC_HAND) # マウスカーソルを手の形状に変更

      # マウスクリックの検出
      if Input.mouse_push?(M_LBUTTON)
        $scene = 1
      end

    else
      Input.set_cursor(IDC_ARROW) # デフォルトのマウスカーソルを使用
    end

  end

  # キーボード実装
  def kye_board

    # テスト用目印
    Window.draw(22, 610, @key_maker)

    ('a'..'z').each_with_index do |char, index|
      key_info = @key_data[index]
      if Input.key_down?(eval("K_#{char.upcase}"))
        Window.draw(key_info[:x], key_info[:y], key_info[:image_down_suc])
      else
        Window.draw(key_info[:x], key_info[:y], key_info[:image_up])
      end
    end

  end

  def exec

    Window.draw(0, 90, @back_blue)

    # 終了ボタン
    Window.draw(1725, 3, @button_end)
    button(1725,3)

    Window.draw_scale(-180, -5, @dec_logo,0.4,0.4)
    Window.draw(-12,65,@dec_bar)

    time_bar() # タイムバーの実行

    kye_board() # キーボードの処理

    # スペースキーで結果画面に遷移
    if Input.key_push?(K_SPACE)
      $scene = 4
    end

  end

end