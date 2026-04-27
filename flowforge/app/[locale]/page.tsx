import { setRequestLocale, getTranslations } from "next-intl/server";
import { Link } from "@/i18n/navigation";
import { Button } from "@/components/ui/button";
import { ArrowRight } from "lucide-react";

export default async function HomePage({
  params,
}: {
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  setRequestLocale(locale);
  const t = await getTranslations();

  return (
    <main className="bg-radial-fade min-h-screen flex flex-col items-center justify-center px-6 text-center">
      <div className="max-w-2xl flex flex-col gap-6">
        <div className="inline-flex self-center items-center gap-2 rounded-full border border-(--color-border-default) bg-(--color-bg-secondary) px-3 py-1 text-xs text-(--color-text-secondary)">
          <span className="h-1.5 w-1.5 rounded-full bg-(--color-success)" />
          {t("common.comingSoon")}
        </div>
        <h1 className="text-5xl md:text-7xl font-semibold tracking-tight">
          {t("app.name")}
        </h1>
        <p className="text-lg text-(--color-text-secondary)">
          {t("app.tagline")}
        </p>
        <div className="flex items-center justify-center gap-3 mt-2">
          <Button asChild size="lg">
            <Link href="/login">
              {t("auth.signIn")}
              <ArrowRight className="h-4 w-4 rtl:rotate-180" />
            </Link>
          </Button>
          <Button asChild variant="secondary" size="lg">
            <Link href="/dashboard">{t("nav.dashboard")}</Link>
          </Button>
        </div>
      </div>
    </main>
  );
}
