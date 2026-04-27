import { defineRouting } from "next-intl/routing";

export const locales = ["de", "ar", "uk"] as const;
export type Locale = (typeof locales)[number];

export const localeLabels: Record<Locale, string> = {
  de: "Deutsch",
  ar: "العربية",
  uk: "Українська",
};

export const localeFlags: Record<Locale, string> = {
  de: "🇩🇪",
  ar: "🇸🇦",
  uk: "🇺🇦",
};

export const rtlLocales: readonly Locale[] = ["ar"];

export const routing = defineRouting({
  locales,
  defaultLocale: "de",
  localePrefix: "always",
});

export function isRtl(locale: string): boolean {
  return rtlLocales.includes(locale as Locale);
}

export function getDirection(locale: string): "ltr" | "rtl" {
  return isRtl(locale) ? "rtl" : "ltr";
}
