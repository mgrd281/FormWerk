"use client";

import { useEffect } from "react";
import { useTranslations } from "next-intl";
import { AlertCircle } from "lucide-react";
import { Button } from "@/components/ui/button";

export default function ErrorPage({
  error,
  reset,
}: {
  error: Error & { digest?: string };
  reset: () => void;
}) {
  const t = useTranslations();

  useEffect(() => {
    if (process.env.NODE_ENV !== "production") {
      console.error(error);
    }
  }, [error]);

  return (
    <main className="bg-radial-fade min-h-screen flex items-center justify-center px-6">
      <div className="flex flex-col items-center gap-4 text-center max-w-md">
        <div className="flex h-16 w-16 items-center justify-center rounded-full bg-(--color-bg-tertiary)">
          <AlertCircle className="h-8 w-8 text-(--color-error)" />
        </div>
        <h1 className="text-2xl font-semibold tracking-tight">
          {t("errors.generic")}
        </h1>
        <p className="text-(--color-text-secondary)">
          {t("errors.genericDescription")}
        </p>
        {error.message ? (
          <code className="rounded-md border border-(--color-border-default) bg-(--color-bg-secondary) px-3 py-2 text-xs font-mono text-(--color-text-tertiary)">
            {error.message}
          </code>
        ) : null}
        <Button onClick={reset}>{t("common.tryAgain")}</Button>
      </div>
    </main>
  );
}
