# irohaBoardInstallScript
irohaBoardをUbuntu 16.04 に導入するインストーラースクリプト

## 注意事項
まだ未完成品です。

セキュリティ的にかなり脆弱な状態なので、利用は勧められません

必ずパスワードなどを書き換えて実行し、実行後は消去してください

## 利用させていただいているもの
iroha Board 0.9.13

CakePHP 2.10.7

## 使い化
### OSを最新にする
<code>
sudo apt update
sudo apt upgrade -y
</code>

### ダウンロードする
<code>
wget https://github.com/keloud/irohaboard_InstallScript/archive/master.tar.gz
</code>

### 解凍する
<code>
tar -xvf master.tar.gz
</code>

### カレントディレクトリを変更する
<code>
cd irohaBoard_InstallScript-master
</code>

### 実行権限を与える
<code>
chmod 555 irohaBoard_Installer.sh
</code>

### インストールを開始する
<code>
sudo ./irohaBoard_Installer.sh
</code>
