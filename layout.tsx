import type { Metadata } from "next";
import "./globals.css";
export const metadata: Metadata = {
  title: "NEXORA PC | ابنِ تجربتك",
  description: "وجهتك لتجميعات الكمبيوتر وقطع الـ PC والإكسسوارات.",
};
export default function RootLayout({ children }: Readonly<{ children: React.ReactNode }>) {
  return <html lang="ar" dir="rtl"><body>{children}</body></html>;
}