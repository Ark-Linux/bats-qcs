# bats-qcs
linux 下安装bats

用源码安装


git clone https://github.com/bats-core/bats-core.gitcd bats-core

./install.sh /usr/local


安装完bats，

把kim.bats 和 alexafile 复制到fastboot 的目录下

修改kim.bats里面的Alexa文件的路径

在命令行输入bats kim.bats

即可进行auto test



WiFi是white_cat_wifi

蓝牙是默认与华为mate9进行连接测试

测试结束后 可以唤醒Alexa 
