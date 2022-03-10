# DEM2Geo ver.3.2  2017-12-16~
# ファイル読み込み--
data <- read.csv(file.choose(), header=FALSE)

## 各種関数の定義
# library_visual_scenesの書き出し
# <instance_geometry> ～ </instance_geometry>
F_lib_vis_scene <- function (id) {
  lib_vis_sce2 = array(dim = c(9))
  for (i in 1:id) {
    # instance_geometry urlの設定
    ig_url = paste("\t\t\t\t<instance_geometry url=\"#ID", i, "\">", sep = "") 
    im_tar = paste("\t\t\t\t\t\t\t<instance_material symbol=\"Material2\" target=\"#ID", i, "-material\">", sep = "")
    lib_vis_sce2[1] = ig_url
    lib_vis_sce2[2] = "\t\t\t\t\t<bind_material>"
    lib_vis_sce2[3] = "\t\t\t\t\t\t<technique_common>"
    lib_vis_sce2[4] = im_tar
    lib_vis_sce2[5] = "\t\t\t\t\t\t\t\t<bind_vertex_input semantic=\"UVSET0\" input_semantic=\"TEXCOORD\" input_set=\"0\" />"
    lib_vis_sce2[6] = "\t\t\t\t\t\t\t</instance_material>"
    lib_vis_sce2[7] = "\t\t\t\t\t\t</technique_common>"
    lib_vis_sce2[8] = "\t\t\t\t\t</bind_material>"
    lib_vis_sce2[9] = "\t\t\t\t</instance_geometry>"
    for (j in 1:9){
      write (lib_vis_sce2[j], "outputgeo.dae", append = TRUE)
    }
  }
}

# library_geometries(Position)の書き出し
F_lib_geo_Pos <- function (id, count) {
  lib_geo_Pos = array(dim = c(4))
  # geometry idの設定
  geo_id = paste("\t\t<geometry id=\"ID", id, "\">", sep = "") 
  lib_geo_Pos[1] = geo_id
  lib_geo_Pos[2] = "\t\t\t<mesh>"
  # source idの設定
  sour_id = paste("\t\t\t\t<source id=\"ID", id, "-Pos\">", sep = "") 
  lib_geo_Pos[3] = sour_id
  fl_arr_id = paste("\t\t\t\t\t<float_array id=\"ID", id, "-Pos-array\" count=\"", count, "\">", sep = "") 
  lib_geo_Pos[4] = fl_arr_id
  for (j in 1:4){
    write (lib_geo_Pos[j], "outputgeo.dae", append = TRUE)
  }
}

# Pos_technique_commonの書き出し
F_Pos_Tech_com <- function (id, ver_num) {
  tec_com = array(dim = c(8))
  tec_com[1] = "\t\t\t\t\t</float_array>"
  tec_com[2] = "\t\t\t\t\t<technique_common>"
  # accessor coount, sourceの設定
  accsor = paste("\t\t\t\t\t\t<accessor count=\"", ver_num, "\" source=\"#ID", id, "-Pos-array\" stride=\"3\">", sep = "")
  tec_com[3] = accsor
  tec_com[4] = "\t\t\t\t\t\t\t<param name=\"X\" type=\"float\" />"
  tec_com[5] = "\t\t\t\t\t\t\t<param name=\"Y\" type=\"float\" />"
  tec_com[6] = "\t\t\t\t\t\t\t<param name=\"Z\" type=\"float\" />"
  tec_com[7] = "\t\t\t\t\t\t</accessor>"
  tec_com[8] = "\t\t\t\t\t</technique_common>"
  tec_com[9] = "\t\t\t\t</source>"
  for (j in 1:9){
    write (tec_com[j], "outputgeo.dae", append = TRUE)
  }
}

