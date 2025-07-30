<!DOCTYPE html>
<html lang="th">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>🐰 Bunny Learn Store ครบในหน้าเดียว</title>
<style>
  @import url('https://fonts.googleapis.com/css2?family=Itim&display=swap');
  body {
    font-family: 'Itim', sans-serif;
    background: linear-gradient(135deg, #ffe9ec, #ffe4f0);
    margin: 0; padding: 20px;
    color: #444;
  }
  header {
    background: white;
    padding: 20px;
    text-align: center;
    border-bottom: 2px dashed #f8bad4;
    border-radius: 20px;
    box-shadow: 0 2px 8px rgba(255, 180, 220, 0.2);
  }
  header h1 {
    margin: 0;
    color: #ff69b4;
    font-size: 28px;
  }
  #coinDisplay {
    color: #e91e63;
    font-size: 16px;
    margin-top: 8px;
    background: #fff0f5;
    padding: 10px;
    border-radius: 12px;
    display: inline-block;
    box-shadow: 0 2px 4px rgba(255,105,180,0.2);
  }
  .form-box, .product, .email-box, #slipCheckSection {
    background: #fff;
    border-radius: 24px;
    padding: 20px;
    margin: 15px auto;
    max-width: 420px;
    box-shadow: 0 6px 16px rgba(255, 182, 193, 0.3);
  }
  input, select, button {
    width: 100%;
    padding: 12px;
    margin: 10px 0;
    border-radius: 14px;
    border: 1px solid #ffc1cc;
    box-sizing: border-box;
    font-family: 'Itim', sans-serif;
    font-size: 16px;
  }
  button, .btn-pink {
    background: linear-gradient(to right, #ffb6c1, #ff69b4);
    color: white;
    border: none;
    cursor: pointer;
    font-weight: bold;
    transition: 0.3s ease;
    box-shadow: 0 4px 8px rgba(255,105,180,0.3);
  }
  button:hover {
    transform: scale(1.02);
    background: linear-gradient(to right, #ffa7ba, #ff4d94);
  }
  button#logoutBtn {
    background: #c0c0c0;
    max-width: 400px;
    margin: 10px auto;
    display: block;
  }
  .product iframe {
    width: 100%;
    height: 200px;
    border: none;
    border-radius: 12px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  }
  .product h2 {
    font-size: 20px;
    margin: 10px 0 5px;
    color: #ff1493;
  }
  .product p {
    font-size: 16px;
    color: #666;
  }
  .link {
    text-align: center;
    margin-top: 10px;
  }
  ul#ordersUl, ul#slipListUl {
    list-style: none;
    padding-left: 0;
    max-width: 400px;
    margin: 0 auto;
  }
  ul#ordersUl li, ul#slipListUl li {
    border-bottom: 1px dashed #ffb6c1;
    padding: 8px 0;
    font-size: 15px;
  }
  img.qr {
    width: 100%;
    max-width: 280px;
    display: block;
    margin: 10px auto;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(255,105,180,0.2);
  }
  .slip-status {
    margin-top: 8px;
    font-weight: bold;
    color: #d81b60;
    background: #ffeef3;
    padding: 6px 10px;
    border-radius: 10px;
    display: inline-block;
  }
  .btn-approve {
    background: #ff69b4;
    margin-top: 6px;
    color: white;
    border: none;
    padding: 6px 10px;
    border-radius: 12px;
    cursor: pointer;
    font-weight: bold;
    transition: background 0.3s ease;
  }
  .btn-approve:hover {
    background: #e0488c;
  }
  .cute-text {
    font-size: 18px;
    color: #ff69b4;
    text-align: center;
    margin-bottom: 10px;
  }
  #emailSection {
    max-width: 420px;
    margin: 15px auto;
  }
  .hidden {
    display: none !important;
  }
</style>
</head>
<body>

<header>
  <h1>🐰 Bunny Learn Store 🐇</h1>
  <div id="coinDisplay" class="hidden">เหรียญของคุณ: <strong id="coinAmount">0</strong> 🪙</div>
