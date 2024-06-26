import 'package:dispatch/model/user_model.dart';
import 'package:dispatch/provider/auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

const line_url = "https://line.me/R/ti/p/@226vhgtj";
const line_voom_url =
    "https://linevoom.line.me/user/_dZh2FZ05TpGWYIhKW0pM6TdHizqfWioKmTmFYEs";

const base_api = "https://bizworks.bancheng.tech/backend/";

const oem_image_path =
    "https://bizworks.bancheng.tech/backend/uploads/oem_images/";

String CUSTOMER = "customer";
String DESIGNER = "designer";
String WORKER = "worker";

String tmpSVG = "";

String PENDING = "pending";
String MATCHING = "matching";
String PROCESSING = "processing";
String COMPLETED = "completed";

Color primaryTextColor = const Color(0xFF0063A2);

final GoogleSignIn googleSignIn = GoogleSignIn();

const String KEY_LOGIN_TYPE = "KEY_LOGIN_TYPE";
const String KEY_PHONE = "KEY_PHONE";
const String KEY_PASSWORD = "KEY_PASSWORD";
const String KEY_SOCIAL_ID = "KEY_SOCIAL_ID";
const String KEY_USERDATA = "KEY_USERDATA";
const String KEY_PRICE_REQUESTED = "KEY_PRICE_REQUESTED";

const String KEY_FCM_TOKEN = 'KEY_FCM_TOKEN';
const String KEY_ACCESS_TOKEN = 'KEY_ACCESS_TOKEN';
const String KEY_NOTIFICATION_COUNT = "KEY_NOTIFICATION_COUNT";

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

String getRequestNumber(int number) {
  return "TR${100000000 + number}";
}

String getDateStringFromDB(String date) {
  return (DateTime.fromMillisecondsSinceEpoch(int.parse(date) * 1000))
      .toString()
      .split(" ")
      .first;
}

bool isMatchingExpire(String date) {
  /*return DateTime.fromMillisecondsSinceEpoch(int.parse(date) * 1000)
      .add(Duration(hours: 8))
      .isBefore(DateTime.now());*/
  return false;
}

String getRoleString(String role) {
  switch (role) {
    case 'admin':
      return "管理員";
    case 'designer':
      return "設計師";
    case 'customer':
      return "直客";
    case 'worker':
      return "師傅";
  }
  return "";
}



UserModel getCurrentUser(BuildContext context) {
  return Provider.of<Auth>(context).currentUser;
}

