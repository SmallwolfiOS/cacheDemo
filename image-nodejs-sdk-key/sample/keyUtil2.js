var tencentyun = require('../');
var crypto = require('crypto');

function getKey() {
    var appid          = "1251414411";
    var bucket         = "ocr";
    var secret_id      = "AKIDv364ddH8XNuVmKKTBIxA8J66QG8QtOY5";
    var secret_key     = "fdAkeJh28hhtSSuydm1I3KI57cQ0SyPC";
    var expired        = parseInt(Date.now() / 1000) + 10000;
    var onceExpired    = 0;
    var now            = parseInt(Date.now() / 1000);
    var rdm            = parseInt(Math.random() * Math.pow(2, 32));
    var userid = "0";
    var fileid = "tencentyunSignTest";

    // var  plainText = 'a='+appid+'&b='+bucket+'&k='+secret_id+'&e='+expired+'&t='+now+'&r='+rdm+'&u=0&f='
    var  plainText = 'a='+appid+'&b='+bucket+'&k='+secret_id+'&t='+now+'&e='+expired

    console.log(plainText)
    var data = new Buffer(plainText,'utf8');

    var res = crypto.createHmac('sha1',secret_key).update(data).digest();

    var bin = Buffer.concat([res,data]);

    var sign = bin.toString('base64');

    return sign;

}
// 生成新的上传签名

var sign = getKey();
console.log("-------------------");
console.log(sign);













































// var tencentyun = require('../');
// var crypto = require('crypto');
//
// function getKey() {
//     var appid          = "1251414411";
//     var bucket         = "ocr";
//     var secret_id      = "AKIDv364ddH8XNuVmKKTBIxA8J66QG8QtOY5";
//     var secret_key     = "fdAkeJh28hhtSSuydm1I3KI57cQ0SyPC";
//     var expired        = parseInt(Date.now() / 1000) + 9999;
//     var onceExpired    = 0;
//     var now            = parseInt(Date.now() / 1000);
//     var rdm            = parseInt(Math.random() * Math.pow(2, 32));
//     var userid = "0";
//     var fileid = "tencentyunSignTest";
//
//     var  plainText = 'a='+appid+'&b='+bucket+'&k='+secret_id+'&t='+now+'&e='+expired
//
//     console.log(plainText)
//     var data = new Buffer(plainText,'utf8');
//
//     var res = crypto.createHmac('sha1',secret_key).update(data).digest();
//
//     var bin = Buffer.concat([res,data]);
//
//     var sign = bin.toString('base64');
//
//     return sign;
//
// }
// // 生成新的上传签名
//
// var sign = getKey();
// console.log("-------------------");
// console.log(sign);