</header>

<!-- สมัคร/เข้าสู่ระบบ -->
<div class="form-box" id="authSection">
  <h2 class="cute-text">สมัครสมาชิก / เข้าสู่ระบบ 🐰</h2>
  <input type="text" id="username" placeholder="ชื่อผู้ใช้สุดน่ารักของคุณ" autocomplete="off" />
  <input type="password" id="password" placeholder="กรอกรหัส (สำหรับแอดมินเท่านั้น)" autocomplete="off" />
  <button onclick="signIn()">เข้าสู่ระบบ / สมัครเลย!</button>
  <p style="font-size:14px; color:#999; margin-top: -5px; text-align:center;">
    * ถ้าใส่ชื่อผู้ใช้เป็น <strong>Uniff</strong> ต้องใส่รหัสผ่านแอดมินด้วยนะ
  </p>
</div>

<button id="logoutBtn" class="hidden" onclick="signOut()">ออกจากระบบ 🐇</button>

<!-- เติมเหรียญ -->
<div id="topupSection" class="form-box hidden">
  <h2 class="cute-text">เติมเหรียญน่ารัก ๆ 🐰</h2>
  <p>เลือกจำนวนเหรียญที่อยากเติม (1 เหรียญ = 1 บาท)</p>
  <select id="topupAmount">
    <option value="1">1 เหรียญ (1 บาท)</option>
    <option value="10">10 เหรียญ (10 บาท)</option>
    <option value="20">20 เหรียญ (20 บาท)</option>
    <option value="50">50 เหรียญ (50 บาท)</option>
    <option value="70">70 เหรียญ (70 บาท)</option>
    <option value="100">100 เหรียญ (100 บาท)</option>
  </select>
  <button onclick="startTopUp()">เติมเหรียญเลย!</button>

  <div class="link" style="margin-top: 15px;">
    <p>โปรดโอนเงินตามจำนวนเหรียญที่เลือก เติมเงินแล้วอย่าลืมส่งสลิปชำระเงินนะคะ 🐇💕</p>
    <img src="https://i.postimg.cc/DyfTXMcP/1752133160670.jpg" alt="QR Code ชำระเงิน" class="qr" />
    <input type="file" id="slipFile" accept="image/*" style="margin-top:10px;" />
    <button onclick="uploadSlip()">ส่งสลิปชำระเงิน</button>
    <p id="slipStatus" class="slip-status"></p>
  </div>
</div>

<!-- แอดมินตรวจสอบสลิป -->
<div id="slipCheckSection" class="form-box hidden">
  <h2 class="cute-text">รายการสลิปรอตรวจสอบ (สำหรับแอดมิน) 🐇</h2>
  <ul id="slipListUl"><li>ไม่มีสลิปที่รอตรวจสอบค่ะ</li></ul>
</div>

<!-- ร้านค้า -->
<div id="storeSection" class="hidden">

  <h2 class="cute-text">สินค้าแนะนำสำหรับน้อง ๆ 🐰🎉</h2>

  <div class="product">
    <iframe src="https://drive.google.com/file/d/1uU2mij8I9Vw7iMN7gctJLrnRdnL8cIJU/preview" allow="autoplay"></iframe>
    <h2>ใบงานชุดที่ 1</h2>
    <p>ราคา: 10 เหรียญ</p>
    <button onclick="buyProduct('ใบงานชุดที่ 1', 10)">แลกซื้อเลย!</button>
  </div>

  <div class="product">
    <iframe src="https://drive.google.com/file/d/1MohreVUAwaLZXqNw08Ar2Selsb4Ee8je/preview" allow="autoplay"></iframe>
    <h2>ใบงานชุดที่ 2</h2>
    <p>ราคา: 22 เหรียญ</p>
    <button onclick="buyProduct('ใบงานชุดที่ 2', 22)">แลกซื้อเลย!</button>
  </div>

  <!-- กรอกอีเมลรับไฟล์ -->
  <div class="email-box hidden" id="emailSection">
    <h2 class="cute-text">กรอกอีเมลของคุณเพื่อรับไฟล์ 🐰💌</h2>
    <input type="email" id="emailInput" placeholder="อีเมลของคุณ" autocomplete="off" />
    <button onclick="sendFile()">ส่งไฟล์ให้หนูด้วยค่ะ!</button>
  </div>

  <!-- รายการสั่งซื้อ -->
  <div class="form-box" style="max-width: 600px; margin-top: 30px;">
    <h2 class="cute-text">รายการสั่งซื้อของคุณ 🛒</h2>
    <ul id="ordersUl"><li>ยังไม่มีรายการสั่งซื้อเลยค่ะ</li></ul>
  </div>