# library_geometries(Normal)の書き出し
F_lib_geo_Nor <- function (id, count) {
  sour_id = paste("\t\t\t\t<source id=\"ID", id, "-Normal\">", sep = "") 
  fl_arr_id = paste("\t\t\t\t\t<float_array id=\"ID", id, "-Normal-array\" count=\"", count, "\">", sep = "") 
  lib_geo_Pos = array(dim = c(2))
  lib_geo_Pos[1] = sour_id
  lib_geo_Pos[2] = fl_arr_id
  for (j in 1:2){
    write (lib_geo_Pos[j], "outputgeo.dae", append = TRUE)
  }
}

# 法線ベクトルを求める
F_normal_vector <- function (p1, p2, p3) {
#   v1 = array(dim = c(3))
#   v2 = array(dim = c(3))
#   cross = array(dim = c(3))
#   for (j in 1:3) {
#     v1[j] = p1[j] - p2[j]
#   }
#   for (j in 1:3) {
#     v2[j] = p3[j] - p2[j]
#   }
#   for (j in 1:3) {
#     cross[j] = v2[(j+1)%%3+1]*v1[(j+2)%%3+1] - v2[(j+2)%%3+1]*v1[(j+1)%%3+1]
#   }
#   length = sqrt(cross[1] * cross[1] + cross[2] * cross[2] + cross[3] * cross[3])
#   normal = array(dim = c(3))
#   for (j in 1:3) {
#     normal[j] = cross[j] / length
#   }
#   return(c(normal[3], normal[1], normal[2]))
  return(c(0, 0, 1))
}

# Nor_technique_commonの書き出し
F_Nor_Tech_com <- function (id, ver_num) {
  tec_com = array(dim = c(8))
  tec_com[1] = "\t\t\t\t\t</float_array>"
  tec_com[2] = "\t\t\t\t\t<technique_common>"
  # accessor coount, sourceの設定
  accsor = paste("\t\t\t\t\t\t<accessor count=\"", ver_num, "\" source=\"#ID", id, "-Noamal-array\" stride=\"3\">", sep = "")
  tec_com[3] = accsor
  tec_com[4] = "\t\t\t\t\t\t\t<param name=\"X\" type=\"float\" />"
  tec_com[5] = "\t\t\t\t\t\t\t<param name=\"Y\" type=\"float\" />"
  tec_com[6] = "\t\t\t\t\t\t\t<param name=\"Z\" type=\"float\" />"
  tec_com[7] = "\t\t\t\t\t\t</accessor>"
  tec_com[8] = "\t\t\t\t\t</technique_common>"
  tec_com[9] = "\t\t\t\t</source>"
  for (j in 1:9){
    write (tec_com[j], "outputgeo.dae", append = TRUE)
  }
}

# vertices + polilystの書き出し
F_verti_polist <- function (id) {
  # verticesの書き出し
  verti = array(dim = c(4))
  id_vtx = paste("\t\t\t\t<vertices id=\"ID", id, "-Vtx\">", sep = "")
  id_pos = paste("\t\t\t\t\t<input semantic=\"POSITION\" source=\"#ID", id, "-Pos\" />", sep = "")
  id_nor = paste("\t\t\t\t\t<input semantic=\"NORMAL\" source=\"#ID", id, "-Normal\" />", sep = "")
  verti[1] = id_vtx
  verti[2] = id_pos
  verti[3] = id_nor
  verti[4] = "\t\t\t\t</vertices>"
  for (j in 1:4){
    write (verti[j], "outputgeo.dae", append = TRUE)
  }
  p_num = ver_num
  p_no = c(0)               # ０に(p_num-1)の数値まで追加していく
  for (j in 1:(p_num-1)) {
    p_no = c(p_no, j)
  }
  polist = array(dim = c(5))
  poly_mate = paste("\t\t\t\t<polylist count=\"", poly_mate_cnt, "\" material=\"Material2\">", sep = "")
  polist[1] = poly_mate
  sour_id = paste("\t\t\t\t\t<input offset=\"0\" semantic=\"VERTEX\" source=\"#ID", id, "-Vtx\" />", sep = "")
  polist[2] = sour_id
  for (j in 1:2) {
    write (polist[j], "outputgeo.dae", append = TRUE)
  }
  # <vcount>～</vcount>
  sink(file = "outputgeo.dae", append = TRUE, split = TRUE)
  cat ("\t\t\t\t\t<vcount>", vcnt, "</vcount>\n")
  sink()
  # <p>～</p>
  sink(file = "outputgeo.dae", append = TRUE, split = TRUE)
  cat ("\t\t\t\t\t<p>", p_no, "</p>\n")
  sink()
  polist[3] = "\t\t\t\t</polylist>"
  polist[4] = "\t\t\t</mesh>"
  polist[5] = "\t\t</geometry>"
  for (j in 3:5) {
    write (polist[j], "outputgeo.dae", append = TRUE)
  }
}

