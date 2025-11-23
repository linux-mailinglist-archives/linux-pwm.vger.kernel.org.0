Return-Path: <linux-pwm+bounces-7671-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2200AC7DEC4
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Nov 2025 10:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0AF454E1EAB
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Nov 2025 09:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B47284671;
	Sun, 23 Nov 2025 09:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1syOFK/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0EB27FD74
	for <linux-pwm@vger.kernel.org>; Sun, 23 Nov 2025 09:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763890002; cv=none; b=kkX4c3VNAkc1gjRuXQeqwG8yengnxcwc4iMvUKyR1swjdIVyhnP2ry6KHCQ8bhjBsAbUgAkm+OmvS9WZ2OpUVro2ENzYszGwkkuEb5hr8l6oiJv4Nhn8vaUF4YvjSIgFICuhV2oHSdaP9k+nEp0fl8tHfn46QtvefvCANx/8U9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763890002; c=relaxed/simple;
	bh=vKoO79hHEPcCQYl/tNMLa4IXudiHam4RZkBRwZbei0g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CAVf9xq1cbPIa933EcAQ08rE8AGj68Oqy7etjU3Ux7BXR9PKFhIDw1aHYOufBoqf5gm9ap12Ln8UNctnohwyWsRunb4ecNJimMB77tv5q5DYD9UWqGXr1cv9rirSo55PGvG577yAetin7cBgPC5iQ8OmhdvSjWg5VTD5+lH/ZNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1syOFK/; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-297ef378069so30256765ad.3
        for <linux-pwm@vger.kernel.org>; Sun, 23 Nov 2025 01:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763890000; x=1764494800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HepyoJQ30V+nS3WwhUyswnLGOzdzEO2vo/wcuCFozBE=;
        b=l1syOFK/G37q9PN7BrZKA9mj4Be5qzWE5IlcmClTr8OeaMahODUx21koQqvABB6wCX
         8ClhO7CfqhHbFVZjh0pJT+jBL88ySAgO64dYzaPbJHiMFelNsX4PfV/qde5i6TjfTyVT
         k0DLwAiciToHUtYEYYj7TqTUHtYbiLMyguYVVbnt2M5et6ewgrZVDL2mQETplvbm43+W
         BUCFARN9c+mRQj2At0Pq8OX15gmydPNXTzK56E38OEBL+JwB9a3Fd6kBNW83saevUhoM
         VE+HTbAmP8PbY1x/9cEH+ZhpKxUemc0oFlwNc0bCpvTUn6oOFJ3G0vBboNZDiZqqWSp1
         3/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763890000; x=1764494800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HepyoJQ30V+nS3WwhUyswnLGOzdzEO2vo/wcuCFozBE=;
        b=pbiIogdjg/Pm1Ag1bv5X/FnEzIbbbr8cSfRktTquJkm/qiRLd8P4QlrdW5K6BLfbot
         OfcRGk9nk+imY9MuyCZR0c28zPPO7g0dokjbmgmq7e6boMSCTybGAw0b08m6EZ8XWERs
         DjEHs66Zwu4yoWvnqsMraLUXAL8FQf+9gHzclnSwnCeMsIxhIgz8WhVxM42wIsA1VPEd
         F8RVPBobhr6G1A1SknVdZLqS9VtXEWkBe0mXNwfzbd7e4eOmJU95AWWBwaEOPaKWs6RD
         qO88jtxLcEpEB2bFf6Gp+/lWOZyVeWE9BPnERLxsdllPWxaZaY8nzE4W2MGxfY7hGgVM
         8fUg==
X-Forwarded-Encrypted: i=1; AJvYcCVMQ0b/l3PXn2iDJrAyhQZLv3xLtMH8lKbwQdpsQFEh8FVH8OnItHvs2UbaKbFJeDmOr1RqvZzxI5c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5ODExG+t42qDdsTQ3l5/8rV3NB8acdgCtIt4SwYxiaTgcMzZ8
	94yn2rdhMSIyR6uHbhU/NycMNDPLEMmUBsCfe3quD8xMH5R+4indM/Og
X-Gm-Gg: ASbGncuts4qRZ2TuFkgioTqGASytpmPDA3cpG/jLrggQBJwNTCAqUFJ31MkbUKxDxcp
	cYggc9JPvtW0XRdA3g1YR//DTIRX2q5qJU4zWdTDKM/Fq8cwuIxl2vbYRjNdWfkwiY4wtoIl0gm
	Bb1u7B23pKqwBE4CDy47buEMVLxjAQqvHTyKN7QzwaK9j4xpd7Kb5fH1mw0bO30p8ouHA0406L+
	HRLg2T0OtntyhrNNCosFtWl1zpsFPQlTW5bdPm9+hPKhvYaZSCcQAnvR0t4SWxoU63yXtN821Od
	75yuAqkqBOvKdTfJcr9yZOKqQxk0yFD/vnx3LOVzF2YMHPZmW7QNaK+4VXn1oB4USNib/ymmmg3
	B6LUFcjGakIc35bQ8Xt2z56gZzOhhQED9hcodFT0Xz3uK0w2vL3I83l6A7BrhpdpszxNyGMdLD0
	fPxn8T8cOhlOZUzdZjwPpSNLCqFQ==
X-Google-Smtp-Source: AGHT+IHnc+TnFjT4Ewq3NCmcVSOlFxFcCR7lWrTNRkJuldxiSn0BMR95iGNmXPyBh157L0RjhglO7g==
X-Received: by 2002:a17:903:2c06:b0:295:6427:87d4 with SMTP id d9443c01a7336-29b6bf77fedmr93037125ad.50.1763890000307;
        Sun, 23 Nov 2025 01:26:40 -0800 (PST)
Received: from shankari-IdeaPad.. ([103.24.60.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b138c08sm100811105ad.25.2025.11.23.01.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 01:26:39 -0800 (PST)
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
Subject: [PATCH 05/10] rust: kernel: Update ARef and AlwaysRefCounted imports to use sync::aref
Date: Sun, 23 Nov 2025 14:54:33 +0530
Message-Id: <20251123092438.182251-6-shankari.ak0208@gmail.com>
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

Update call sites in `i2c.rs` to import `ARef` and
`AlwaysRefCounted` from `sync::aref` instead of `types`.

This aligns with the ongoing effort to move `ARef` and
`AlwaysRefCounted` to sync.

Suggested-by: Benno Lossin <lossin@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1173
Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
---
 rust/kernel/i2c.rs | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
index 1aee46f59460..c50ca464d87c 100644
--- a/rust/kernel/i2c.rs
+++ b/rust/kernel/i2c.rs
@@ -17,10 +17,8 @@
     of,
     prelude::*,
     str::CStrExt as _,
-    types::{
-        AlwaysRefCounted,
-        Opaque, //
-    }, //
+    sync::aref::AlwaysRefCounted,
+    types::Opaque, //
 };
 
 use core::{
@@ -32,7 +30,7 @@
     }, //
 };
 
-use kernel::types::ARef;
+use kernel::sync::aref::ARef;
 
 /// An I2C device id table.
 #[repr(transparent)]
@@ -408,7 +406,7 @@ pub fn get(index: i32) -> Result<ARef<Self>> {
 kernel::impl_device_context_into_aref!(I2cAdapter);
 
 // SAFETY: Instances of `I2cAdapter` are always reference-counted.
-unsafe impl crate::types::AlwaysRefCounted for I2cAdapter {
+unsafe impl crate::sync::aref::AlwaysRefCounted for I2cAdapter {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
         unsafe { bindings::i2c_get_adapter(self.index()) };
-- 
2.34.1


