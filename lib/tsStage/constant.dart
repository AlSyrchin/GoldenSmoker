import 'package:flutter/material.dart';

const t14w500 = TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: mainFon);
const t16w400 = TextStyle(fontSize: 16, fontWeight: FontWeight.w400);
const t20w400 = TextStyle(fontSize: 20, color: mainFon);
const t20w400w = TextStyle(fontSize: 20, color: white);
const t20w500 = TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: mainFon);
const t24w500 = TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: mainFon);
const t24w500a = TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: amber);
const t24w700 = TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: mainFon);
const t24w700w = TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: white);
const t26w500 = TextStyle(fontSize: 26, fontWeight: FontWeight.w500, color: mainFon);
const t29w500w = TextStyle(fontSize: 29, fontWeight: FontWeight.w500, color: white);
const t32w500 = TextStyle(fontSize: 32, fontWeight: FontWeight.w500, color: mainFon);
const t32w700a = TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: amber);
const t46w700 = TextStyle(fontSize: 46, fontWeight: FontWeight.w700);
const t56w700 = TextStyle(fontSize: 56, fontWeight: FontWeight.w700, color: mainFon);
const t56w500g = TextStyle(fontSize: 56, fontWeight: FontWeight.w700, color: mainFon04);
const t62w500 = TextStyle(fontSize: 62, fontWeight: FontWeight.w500, color: mainFon);

const stWidg = VisualDensity(horizontal: 0, vertical: -4);

const Color mainFon = Color.fromRGBO(31, 10, 9, 1);
const Color white = Color.fromRGBO(255, 255, 255, 1);
const Color amber = Color.fromRGBO(255, 193, 7, 1);
const Color noActive = Color.fromRGBO(179, 179, 179, 1);
const Color mainFon04 = Color.fromRGBO(31, 10, 9, 0.4);
const Color white02 = Color.fromRGBO(255, 255, 255, 0.2);
const Color white06 = Color.fromRGBO(255, 255, 255, 0.6);

const String indicate = '°';

List<String> etapName = ['Отепление','Сушка','Варка', 'Копчение', 'Жарка', 'Универсальный'];


double h(context, double height){
  return MediaQuery.of(context).size.height * height/990; 
}
double w(context, double width){
  return MediaQuery.of(context).size.width * width/1440; 
}

