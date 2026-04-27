import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: {
    default: "FlowForge",
    template: "%s · FlowForge",
  },
  description:
    "Workflow automation for builders. Create, schedule, and run automations with visual building blocks.",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return children;
}
