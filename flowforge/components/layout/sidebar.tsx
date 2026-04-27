"use client";

import { useTranslations } from "next-intl";
import { usePathname, Link } from "@/i18n/navigation";
import {
  LayoutDashboard,
  Workflow,
  Plug,
  Activity,
  Settings,
  type LucideIcon,
} from "lucide-react";
import { cn } from "@/lib/utils";

type NavItem = {
  href: string;
  icon: LucideIcon;
  labelKey: string;
};

const NAV_ITEMS: NavItem[] = [
  { href: "/dashboard", icon: LayoutDashboard, labelKey: "dashboard" },
  { href: "/workflows", icon: Workflow, labelKey: "workflows" },
  { href: "/connections", icon: Plug, labelKey: "connections" },
  { href: "/executions", icon: Activity, labelKey: "executions" },
  { href: "/settings", icon: Settings, labelKey: "settings" },
];

export function Sidebar() {
  const t = useTranslations("nav");
  const pathname = usePathname();

  return (
    <aside className="hidden md:flex w-60 shrink-0 flex-col border-e border-(--color-border-default) bg-(--color-bg-secondary)">
      <div className="flex h-14 items-center gap-2 border-b border-(--color-border-default) px-4">
        <div className="flex h-7 w-7 items-center justify-center rounded-md bg-(--color-accent)">
          <Workflow className="h-4 w-4 text-white" />
        </div>
        <span className="text-sm font-semibold tracking-tight">FlowForge</span>
      </div>
      <nav className="flex-1 overflow-y-auto p-2">
        <ul className="flex flex-col gap-0.5">
          {NAV_ITEMS.map((item) => {
            const isActive =
              pathname === item.href || pathname.startsWith(`${item.href}/`);
            const Icon = item.icon;
            return (
              <li key={item.href}>
                <Link
                  href={item.href}
                  className={cn(
                    "group flex h-9 items-center gap-3 rounded-md px-3 text-sm transition-colors duration-150",
                    "border-s-2 border-transparent",
                    isActive
                      ? "bg-(--color-bg-tertiary) text-(--color-text-primary) border-s-(--color-accent)"
                      : "text-(--color-text-secondary) hover:bg-(--color-bg-tertiary) hover:text-(--color-text-primary)",
                  )}
                >
                  <Icon className="h-4 w-4 shrink-0" />
                  <span className="truncate">{t(item.labelKey)}</span>
                </Link>
              </li>
            );
          })}
        </ul>
      </nav>
      <div className="border-t border-(--color-border-default) p-3 text-xs text-(--color-text-tertiary)">
        v0.1.0
      </div>
    </aside>
  );
}
