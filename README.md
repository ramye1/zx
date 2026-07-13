markdown
# مرسم الدخيل (Masra Al-Dokhail)

تطبيق Flutter احترافي لرسم شجرة العائلة بشكل تفاعلي.

## المميزات

- ✨ رسم عناصر الشجرة (جذع، غصن، ورقة)
- 🎨 تحريك وتحجيم العناصر
- 📐 نظام شبكة قابل للإخفاء
- ↩️ نظام Undo/Redo
- 🎯 اختيار متعدد العناصر
- 💾 حفظ واستعادة الرسم

## البنية المعمارية

يتبع التطبيق **Clean Architecture**:


lib/
├── core/              # الأدوات المشتركة والثوابت
├── domain/            # قواعد العمل والـ Entities
├── data/              # تنفيذ Repositories والـ Models
└── presentation/      # واجهة المستخدم والـ State Management


## البدء

### المتطلبات
- Flutter 3.0+
- Dart 3.0+

### التثبيت

bash
flutter pub get
flutter run


### بناء التطبيق

bash
flutter build apk          # Android
flutter build ios          # iOS
flutter build web          # Web


## العناصر الأساسية الثلاثة

### 1. الجذع (Trunk)
- العنصر الأساسي في الشجرة
- اللون: بني

### 2. الغصن (Branch)
- يتفرع من الجذع أو أغصان أخرى
- اللون: أخضر

### 3. الورقة (Leaf)
- تمثل النهاية (شخص في الشجرة)
- اللون: أخضر فاتح

## الاستخدام

1. انقر على أيقونة الأداة لإضافة عنصر جديد
2. اسحب العناصر لتحريكها
3. انقر على عنصر لاختياره
4. استخدم أزرار الحذف لحذف العناصر المختارة

## التطوير

### هيكل الملفات

- `lib/main.dart` - نقطة الدخول
- `lib/presentation/pages/canvas_page.dart` - الصفحة الرئيسية
- `lib/presentation/widgets/canvas_widget.dart` - الـ Canvas الرئيسي
- `lib/domain/entities/` - الـ Entities الأساسية

### إضافة ميزات جديدة

1. أضف الـ Entity في `domain/entities/`
2. أضف الـ Model في `data/models/`
3. أضف الـ Provider في `presentation/providers/`
4. أضف الـ Widget في `presentation/widgets/`

## الترخيص

جميع الحقوق محفوظة © حسين الدخيل