String legal = """
<bold>BizWorks用戶條款</bold>

壹、引言
歡迎您使用BizWorks(下稱本平台)進行下單！當您安裝或使用本軟體時，即視為您已完整閱讀並同意接受本服務協議及本平台公告之其他一切條款、規定及政策等所有內容，始得使用本平台。本平台公告之其他一切條款、規定及政策等所有內容均視為本服務協議之一部分，與本服務協議具有同等法律效力。您同意本平台有權於任何時間修改或變更本服務協議之內容，建議您隨時注意該等修改及變更。您於任何修改或變更後繼續使用本服務者，視為您已閱讀、瞭解並同意接受該等修改及變更。為保障您自身權益，建議仔細閱讀各條款，若您不同意本協議及本平台公告之任一條款、規定及政策之內容，請勿安裝本軟體，如您已安裝本軟體，請立即登出並停止使用本平台提供之任何服務，並將它從您之裝置中移除。
本平台提供之第三方服務包括OOO等服務，前揭服務之提供者，無論係法人或自然人，以下均簡稱為「師傅」。

貳、使用資格
如您為自然人，您須年滿18 歲，方能註冊本平台之帳戶。若您未滿18歲，您應於父母或法定代理人之陪同下一同審閱本協議，並確定您與法定代理人均充分瞭解並同意本協議。

參、帳號及密碼
一、 為使用本平台之服務，您將需於本平台中建立一帳戶，需填寫您之姓名（或法人名稱）、email(電子發票)、場勘或施工地址等資料。您保證在本平台申請註冊帳戶時，提供真實、完整、正確且最新之資訊，倘該等資訊有任何變更或過期，您應立即更新，若因您所提供之資訊不真實、不正確、不完整或已過期，導致您未能收受任何與本平台相關之資訊（包括但不限於本協議之修訂）、您因此無法使用本平台之服務，應由您自行負擔一切損失及因此所生或相關之一切損害賠償責任。
二、 您應遵守本平台為建立使用者帳號及密碼所訂定之規則及程序，您之會員帳號僅限本人使用，不得授權第三人或將帳號轉讓予第三人，您對帳號及密碼負有保密義務，應妥善保管，於使用完本平台提供之各項服務功能後，務必登出帳戶，若與他人共享電腦或使用公共電腦，務必登出及關閉瀏覽視窗，若因您之疏忽導致該帳號、密碼遭他人非法使用，致本平台、本平台所屬公司或他人受有損害時，您需自行負責一切損害賠償責任，並自行承擔一切損失。
三、 若您發現會員帳號內之個人資料遭他人非法使用或有任何異常情形時，應立即通知本平台，本平台有權針對該帳號進行必要之處理措施。

肆、服務流程規範
一、派遣費用：您了解並同意，當您使用本服務媒合成功後本平台將會收取一筆新臺幣300元派遣費用，此派遣費用僅包含一次媒合機會，若您於同一時間需要兩種以上服務或位於不同地址時，您不得於一次媒合服務要求師傅提供多次或多點服務，您需要將兩個不同地址之服務分別下單媒合，媒合成功後若您同意師傅之報價，派遣費可以折抵施工費用，於支付尾款時扣抵，若您不同意師傅之報價，本平台仍然會支付師傅車馬費用，故縱令媒合成功您與師傅未能就施工費用或方式等達成合意，平台將不會退還派遣費。
二、平台服務費用：您了解並同意，為了改善台灣修繕市場長期不開立發票之陋習，每個案件平台皆會開立電子發票寄至您之信箱，您所同意之師傅報價會另加5%之稅金，施工期間費用如有增減亦同。
三、訂金：若師傅報價單之金額超過新台幣伍萬元整，您同意於施工前支付30%金額作為服務之訂金，並於竣
工後，支付剩餘70%之金額(可扣除派遣費)。
四、 本平台透過媒合或許願牆之方式尋找師傅，您可以透過平台所提供之通話與訊息功能與師傅進行必要之溝通與相關確認(如報價、勘場時間、地址等)，您了解並同意，為了保護雙方之權益，如果您點選「我同意」或類似語意之選項、或在本平台線上進行訂購、付款、消費或其他消費相關行為，就視為您事先已經詳閱本協議及本平台公告之一切條款、規定及政策，並同意所有內容，若您不同意，請勿使用本平台服務。
五、師傅施工方式與施工內容須依據專案報價單確切執行，在未經您之同意，不得擅自變換施工方式，應依專案契約遵守施工與完工日期，施工中如有工項增減、備料等因素，須修改報價單，亦應事前取得您之同意，始得為之，任何臨時變更皆須與您做確認，不得自行變更。若因未能遵守約定日期或違反前揭規定，導致您取消契約之狀況，師傅應自行承擔師傅端之損失。
六、本平台絕對禁止私下交易，本協議所有款項皆須全程使用本平台以信用卡或匯款方式進行支付，任何透過非平台系統對應產生之交易均屬於私下交易，任何與師傅協議私下之接洽皆為不允許之行為，所有私下接洽除了無法享受本平台提供之所有之權利、服務與相關保險外，平台亦不保障任何後續問題，同時您將失去繼續使用平台之資格，本平台亦將就前揭損失請求損害賠償。師傅若有任何私下接案之要求，您應予以拒絕並立即通知客服人員，公司亦將停止師傅繼續使用平台之權利。
七、師傅應透過本平台通知完工 ，請您務必於通知完工後三日內進行驗收，若逾期未驗收者，視為驗收完成。若於驗收時，認為有未符合報價單所提供之服務項目，請於三日內向師傅提出具體改善需求，不得以任何原因拖延改善服務及驗收時間。經驗收後您提出之改善需求，師傅應依照與您協商約定之期間內進行改善，並依前揭方式再行驗收，若因您單方因素拖延驗收時間，本平台亦得以自通知驗收後第四日開始，每日依其工程款2 ‰計算延遲服務費用，並應於支付費用時同時加計支付，如因此衍生並進行法律相關催收程序時，因此程序所產生之相關費用亦將由您全數負擔。
八、 您於本平台內發表之言論、意見、評論等，不論為公開或非公開，均應自負責任，且不得有以下情形：
(一)侵害他人之智慧財產權、人格權、隱私權或其他權利者。
(二)內容構成犯罪或煽惑他人犯罪者。
(三)錯誤、意圖誤導、虛假和不正確之資訊。
(四)違反公共秩序與善良風俗。
(五)廣告、廣告連結、宣傳、商業性訊息、垃圾訊息、騷擾訊息。
(六)攻擊性、歧視性、誹謗、侮辱、不雅、猥褻、性騷擾、性暗示或其他引人厭惡之內容。
(七)與本平台作品或服務之內容無正當合理關聯性者。
(八)其他一切違法或不正當之內容。
若有上述情事，本平台有權逕行刪除貼文，並保留相關法律責任之追訴權利。
九、保固說明：
(一)本平台將依據第三方服務項目性質，設定不同之保固天數。
(二)在保固期間內，如因施工不良、材料不當或其他非人為因素所造成之損害情形發生，經雙方會同察看確認後，應由師傅負擔全部保固責任。
(三)因天災或不可抗力事變、材料自然、您個人使用不當、未善盡保管之責及消耗性物品等，所導致之損害，不屬於保固範圍內。
(四)每一派案之保固期間皆記錄於APP上，恕不另外提供紙本保固書。

伍、爭議審查
當您與師傅媒合及施工過程中，若遭遇到有爭議情況，您與師傅均可提交爭議審查申請，平台將依據爭議審查規章，針對不同工項實際情形，做出最妥適裁決，如任一方未能接受裁決結果，應於本平台發送裁決通知後十日內，提出已採取法律相關途徑之證明文件，本平台就已收取尚未匯款予師傅或尚未退款予您之款項，將保留至雙方法律爭議確定後(判決確定或和解時)，依其結果匯款予您或師傅，並將酌收平台作業費。您同意如未能於十日內提出已採取法律相關途徑之證明文件，視為對於裁決結果無異議，本平台將依照現有文件及裁決結果，逕予撥付款項，另酌收平台作業費。

陸、智慧財產權
一、本平台或本平台所屬公司所使用之軟體、程式、或網站之所有內容，包括但不限於著作、圖片、檔案、資訊、資料、網站架構、網站畫面之安排、網頁設計，均係由本平台所屬公司或其他權利人依法擁有之智慧財產權，包括但不限於商標權、專利權、著作權、營業秘密與專有技術等。
二、前項內容，您不得逕自使用、修改、重製、公開播送、編輯、改作、出租、散布、發行、公開發表、進行還原工程、解編。若您欲引用或轉載前述軟體、程式或網站內容，必須依法取得本平台所屬公司或其他權利人之事前書面同意。如有違反，您應對本平台所屬公司及其相關公司、及其董監事、受僱人、及代理商負損害賠償責任（包括但不限於訴訟費用及律師費用等）。

柒、免責聲明
一、本平台於任何情況下，均不保證經由本平台及網頁所呈現之資訊或建議係安全、無誤，或得在任何特定時間、地點進行存取，或將更正缺陷或錯誤，或您得透過存取或使用本平台及網頁內容，達到符合您要求之特定結果，亦不保證您會被通知或您將取得本平台及網頁內容之最新版本。
二、本平台得不經通知，變更本平台及網頁內容之所有資訊。本平台不保證且無法確保您自本平台及網頁所接收或下載之任何內容皆未含有電腦病毒，或其他有害或具破壞性之成分。
三、本平台茲聲明，不因您使用或存取本平台及網頁、或第三方連結有關之任何行為、債務不履行、錯誤、中斷、瑕疵、運作或傳輸延遲、惡意軟體、第三方未經授權之存取，所致任何及所有損害、責任或傷害負責。
四、您了解並同意，免除本平台及師傅提供之信息錯誤對您所造之困擾及責任，如遇本平台及任何第三方修繕服務提供者提供之信息有誤，煩請您不吝於透過本平台之聯絡信箱告知本平台，本平台將盡快調整相關錯漏。本平台不承擔任何現行法律允許範圍下有關之服務和商品供應之責任。這並不影響您作為消費者之法定權利。
五、您了解並同意，本平台僅為媒合您與第三方師傅之服務，非服務之提供者，本平台對於師傅施工之正確性、品質、材料、時間、完成性等不負任何擔保責任，若師傅施工時產生之任何損失，本平台僅以所投保之國泰產險之營造綜合保險及寵物美容服務之公共意外責任保險所核定之賠償金額為限 ，其他所產生之額外費用，本平台概不負責，本平台不承擔您任何直接、間接損害及所失利益。
六、本平台對於師傅之資格，固經由證照合格之過濾及篩選，惟仍不排除可能遭第三人提供虛假資訊、名實不符等情形，您仍應隨時保持警覺，注意自身權益與安全，本平台恕不為任何師傅之延誤、疏忽等行為，與因不可抗力因素影響造成之延遲或疏忽負責，但本平台將盡可能提供協調雙方之協助。
七、本平台所提供之服務或產品僅提供給個人或消費者使用，不得作為商業使用。因此，訂單中之任何
間接損失、數據遺失、收入或利潤之損失、損失之財產或使用本網站而產生之第三方索賠損失之損害之責任，本平台恕不承擔。
八、因不可抗力之事件發生，如天災、戰亂、暴動、民變、政府命令、恐怖攻擊、瘟疫、實施禁運或因師傅個人行為等，本平台恕不為此所造成之師傅延遲保固甚至於無法保固之非正常營運情況負責。
九、本平台服務費用之收取，係採委外金流，除非出於本平台之故意過失外，如有任何爭議、疑義或損
失（例如：系統異常、盜用冒用、人為操作不當等），均應由會員與金流服務廠商自行協調，本平台不負擔保、協調、代追償、協助訴訟、代履行、退費或賠償責任。
十、本平台所呈現之廣告內容、文字與圖片之說明、展示樣品或其他銷售資訊，均由各該廣告商所設計與提出。您應自行斟酌與判斷該廣告之正確性與可信度。本平台僅接受委託予以刊登，不對前揭廣告內容負擔任何法律責任。
十一、您同意拋棄對本平台或本平台所屬公司及其董監事、受僱人等，就以上情形之發生為民事權利等請求，亦不任意公開散布有損本平台或本平台所屬公司及其董監事、受僱人等商譽或名譽之言論或文字。

捌、暫停服務
本平台以目前一般認為合理之方式及技術，維護本服務之正常運作。但於下述情況，本平台將暫停或中斷本服務之全部或一部份：
一、對本服務相關軟硬體設備進行搬遷、更換、升級、保養或維修等；
二、使用者有任何違反政府法令或本使用條款情形；
三、天災或其他不可抗力之因素所導致之服務停止或中斷；
四、其他不可歸責於本平台之事由所致之服務停止或中斷；
五、非本平台所得控制之事由而致本服務資訊顯示不正確、或遭偽造、竄改、刪除或擷取、或致系統中斷或不能正常運作時。

玖、發票開立
一、本平台採用線上電子計算機發票，恕不提供紙本式寄送服務。
二、如有公司報帳需求，請填寫統一編號、公司名稱，以便開立三聯式發票。
三、依統一發票使用辦法規定，個人戶發票無法換開為公司戶發票；公司戶發票無法換開為個人戶發票。發票一經開立，對於買方名稱及統一編號不得任意更改或應買方要求改開其他營利事業及統一編號。另，統一發票因書寫錯誤退回另開，不得按退貨或折讓處理。

拾、其他約定
一、本協議以中華民國法律為準據法。
二、使用者與本平台因服務關係而生之爭議，雙方合意以臺灣臺北地方法院為第一審管轄法院。
三、本平台未行使、遲延行使或執行本協議任何權利或規定，不構成對任何權利之放棄。
四、本協議之任何一部牴觸法律或無效，不影響其他部份之效力。
五、本協議將因應需求隨時修訂或更新，毋須事前另行通知，並將最新版本載於本平台APP或網址，請您定期查閱最新版本，本協議修訂於民國111年9月16日，取代修正前之協議。
OOO有限公司擁有以上聲明之著作權
""";

