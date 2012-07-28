
/*
 * GET home page.
 */

exports.index = function(req, res){
  res.render('index', { title: 'Beauty Of The Love ♥ 美丽的爱情' });
};


/*
 * GET about page.
 */

exports.about = function (req, res) {
  res.render('about', { title: 'Beauty Of The Love ♥ 美丽的爱情' });
};
