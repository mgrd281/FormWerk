"use client";

import { useTheme } from "next-themes";
import { Toaster as Sonner } from "sonner";

type ToasterProps = React.ComponentProps<typeof Sonner>;

export const Toaster = (props: ToasterProps) => {
  const { theme = "system" } = useTheme();

  return (
    <Sonner
      theme={theme as ToasterProps["theme"]}
      className="toaster group"
      toastOptions={{
        classNames: {
          toast:
            "group toast group-[.toaster]:bg-(--color-bg-elevated) group-[.toaster]:text-(--color-text-primary) group-[.toaster]:border group-[.toaster]:border-(--color-border-strong) group-[.toaster]:shadow-lg",
          description: "group-[.toast]:text-(--color-text-secondary)",
          actionButton:
            "group-[.toast]:bg-(--color-accent) group-[.toast]:text-white",
          cancelButton:
            "group-[.toast]:bg-(--color-bg-tertiary) group-[.toast]:text-(--color-text-primary)",
        },
      }}
      {...props}
    />
  );
};