String privacy = """
非常歡迎您光臨「Bizworks」派工系統(以下稱”本系統”)，為了讓您能夠安心使用本系統的各項服務與資訊，特此向您(以下均包含師傅)說明本系統的隱私權保護政策，以保障您的權益，請您詳閱下列內容，若您不同意本隱私權政策任何內容，請立即登出並停止使用本系統提供之任何服務，並將它從您的裝置中移除。

<bold>適用範圍</bold>
保護您的隱私對我們來說非常重要，本公司只會用您所提供的資料來處理您下單的相關事宜，並使您的使用者經驗更加完美，我們絕不會將您的個人資料出租， 交換或是賣給第三方，我們也不會儲存您的信用卡資料，信用卡資料是由金流公司處理。我們承諾保護您的隱私及個人資料，並致力確保本聲明及蒐集、處理、使用您的個人資料及隱私之行為等皆符合中華民國法令規定。以下聲明將說明本公司蒐集您哪些個人資料或隱私，及本公司乃是如何處理與保護該等資料。

<bold>安全性與隱私權</bold>
保護您的隱私對我們來說非常重要， 為使您的使用者經驗更加完美，除有法律依據或取得您事前同意外，我們絕不會將您的個人資料提供、出租、交換或出售給第三方 。我們承諾保護您的隱私及個人資料，並致力確保本聲明及蒐集、處理、利 用您的個人資料及隱私之行為等皆符合中華民國法令規定。以下聲明將說明本系統蒐集、處理及利用您哪些個人資料或隱私，及本系統如何處理與保護該等資料。

<bold>個人資料蒐集聲明</bold>
一、本聲明依照中華民國法律所制定，以適法經營本系統服務及產品。
二、本系統致力保護您的個人資料，並確保有關蒐集、處理、利用、保存、揭露、傳輸、保密及查閱個人資料的政策及行為均符合中華民國個資保護法律規定。
三、「個資保護法律」係指中華民國《個人資料保護法及其施行細則》、《通訊保障及監察法》、《消費者保護法》及與個人資料保護有關的、現時有效的法律、法規、行政函釋和其他具強制性的規範。
四、蒐集之目的：
您同意本系統為行銷、消費者保護、服務管理、帳務管理、調查與研究分析、資料管理、廣告及商業行為管理等目的，同時為使您享有本系統所供應之各種產品與服務，您需要向本系統提供某些必要的個人資料，本系統亦可能要求您提供其他資料，以協助本系統為您提供及挑選您可能感興趣的產品及服務，以提供您更完整的消費體驗。
五、蒐集之類別：

本系統內蒐集之個人資料種類包括：
(1) 您的姓名、身分證字號、性別、地址、電子郵件、電話號碼、出生日期、社群媒體資料等資訊。
(2) 您的信用卡及金融帳戶等資訊。
(3) 您的連線設備IP 位址、裝置資訊、位置、使用時間、瀏覽、搜尋紀錄及點選資料記錄等資訊。
六、您同意本系統有權於本聲明所載之目的範圍內，蒐集、處理及利用您提供給本系統之個人資料。如您不能或不願意提供完整及正確之個人資料，本系統將可能無法向您提供或繼續提供本系統之產品或服務。
七、利用期間、對象及方式：

您同意本系統可以利用及保存您向本系統提供的個人資料，期間及方式如下：
(1)利用期間：至您要求停止使用為止。
(2)利用對象及方式：您的個人資料除用於本系統之行銷、消費者保護、服務管理、帳務管理、調查與研究分析、資料管理、廣告及商業行為管理、各項相關服務使用等功能外，亦將利用於辨識身份、金流服務、物流服務等。例示如下：
a.處理您的申請註冊成為本系統客戶之相關服務。
b.向您提供定期資訊，包括本系統所屬公司集團(包括關係企業及子公司)內服務之詳情、最新會員權益資訊、政策聲明或優惠的詳情。
c.本系統所屬公司集團(包括關係企業及子公司)所經營的相關修繕、房地產業務、電子商務(包括平台及網上拍賣)、支付服務、金融、投資及保險產品及服務及物業相關服務提供的優惠或促銷活動。
d.您下單、購買或從事其他交易時，關於服務提供、金錢給付、回覆詢問、相關售後保固服務及其他遂行交易所必要之業務。
e.進行您有參與的抽獎、遊戲或比賽等。
f.進行數據分類及分析等，使本系統能理解您的消費特徵及消費行為，向您提供更符合您需求的服務，協助本系統挑選您可能感興趣的服務或產品。
g.調查消費爭議或可疑交易，以及研究服務改善措施。
h.依法規揭露或配合偵查可能之犯罪行為，例如應傳票、法院命令或法律程序被要求提供個人資訊。
八、本系統可能揭露及轉移(無論在中華民國境內或海外)您的個人資料予向本系統負有保密責任的代理人、承辦(包)商，以向本系統提供管理、數據分析、市場推廣及研究、資訊服務、專業服務或其他類似的服務。
九、在進行本系統業務之重組及/或與本系統或第三方進行合併、銷售或轉讓(包括部份或全部資產或股權)時，本系統可能揭露或轉移(無論在中華民過境內或海外)您的個人資料予相關實際或建議受讓人，按本聲明所述的目的而利用、持有、處理或保留您個人資料。
十、您的瀏覽訊息(Cookies)


為了提供您最佳的服務，本網站會在您的電腦中放置並取用我們的Cookie，若您不願接受Cookie的寫入，您可在您使用的瀏覽器功能項中設定隱私權等級為高，即可拒絕Cookie的寫入，但可能會導致網站某些功能無法正常執行，如您選擇剔除接收從第三方廣告商、網絡廣告倡議 (Network Advertising Initiative) 成員、或根據數碼廣告聯盟 (Digital Advertising Alliance) 所訂之網上行為精準式廣告指引而提供的個人化廣告，可經網絡廣告倡議及數碼廣告聯盟的網站了解詳情。
十一、本系統採取適當的技術和企業措施，以保護您向本系統提供的個人資料，防止意外或非法銷毀、丟失、更改、揭露或存取您的個人資料。
十二、凡為本系統註冊客戶者，皆有義務維持並更新其所屬個人資料，並確保該資料為正確、最新以及完整。若發現有任何不實或可能導致錯誤之資料，本系統有權拒絕您以該帳號繼續使用本系統全部或部份服務。
十三、本系統APP上之內容、網站、文宣廣告等等所有相關內容，包含文字、圖像、影音、程式、版面設計及資料編輯等，其著作權、商標及其他智慧財產權，均屬走運股份有限公司所有，非經本公司授權書面同意，不得以任何形式轉載、重製、散布、公開播送、出版或發行以上任何內容，否則本將依法追究法律責任並請求賠償(包括但不限於律師費、訴訟費用等一切損失)。
十四、本隱私權政策將因應需求隨時修訂或更新，毋須事前另行通知，並將最新版本載於本系統APP或網址，請您定期查閱最新版本，謝謝您的關注與使用。本隱私權政策修訂於民國111年9月7日，取代修正前之隱私權政策。

本合約2023版本 由XX法律事務所審閱校正並僅適用於一般情形，若於個案情形請自行斟酌適用。
""";
