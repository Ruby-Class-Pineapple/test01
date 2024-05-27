module GameMain

  # 書式設定
  @font = Font.new(32)

  module_function
  def exec

    # 文字の出力
    Window.draw_font(400, 500, "ゲームシーンです。", @font,color:[0,0,0])

    # スペースキーで結果画面に遷移
    if Input.key_push?(K_SPACE)
      $scene = 4
    end

  end
end