# library_materialsの書き出し
F_lib_mate <- function (id) {
  lib_mate = array(dim = c(7))
  lib_mate[1] = "\t</library_geometries>"
  lib_mate[2] = "\t<library_materials>"
  for (j in 1:2){
    write (lib_mate[j], "outputgeo.dae", append = TRUE)
  }
  for (i in 1:id) {
    mate_id = paste("\t\t<material id=\"ID", i, "-material\">", sep = "")
    effe_url = paste("\t\t\t<instance_effect url=\"#ID", i, "-surface\" />", sep = "")
    lib_mate[3] = mate_id
    lib_mate[4] = effe_url
    lib_mate[5] = "\t\t</material>"
    for (j in 3:5){
      write (lib_mate[j], "outputgeo.dae", append = TRUE)
    }
  }
  lib_mate[6] = "\t</library_materials>"
  lib_mate[7] = "\t<library_effects>"
  for (j in 6:7){
    write (lib_mate[j], "outputgeo.dae", append = TRUE)
  }
}

# library_effectsの書き出し
F_lib_effe <- function (id) {
  for (i in 1:id) {
    lib_effe = array(dim = c(11))
    effe_id = paste("\t\t<effect id=\"ID", i, "-surface\">", sep = "")
    col_rgb = "0.41 0.41 0.41 1"
    effe_col = paste("\t\t\t\t\t\t\t<color>", col_rgb, "</color>", sep = "")
    lib_effe[1] = effe_id
    lib_effe[2] = "\t\t\t<profile_COMMON>"
    lib_effe[3] = "\t\t\t\t<technique sid=\"COMMON\">"
    lib_effe[4] = "\t\t\t\t\t<lambert>"
    lib_effe[5] = "\t\t\t\t\t\t<diffuse>"
    lib_effe[6] = effe_col
    lib_effe[7] = "\t\t\t\t\t\t</diffuse>"
    lib_effe[8] = "\t\t\t\t\t</lambert>"
    lib_effe[9] = "\t\t\t\t</technique>"
    lib_effe[10] = "\t\t\t</profile_COMMON>"
    lib_effe[11] = "\t\t</effect>"
    for (j in 1:11){
      write (lib_effe[j], "outputgeo.dae", append = TRUE)
    }
  }
}

## プログラム本体
# rm(list=ls()); gc();  gc();

# 変数の宣言
nrow(data)
counter = nrow(data)
kansan = 0.0254       # ｍをインチ換算

## データ(data)を配列に読み込む
Xzahyo = array(dim = c(counter))
Yzahyo = array(dim = c(counter))
hyoukou = array(dim = c(counter))
for (i in 1:counter) {
  Xzahyo[i] = data[i, 9] / kansan    # X座標の読み込み
  Yzahyo[i] = data[i, 10] / kansan    # Y座標の読み込み
  hyoukou[i] = data[i, 11] / kansan   # 地盤高データの読み込み
}

