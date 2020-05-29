/** TWITTER STREAM **/
module.exports = function (twitter) {

	var track = require("../../app/lib/track.js");
	var trackWords = track.getWords();
	trackWords = '["gentuza","mermao","puto facha","puta facha","puta fascista","puto fascista","hijo de puta","hija de puta","hijadeputa","hijoputa","hijaputa","hijasdeputa","hijodeputa","hijosdeputa","asco de gente","ascazo de gente","puta feminazi","maldita feminazi","das asco","imbécil","gilipollas","malnacido","malnacida","payaso","payasa","bastardo","bastarda","eres asqueroso","eres asquerosa","idiota","maricón","niñato","niñata","eres muy tonto","tú eres tonto","tú eres tonta","eres muy tonta","sois basura","eres basura","miserable","cabron","impresentable","vomitivo","vomitiva","calaña","indeseable","peperro","alimaña","estúpido","cantamañanas","tipejo","tipeja","gente repugnante","persona repugnante","mamarracho","mamarracha","sinverguenza","subnormal","eres un mierda","eres una mierda","bocachancla","lameculos","parguela","cenutrio","tolai","malfollao","malfollado","mal follado","mal follao","malfollada","malfolla","de los cojones","panoli","cagalindes","eres retrasado","eres retrasada","sabandija","lerdo","retrasado mental","mongolo","mongola","cretino","ojalá sufras","ojalá mueras","muérete","separrata","puto comunista","puto nazi","puta nazi","izmierda","puto negro","puta negra","puto baboso","tiene puta idea","tienes puta idea","tienen puta idea","eres desgraciado","eres desgraciada","eres lerdo","eres lerda","es lerdo","es lerda","inepto","eres mentiroso","eres mentirosa","eres cobarde","eres hipócrita","eres impresentable","eres falso","eres cerdo","eres cerda","vete tomar por culo","hdlgp","eres mierda","sois mierda","eres alimaña","eres canalla","menudo canalla","menuda alimaña"]';
	var twitterStream;
	console.log(trackWords);

	if (global.lang === 'es') {
		twitterStream = twitter.stream('statuses/filter', {
			track: trackWords,
			language: 'es',
			place: 'Spain'
		});
	} else {
		twitterStream = twitter.stream('statuses/filter', {
			track: trackWords,
			language: 'en'
		});
	}

	return twitterStream;
};