# NEXORA PC — دليل التشغيل والنشر

## الموجود في المشروع
- متجر عربي RTL بتصميم داكن ومتجاوب.
- بحث وتصنيفات وسلة تجريبية.
- لوحة مالك لإضافة المنتجات وتعديلها وحذفها.
- Supabase Auth + PostgreSQL + سياسات RLS لحماية عمليات التعديل.
- منتجات نموذجية للعرض إذا لم تتم تهيئة قاعدة البيانات بعد.

## 1) إنشاء قاعدة البيانات
1. افتح https://supabase.com وأنشئ مشروعًا جديدًا.
2. من SQL Editor افتح ملف `supabase/schema.sql` والصق محتواه وشغّله.
3. من Authentication > Users أنشئ مستخدمًا ببريدك أنت وكلمة مرور قوية.
4. انسخ User UID لهذا المستخدم.
5. في SQL Editor نفّذ التالي بعد استبدال UUID:
   ```sql
   insert into public.admins (user_id) values ('YOUR_AUTH_USER_UUID');
   ```
   لا تضف أي زائر إلى جدول `admins`.

## 2) متغيرات البيئة
من Supabase > Project Settings > API انسخ Project URL و anon/public key.
- انسخ `.env.example` إلى `.env.local`
- أدخل القيم في:
  - `NEXT_PUBLIC_SUPABASE_URL`
  - `NEXT_PUBLIC_SUPABASE_ANON_KEY`

لا تضع `service_role` key في متغير يبدأ بـ `NEXT_PUBLIC_` ولا ترفعه إلى GitHub.

## 3) تشغيل محلي
```bash
npm install
npm run dev
```
ثم افتح http://localhost:3000

## 4) النشر على Vercel
1. ارفع محتويات المشروع إلى مستودع GitHub.
2. في Vercel اختر Add New > Project واستورد `NotMaker/nexora-pc`.
3. أضف متغيري البيئة أعلاه في Project Settings > Environment Variables.
4. اضغط Deploy. أي تحديث جديد على الفرع الرئيسي سيطلق نشرًا جديدًا تلقائيًا.
5. افتح رابط `/admin` وسجّل دخول حساب المالك الذي أنشأته في Supabase.

## ملاحظات مهمة
- لا يوجد دفع حقيقي ولا معالجة مدفوعات في هذا النموذج.
- السلة تجريبية في المتصفح وليست طلب شراء دائمًا.
- إذا لم تُضبط متغيرات Supabase، سيظهر المتجر بمنتجات نموذجية، وتعرض لوحة الإدارة تعليمات الإعداد بدل السماح بتعديل غير محفوظ.
- صلاحيات المالك الفعلية تُفرض من قاعدة البيانات عبر RLS، وليست بمجرد إخفاء رابط الإدارة.
