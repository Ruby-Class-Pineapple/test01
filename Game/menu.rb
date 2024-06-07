module GameMenu

  # 書式設定
  @font1 = Font.new(32)
  @font2 = Font.new(60)

  #イメージ画像の読み込み
  @image1 = Image.load("Image_menu/button_end.png")
  @image2 = Image.load("Image_menu/button_oji1.png")
  @image3 = Image.load("Image_menu/button_oji2.png")
  @image4 = Image.load("Image_menu/button_oji3.png")
  @image5 = Image.load("Image_home/dec_hige.png")
  @image6 = Image.load("Image_home/dec_logo.png")

  module_function

  # ボタン実装
  def button(image,button_x,button_y,&action)

    # 終了ボタンの座標とサイズ
    button_width = image.width
    button_height = image.height

    # マウスの位置を取得
    mouse_x = Input.mouse_pos_x
    mouse_y = Input.mouse_pos_y

    # ボタンの上にカーソルがあるとき
    if mouse_x >= button_x && mouse_x <= button_x + button_width &&
      mouse_y >= button_y && mouse_y <= button_y + button_height

      Input.set_cursor(IDC_HAND) # マウスカーソルを手の形状に変更

      # マウスクリックの検出
      if Input.mouse_push?(M_LBUTTON)
        action.call
      end

      true

    else
      false
    end

  end

  def exec

    cursor_changed = false

    #やめるボタン
    Window.draw(1725, 3, @image1)
    cursor_changed = true if button(@image1,1725,3){$scene = 1}

    #おじせんたくボタン
    #レベル１
    Window.draw(581, 300, @image2)
    cursor_changed = true if button(@image2,581,300){$type_oji = 1; $scene = 3}

    #レベル２
    Window.draw(581, 450, @image3)
    cursor_changed = true if button(@image3,581,450){$type_oji = 2; $scene = 3}

    #レベル３
    Window.draw(581, 600, @image4)
    cursor_changed = true if button(@image4,581,600){$type_oji = 3; $scene = 3}
  

    #ひげマーク
    Window.draw_scale(887.5, 200, @image5,0.6,0.6)

    #ロゴマーク
    Window.draw_scale(-180,-5, @image6,0.4,0.4)

    # 文字の出力
    Window.draw_font(750, 800, "お好みのおじを選択してください", @font1,color:[0,0,0])
    Window.draw_font(800, 140, "おじせんたく", @font2,color:[0,0,0])

    # スペースキーでゲーム画面に遷移
    if Input.key_push?(K_SPACE)
      $scene = 3
    end

    # カーソルをデフォルトに戻す
    Input.set_cursor(IDC_ARROW) unless cursor_changed
    
  end

end

