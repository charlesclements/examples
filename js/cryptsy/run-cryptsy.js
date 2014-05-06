var Cryptsy = require('cryptsy');

var cryptsy = new Cryptsy('cd61b17c9da2667cacfd456670794723e3d45990', '62b6b7f13d4628510bface72d30347d5b33ee02ed572b88acbd6731e749e5bbc4dbf635aec51d338');


cryptsy.api('singlemarketdata', { marketid: 26 }, function (err, data) {
    console.log(err);
    console.log(data);
});