## 配列（マトリックス）の大きさを決める処理
X_max = Xzahyo[1] # X座標の最大値の初期化
Y_max = Yzahyo[1] # Y座標の最大値の初期化
X_min = Xzahyo[1] # X座標の最小値の初期化
Y_min = Yzahyo[1] # Y座標の最小値の初期化

for (i in 2:counter) {
  # X座標・Y座標の最大値と最小値を求める
  if (X_max < Xzahyo[i]) {
    X_max = Xzahyo[i]      # X座標の最大値の更新
  }
  if (Y_max < Yzahyo[i]) {
    Y_max = Yzahyo[i]      # Y座標の最大値の更新
  }
  if (X_min > Xzahyo[i]) {
    X_min = Xzahyo[i]      # X座標の最小値の更新
  }
  if (Y_min > Yzahyo[i]) {
    Y_min = Yzahyo[i]      # Y座標の最小値の更新
  }
}

# マトリックスの大きさを決めるためにX(東西)方向とY(南北)方向の大きさを求める
X_len = abs(X_max - X_min)          # X(東西)方向の幅
Y_len = abs(Y_max - Y_min)          # Y(南北)方向の高さ

X_countMax = 0        # X(東西)方向マス数最大値の初期化
Y_count = 0           # Y(南北)方向マス数
X_dist = 0            # X(東西)方向のマス目の大きさ
Y_dist = 0            # Y(南北)方向のマス目の大きさ
X_dist_temp = 0       # X(東西)方向のマス目の計算過程での大きさ
Y_dist_temp = 0       # Y(南北)方向のマス目の計算過程での大きさ
Y_len_temp = 0        # Y(南北)方向の計算過程での高さ
Y_dist_cnt = 0        # Y(南北)方向の計算過程での累積回数
pre_Yzahyo = 0        # １つ前の行（段）の１番目のデータのY座標
X_dot = 0             # X(東西)方向の頂点データ数
Y_dot = 0             # Y(南北)方向の頂点データ数

# X(東西)方向のマス目の大きさ(最小値)を求める
# X座標の間隔は上(北)の方は狭く，下(南)は広く，同じ行(段)は等間隔になっている
X_dist = Xzahyo[2] - Xzahyo[1]
for (i in 3:counter) {
  if (Xzahyo[i] > Xzahyo[i - 1]) {
    X_dist_temp = Xzahyo[i] - Xzahyo[i - 1]
    if (X_dist > X_dist_temp) {
      X_dist = X_dist_temp
    }
  }
}

# X(東西)方向のデータ数を求める
X_countMax = round(X_len / X_dist, 0)
X_dot = X_countMax + 1

# Y(南北)方向のマス目の大きさを求める
Yzahyo_accu = 0
Y_cnt_tmp = 0
# Y_row = round(counter / X_dot, 0)
Y_row = ceiling(counter / X_dot)
Yzahyo_ave = array(dim = c(Y_row * 2))    # Y座標平均値用の配列準備
row_cnt = 1
for (i in 2:counter) {
  # Y座標値を累積して平均値を求める
  if (Xzahyo[i] > Xzahyo[i - 1]) {
    Yzahyo_accu = Yzahyo_accu + Yzahyo[i]
    Y_cnt_tmp = Y_cnt_tmp + 1
  } else {
    Yzahyo_ave[row_cnt] = Yzahyo_accu / Y_cnt_tmp
    row_cnt = row_cnt + 1
    Yzahyo_accu = 0
    Y_cnt_tmp = 0
  }
  if (i == counter) {
    Yzahyo_ave[row_cnt] = Yzahyo_accu / Y_cnt_tmp
  }
}

for (j in 2:row_cnt) {
  Y_dist_temp = Yzahyo_ave[j] - Yzahyo_ave[j - 1]
  if (Y_dist_temp < X_dist * 1.5) {
    Y_len_temp = Y_len_temp + Y_dist_temp
    Y_dist_cnt = Y_dist_cnt + 1
  }
}
Y_dist = Y_len_temp / Y_dist_cnt

