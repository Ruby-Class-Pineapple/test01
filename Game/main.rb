require "dxruby"
require "scene_switcher"

# 画面サイズ指定(1920×1080)
Window.width  = 1920
Window.height = 1080

# 画面の背景色を設定（R:255,G:255,B:255）
Window.bgcolor = C_WHITE

# ゲームのタイトルを設定
Window.caption = "おじタイピング"

# フォントの設定
font = Font.new(24)

Window.loop do
    Window.draw_font(960, 540, "1:tittle,2:menu,3:game,4:result", font,color:[0,0,0] )
    if Input.key_push?(K_1)
        switch_to "tittle.rb"
    end
    if Input.key_push?(K_2)
        switch_to "menu.rb"
    end
    if Input.key_push?(K_3)
        switch_to "game.rb"
    end
    if Input.key_push?(K_4)
        switch_to "result.rb"
    end
end

# 参考サイト
# https://qiita.com/noanoa07/items/bced6519d9b53685b651