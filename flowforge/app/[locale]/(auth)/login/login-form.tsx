"use client";

import { useState, useTransition } from "react";
import { useTranslations } from "next-intl";
import { Mail, Workflow, ArrowLeft } from "lucide-react";
import { toast } from "sonner";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import { signInWithEmail, signInWithGoogle } from "./actions";

export function LoginForm({ verifyMode }: { verifyMode: boolean }) {
  const t = useTranslations();
  const [email, setEmail] = useState("");
  const [submittedEmail, setSubmittedEmail] = useState<string | null>(null);
  const [errorMsg, setErrorMsg] = useState<string | null>(null);
  const [emailPending, startEmail] = useTransition();
  const [googlePending, startGoogle] = useTransition();

  const showVerify = verifyMode || submittedEmail !== null;

  function handleEmailSubmit(formData: FormData) {
    setErrorMsg(null);
    const value = String(formData.get("email") ?? "").trim();
    if (!value) {
      setErrorMsg(t("auth.errors.emailRequired"));
      return;
    }
    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value)) {
      setErrorMsg(t("auth.errors.invalidEmail"));
      return;
    }
    startEmail(async () => {
      try {
        await signInWithEmail(value);
        setSubmittedEmail(value);
      } catch {
        setErrorMsg(t("auth.errors.sendFailed"));
        toast.error(t("auth.errors.sendFailed"));
      }
    });
  }

  function handleGoogle() {
    startGoogle(async () => {
      try {
        await signInWithGoogle();
      } catch {
        toast.error(t("auth.errors.sendFailed"));
      }
    });
  }

  if (showVerify) {
    return (
      <Card className="w-full max-w-md text-center">
        <CardHeader className="items-center">
          <div className="mx-auto mb-2 flex h-12 w-12 items-center justify-center rounded-full bg-(--color-bg-tertiary)">
            <Mail className="h-6 w-6 text-(--color-accent)" />
          </div>
          <CardTitle>{t("auth.checkInbox")}</CardTitle>
          <CardDescription>
            {t("auth.magicLinkSent", {
              email: submittedEmail ?? t("auth.email").toLowerCase(),
            })}
          </CardDescription>
        </CardHeader>
        <CardContent>
          <p className="text-sm text-(--color-text-secondary)">
            {t("auth.magicLinkInstructions")}
          </p>
          <Button
            variant="ghost"
            size="sm"
            onClick={() => {
              setSubmittedEmail(null);
            }}
            className="self-center"
          >
            <ArrowLeft className="h-4 w-4 rtl:rotate-180" />
            {t("common.back")}
          </Button>
        </CardContent>
      </Card>
    );
  }

  return (
    <Card className="w-full max-w-md">
      <CardHeader>
        <div className="flex items-center gap-2 mb-2">
          <div className="flex h-8 w-8 items-center justify-center rounded-md bg-(--color-accent)">
            <Workflow className="h-4 w-4 text-white" />
          </div>
          <span className="text-sm font-semibold">{t("app.name")}</span>
        </div>
        <CardTitle className="text-2xl">{t("auth.signInTitle")}</CardTitle>
        <CardDescription>{t("auth.signInSubtitle")}</CardDescription>
      </CardHeader>
      <CardContent>
        <Button
          type="button"
          variant="secondary"
          size="lg"
          className="w-full"
          onClick={handleGoogle}
          loading={googlePending}
        >
          <GoogleIcon />
          {t("auth.googleContinue")}
        </Button>

        <div className="relative my-2">
          <div className="absolute inset-0 flex items-center">
            <span className="w-full border-t border-(--color-border-default)" />
          </div>
          <div className="relative flex justify-center">
            <span className="bg-(--color-bg-secondary) px-3 text-xs uppercase tracking-wide text-(--color-text-tertiary)">
              {t("auth.or")}
            </span>
          </div>
        </div>

        <form action={handleEmailSubmit} className="flex flex-col gap-3">
          <div className="flex flex-col gap-2">
            <Label htmlFor="email">{t("auth.email")}</Label>
            <Input
              id="email"
              name="email"
              type="email"
              autoComplete="email"
              required
              placeholder={t("auth.emailPlaceholder")}
              value={email}
              onChange={(e) => {
                setEmail(e.target.value);
                if (errorMsg) setErrorMsg(null);
              }}
              invalid={!!errorMsg}
            />
            {errorMsg ? (
              <p className="text-xs text-(--color-error)">{errorMsg}</p>
            ) : null}
          </div>
          <Button type="submit" size="lg" loading={emailPending}>
            <Mail className="h-4 w-4" />
            {t("auth.sendMagicLink")}
          </Button>
        </form>

        <p className="text-xs text-(--color-text-tertiary) text-center mt-2">
          {t("auth.termsAgreement", {
            terms: t("auth.terms"),
            privacy: t("auth.privacy"),
          })}
        </p>
      </CardContent>
    </Card>
  );
}

function GoogleIcon() {
  return (
    <svg
      className="h-4 w-4"
      viewBox="0 0 24 24"
      aria-hidden
      xmlns="http://www.w3.org/2000/svg"
    >
      <path
        fill="#EA4335"
        d="M12 10.2v3.9h5.5c-.24 1.4-1.66 4.1-5.5 4.1-3.32 0-6.02-2.74-6.02-6.13S8.68 5.94 12 5.94c1.88 0 3.14.8 3.86 1.49l2.63-2.54C16.9 3.36 14.66 2.4 12 2.4 6.84 2.4 2.7 6.55 2.7 11.7s4.14 9.3 9.3 9.3c5.36 0 8.92-3.77 8.92-9.07 0-.61-.07-1.08-.16-1.55H12z"
      />
    </svg>
  );
}