# マトリックスのY(南北)方向の大きさをY座標の傾きの分だけ修正する
Yzahyo_ini = 0
Yzahyo_accu2 = 0
Y_cnt_tmp2 = 0

for (i in 2:counter) {
  if (Xzahyo[i] < Xzahyo[i - 1]) {
    if (Y_cnt_tmp2 == 0) {
      Yzahyo_ini = Yzahyo[i]
      Y_cnt_tmp2 = 1
    } else {
      Yzahyo_accu2 = Yzahyo_accu2 + abs(Yzahyo[i - 1] - Yzahyo_ini)
      Yzahyo_ini = Yzahyo[i]
      Y_cnt_tmp2 = Y_cnt_tmp2 + 1
    }
  }
}

Y_tilt = Yzahyo_accu2 / (Y_cnt_tmp2 - 1)
Y_len = Y_len + Y_tilt

# Y(南北)方向のデータ数を求める
Y_countMax = round(Y_len / Y_dist, 0)
Y_dot = Y_countMax + 1

# マトリックスの大きさ（２次元配列）を決める
X_matrix = array(dim = c(X_dot, Y_dot))   # X座標
Y_matrix = array(dim = c(X_dot, Y_dot))   # Y座標
Z_matrix = array(dim = c(X_dot, Y_dot))   # Z座標

## マトリックスにデータを割り付ける
col_num = 0     # 桁の番号，左端が１
row_num = 1     # 行（段）の番号，下端が１
blunk = 0       # 空白部分の桁数，初期値は０

for (i in 1:counter) {
  if (i == 1 || Xzahyo[i] < Xzahyo[i - 1]) {
    # pre_Yzahyo = Yzahyo[i]  # Y(南北)方向のマス目の大きさを求めるための前の行（段）のY座標
    
    # 各行（段）の１番目のデータの配列（配置場所）を決める
    # 左端からの距離は許容範囲内か？
    if ((Xzahyo[i] - X_min) < X_dist * 0.8) {
      col_num = 1
      X_matrix[col_num, row_num] = Xzahyo[i]
      Y_matrix[col_num, row_num] = Yzahyo[i]
      Z_matrix[col_num, row_num] = hyoukou[i]
      col_num = 1 + 1     # 次の列番号
    } else {
      # 空白部分の桁数を求める
      blunk = round((Xzahyo[i] - X_min) / X_dist, 0)
      col_num = 1
      X_matrix[col_num + blunk, row_num] = Xzahyo[i]
      Y_matrix[col_num + blunk, row_num] = Yzahyo[i]
      Z_matrix[col_num + blunk, row_num] = hyoukou[i]

      # 空白部分を標高０としてダミーで埋める
      for (j in 1:blunk) {
        X_matrix[j, row_num] = X_min + X_dist * (j - 1)
        # Y_matrix[j, row_num] = Y_min + Y_dist * (row_num - 1)
        Y_matrix[j, row_num] = Y_min + Y_tilt + Y_dist * (row_num - 1)
        Z_matrix[j, row_num] = 0
      }
      col_num = 1 + blunk + 1     # 次の列番号
    }
  } else if (i > 1 && Xzahyo[i] > Xzahyo[i - 1]) {
    # Xzahyo[i + 1] > Xzahyo[i]
    # 各行（段）の２番目以降のデータの配列（配置場所）を決める
    # i >= 2, col_num >= 2
    # １番目のデータからの距離は許容範囲内か？
    if ((Xzahyo[i] - Xzahyo[i - 1]) < X_dist * 1.1) {
      X_matrix[col_num, row_num] = Xzahyo[i]
      Y_matrix[col_num, row_num] = Yzahyo[i]
      Z_matrix[col_num, row_num] = hyoukou[i]
      col_num = col_num + 1     # 次の列番号
    } else {
      blunk = round((Xzahyo[i] - Xzahyo[i - 1]) / X_dist, 0)
      X_matrix[col_num + blunk - 1, row_num] = Xzahyo[i]
      Y_matrix[col_num + blunk - 1, row_num] = Yzahyo[i]
      Z_matrix[col_num + blunk - 1, row_num] = hyoukou[i]

      # 空白部分を標高０としてダミーで埋める
      for (j in 1:(blunk - 1)) {
        X_matrix[col_num + j - 1, row_num] = Xzahyo[i - 1] + X_dist * j
        Y_matrix[col_num + j - 1, row_num] = Yzahyo[i - 1]
        Z_matrix[col_num + j - 1, row_num] = 0
      }
      col_num = col_num + blunk     # 次の列番号
    }
    
    # 改行されるかどうかをチェックする
    if (i != counter && Xzahyo[i + 1] < Xzahyo[i]) {
      # 改行される前に空白部分がないか調べる
      if (col_num <= X_dot) {
        blunk = X_dot - col_num + 1

        # 空白部分を標高０としてダミーで埋める
        for (j in 1:blunk) {
          X_matrix[col_num + j - 1, row_num] = Xzahyo[i] + X_dist * j
          Y_matrix[col_num + j - 1, row_num] = Yzahyo[i]
          Z_matrix[col_num + j - 1, row_num] = 0
        }
      }
      pre_Yzahyo = Y_matrix[1, row_num]
      
      # 帯状空白部分がある場合は標高０としてダミーで埋める
      if (row_num == 1) {
        pre_Yzahyo = Y_matrix[1, 1]
      }
      if ((Yzahyo[i + 1]) - pre_Yzahyo > Y_dist * 1.8) {
        row_num = row_num + 1
        for (j in 1:X_dot) {
          X_matrix[j, row_num] = X_min + X_dist * (j - 1)
          Y_matrix[j, row_num] = Y_matrix[j, row_num - 1]
          Z_matrix[j, row_num] = 0
        }
      }
      
      # 改行されているので桁(col)番号を１に戻す
      col_num = 1
      # 改行されているので行(row)番号が変更になる
      row_num = row_num + 1
    }
  }
}

