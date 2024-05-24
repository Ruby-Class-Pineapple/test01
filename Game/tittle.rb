require "dxruby"
require "scene_switcher"

# 画面サイズ指定(1920×1080)
Window.width  = 1920
Window.height = 1080

# 画面の背景色を設定（R:255,G:255,B:255）
Window.bgcolor = C_WHITE

# ゲームのタイトルを設定
Window.caption = "おじタイピング/タイトル"

# ゲームの画像を読み込み
image1 = Image.load("Image_home/png/dec_hige.png")
image2 = Image.load("Image_home/png/dec_logo.png")
image3 = Image.load("Image_home/png/button_start.png")

Window.loop do
    
    # 画像を描写
    Window.draw(960, 540, image1)
    Window.draw(960, 700, image2)
    Window.draw(960, 400, image3)

    # スペースキーを押したらmain.rbに画面を切り替える
    if Input.key_push?(K_SPACE)
        switch_to "main.rb"
    end
    
end