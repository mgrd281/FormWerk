import { getTranslations } from "next-intl/server";
import { FileQuestion } from "lucide-react";
import { Link } from "@/i18n/navigation";
import { Button } from "@/components/ui/button";

export default async function NotFound() {
  const t = await getTranslations();
  return (
    <main className="bg-radial-fade min-h-screen flex items-center justify-center px-6">
      <div className="flex flex-col items-center gap-4 text-center max-w-md">
        <div className="flex h-16 w-16 items-center justify-center rounded-full bg-(--color-bg-tertiary)">
          <FileQuestion className="h-8 w-8 text-(--color-accent) opacity-70" />
        </div>
        <h1 className="text-2xl font-semibold tracking-tight">
          {t("errors.notFound")}
        </h1>
        <p className="text-(--color-text-secondary)">
          {t("errors.notFoundDescription")}
        </p>
        <Button asChild>
          <Link href="/">{t("errors.goHome")}</Link>
        </Button>
      </div>
    </main>
  );
}
