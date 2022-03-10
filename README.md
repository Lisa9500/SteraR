# GISと3DCGアプリで作る３次元都市モデル

国土地理院が公開している基盤地図情報を基データとして，GISアプリケーションソフト（QGIS）と3DCGアプリケーションソフト（SketchUp）を用いて，３次元都市モデルを
制作します．

# DEMO

"StreraR"の魅力が直感的に伝えわるデモ動画や図解を載せる

# Features

このプログラムはＲ言語で記述されています．動作にはRとRStudioが必要です．Stera_Rが，基盤地図情報の建築物データから建物モデルを生成します．DEM2Geoが数値標高データから地形モデルを生成します．

# Requirement

* R-3.3.2-win
* RStudio-1.0.136

# Installation

RStudioの”File-Open File...”で開いたダイアログからプログラムファイルを読み込んでください．

# Usage

RStudioにプログラムファイルを読み込んで，Sourceアイコンをクリック，もしくはCtrl+Shift+Sを押して，開いたダイアログで基盤地図情報から変換したCSVファイルを読み込ませます．

# Note

基盤地図情報の仕様変更により動作不良となる場合があります．

# Author

* 山﨑 俊夫 ／ Toshio YAMAZAKI
* 函館工業高等専門学校 ／ UPCS（Urban Planning Cyber Studio）
* toshi_ya@hakodate-ct.ac.jp  ／ lisa9500jp@gmail.com

# License

"SteraR" is under [MIT license](https://en.wikipedia.org/wiki/MIT_License).