const svgBookRecipe = '''<svg xmlns="http://www.w3.org/2000/svg" width="181" height="221" viewBox="0 0 181 221" fill="none">
  <filter id="filter0_d_106_1889" x="0.553467" y="0.396423" width="180.152" height="220.584" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
      <feFlood flood-opacity="0" result="BackgroundImageFix"/>
      <feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
      <feOffset dy="3"/>
      <feGaussianBlur stdDeviation="1.5"/>
      <feComposite in2="hardAlpha" operator="out"/>
      <feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.13 0"/>
      <feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow_106_1889"/>
      <feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow_106_1889" result="shape"/>
    </filter>
    <linearGradient id="paint0_linear_106_1889" x1="90.6294" y1="0.396423" x2="90.6294" y2="214.981" gradientUnits="userSpaceOnUse">
      <stop stop-color="#FDD443"/>
      <stop offset="1" stop-color="#EF9D1A"/>
    </linearGradient>
    <linearGradient id="paint1_linear_106_1889" x1="90.6294" y1="0.396423" x2="90.6294" y2="214.981" gradientUnits="userSpaceOnUse">
      <stop stop-color="white"/>
      <stop offset="1" stop-color="#F2AB24" stop-opacity="0"/>
    </linearGradient>
  <g filter="url(#filter0_d_106_1889)">
    <path fill-rule="evenodd" clip-rule="evenodd" d="M176.605 189.156C176.824 205.88 167.571 213.49 147.608 214.256C102.136 216.063 49.9365 213.983 32.9394 213.49C12.5099 212.888 3.31118 201.747 3.55831 184.092C3.80544 166.437 6.85339 2.36723 6.85339 2.36723C6.85339 2.36723 77.8623 0.971242 120.396 0.396423C131.078 0.396423 143.132 5.54242 143.819 22.2943C144.89 48.079 144.945 143.69 145.329 165.725C145.549 177.796 138.437 186.857 123.06 187.212C90.9877 187.979 44.8566 186.555 20.4181 185.652C22.1755 193.864 27.53 197.121 39.1452 197.121C55.0164 197.121 159.965 196.793 159.965 196.793L161.063 45.0133L154.912 32.6684L155.461 19.2833C156.475 19.5957 157.513 19.8246 158.564 19.9676C168.12 21.0625 176.66 25.8253 177.374 42.6866C178.527 68.5808 176.275 164.11 176.605 189.156ZM115.207 89.028V73.59L33.7083 73.1246V88.5626L115.207 89.028ZM88.434 54.7305V39.2925L34.9988 38.225L32.4177 54.0188L88.434 54.7305Z" fill="url(#paint0_linear_106_1889)"/>
    <path d="M147.57 213.257L147.568 213.257C107.207 214.861 61.5348 213.399 39.9159 212.707C37.2017 212.62 34.8667 212.545 32.9689 212.49C22.9254 212.194 15.8053 209.315 11.2195 204.496C6.63225 199.676 4.43702 192.764 4.55821 184.106C4.68174 175.281 5.50544 129.853 6.29836 86.6273C6.6948 65.0152 7.08351 43.9548 7.37312 28.2975C7.51792 20.4688 7.63795 13.9909 7.72177 9.47012L7.81893 4.23268L7.83535 3.34821L10.007 3.30594C12.0317 3.26664 14.9715 3.20987 18.6322 3.13995C25.9537 3.00009 36.1587 2.80764 47.6928 2.59722C70.7592 2.17642 99.1393 1.68381 120.403 1.39642C125.6 1.3975 131.044 2.65272 135.249 5.85868C139.42 9.03801 142.487 14.2208 142.82 22.3352L142.82 22.3358C143.519 39.1806 143.785 85.8243 143.992 122.288C144.102 141.62 144.196 158.09 144.329 165.743L144.329 165.743C144.435 171.58 142.771 176.584 139.322 180.169C135.877 183.751 130.532 186.039 123.037 186.213L123.036 186.213C90.9981 186.978 44.8953 185.556 20.4551 184.653L19.1715 184.605L19.4403 185.861C20.3606 190.162 22.2621 193.3 25.5633 195.319C28.8086 197.304 33.2738 198.121 39.1452 198.121C47.0827 198.121 77.2896 198.039 105.51 197.957C119.62 197.916 133.235 197.875 143.322 197.844C148.365 197.829 152.527 197.816 155.427 197.807L158.785 197.796L159.666 197.794L159.892 197.793L159.949 197.793L159.963 197.793L159.967 197.793C159.967 197.793 159.968 197.793 159.965 196.793L159.968 197.793L160.957 197.79L160.965 196.8L162.063 45.0205L162.065 44.7814L161.958 44.5673L155.922 32.4525L156.409 20.5792C157.075 20.7394 157.75 20.866 158.429 20.9585L158.44 20.9599L158.45 20.9611C163.111 21.4951 167.38 22.9084 170.576 26.1201C173.764 29.3241 176.024 34.4591 176.375 42.729L176.375 42.7311C176.95 55.6422 176.676 85.9615 176.298 116.227C176.222 122.323 176.142 128.416 176.063 134.362C175.753 157.91 175.473 179.157 175.605 189.169C175.712 197.341 173.51 203.095 169.025 206.93C164.496 210.804 157.463 212.877 147.57 213.257ZM115.201 90.0279L116.207 90.0337V89.028V73.59V72.5957L115.212 72.59L33.714 72.1247L32.7083 72.1189V73.1246V88.5626V89.5569L33.7026 89.5626L115.201 90.0279ZM88.4213 55.7304L89.434 55.7432V54.7305V39.2925V38.3123L88.454 38.2927L35.0188 37.2252L34.1518 37.2078L34.0119 38.0637L31.4308 53.8575L31.2434 55.0039L32.405 55.0187L88.4213 55.7304Z" stroke="url(#paint1_linear_106_1889)" stroke-opacity="0.27" stroke-width="2"/>
  </g>
  <defs>
    
  </defs>
</svg>
''';