# 右上（北東）隅に空白部分がある場合の処理
if (X_max - Xzahyo[counter] > X_dist * 0.9) {
  blunk = round((X_max - Xzahyo[counter]) / X_dist, 0)
  for (j in 1:blunk) {
    X_matrix[col_num + blunk - 1, row_num] = X_matrix[col_num - 1, row_num] + X_dist * j
    Y_matrix[col_num + blunk - 1, row_num] = Y_matrix[col_num - 1, row_num]
    Z_matrix[col_num + blunk - 1, row_num] = 0
  }
}

# マトリックス（２次元配列）に割り付けられたデータをチェックする
# 最後の列と最後の行(段)にデータが入っているかどうかを調べる
X_matrix_chk = 0
Y_matrix_chk = 0

while (X_matrix_chk == 0) {
  for (i in 1:X_dot) {
    if (is.na(X_matrix[i, Y_dot]) == TRUE) {
      Y_dot = Y_dot - 1
      
      break
    } else {
      X_matrix_chk = 1
    }
  }
}
while (Y_matrix_chk == 0) {
  for (i in 1:Y_dot) {
    if (is.na(Y_matrix[X_dot, i]) == TRUE) {
      X_dot = X_dot - 1
      
      break
    } else {
      Y_matrix_chk = 1
    }
  }
}

## 地形の３角メッシュのモデリング
# 四角ポリゴンの数
polycount = (X_countMax) * (Y_countMax)
# 各行(段)の四角ポリゴンの３角メッシュの数
meshcount = 2 * (X_countMax)
# 各行(段)の面頂点数の総和（３角メッシュ数×頂点数）
ver_num = meshcount * 3
# 各行(段)の配列データ数（３角メッシュ数×頂点数×軸数（X･Y･Z））
count = meshcount * 3 * 3
# 各行(段)の面の総数
poly_mate_cnt = meshcount

