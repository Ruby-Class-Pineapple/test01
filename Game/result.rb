module GameResult

  # 結果画像を読み込み
  @image_result = Image.load("Image_result/dec_result.png")
  @iamge_retry = Image.load("Image_result/button_retry.png")
  @image_oji1 = Image.load("Image_result/dec_result_oji1.png")
  @image_oji2 = Image.load("Image_result/dec_result_oji2.png")
  @image_oji3 = Image.load("Image_result/dec_result_oji3.png")
  @image_hige = Image.load("Image_home/dec_hige.png")

  # 書式設定
  @font = Font.new(32)

  module_function
  def exec

    # 画像を描写
    Window.draw(960, 540, @image_result)
    Window.draw(960, 600, @iamge_retry)
    Window.draw(960, 300, @image_hige)

    # 文字の出力
    Window.draw_font(400, 500, "結果シーンです。", @font,color:[0,0,0])
    Window.draw_font(960, 200, "おじスコア", @font,color:[0,0,0])

    # スペースキーでタイトル画面に遷移
    if Input.key_push?(K_SPACE)
      $scene = 1
    end
    
  end
end