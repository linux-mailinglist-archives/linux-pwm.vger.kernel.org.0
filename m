Return-Path: <linux-pwm+bounces-7672-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D291BC7DED9
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Nov 2025 10:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80BE73A9529
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Nov 2025 09:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6088113B293;
	Sun, 23 Nov 2025 09:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wg8gL3rt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E9C176ADE
	for <linux-pwm@vger.kernel.org>; Sun, 23 Nov 2025 09:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763890015; cv=none; b=ScqnQvXC5Vb1lFgkiHxrGRJSUqxtPDs4WK4mUlZNrh2R7kMw3jKiCDgV0nSBCPn8Og6eA8fGKpZ9aG58yO97PvAD+wvPaIO25pgjzDSGvKnTHJ5+XE3nga0QgpvfsMoXPzH2Ztc9DU2y+XYxgmnUkjJXHAqCQ2NwYoQHX5wtGok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763890015; c=relaxed/simple;
	bh=kZYfkI2nCmz7qEGxmYNzPwIxYr9EHSD53GvUwikKHWw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=itj1Ls/QC+4L0hPA8KQ5c9TYQ0MutUNFwluaNgl3gUG17neGJzKn3AFvRsU1w7aa/JK5E5zU+uKWPZnGUHbluA4zQ+PhPOyAQWrtNAZsRqjKlYhrMTNquuKDfsIkj5DlwRSFvtDJvcTSBqKEx9wbETew3oAJZoHzLwVYq67ltFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wg8gL3rt; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-297ec50477aso13709965ad.1
        for <linux-pwm@vger.kernel.org>; Sun, 23 Nov 2025 01:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763890013; x=1764494813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jcsZ1pYdc/lZZufwkk7hmx3zrC9Zk2tE9eYLDhtARFw=;
        b=Wg8gL3rtvfAG7OKuY3TqC9T58J5r3F7nruwCS3wUeqJ/0UtxF/rVy+ifrUj1zGAmZg
         Km/JjB4uUibg9z1sYgfXsWv6VWAfH9OefS0q2mo8FM4uL8K6tlV1LyKBbIw2SlAqMhPz
         jwqLjCoYdCpGbnmWYASyzsq6QvyeNM5vVit55rCNupdXmEyrlYnAWXO5zLWojFgrW7CV
         tB2Td85/zWw3O8FGgMG2ApxUpR5A0xF3l1mpJu8nNM2xJMVMGFTHBr+HnwDdVjntq0FC
         9jPevqObnm8M+xrMlW4qtK3HqOtSMS9cC1FGGPBhPB+4IlG2vG2Sxlx4qU6mp9ePe7uB
         pELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763890013; x=1764494813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jcsZ1pYdc/lZZufwkk7hmx3zrC9Zk2tE9eYLDhtARFw=;
        b=Uju1uVoltMt7dR5taOIwAH4kKRZtmP8SSFRPZsL8DKOamfG7YUtfOzWwlQ0sevLg/E
         /7b2ZTYb8bhwqdMeNsc3UOJwZM6ptqkvuduv/hEqfO8v+4pDCBHpSEtutac6crjZ+Pem
         H6nKR6qnt94qesszEtN1la0wvdyrUbFRMvm2sAUulNU64YGigi/sEu6WhJppn+yYKwQX
         A0xmYejHGU4RgbCnooPaoifAoTbE3NOi5xgq9T7z/5X9SwWMhSljF6NNBPOOWNSvQMX6
         Mdw1k6dN4a8T5yA5YOCX08wFmQ5Aci4anQAvgkFBGL1ivWyLdgMKe61LjJvvpCnEC3MM
         la7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXH3A0arF2GdBPGr+f7yAwGyYXpkaVBWxpgNbd4ukKSwDvQbitSy+5e6CvUHoFHccXGYux75iydgxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyouJe0vv6oqaYjvzFDLtBOXfWG6pyzfhUPCnYOBDxFcuXvmgtz
	2ppJlk8ERX2deMwGgj/ffmhGI4Qajsc1uzD6OtCRZg3AoWRaqNdkx6Zd
X-Gm-Gg: ASbGncsij0yT0GfmDJ4wbCqT0uGzaH+PYoNG1KzwH9Eb5zsaz0LU13aU5jomw3JTADJ
	SDzwQDr/o9uq4fnKFXX3STYUsytby56XauBpNA7b8MjNKbgVS8qMqB+m5rkk4YpYSaeMv51IOwi
	Xc9QQDzWMqtq0AhgNAL4DHfvXE6cnVwoAN4+EUPVlzALUHuNpiczOm9JAeS50d0MfVIuamHbrwq
	M3xExtH4grYHthoc+4WE1XvMR/Yb4DCQjQkjD3RGeHUq7UIZzit+W1/5ItA3i+k9lp5XTii6P3Z
	x9T4Zinc9ni1KOSl2BjZI895a7ZwvMqw7wZNB5EPJ04cCnImirIX7PXokgD9eQhR+x8kPEli062
	2BEtEqkYA7UT09F2/28j3BgYsEMzlSEh5Y/AlvQ2LJP7gYg6I12cPVGv+1oyFy0fs4voHbNPSJz
	RldObv7TjewgTWX24UywUwZDPWRw==
X-Google-Smtp-Source: AGHT+IEPaSiAglOPtRohHhMD3F7poU82nQz/JA+b9mPjFhoImXk6hT3H7zPq8hH/JIUpP2uJO5DptA==
X-Received: by 2002:a17:902:ef4f:b0:295:82d0:9baa with SMTP id d9443c01a7336-29b6bfa8cd3mr100768505ad.17.1763890013033;
        Sun, 23 Nov 2025 01:26:53 -0800 (PST)
Received: from shankari-IdeaPad.. ([103.24.60.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b138c08sm100811105ad.25.2025.11.23.01.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 01:26:52 -0800 (PST)
From: Shankari Anand <shankari.ak0208@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Alexandre Courbot <acourbot@nvidia.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Igor Korotin <igor.korotin.linux@gmail.com>,
	Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Shankari Anand <shankari.ak0208@gmail.com>
Subject: [PATCH 06/10] rust: kernel: Update ARef and AlwaysRefCounted imports to use sync::aref
Date: Sun, 23 Nov 2025 14:54:34 +0530
Message-Id: <20251123092438.182251-7-shankari.ak0208@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251123092438.182251-1-shankari.ak0208@gmail.com>
References: <20251123092438.182251-1-shankari.ak0208@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update call sites in `pwm.rs` to import `ARef`
and `AlwaysRefCounted` from `sync::aref`
instead of `types`.

This aligns with the ongoing effort to move `ARef` and
`AlwaysRefCounted` to sync.

Suggested-by: Benno Lossin <lossin@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1173
Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
---
 rust/kernel/pwm.rs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
index cb00f8a8765c..1605d13d5d64 100644
--- a/rust/kernel/pwm.rs
+++ b/rust/kernel/pwm.rs
@@ -13,7 +13,8 @@
     devres,
     error::{self, to_result},
     prelude::*,
-    types::{ARef, AlwaysRefCounted, Opaque}, //
+    sync::aref::{ARef, AlwaysRefCounted},
+    types::Opaque, //
 };
 use core::{marker::PhantomData, ptr::NonNull};
 
-- 
2.34.1


