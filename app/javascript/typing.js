import defaultData from './default.js';


// ページ読み込み
document.addEventListener('DOMContentLoaded', () => {
  const word_displayEL = document.getElementById("word-display");
  const word_inputEL = document.getElementById("word-input");
  const countdownEl = document.getElementById("countdown");
  const scoreEL = document.getElementById("score");
  const start_btn = document.getElementById("start-btn");


  // カウントダウン
  function countdown() {
    var seconds = 60;
    var timer = setInterval(() => {
      seconds--;
      if (seconds <= 0) {
        clearInterval(timer);
        countdownEl.textContent = "時間切れ！ゲーム終了です。";
        end_game();
      } else {
        countdownEl.textContent = `残り時間: ${seconds} 秒`;
      }
    }, 1000);
  };
  
  // 作問
  function question(data) {
    var random = Math.floor(Math.random() * data.length);
    var title = data[random]['title']
    var ans = data[random]['answer']
    word_displayEL.textContent = title;
    return ans
  };

  // ゲーム終了
  function end_game() {
    start_btn.textContent = "escキーをおしてね"
    start_btn.style.visibility ="visible";
    word_inputEL.disabled = true;
    window.addEventListener('keydown', reload_page_on_escape);
  };

  // 初期化
  function game_clear() {
    word_displayEL.textContent = '';
    word_inputEL.value = '';
    word_inputEL.style.color = null;
  };

  // ページリロード
  function reload_page_on_escape(event) {
    if (event.key === "Escape") {
      location.reload();
    };
  };

  // ゲームスタート
  function game_start() {
    start_btn.style.visibility ="hidden";
    // モデルアクセス
    const XHR = new XMLHttpRequest();
    XHR.open('GET', '/games/search', true);
    XHR.send();
    XHR.onreadystatechange = function() {
      if(XHR.readyState === 4 && XHR.status === 200) {
        var score = 0
        var data = JSON.parse(XHR.responseText)['games'];

        // データなし、defaultData使用
        if (data.length == 0) {
          data = defaultData;
        };

        countdown();
        game_clear();
        var answer = question(data);
        
        word_inputEL.addEventListener('input', () => {
          word_inputEL.addEventListener('keydown', reload_page_on_escape);

          var len = word_inputEL.value.length

          // 文字判定
          if (len < answer.length &&
              answer.slice(0, len) === word_inputEL.value.slice(0, len)) {
            word_inputEL.style.color = null;
          } else {
            word_inputEL.style.color = 'red';
          };

          // 正解
          if (answer === word_inputEL.value) {
            score += 1
            scoreEL.textContent = score
            game_clear();
            answer = question(data);
          };
        });
      };
    };
  };

  // スタートイベント
  window.addEventListener('keydown', event => {
    if (event.code === 'Space') {
      word_inputEL.focus();
      game_start();
    };
  }, { once: true });
});
