module GameTitle

    # ゲームの画像を読み込み
    @image1 = Image.load("Image_home/dec_hige.png")
    @image2 = Image.load("Image_home/dec_logo.png")
    @image3 = Image.load("Image_home/button_start.png")

    # 書式設定
    @font = Font.new(32)

    module_function
    def exec

        # カーソル形状フラグ
        cursor_changed = false
        
        # 画像を描写
        Window.draw(850, 440, @image1)
        Window.draw(570, 330, @image2)
        Window.draw(690, 590, @image3)
        cursor_changed = true if $button_set.button(@image3,690,590){$scene = 2}

        # 文字の出力
        Window.draw_font(755, 900, "＠Powered by Pineapple", @font,color:[0,0,0])

        # スペースキーでメニュー画面に遷移
        if Input.key_push?(K_SPACE)
            $scene = 2
        end

        # カーソルをデフォルトに戻す
        Input.set_cursor(IDC_ARROW) unless cursor_changed

    end

end