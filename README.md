# Terraform-Nutanix-Sample
Terraform で Nutanix AHV に仮想マシンをデプロイするためのサンプルコード


## これは何？ - What's this?
Terraform で Nutanix AHV に仮想マシンをデプロイするためのサンプルコードです。

任意の接頭語の仮想マシンを 001 から始まる3桁の連番で作成します。(デフォルトは tfvm001 です。)

## 使い方 - How to use
Terraform をインストールして、任意のディレクトリで実行します。

任意のディレクトリには main.tf と terraform.tfvars の2つのファイルが格納されている必要があります。

サンプルとして動作確認をしたい場合、 terraform.tfvars を対象となる環境にあわせて書き換えてください。

仮想マシンを展開するときは "Terraform Apply" で、

仮想マシンを破棄するときは "Terraform Destroy" を実行します。

## 変数の説明 - Detail of variables
- prov_username = "admin" : PRISMにログインするユーザー名を入力します。
- prov_password = "nutanix/4u" : 上記ユーザーに対応するパスワードを入力します。
- prov_endpoint = "0.0.0.0" : PRISMのクラスターIPまたはFQDNを入力します。
- prov_cluster_name = "AHV" : PRISMのクラスター名を入力します。
- prov_vmname_prefix = "tfvm" : 仮想マシンの接頭語を入力します。
- prov_num = "2" : 展開したい台数を入力します。
- prov_subnet_uuid = "7ebac8b7-b6e9-4cda-8956-ee9e100XXXXX" : 展開対象の仮想マシンのネットワークを指定します。
- prov_diskimage_uuid = "25107393-fd41-4234-a6e2-a1da21aXXXXX" : 展開対象の仮想マシンのテンプレートイメージを指定します。
- prov_vcpu = 2 : 仮想マシンのスペック (1ソケットあたりのvCPU数)
- prov_sock = 1 : 仮想マシンのスペック (ソケット数)
- prov_mem = 4096 : 仮想マシンのスペック (メモリをMB単位で指定)
