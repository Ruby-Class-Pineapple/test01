module GameResult

  # 結果画像を読み込み
  @image_result = Image.load("Image_result/dec_result.png")
  @iamge_retry = Image.load("Image_result/button_retry.png")
  @image_oji1 = Image.load("Image_result/dec_result_oji1.png")
  @image_oji2 = Image.load("Image_result/dec_result_oji2.png")
  @image_oji3 = Image.load("Image_result/dec_result_oji3.png")
  @image_hige = Image.load("Image_home/dec_hige.png")
  @image_logo = Image.load("Image_home/dec_logo.png")
  @image_yameru = Image.load("Image_menu/button_end.png")

  # 書式設定
  @font = Font.new(80,'Yu Gothic',weight:true)
  @font2 = Font.new(40,'Yu Gothic',weight:true)

  module_function
  def exec

    # 画像を描写
    Window.draw(570, 298, @image_result)
    Window.draw(790, 820, @iamge_retry)
    Window.draw(887.5, 200, @image_hige)
    
    #ロゴマーク
    Window.draw_scale(-180,-5, @image_logo,0.4,0.4)

    #やめるボタン
    Window.draw(1725, 3, @image_yameru)
    cursor_changed = true if $button_set.button(@image_yameru,1725,3){$scene = 1}


    # 文字の出力
    Window.draw_font(803, 100, "おじスコア", @font,color:[0,0,0])
    Window.draw_font(1040, 515, "87", @font,color:[0,0,0])
    Window.draw_font(1050, 615, "420", @font2,color:[177,176,176])
    Window.draw_font(1068, 673, "95", @font2,color:[177,176,176])
    Window.draw_font(1068, 735, "22", @font2,color:[177,176,176])

    # スペースキーでタイトル画面に遷移
    if Input.key_push?(K_SPACE)
      $scene = 1
    end
    
  end
end