# COLLADAファイルの出力開始
# ファイル出力（ヘッダー部分の書き出し）
xml = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
collada_1 = "<COLLADA xmlns=\"http://www.collada.org/2005/11/COLLADASchema\" version=\"1.4.1\">"
write (xml, "outputgeo.dae")
write (collada_1, "outputgeo.dae", append = TRUE)
asset = array(dim = c(4))
asset[1] = "\t<asset>"
asset[2] = "\t\t<unit meter=\"0.0254\" name=\"inch\" />"
asset[3] = "\t\t<up_axis>Z_UP</up_axis>"
asset[4] = "\t</asset>"
for (j in 1:4){
  write (asset[j], "outputgeo.dae", append = TRUE)
}

# library_visual_scenesの書き出し
# <library_visual_scenes> ～ <node>
lib_vis_sce1 = array(dim = c(3))
lib_vis_sce1[1] = "\t<library_visual_scenes>"
lib_vis_sce1[2] = "\t\t<visual_scene id=\"DefaultScene\">"
lib_vis_sce1[3] = "\t\t\t<node name=\"Building\">"
for (j in 1:3){
  write (lib_vis_sce1[j], "outputgeo.dae", append = TRUE)
}
# <instance_geometry> ～ </instance_geometry>
# データ毎に必要な部分（url(#ID）のみが変わる）
# IDの設定
id = Y_dot - 1
# id = Y_countMax
F_lib_vis_scene (id)   # 関数によるIDのみを変更した繰り返し部分の書き出し

# </node> ～ <library_geometries>
lib_vis_sce3 = array(dim = c(4))
lib_vis_sce3[1] = "\t\t\t</node>"
lib_vis_sce3[2] = "\t\t</visual_scene>"
lib_vis_sce3[3] = "\t</library_visual_scenes>"
lib_vis_sce3[4] = "\t<library_geometries>"
for (j in 1:4){
  write (lib_vis_sce3[j], "outputgeo.dae", append = TRUE)
}