const svgDirectControl = '''<svg xmlns="http://www.w3.org/2000/svg" width="153" height="223" viewBox="0 0 153 223" fill="none">
 <filter id="filter0_d_106_1878" x="-3" y="0" width="188" height="229" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
      <feFlood flood-opacity="0" result="BackgroundImageFix"/>
      <feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
      <feOffset dy="3"/>
      <feGaussianBlur stdDeviation="1.5"/>
      <feComposite in2="hardAlpha" operator="out"/>
      <feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.13 0"/>
      <feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow_106_1878"/>
      <feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow_106_1878" result="shape"/>
    </filter>
    <linearGradient id="paint0_linear_106_1878" x1="91" y1="0" x2="91" y2="223" gradientUnits="userSpaceOnUse">
      <stop stop-color="#FDD443"/>
      <stop offset="1" stop-color="#EF9D1A"/>
    </linearGradient>
    <linearGradient id="paint1_linear_106_1878" x1="91" y1="0" x2="91" y2="223" gradientUnits="userSpaceOnUse">
      <stop stop-color="white"/>
      <stop offset="1" stop-color="#F2AB24" stop-opacity="0"/>
    </linearGradient>
  <g clip-path="url(#clip0_106_1878)">
    <g filter="url(#filter0_d_106_1878)">
      <mask id="path-2-inside-1_106_1878" fill="white">
        <path fill-rule="evenodd" clip-rule="evenodd" d="M182 215.019L148.941 223L127.221 184.875C124.49 184.39 121.697 183.815 118.874 183.087C112.19 181.375 105.637 179.208 99.2632 176.602L60.5074 201.028L23.2721 163.146L45.8926 129.083C41.2641 119.541 38.3664 109.287 37.3284 98.7775L0 78.7455L14.1184 32.0751L54.0223 33.3782C60.326 23.7799 68.296 15.3294 77.5736 8.4065L77.1524 0H142C164.091 0 182 17.9086 182 40V61.7666C175.664 51.5323 165.157 43.2563 149.841 39.3181C83.9347 22.3773 51.3227 121.143 127.5 140.69C152.796 147.246 172.056 135.578 182 117.974V215.019Z"/>
      </mask>
      <path fill-rule="evenodd" clip-rule="evenodd" d="M182 215.019L148.941 223L127.221 184.875C124.49 184.39 121.697 183.815 118.874 183.087C112.19 181.375 105.637 179.208 99.2632 176.602L60.5074 201.028L23.2721 163.146L45.8926 129.083C41.2641 119.541 38.3664 109.287 37.3284 98.7775L0 78.7455L14.1184 32.0751L54.0223 33.3782C60.326 23.7799 68.296 15.3294 77.5736 8.4065L77.1524 0H142C164.091 0 182 17.9086 182 40V61.7666C175.664 51.5323 165.157 43.2563 149.841 39.3181C83.9347 22.3773 51.3227 121.143 127.5 140.69C152.796 147.246 172.056 135.578 182 117.974V215.019Z" fill="url(#paint0_linear_106_1878)"/>
      <path d="M182 215.019L182.469 216.963L184 216.594V215.019H182ZM148.941 223L147.204 223.99L147.948 225.297L149.411 224.944L148.941 223ZM127.221 184.875L128.958 183.885L128.494 183.07L127.57 182.906L127.221 184.875ZM118.874 183.087L119.373 181.151L119.37 181.15L118.874 183.087ZM99.2632 176.602L100.02 174.751L99.0675 174.361L98.1968 174.91L99.2632 176.602ZM60.5074 201.028L59.0811 202.43L60.2106 203.579L61.5738 202.72L60.5074 201.028ZM23.2721 163.146L21.606 162.04L20.7085 163.391L21.8458 164.548L23.2721 163.146ZM45.8926 129.083L47.5587 130.189L48.1905 129.238L47.692 128.21L45.8926 129.083ZM37.3284 98.7775L39.3187 98.5809L39.2139 97.5195L38.2741 97.0152L37.3284 98.7775ZM0 78.7455L-1.91432 78.1664L-2.38841 79.7336L-0.94571 80.5078L0 78.7455ZM14.1184 32.0751L14.1837 30.0761L12.6488 30.026L12.2041 31.496L14.1184 32.0751ZM54.0223 33.3782L53.957 35.3771L55.0782 35.4138L55.694 34.4761L54.0223 33.3782ZM77.5736 8.4065L78.7697 10.0094L79.6245 9.3716L79.5711 8.30641L77.5736 8.4065ZM77.1524 0V-2H75.0497L75.1549 0.100093L77.1524 0ZM182 61.7666L180.299 62.8193L184 68.797V61.7666H182ZM149.841 39.3181L150.339 37.3811L150.339 37.3811L149.841 39.3181ZM127.5 140.69L128.002 138.754L127.997 138.753L127.5 140.69ZM182 117.974H184V110.367L180.259 116.991L182 117.974ZM181.531 213.075L148.472 221.055L149.411 224.944L182.469 216.963L181.531 213.075ZM150.679 222.01L128.958 183.885L125.483 185.865L147.204 223.99L150.679 222.01ZM127.57 182.906C124.876 182.428 122.135 181.862 119.373 181.151L118.375 185.024C121.26 185.767 124.104 186.353 126.871 186.845L127.57 182.906ZM119.37 181.15C112.775 179.46 106.309 177.322 100.02 174.751L98.5064 178.453C104.965 181.094 111.605 183.29 118.377 185.025L119.37 181.15ZM98.1968 174.91L59.441 199.336L61.5738 202.72L100.33 178.294L98.1968 174.91ZM61.9338 199.626L24.6984 161.744L21.8458 164.548L59.0811 202.43L61.9338 199.626ZM24.9382 164.253L47.5587 130.189L44.2265 127.977L21.606 162.04L24.9382 164.253ZM47.692 128.21C43.1662 118.88 40.3335 108.855 39.3187 98.5809L35.3381 98.974C36.3994 109.72 39.3621 120.202 44.0931 129.956L47.692 128.21ZM38.2741 97.0152L0.94571 76.9832L-0.94571 80.5078L36.3827 100.54L38.2741 97.0152ZM1.91432 79.3246L16.0327 32.6542L12.2041 31.496L-1.91432 78.1664L1.91432 79.3246ZM14.0531 34.074L53.957 35.3771L54.0875 31.3793L14.1837 30.0761L14.0531 34.074ZM55.694 34.4761C61.8688 25.0742 69.6772 16.7941 78.7697 10.0094L76.3775 6.80357C66.9147 13.8646 58.7833 22.4857 52.3506 32.2803L55.694 34.4761ZM79.5711 8.30641L79.1499 -0.100093L75.1549 0.100093L75.5761 8.50659L79.5711 8.30641ZM77.1524 2H142V-2H77.1524V2ZM142 2C162.987 2 180 19.0132 180 40H184C184 16.804 165.196 -2 142 -2V2ZM180 40V61.7666H184V40H180ZM183.701 60.7139C177.078 50.0166 166.126 41.4406 150.339 37.3811L149.343 41.2551C164.187 45.0719 174.251 53.048 180.299 62.8193L183.701 60.7139ZM150.339 37.3811C116.161 28.5959 90.5709 49.896 83.4605 75.7915C79.9037 88.7455 80.9282 102.947 87.8435 115.205C94.7745 127.49 107.511 137.626 127.003 142.627L127.997 138.753C109.4 133.981 97.6469 124.441 91.3273 113.239C84.9921 102.01 84.0055 88.9139 87.3178 76.8506C93.9458 52.7118 117.614 33.0995 149.343 41.2551L150.339 37.3811ZM126.998 142.626C153.282 149.438 173.411 137.247 183.741 118.958L180.259 116.991C170.702 133.91 152.311 145.054 128.002 138.754L126.998 142.626ZM180 117.974V215.019H184V117.974H180Z" fill="url(#paint1_linear_106_1878)" fill-opacity="0.27" mask="url(#path-2-inside-1_106_1878)"/>
    </g>
  </g>
  <defs>
    
    <clipPath id="clip0_106_1878">
      <path d="M0 20C0 8.9543 8.95431 0 20 0H133C144.046 0 153 8.9543 153 20V203C153 214.046 144.046 223 133 223H20C8.9543 223 0 214.046 0 203V20Z" fill="white"/>
    </clipPath>
  </defs>
</svg>''';

