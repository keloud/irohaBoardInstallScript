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
wget https://github.com/keloud/irohaboard_InstallScript/archive/master.tar.gz

### 解凍する
tar -xvf master.tar.gz

### カレントディレクトリを変更する
cd irohaBoard_InstallScript-master

### 実行権限を与える
chmod 555 irohaBoard_Installer.sh

### インストールを開始する
sudo ./irohaBoard_Installer.sh
