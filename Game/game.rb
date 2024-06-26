module GameMain
  
  @dec_logo = Image.load("Image_home/dec_logo.png")  # 終了ボタン
  @back_blue = Image.new(1920, 500, [151, 170, 212]) # 背景
  @dec_bar = Image.load("Image_game/dec_bar.png") # バー
  @button_gameend = Image.load("Image_menu/button_end.png") # 終了ボタン

  @part = 1 # ゲーム内シーン

  # 開始前
  @start_flg = false
  @load_hide = false
  @load_frame = 0 # frameを
  @load_font1 = Font.new(80,'Yu Gothic',weight:true) # 書式設定
  @load_font2 = Font.new(30,'Yu Gothic',weight:true) # 書式設定

  # 開始カウントダウン 
  @count = 4
  @count_first_time = 0
  @start_font = Font.new(150,'Yu Gothic',weight:true) # 書式設定
  @count_started = false # カウントダウン実行フラグ
  @timer_flg = false # ゲームスタートフラグ

  # タイムバー
  @first_time = 0
  @time = 61 # タイマー用
  @time_font = Font.new(30,'Yu Gothic',weight:true) # 書式設定
  @time_bars = (1..10).map { |i| Image.load("Image_game/time_bar_#{i}.png") }
  @timer_started = false # カウントダウン開始フラグ

  # テキストファイルの読み込み
  @content = CSV.read("Type-sample/sample#{$type_oji}.csv")
  @content2 = CSV.read("Type-sample/sample2.csv")
  @content_num = 0

  # ゲーム画面
  @dec_icon_ojis = (1..3).map { |i| Image.load("Image_game/dec_icon_oji#{i}.png") }
  @dec_message_box = Image.load("Image_game/dec_message_box.png")
  @prob_font0 = Font.new(35,'Consolas')
  @prob_font1 = Font.new(45,'Yu Gothic',weight:true)
  @prob_font2 = Font.new(20)
  @prob_font3 = Font.new(18)

  #文字入力認識
  @kye_index_1 = 0
  @kye_index_2 = 0
  @sum_index = 0
  @kye_bool = true
  @target_key = eval("K_RETURN")
  @bef_key_1 = eval("K_RETURN")
  @bef_key_2 = eval("K_RETURN")
  @bef_key_3 = eval("K_RETURN")
  @key_pressed = false

  # キーボードの座標を設定
  @key_xy = {
  'a' => 0,   'b' => 0,  'c' => 0,  'd' => 0,
  'e' => 0,   'f' => 0,  'g' => 0,  'h' => 0,
  'i' => 0,   'j' => 0,  'k' => 0, 'l' => 0,
  'm' => 0,  'n' => 0, 'o' => 0, 'p' => 0,
  'q' => 0,  'r' => [585, 720], 's' => [355, 830], 't' => [730, 720],
  'u' => [1020, 720],  'v' => [725, 940], 'w' => [295, 720], 'x' => [435, 940],
  'y' => [875, 720],  'z' => [290, 940],  'ent' => [1715,720]
  }

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

  # リセット処理
  def reset
    @count_started = false
    @timer_started = false
    @content_num = 0
    @timer_flg = false
    @part = 1
  end

  # タイムバー
  def time_bar

    # カウントダウン開始
    unless @timer_started && @timer_flg
      @first_time = Time.now
      @timer_started = true
    end

    # 選択別表示
    case $type_oji
    when 1 then
      Window.draw_font(30, 105, "< 田中文雄", @time_font,color:[255,255,255])
    when 2 then
      Window.draw_font(30, 105, "< 佐藤信之", @time_font,color:[255,255,255])
    when 3 then
      Window.draw_font(30, 105, "< 山下克之", @time_font,color:[255,255,255])
    end

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
      reset() # リセット
      $scene = 4
    end

  end

  # 開始前画面
  def load

    @load_frame += 1

    Window.draw_font(700, 305, "おじさんから新着メッセージが届いているヨ！", @load_font2, color:[255,255,255])

    # 点滅表示用
    if @load_frame % 45 == 0
      @load_hide = !@load_hide
      @load_frame = 0
    end

    if @load_hide
      Window.draw_font(600, 360, "Enter を押してスタート", @load_font1, color:[255,255,255])
    end

    # Enterを押したらスタート
    if Input.key_push?(K_RETURN)
      @part = 2
    end

  end

  # 開始カウントダウン
  def start

    # カウントダウン開始
    unless @count_started
      @count_first_time = Time.now
      @count_started = true
    end

    # 経過時間を計算
    elapsed_time = Time.now - @count_first_time

    # 経過時間が@countを超えたらループを終了
    if elapsed_time >= @count
      @timer_flg = true
      @part = 3
    else

      # カウントダウンを表示
      if (@count - elapsed_time).floor == 0
        Window.draw_font(700, 320, "START !", @start_font,color:[255,255,255])
      else
        Window.draw_font(900, 320, "#{(@count - elapsed_time).floor} ", @start_font,color:[255,255,255])
      end
    end

  end

  # ゲームメイン関数
  def game_main
    Window.draw(260, 280, @dec_message_box)
    Window.draw(90, 260, @dec_icon_ojis[$type_oji-1])
    Window.draw_font(1700,500, "#{@content2[@content_num].length}文字",@prob_font3,color:[100,100,100])

    # 全角文字列
    str_1 = @content2[@content_num]

    # 全角文字列の結合
    str_1_set_1 = ""
    str_1_set_2 = ""
    for i in str_1[0,@kye_index_1] do
      if i == "１"
        str_1_set_2 += "　"
      else
        str_1_set_2 += i
      end
    end
    for i in str_1[@kye_index_1..-1] do
      if i == "１"
        str_1_set_1 += "　"
      else
        str_1_set_1 += i
      end
    end

    # 全角文字列の出力
    appearance_1 = 960 - (str_1_set_1.length + str_1_set_2.length) * 15.5 # 文字を中央に寄せる
    Window.draw_font(appearance_1+(@kye_index_1*(@prob_font1.size*0.778)), 370,str_1_set_1, @prob_font1,color:[80,80,80])
    Window.draw_font(appearance_1, 370,str_1_set_2, @prob_font1,color:[151,170,212])

    # 半角文字列
    str_2 = @content2[@content_num+1]

    # 半角文字列の結合
    str_2_set_1 = ""
    str_2_set_2 = ""
    for i in 0..@kye_index_1 do
      if i == @kye_index_1
        str_2_set_2 += str_2[i][0, @kye_index_2]
      else
        str_2_set_2 += str_2[i]
      end
    end
    for i in @kye_index_1..(str_2.length-1) do
      if i == @kye_index_1
        str_2_set_1 += str_2[i][@kye_index_2..-1]
      else
        str_2_set_1 += str_2[i]
      end
    end

    # 半角文字の出力
    appearance_2 = 960 - (str_2_set_1.length + str_2_set_2.length ) * 7 # 文字を中央に寄せる
    Window.draw_font(appearance_2+(@sum_index*16), 420,str_2_set_1, @prob_font0,color:[180,180,180])
    Window.draw_font(appearance_2, 420,str_2_set_2, @prob_font0,color:[120,120,120])

    # キー入力判定

    @target_key = eval("K_#{str_2[@kye_index_1][@kye_index_2].upcase}")
    if @sum_index > 0
      @bef_key_1 = eval("K_#{str_2_set_2[(str_2_set_2.length)-1].upcase}")
    elsif @sum_index > 1
      @bef_key_2 = eval("K_#{str_2_set_2[(str_2_set_2.length)-2].upcase}")
    elsif @sum_index > 2
      @bef_key_3 = eval("K_#{str_2_set_2[(str_2_set_2.length)-3].upcase}")
    end
    
    if Input.key_push?(@target_key)
      @sum_index += 1
      @kye_index_2 += 1

      # 1文字入力完了判定
      if @kye_index_2 == str_2[@kye_index_1].length
        @kye_index_1 += 1
        @kye_index_2 = 0
        
        # 1フレーズ入力完了判定
        if @kye_index_1 == str_1.length
          @kye_index_1 = 0
          @sum_index = 0
          @content_num += 2
        end
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

        # 入力に応じてキー色変更
        if [@target_key,@bef_key_1,@bef_key_2,@bef_key_3].include?(eval("K_#{char.upcase}"))
          Window.draw(key_info[:xy][0], key_info[:xy][1], key_info[:image_down_suc])
        else
          Window.draw(key_info[:xy][0], key_info[:xy][1], key_info[:image_down_err])
        end

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

    cursor_changed = false
    
    Window.draw(0, 90, @back_blue)

    # 終了ボタン
    Window.draw(1725, 3, @button_gameend)
    cursor_changed = true if $button_set.button(@button_gameend,1725,3){reset(); $scene = 1}

    Window.draw_scale(-180, -5, @dec_logo,0.4,0.4)
    Window.draw(-12,65,@dec_bar)

    # パート切り替え
    case @part
    when 1 then # 開始前画面
      load()
    when 2 then # 開始前カウントダウン
      start()
    when 3 then # ゲーム画面
      game_main()
    end

    time_bar() # タイムバーの実行

    kye_board() # キーボードの処理

    # スペースキーで結果画面に遷移
    if Input.key_push?(K_SPACE)
      $scene = 4
    end

    # カーソルをデフォルトに戻す
    Input.set_cursor(IDC_ARROW) unless cursor_changed

  end
end