const svgCreateRecipe = '''<svg xmlns="http://www.w3.org/2000/svg" width="87" height="75" viewBox="0 0 87 75" fill="none">

  <filter id="filter0_d_106_1890" x="-3" y="-16.501" width="98.2957" height="97.5" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
      <feFlood flood-opacity="0" result="BackgroundImageFix"/>
      <feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
      <feOffset dy="3"/>
      <feGaussianBlur stdDeviation="1.5"/>
      <feComposite in2="hardAlpha" operator="out"/>
      <feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.13 0"/>
      <feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow_106_1890"/>
      <feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow_106_1890" result="shape"/>
    </filter>
    <linearGradient id="paint0_linear_106_1890" x1="46.1478" y1="-16.501" x2="46.1478" y2="74.999" gradientUnits="userSpaceOnUse">
      <stop stop-color="#FDD443"/>
      <stop offset="1" stop-color="#EF9D1A"/>
    </linearGradient>
    <linearGradient id="paint1_linear_106_1890" x1="46.1478" y1="-16.501" x2="46.1478" y2="74.999" gradientUnits="userSpaceOnUse">
      <stop stop-color="white"/>
      <stop offset="1" stop-color="#F2AB24" stop-opacity="0"/>
    </linearGradient>
  <g clip-path="url(#clip0_106_1890)">
    <g filter="url(#filter0_d_106_1890)">
      <mask id="path-2-inside-1_106_1890" fill="white">
        <path fill-rule="evenodd" clip-rule="evenodd" d="M57.4957 -16.501H34.8V18.0003H0V40.5003H34.8V74.999H57.4957V40.5003H92.2957V18.0003H57.4957V-16.501Z"/>
      </mask>
      <path fill-rule="evenodd" clip-rule="evenodd" d="M57.4957 -16.501H34.8V18.0003H0V40.5003H34.8V74.999H57.4957V40.5003H92.2957V18.0003H57.4957V-16.501Z" fill="url(#paint0_linear_106_1890)"/>
      <path d="M34.8 -16.501V-18.501H32.8V-16.501H34.8ZM57.4957 -16.501H59.4957V-18.501H57.4957V-16.501ZM34.8 18.0003V20.0003H36.8V18.0003H34.8ZM0 18.0003V16.0003H-2V18.0003H0ZM0 40.5003H-2V42.5003H0V40.5003ZM34.8 40.5003H36.8V38.5003H34.8V40.5003ZM34.8 74.999H32.8V76.999H34.8V74.999ZM57.4957 74.999V76.999H59.4957V74.999H57.4957ZM57.4957 40.5003V38.5003H55.4957V40.5003H57.4957ZM92.2957 40.5003V42.5003H94.2957V40.5003H92.2957ZM92.2957 18.0003H94.2957V16.0003H92.2957V18.0003ZM57.4957 18.0003H55.4957V20.0003H57.4957V18.0003ZM34.8 -14.501H57.4957V-18.501H34.8V-14.501ZM36.8 18.0003V-16.501H32.8V18.0003H36.8ZM0 20.0003H34.8V16.0003H0V20.0003ZM2 40.5003V18.0003H-2V40.5003H2ZM34.8 38.5003H0V42.5003H34.8V38.5003ZM36.8 74.999V40.5003H32.8V74.999H36.8ZM57.4957 72.999H34.8V76.999H57.4957V72.999ZM55.4957 40.5003V74.999H59.4957V40.5003H55.4957ZM92.2957 38.5003H57.4957V42.5003H92.2957V38.5003ZM90.2957 18.0003V40.5003H94.2957V18.0003H90.2957ZM57.4957 20.0003H92.2957V16.0003H57.4957V20.0003ZM55.4957 -16.501V18.0003H59.4957V-16.501H55.4957Z" fill="url(#paint1_linear_106_1890)" fill-opacity="0.27" mask="url(#path-2-inside-1_106_1890)"/>
    </g>
  </g>
  <defs>
    
    <clipPath id="clip0_106_1890">
      <path d="M0 0H63C76.2548 0 87 10.7452 87 24V75H0V0Z" fill="white"/>
    </clipPath>
  </defs>
</svg>''';