</div>

<script>
  let currentUser = null;
  let isAdmin = false;
  let buyingProduct = null;

  // ฟังก์ชันจัดการเหรียญ
  function getCoins() {
    return parseInt(localStorage.getItem('bls_coins_' + currentUser) || '0');
  }
  function setCoins(amount) {
    localStorage.setItem('bls_coins_' + currentUser, amount);
    if (!isAdmin) {
      document.getElementById('coinAmount').innerText = amount;
    }
  }
  function updateCoinDisplay() {
    if (isAdmin) {
      document.getElementById('coinDisplay').classList.add('hidden');
    } else {
      document.getElementById('coinDisplay').classList.remove('hidden');
      document.getElementById('coinAmount').innerText = getCoins();
    }
  }

  // ตรวจสอบสถานะล็อกอิน
  function checkLogin() {
    const user = localStorage.getItem('bls_user');
    const adminFlag = localStorage.getItem('bls_admin') === 'yes';

    if (user) {
      currentUser = user;
      isAdmin = adminFlag;

      document.getElementById('authSection').classList.add('hidden');
      document.getElementById('logoutBtn').classList.remove('hidden');
      document.getElementById('storeSection').classList.remove('hidden');
      document.getElementById('topupSection').classList.remove('hidden');

      loadOrders();
      updateCoinDisplay();
      resetEmailSection();
      resetSlipStatus();

      if (isAdmin) {
        document.getElementById('slipCheckSection').classList.remove('hidden');
        loadSlipChecks();
      } else {
        document.getElementById('slipCheckSection').classList.add('hidden');
      }
    } else {
      currentUser = null;
      isAdmin = false;

      document.getElementById('authSection').classList.remove('hidden');
      document.getElementById('logoutBtn').classList.add('hidden');
      document.getElementById('storeSection').classList.add('hidden');
      document.getElementById('topupSection').classList.add('hidden');
      document.getElementById('emailSection').classList.add('hidden');
      document.getElementById('coinDisplay').classList.add('hidden');
      document.getElementById('slipCheckSection').classList.add('hidden');
    }
  }

  // เข้าสู่ระบบ / สมัครสมาชิก
  function signIn() {
    const usernameInput = document.getElementById('username').value.trim();
    const passwordInput = document.getElementById('password').value.trim();

    if (!usernameInput) {
      alert('กรุณากรอกชื่อผู้ใช้ก่อนนะคะ 🐰');
      return;
    }

    if (usernameInput.toLowerCase() === 'uniff') {
      if (passwordInput !== '090953') {
        alert('รหัสผ่านแอดมินไม่ถูกต้องจ้า ลองใหม่อีกครั้งนะ 🐇');
        return;
      }
      isAdmin = true;
      currentUser = 'admin';
      localStorage.setItem('bls_admin', 'yes');
    } else {
      isAdmin = false;
      currentUser = usernameInput;
      localStorage.removeItem('bls_admin');
    }

    localStorage.setItem('bls_user', currentUser);
    alert(isAdmin ? 'ยินดีต้อนรับแอดมิน Uniff 🐇✨' : `ยินดีต้อนรับคุณ ${currentUser} ค่ะ 🐰💕`);
    checkLogin();
  }

  // ออกจากระบบ
  function signOut() {
    if (confirm('ต้องการออกจากระบบไหมคะ?')) {
      localStorage.removeItem('bls_user');
      localStorage.removeItem('bls_admin');
      currentUser = null;
      isAdmin = false;
      alert('ออกจากระบบเรียบร้อยแล้ว ขอบคุณที่มาเยี่ยมชมค่า 🐰💖');
      checkLogin();
    }
  }

  // โหลดรายการสั่งซื้อ
  function loadOrders() {
    const ordersUl = document.getElementById('ordersUl');
    const orders = JSON.parse(localStorage.getItem('bls_orders') || '[]');
    const displayOrders = isAdmin ? orders : orders.filter(o => o.user === currentUser);

    if (displayOrders.length === 0) {
      ordersUl.innerHTML = '<li>ยังไม่มีรายการสั่งซื้อเลยค่ะ 🐇</li>';
      return;
    }

    ordersUl.innerHTML = '';
    displayOrders.forEach(order => {
      const li = document.createElement('li');
      li.innerHTML = `
        ${isAdmin ? `<strong>ผู้ใช้:</strong> ${order.user}<br>` : ''}
        <strong>สินค้า:</strong> ${order.product}<br>
        <strong>อีเมล:</strong> ${order.email ? order.email : '-'}<br>
        <strong>วันที่สั่งซื้อ:</strong> ${order.timestamp}
      `;
      ordersUl.appendChild(li);
    });
  }

  // เริ่มเติมเหรียญ (แจ้งโอนเงิน)
  function startTopUp() {
    const amount = parseInt(document.getElementById('topupAmount').value);
    alert(`กรุณาโอนเงินจำนวน ${amount} บาทตาม QR Code ด้านล่าง แล้วกดส่งสลิปยืนยันด้วยนะคะ 🐰💖`);
  }

  // รีเซ็ตสถานะสลิป
  function resetSlipStatus() {
    document.getElementById('slipStatus').textContent = '';
  }

  // อัปโหลดสลิป
  function uploadSlip() {
    const slipFileInput = document.getElementById('slipFile');
    const slipFile = slipFileInput.files[0];
    if (!slipFile) {
      alert('กรุณาเลือกไฟล์สลิปก่อนนะคะ 🐰');
      return;
    }

    const amount = parseInt(document.getElementById('topupAmount').value);
    let slips = JSON.parse(localStorage.getItem('bls_slips') || '[]');

    slips.push({
      id: Date.now(),
      user: currentUser,
      amount: amount,
      slipFileName: slipFile.name,
      timestamp: new Date().toLocaleString(),
      status: 'รอตรวจสอบ'
    });

    localStorage.setItem('bls_slips', JSON.stringify(slips));
    document.getElementById('slipStatus').textContent = `ได้รับสลิปเติมเงินจำนวน ${amount} เหรียญแล้วค่ะ 🐰💕 รอตรวจสอบจากแอดมินนะคะ`;

    slipFileInput.value = '';
    loadSlipChecks();
  }

  // โหลดรายการสลิปสำหรับแอดมินตรวจสอบ
  function loadSlipChecks() {
    const slipListUl = document.getElementById('slipListUl');
    if (!isAdmin) {
      slipListUl.innerHTML = '<li>ไม่มีสิทธิ์ดูรายการสลิปค่ะ</li>';
      return;
    }
    let slips = JSON.parse(localStorage.getItem('bls_slips') || '[]');
    let pendingSlips = slips.filter(s => s.status === 'รอตรวจสอบ');

    if (pendingSlips.length === 0) {
      slipListUl.innerHTML = '<li>ไม่มีสลิปที่รอตรวจสอบค่ะ</li>';
      return;
    }

    slipListUl.innerHTML = '';
    pendingSlips.forEach(slip => {
      const li = document.createElement('li');
      li.innerHTML = `
        <strong>ผู้ใช้:</strong> ${slip.user}<br>
        <strong>จำนวน:</strong> ${slip.amount} เหรียญ<br>
        <strong>ชื่อ
