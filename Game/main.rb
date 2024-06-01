require "dxruby"

# グローバル変数定義
$scene = 1

# ゲーム用グローバル変数
$type_oji = 1

# シーンごとのrubyファイルを読み込み
require_relative "title"
require_relative "menu"
require_relative "game"
require_relative "result"

# モジュールを宣言
$scene_title = GameTitle
$scene_menu = GameMenu
$scene_game = GameMain
$scene_result = GameResult

# 画面サイズ指定(1920×1080)
Window.width  = 1920
Window.height = 1080

# フルスクリーンに設定
# Window.full_screen = true

# 画面の背景色を設定（R:255,G:255,B:255）
Window.bgcolor = C_WHITE

# ゲームのタイトルを設定
Window.caption = "おじタイピング"

# 書式設定
font = Font.new(32)

# 描写する内容を記述
Window.loop do

    # 画面遷移設定
    case $scene
    when 1 then # タイトルシーン
        $scene_title.exec()
    when 2 then # メニューシーン
        $scene_menu.exec()
    when 3 then # ゲームシーン
        $scene_game.exec()
    when 4 then # 結果シーン
        $scene_result.exec()
    else
        # errer
        Window.draw_font(400, 500, "[errer] 無効なシーンです。", font,color:[0,0,0])
    end

    # ESCキーでゲームを終了
    if Input.key_push?(K_ESCAPE)
        Window.close
    end

end

# 参考サイト
# https://qiita.com/noanoa07/items/bced6519d9b53685b651