const svgRectanle = '''<svg xmlns="http://www.w3.org/2000/svg" width="103" height="26" viewBox="0 0 103 26" fill="none">
      <linearGradient id="paint0_linear_106_1895" x1="51.5" y1="0" x2="51.5" y2="26" gradientUnits="userSpaceOnUse">
      <stop stop-color="#FDD443"/>
      <stop offset="1" stop-color="#EF9D1A"/>
    </linearGradient>
    <linearGradient id="paint1_linear_106_1895" x1="90.2923" y1="0" x2="90.2923" y2="26" gradientUnits="userSpaceOnUse">
      <stop stop-color="#FDD443"/>
      <stop offset="1" stop-color="#EF9D1A"/>
    </linearGradient>
    <linearGradient id="paint2_linear_106_1895" x1="12.7078" y1="0" x2="12.7078" y2="26" gradientUnits="userSpaceOnUse">
      <stop stop-color="#FDD443"/>
      <stop offset="1" stop-color="#EF9D1A"/>
    </linearGradient>
  <ellipse cx="51.5" cy="13" rx="12.7078" ry="13" fill="url(#paint0_linear_106_1895)"/>
  <ellipse cx="90.2923" cy="13" rx="12.7078" ry="13" fill="url(#paint1_linear_106_1895)"/>
  <ellipse cx="12.7078" cy="13" rx="12.7078" ry="13" fill="url(#paint2_linear_106_1895)"/>
  <defs>
  </defs>
</svg>''';

