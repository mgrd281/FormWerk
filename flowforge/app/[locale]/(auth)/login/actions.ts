"use server";

import { signIn } from "@/auth";

export async function signInWithEmail(email: string) {
  await signIn("resend", { email, redirectTo: "/dashboard" });
}

export async function signInWithGoogle() {
  await signIn("google", { redirectTo: "/dashboard" });
}
