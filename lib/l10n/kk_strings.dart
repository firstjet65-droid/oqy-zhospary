/// All user-visible strings of the app (Kazakh).
class KkStrings {
  KkStrings._();

  // General
  static const appName = 'Оқу Жоспары';
  static const slogan = 'Жоспарла. Үлгер. Жеткіз.';
  static const version = '1.0.0';
  static const save = 'Сақтау';
  static const add = 'Қосу';
  static const edit = 'Өңдеу';
  static const delete = 'Өшіру';
  static const yes = 'Иә';
  static const no = 'Жоқ';
  static const cancel = 'Бас тарту';
  static const logout = 'Шығу';
  static const all = 'Барлығы';
  static const unknownError = 'Күтпеген қате орын алды';

  // Auth
  static const login = 'Кіру';
  static const register = 'Тіркелу';
  static const email = 'Электрондық пошта';
  static const password = 'Құпиясөз';
  static const confirmPassword = 'Құпиясөзді растаңыз';
  static const fullName = 'Аты-жөніңіз';
  static const loginTitle = 'Қош келдіңіз!';
  static const loginSubtitle = 'Есептік жазбаңызға кіріңіз';
  static const registerTitle = 'Жаңа есептік жазба';
  static const registerSubtitle = 'Оқу жоспарын құруды бастаңыз';
  static const noAccount = 'Тіркелгіңіз жоқ па?';
  static const haveAccount = 'Тіркелгіңіз бар ма?';
  static const forgotPassword = 'Құпиясөзді ұмыттыңыз ба?';
  static const forgotPasswordSubtitle =
      'Поштаңызды енгізіңіз, біз қалпына келтіру нұсқаулығын жібереміз';
  static const sendInstructions = 'Нұсқаулық жіберу';
  static const instructionsSent = 'Нұсқаулық поштаға жіберілді';
  static const registerSuccess = 'Тіркелу сәтті аяқталды';
  static const showPassword = 'Құпиясөзді көрсету';
  static const hidePassword = 'Құпиясөзді жасыру';

  // Validation
  static const errRequired = 'Бұл өріс бос болмауы керек';
  static const errNameShort = 'Аты-жөні кемінде 2 таңбадан тұруы керек';
  static const errNameChars = 'Тек әріптер, бос орын және сызықша болуы мүмкін';
  static const errEmail = 'Электрондық пошта қате';
  static const errPasswordShort = 'Құпиясөз кемінде 6 таңбадан тұруы керек';
  static const errPasswordFormat = 'Құпиясөзде әріп пен сан болуы керек';
  static const errPasswordMismatch = 'Құпиясөздер сәйкес келмейді';
  static const errEmailTaken = 'Бұл пошта тіркелген';
  static const errInvalidCredentials = 'Пошта немесе құпиясөз қате';

  // Navigation
  static const tabHome = 'Басты бет';
  static const tabSchedule = 'Кесте';
  static const tabTasks = 'Тапсырмалар';
  static const tabStats = 'Статистика';
  static const tabProfile = 'Профиль';

  // Home
  static const greeting = 'Сәлем';
  static const weekProgress = 'Апталық прогресс';
  static const weekProgressHint = 'Тапсырмалардың 65 %-ы орындалды';
  static const todayLessons = 'Бүгінгі сабақтар';
  static const upcomingDeadlines = 'Жақын мерзімдер';
  static const quickActions = 'Жылдам әрекеттер';
  static const addTask = 'Тапсырма қосу';
  static const addLesson = 'Сабақ қосу';
  static const fullSchedule = 'Барлық кесте';
  static const statistics = 'Статистика';
  static const noLessonsToday = 'Бүгін сабақ жоқ';
  static const noTasks = 'Тапсырмалар жоқ';

  // Schedule
  static const noLessonsDay = 'Бұл күні сабақ жоспарланбаған';
  static const lessonAdded = 'Сабақ қосылды';
  static const subject = 'Пән';
  static const day = 'Күн';
  static const startTime = 'Басталуы';
  static const endTime = 'Аяқталуы';
  static const room = 'Аудитория';
  static const teacher = 'Оқытушы';
  static const repeatWeekly = 'Апта сайын қайталау';
  static const selectTime = 'Уақытты таңдаңыз';

  // Tasks
  static const filterActive = 'Орындалуда';
  static const filterDone = 'Орындалды';
  static const filterOverdue = 'Мерзімі өтті';
  static const taskAdded = 'Тапсырма қосылды';
  static const taskTitle = 'Тапсырма атауы';
  static const description = 'Сипаттама';
  static const deadline = 'Мерзімі';
  static const priority = 'Басымдық';
  static const priorityLow = 'Төмен';
  static const priorityMedium = 'Орташа';
  static const priorityHigh = 'Жоғары';
  static const reminder = 'Еске салу';
  static const status = 'Күйі';
  static const progress = 'Орындалуы';
  static const markDone = 'Орындалды деп белгілеу';
  static const markedDone = 'Тапсырма орындалды деп белгіленді';
  static const taskDeleted = 'Тапсырма өшірілді';
  static const taskDetail = 'Тапсырма';
  static const statusActive = 'Орындалуда';
  static const statusDone = 'Орындалды';
  static const statusOverdue = 'Мерзімі өтті';
  static const selectDate = 'Күнді таңдаңыз';

  // Stats
  static const completed = 'Орындалған';
  static const late = 'Кешіккен';
  static const planned = 'Жоспарда';
  static const weeklyActivity = 'Апталық белсенділік';
  static const mostActiveSubject = 'Ең белсенді пән';
  static const mostActiveSubjectHint = 'Осы аптада 7 тапсырма орындалды';

  // Profile
  static const settings = 'Баптаулар';
  static const notifications = 'Хабарламалар';
  static const mySubjects = 'Пәндерім';
  static const about = 'Қолданба туралы';
  static const registeredOn = 'Тіркелген күні';
  static const logoutConfirm = 'Шығуды растайсыз ба?';
  static const profile = 'Профиль';

  // Settings
  static const darkTheme = 'Қараңғы тақырып';
  static const pushNotifications = 'Хабарландыру';
  static const sound = 'Дыбыс';
  static const language = 'Тіл';
  static const languageValue = 'Қазақша';

  // Notifications / subjects
  static const noNotifications = 'Хабарламалар жоқ';
  static const noSubjects = 'Пәндер жоқ';

  // About
  static const aboutGoalTitle = 'Мақсаты';
  static const aboutGoal =
      'Студентке оқу аптасын жоспарлауға және тапсырма мерзімдерін '
      'ешқашан өткізіп алмауға көмектесу.';
  static const aboutAudienceTitle = 'Мақсатты аудитория';
  static const aboutAudience = 'Колледж және университет студенттері.';
  static const aboutFeaturesTitle = 'Жоспарланған функциялар';
  static const aboutFeatures =
      '• Апталық оқу кестесі\n'
      '• Мерзімі мен басымдығы бар тапсырмалар тізімі\n'
      '• Прогресс статистикасы\n'
      '• Еске салғыштар';
  static const aboutTopicTitle = 'Тақырыбы';
  static const aboutTopic =
      'Жеке оқу кестесін құру және тапсырма мерзімдерін бақылауға '
      'арналған мобильді қолданба әзірлеу.';
  static const versionLabel = 'Нұсқа';

  // Weekdays (short)
  static const weekdaysShort = ['Дс', 'Сс', 'Ср', 'Бс', 'Жм', 'Сб', 'Жс'];
}
