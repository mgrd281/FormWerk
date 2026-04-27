"use client";

import { useTranslations } from "next-intl";
import { Search } from "lucide-react";
import { useEffect, useState } from "react";
import { ThemeToggle } from "@/components/theme-toggle";
import { LanguageSwitcher } from "@/components/language-switcher";
import { cn } from "@/lib/utils";

export function Topbar({ userEmail }: { userEmail?: string | null }) {
  const t = useTranslations("common");
  const [scrolled, setScrolled] = useState(false);

  useEffect(() => {
    function handler() {
      setScrolled(window.scrollY > 4);
    }
    handler();
    window.addEventListener("scroll", handler, { passive: true });
    return () => window.removeEventListener("scroll", handler);
  }, []);

  return (
    <header
      className={cn(
        "sticky top-0 z-40 flex h-14 items-center gap-4 border-b border-(--color-border-default) bg-(--color-bg-primary)/80 px-4 transition-[backdrop-filter] duration-150",
        scrolled && "backdrop-blur-md",
      )}
    >
      <div className="flex-1 max-w-md">
        <button
          type="button"
          className="flex h-9 w-full items-center gap-2 rounded-md border border-(--color-border-default) bg-(--color-bg-secondary) px-3 text-sm text-(--color-text-tertiary) hover:border-(--color-border-strong) transition-colors duration-150"
          aria-label={t("search")}
        >
          <Search className="h-4 w-4" />
          <span>{t("searchPlaceholder")}</span>
          <kbd className="ms-auto inline-flex items-center gap-1 rounded border border-(--color-border-default) bg-(--color-bg-tertiary) px-1.5 py-0.5 text-[10px] font-mono text-(--color-text-tertiary)">
            ⌘K
          </kbd>
        </button>
      </div>
      <div className="flex items-center gap-1">
        <ThemeToggle />
        <LanguageSwitcher />
        {userEmail ? (
          <div
            className="ms-2 flex h-8 w-8 items-center justify-center rounded-full bg-(--color-bg-tertiary) text-xs font-medium uppercase text-(--color-text-primary)"
            aria-label={userEmail}
            title={userEmail}
          >
            {userEmail.charAt(0)}
          </div>
        ) : null}
      </div>
    </header>
  );
}
