module GameTitle

    # ゲームの画像を読み込み
    @image1 = Image.load("Image_home/dec_hige.png")
    @image2 = Image.load("Image_home/dec_logo.png")
    @image3 = Image.load("Image_home/button_start.png")

    module_function
    def exec
        
        # 画像を描写
        Window.draw(960, 540, @image1)
        Window.draw(960, 700, @image2)
        Window.draw(960, 400, @image3)

        # スペースキーでメニュー画面に遷移
        if Input.key_push?(K_SPACE)
            $scene = 2
        end

    end
end