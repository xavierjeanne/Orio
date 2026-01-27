"use client";

import { useState } from "react";
import Link from "next/link";
import { Menu } from "lucide-react";

export function MobileMenu() {
  const [open, setOpen] = useState(false);

  return (
    <>
      <button
        onClick={() => setOpen(true)}
        aria-label="Ouvrir le menu"
        className="p-2"
      >
        <Menu />
      </button>

      {open && (
        <div className="fixed inset-0 z-50 bg-background">
          <button
            onClick={() => setOpen(false)}
            className="absolute top-4 right-4"
          >
            ✕
          </button>

          <nav className="flex flex-col items-center gap-6 mt-20">
            <Link href="/events" onClick={() => setOpen(false)}>
              Événements
            </Link>
            <Link href="/venues" onClick={() => setOpen(false)}>
              Lieux
            </Link>
            <Link href="/blog" onClick={() => setOpen(false)}>
              Blog
            </Link>
          </nav>
        </div>
      )}
    </>
  );
}