const svgLamp = '''<svg xmlns="http://www.w3.org/2000/svg" width="29" height="45" viewBox="0 0 29 45" fill="none">
  <linearGradient id="paint0_linear_106_1411" x1="14.5" y1="0" x2="14.5" y2="45" gradientUnits="userSpaceOnUse">
      <stop stop-color="#FDD443"/>
      <stop offset="1" stop-color="#EF9D1A"/>
    </linearGradient>
  <path fill-rule="evenodd" clip-rule="evenodd" d="M20.8604 30.4041H20.2229C20.3514 23.7193 25.758 19.4092 25.758 14.5264C25.758 -0.284913 3.19257 -1.00079 3.19257 14.7782C3.19257 19.9078 8.62884 22.7121 8.73262 30.3695H8.05061C6.568 30.3695 5.55487 29.7919 5.55487 28.7304C5.55487 25.4226 0 19.8831 0 14.9065C0 -5.37012 29 -4.45676 29 14.5807C29 20.13 23.5143 26.4988 23.5143 28.6465C23.4896 29.8314 22.3826 30.4041 20.8604 30.4041ZM12.37 12.7243L13.6796 30.2214L10.9911 30.2856C10.9911 30.2856 10.0571 19.424 9.78033 15.5632C9.50358 11.7024 12.37 12.7243 12.37 12.7243ZM15.2215 30.3004L16.294 12.6552C16.294 12.6552 19.4915 11.1741 19.1604 15.6175C18.8292 20.0609 17.9347 30.2264 17.9347 30.2264L15.2215 30.3004ZM22.2442 32.69C22.2442 32.69 22.1355 35.9336 22.1256 37.3753C22.1256 39.3501 19.017 41.8927 17.6777 42.1099C17.3911 45.951 11.688 45.9757 11.4853 42.1099C10.5365 41.9174 6.97819 39.6858 6.99301 37.4444C6.99301 35.7905 7.09186 32.7393 7.09186 32.7393L22.2442 32.69Z" fill="url(#paint0_linear_106_1411)"/>
  <defs>
  </defs>
</svg>''';