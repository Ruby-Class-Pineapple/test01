module GameMain
  
  @dec_logo = Image.load("Image_home/dec_logo.png")  # 終了ボタン
  @back_blue = Image.new(1920, 500, [151, 170, 212]) # 背景
  @dec_bar = Image.load("Image_game/dec_bar.png") # バー
  @button_end = Image.load("Image_menu/button_end.png") # 終了ボタン

  # 開始前
  @start_flg = false
  @load_hide = false
  @load_frame = 0 # frameを
  @load_font1 = Font.new(70) # 書式設定
  @load_font2 = Font.new(30) # 書式設定

  # 開始カウントダウン 
  @count = 4
  @start_time = 0
  @start_font = Font.new(100) # 書式設定
  @start_count = false # カウントダウン実行フラグ
  @timer_flg = false # ゲームスタートフラグ

  # タイムバー
  @time = 61 # タイマー用
  @time_font = Font.new(25) # 書式設定
  @time_bars = (1..10).map { |i| Image.load("Image_game/time_bar_#{i}.png") }
  @timer_started = false # カウントダウン開始フラグ

  # ダミーキーボード
  @back_key = Image.new(1920, 500, [220, 220, 220]) # キーボード背景
  @dec_key_right = Image.load("Image_game/dec_key_right.png")
  @dec_key_left = Image.load("Image_game/dec_key_left.png")

  # キーボードの座標を設定
  @key_xy = {
  'a' => [210, 830],   'b' => [870, 940],  'c' => [580, 940],  'd' => [500, 830],
  'e' => [440, 720],   'f' => [645, 830],  'g' => [790, 830],  'h' => [935, 830],
  'i' => [1165, 720],   'j' => [1080, 830],  'k' => [1225, 830], 'l' => [1370, 830],
  'm' => [1160, 940],  'n' => [1015, 940], 'o' => [1310, 720], 'p' => [1455, 720],
  'q' => [150, 720],  'r' => [585, 720], 's' => [355, 830], 't' => [730, 720],
  'u' => [1020, 720],  'v' => [725, 940], 'w' => [295, 720], 'x' => [435, 940],
  'y' => [875, 720],  'z' => [290, 940],  'ent' => [1715,720]
  }

  # a ~ zの画像ファイル読み込み
  @key_data = ('a'..'z').map.with_index do |char|{ 
    image_up: Image.load("Image_game/key_#{char}_1.png"),
    image_down_suc: Image.load("Image_game/key_#{char}_2.png"),
    image_down_err: Image.load("Image_game/key_#{char}_3.png"),
    xy: @key_xy[char] # @key_xy から座標を取得
  }
  end

  # enterキーの画像ファイルを読み込み
  @kye_enter = {
    image_up: Image.load("Image_game/key_ent_1.png"),
    image_down_suc: Image.load("Image_game/key_ent_2.png"),
    image_down_err: Image.load("Image_game/key_ent_3.png"),
    xy: @key_xy['ent'] # @key_xy から座標を取得
  }

  module_function

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

  # タイムバー
  def time_bar

    # カウントダウン開始
    unless @timer_started && @timer_flg
      @first_time = Time.now
      @timer_started = true
    end

    Window.draw_font(30, 105, "< 田中文雄", @time_font,color:[255,255,255])
    Window.draw_font(1200, 105, "残り時間", @time_font,color:[255,255,255])

    # 経過時間を計算
    elapsed_time = Time.now - @first_time

    # 現在の表示すべき画像のインデックスを計算
    current_index = [(elapsed_time / (@time / 10)).floor, 9].min

    # 画像の描画
    Window.draw(1330, 105, @time_bars[current_index])

    # 残り時間表示
    if @timer_flg
      Window.draw_font(1830, 105, "#{(@time - elapsed_time).floor} 秒", @time_font, color:[255,255,255])
    else 
      Window.draw_font(1830, 105, "60 秒", @time_font, color:[255,255,255])
    end

    # 経過時間が@timeを超えたらループを終了
    if elapsed_time >= @time
      $scene = 4
    end

  end

  # 開始前画面
  def load

    @load_frame += 1

    Window.draw_font(700, 320, "おじさんから新着メッセージが届いているヨ！", @load_font2, color:[255,255,255])

    if @load_frame % 45 == 0
      @load_hide = !@load_hide
    end

    if @load_hide
      Window.draw_font(650, 370, "Enter を押してスタート", @load_font1, color:[255,255,255])
    end

    if Input.key_push?(K_RETURN)
      @start_flg = true
    end

  end

  # 開始カウントダウン
  def start

    # カウントダウン開始
    unless @start_count
      @start_time = Time.now
      @start_count = true
    end

    # 経過時間を計算
    elapsed_time = Time.now - @start_time

    # 経過時間が@timeを超えたらループを終了
    if elapsed_time >= @count
      @timer_flg = true
    else

      # カウントダウンを表示
      if (@count - elapsed_time).floor == 0
        Window.draw_font(750, 340, "START !", @start_font,color:[255,255,255])
      else
        Window.draw_font(900, 340, "#{(@count - elapsed_time).floor} ", @start_font,color:[255,255,255])
      end
    end

  end


  # キーボード実装
  def kye_board

    # ダミーキーボード
    Window.draw(0, 590, @back_key)
    Window.draw(20, 610, @dec_key_left)
    Window.draw(1515, 610, @dec_key_right)

    # a ~ zのキーの動作
    ('a'..'z').each_with_index do |char, index|
      key_info = @key_data[index]
      if Input.key_down?(eval("K_#{char.upcase}"))
        Window.draw(key_info[:xy][0], key_info[:xy][1], key_info[:image_down_suc])
      else
        Window.draw(key_info[:xy][0], key_info[:xy][1], key_info[:image_up])
      end
    end

    # enterキーの動作
    key_info = @kye_enter
    if Input.key_down?(eval("K_RETURN"))
      Window.draw(key_info[:xy][0], key_info[:xy][1], key_info[:image_down_suc])
    else
      Window.draw(key_info[:xy][0], key_info[:xy][1], key_info[:image_up])
    end


  end

  def exec

    Window.draw(0, 90, @back_blue)

    # 終了ボタン
    Window.draw(1725, 3, @button_end)
    button(1725,3)

    Window.draw_scale(-180, -5, @dec_logo,0.4,0.4)
    Window.draw(-12,65,@dec_bar)

    # 開始前画面
    unless @start_flg
      load()
    end

    # 開始前カウントダウン
    unless @timer_flg || !@start_flg
      start()
    end

    time_bar() # タイムバーの実行

    kye_board() # キーボードの処理

    # スペースキーで結果画面に遷移
    if Input.key_push?(K_SPACE)
      $scene = 4
    end

  end

end