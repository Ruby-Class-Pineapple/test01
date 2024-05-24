require "dxruby"
require "scene_switcher"

# 画面サイズ指定(1920×1080)
Window.width  = 1920
Window.height = 1080

# 画面の背景色を設定（R:255,G:255,B:255）
Window.bgcolor = C_WHITE

# ゲームのタイトルを設定
Window.caption = "おじタイピング/メニュー"

Window.loop do
    # スペースキーを押したらmain.rbに画面を切り替える
    if Input.key_push?(K_SPACE)
        switch_to "main.rb"
      end
end