# 行(段)単位にモデリングする
for (row in 1:(Y_dot - 1)) {
  # ID番号の設定（iをidに変更）
  id = row
  
  # library_geometries(Position)の書き出し
  F_lib_geo_Pos (id, count)
  
  # マトリックス（３角メッシュ／データ部分）の定義
  # 左下から右へ（X方向），そして左に戻って１行上へ（Y方向）
  # 相対する３角メッシュを左下側→右上側→左下側→右上側の順に定義する
  
  ## ３角メッシュの頂点座標の定義
  mesh = c()
  
  ## 法線ベクトルの定義
  normal = array(dim = c(3))
  Nor = c()
  
  # 列ごとに視覚ポリゴン(３角メッシュ×２)を最終列までモデリングする
  # 列番号（X番号）
  for (column in 1:(X_dot - 1)) {
    # 左下側３角メッシュを定義する
    # X･Y座標，標高の割り当て
    x1 = X_matrix[column, row]            # 頂点①
    y1 = Y_matrix[column, row]
    z1 = Z_matrix[column, row]
    x2 = X_matrix[column, row + 1]        # 頂点②
    y2 = Y_matrix[column, row + 1]
    z2 = Z_matrix[column, row + 1]
    x3 = X_matrix[column + 1, row]        # 頂点③
    y3 = Y_matrix[column + 1, row]
    z3 = Z_matrix[column + 1, row]
    # 右上側３角メッシュを定義する
    # X･Y座標，標高の割り当て
    x4 = X_matrix[column, row + 1]        # 頂点②
    y4 = Y_matrix[column, row + 1]
    z4 = Z_matrix[column, row + 1]
    x5 = X_matrix[column + 1, row + 1]    # 頂点④
    y5 = Y_matrix[column + 1, row + 1]
    z5 = Z_matrix[column + 1, row + 1]
    x6 = X_matrix[column + 1, row]        # 頂点③
    y6 = Y_matrix[column + 1, row]
    z6 = Z_matrix[column + 1, row]
    
    mesh = c(mesh, x1 )
    mesh = c(mesh, y1 )
    mesh = c(mesh, z1 )
    mesh = c(mesh, x2 )
    mesh = c(mesh, y2 )
    mesh = c(mesh, z2 )
    mesh = c(mesh, x3 )
    mesh = c(mesh, y3 )
    mesh = c(mesh, z3 )
    mesh = c(mesh, x4 )
    mesh = c(mesh, y4 )
    mesh = c(mesh, z4 )
    mesh = c(mesh, x5 )
    mesh = c(mesh, y5 )
    mesh = c(mesh, z5 )
    mesh = c(mesh, x6 )
    mesh = c(mesh, y6 )
    mesh = c(mesh, z6 )
    
    # 左下側３角メッシュ法線ベクトルの算出
    p1 = c(x3, y3, z3)
    p2 = c(x1, y1, z1)
    p3 = c(x2, y2, z2)
    Nor = c(Nor, F_normal_vector (p1, p2, p3))
    p1 = c(x1, y1, z1)
    p2 = c(x2, y2, z2)
    p3 = c(x3, y3, z3)
    Nor = c(Nor, F_normal_vector (p1, p2, p3))
    p1 = c(x2, y2, z2)
    p2 = c(x3, y3, z3)
    p3 = c(x1, y1, z1)
    Nor = c(Nor, F_normal_vector (p1, p2, p3))
    
    # 右上側３角メッシュ法線ベクトルの算出
    p1 = c(x6, y6, z6)
    p2 = c(x4, y4, z4)
    p3 = c(x5, y5, z5)
    Nor = c(Nor, F_normal_vector (p1, p2, p3))
    p1 = c(x4, y4, z4)
    p2 = c(x5, y5, z5)
    p3 = c(x6, y6, z6)
    Nor = c(Nor, F_normal_vector (p1, p2, p3))
    p1 = c(x5, y5, z5)
    p2 = c(x6, y6, z6)
    p3 = c(x4, y4, z4)
    Nor = c(Nor, F_normal_vector (p1, p2, p3))
  }
  
  # ３角メッシュの頂点座標の書き出し
  sink(file = "outputgeo.dae", append = TRUE, split = TRUE)
  cat ("\t\t\t\t\t\t", mesh, "\n")
  sink()
  
  # Pos_technique_commonの書き出し
  F_Pos_Tech_com (id, ver_num)
  
  # library_geometries(Normal)の書き出し
  F_lib_geo_Nor (id, count)
  
  # 法線ベクトルの書き出し
  sink(file = "outputgeo.dae", append = TRUE, split = TRUE)
  cat ("\t\t\t\t\t\t", Nor, "\n")
  sink()
  
  # Nor_technique_commonの書き出し
  F_Nor_Tech_com (id, ver_num)
  
  # <vcount>～</vcount>
  # vcnt = c(meshcount)
  vcnt = c()
  for (j in 1:meshcount) {
    vcnt = c(vcnt, 3)
  }
  # vertices + polilystの書き出し
  F_verti_polist (id)
}

id = Y_dot -1

# library_materialsの書き出し
F_lib_mate (id)

# library_effectsの書き出し
F_lib_effe (id)

# COLLADAファイルの出力終了
scene = array(dim = c(4))
scene[1] = "\t</library_effects>"
scene[2] = "\t<scene>"
scene[3] = "\t\t<instance_visual_scene url=\"#DefaultScene\" />"
scene[4] = "\t</scene>"
for (i in 1:4){
  write (scene[i], "outputgeo.dae", append = TRUE)
}
collada_2 = "</COLLADA>"
write (collada_2, "outputgeo.dae", append = TRUE)
