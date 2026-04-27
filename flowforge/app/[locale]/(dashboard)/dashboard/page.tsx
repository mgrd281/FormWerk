import { setRequestLocale, getTranslations } from "next-intl/server";
import { Workflow, Activity, CheckCircle2, Zap } from "lucide-react";
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";

export default async function DashboardPage({
  params,
}: {
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  setRequestLocale(locale);
  const t = await getTranslations("dashboard");
  const tNav = await getTranslations("nav");

  const stats = [
    { key: "workflows", icon: Workflow, value: "0" },
    { key: "executions", icon: Activity, value: "0" },
    { key: "successRate", icon: CheckCircle2, value: "—" },
    { key: "activeNow", icon: Zap, value: "0" },
  ] as const;

  return (
    <div className="mx-auto max-w-6xl px-6 py-10 flex flex-col gap-8">
      <header className="flex flex-col gap-1">
        <h1 className="text-3xl font-semibold tracking-tight">
          {tNav("dashboard")}
        </h1>
        <p className="text-sm text-(--color-text-secondary)">
          {t("welcome", { name: t("title") })}
        </p>
      </header>

      <section className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
        {stats.map(({ key, icon: Icon, value }) => (
          <Card key={key}>
            <CardHeader className="mb-0">
              <div className="flex items-center justify-between">
                <CardDescription>{t(`stats.${key}`)}</CardDescription>
                <Icon className="h-4 w-4 text-(--color-text-tertiary)" />
              </div>
            </CardHeader>
            <CardContent>
              <p className="text-3xl font-semibold tabular-nums">{value}</p>
            </CardContent>
          </Card>
        ))}
      </section>

      <section className="grid grid-cols-1 gap-6">
        <Card>
          <CardHeader>
            <CardTitle>{t("recentExecutions")}</CardTitle>
            <CardDescription>
              {tNav("executions")}
            </CardDescription>
          </CardHeader>
          <CardContent>
            <div className="flex flex-col items-center justify-center gap-3 py-12 text-center">
              <div className="flex h-16 w-16 items-center justify-center rounded-full bg-(--color-bg-tertiary)">
                <Activity className="h-8 w-8 text-(--color-accent) opacity-50" />
              </div>
              <p className="text-(--color-text-secondary) text-sm">
                {t("recentExecutions")}
              </p>
            </div>
          </CardContent>
        </Card>
      </section>
    </div>
  );
}
