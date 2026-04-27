import * as React from "react";
import { cn } from "@/lib/utils";

export type InputProps = React.InputHTMLAttributes<HTMLInputElement> & {
  invalid?: boolean;
};

export const Input = React.forwardRef<HTMLInputElement, InputProps>(
  ({ className, type, invalid, ...props }, ref) => (
    <input
      ref={ref}
      type={type}
      aria-invalid={invalid || undefined}
      className={cn(
        "flex h-9 w-full rounded-md border bg-transparent px-3 text-sm placeholder:text-(--color-text-tertiary)",
        "transition-all duration-150 ease-[cubic-bezier(0.16,1,0.3,1)]",
        "focus:outline-none focus:border-(--color-border-focus) focus:shadow-glow-accent",
        "disabled:cursor-not-allowed disabled:opacity-50",
        invalid
          ? "border-(--color-error) focus:border-(--color-error) focus:shadow-[0_0_0_3px_rgba(255,59,48,0.2)]"
          : "border-(--color-border-default)",
        className,
      )}
      {...props}
    />
  ),
);
Input.displayName = "Input";
