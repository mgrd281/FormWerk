import { setRequestLocale } from "next-intl/server";
import { Sidebar } from "@/components/layout/sidebar";
import { Topbar } from "@/components/layout/topbar";
import { auth } from "@/auth";

export default async function DashboardLayout({
  children,
  params,
}: {
  children: React.ReactNode;
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  setRequestLocale(locale);
  const session = await auth().catch(() => null);

  return (
    <div className="flex min-h-screen">
      <Sidebar />
      <div className="flex flex-1 flex-col">
        <Topbar userEmail={session?.user?.email} />
        <main className="flex-1 overflow-y-auto bg-(--color-bg-primary)">
          {children}
        </main>
      </div>
    </div>
  );
}
