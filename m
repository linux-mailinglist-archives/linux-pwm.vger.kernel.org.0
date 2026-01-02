Return-Path: <linux-pwm+bounces-7838-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CA6CEDFDD
	for <lists+linux-pwm@lfdr.de>; Fri, 02 Jan 2026 08:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4040F301672B
	for <lists+linux-pwm@lfdr.de>; Fri,  2 Jan 2026 07:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6452D24A7;
	Fri,  2 Jan 2026 07:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHlwsphG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FBA2D47E1
	for <linux-pwm@vger.kernel.org>; Fri,  2 Jan 2026 07:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767340334; cv=none; b=XuL0Cxi8XS7MawV7JjmXtcXBGxx3dhNadF0Qtsu65N14vrtKKesPQvjT3kg+HFF2glZz20syxPyy0RxlY1AoQh2iGC71GCxkfPI/0WdulKJ1oEYakgIwUHB6Vc+waGWXnpEQMRPoOHm5ILiLJnbKL36WSkGoV3Drgnwb3pjnavI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767340334; c=relaxed/simple;
	bh=2WoOtUgVnGngo1opEuioDWIeyb+NETiI002qJthENXc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B8N816SRz1S9P6NHAofWDU2vmJ3Z4rtaP8MpE8Hvv/IMs/hsdi8/Ja9LKskL1cSl+gpl/J2hszTbLRBAg5WznBX5Xaqyfsmr7DiycfGe+HNxH6mr+Lwcd/i26Hs4gU4RhakDSkX716WCr2n39HG1tsKn6D7x64a52UG5Y5EFRbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHlwsphG; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3825ae23d95so41326301fa.0
        for <linux-pwm@vger.kernel.org>; Thu, 01 Jan 2026 23:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767340330; x=1767945130; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1SwB68mV4E4rv2JZ9xhD6eCQLLJ+hlAXbyX47oNAs8k=;
        b=OHlwsphGqYV1PxIYdVoCkCynRB7t3WNNELyz2GqjUiLfgv9FQ6T/nyUV3LE14ocmtO
         u/Y3o8HnnkihsztFmnBrALT0Nj6nz5ueuhXH6lVUKravVcL/bhDe9x7W2vqNCSI2KqBQ
         D1ksbo5hubTwAWjzrhKAuiZdx0WtoAbk+iMrzcF70E+31nhcDXZbMAFvJ9rzidFDBTZ+
         oew6y144NGV2+etWakBc78BXRjxA0LlPATS7otsUUAgyuFt8hHJ01po5pkBZ3DjcTQmA
         18uNTF5AYZcB+VYk6fgOAz1MzpsrkEo9dbh9MyU6HL9yyWusAaVkYy9rVN29WyQy3LoF
         lnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767340330; x=1767945130;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1SwB68mV4E4rv2JZ9xhD6eCQLLJ+hlAXbyX47oNAs8k=;
        b=ppzo6w6lDoZzSvfcqQm8z+n1DrFuKQJOrLFlw2zI0xWDsBcbL5+c3q5KXYXUJExHyo
         7eMY38Z4BXtmMcr24oTpgo1Hoqf6YhMf2gmmn8o2wuUWdbMi3rKUZy04NQb1wdSGddWu
         jBfMWuxnV1IFZ1ivV4UOwHa/uCyTpq7P0nqgwEy25S1raCUv0DOHBZVYCi1HGfE19JkY
         70vegHe1u6k/K+tiMnFpJpgIdTrY8k21KcbWgyBwwB66pTtM3x20hob25R4jPvOA/PpC
         vYV2cAh1DZD9FQ3ZMnqFVwhaXZ8YbgBMQDbWEqz2HHRcYYxyjwxExrqfmI/GnEA00/Tg
         vWkw==
X-Gm-Message-State: AOJu0YwyqclEABOaJO5kwwZ8FRzcukdQO3gD1g7smsxDjCaqv7ZBfpI/
	ZwbXvPyk8ezHeOScaJNgm96ZWlHJGW8pJfZTICWKkLd/TTnarzScdpCB
X-Gm-Gg: AY/fxX49DWQ4hKJxHWeaj1gDO12jaGiJANKMvBEFznNlJQPaxX31/35/el6bK1AMJ4R
	zGqQe350odZagPyxqa1KovTTVCto/nMl26EsmCuIc4ToPKuUo18RNqhKfNkoCzjEnxIUXPovCKO
	lGkP0X4KOklLasQqAqDuo42zDRtsWfJX6AureP1JeA0r04nei1PuMqCOIQh8UoT1wHLeDFm4U4F
	cJhwFFD4tODafGYQmFgsiT2EDRF8p4zBBuOxqtFewJEK3VTsqbKO7p8LKD+VoaF0JXLIRZH/IHg
	VpAlmlha/Rzj6HAqv/seKRMrOvx3ywfdNVB3viUDW58U37FXsxffjJ55nSVbBp1Ca2WT6C6Bziq
	O0MWSu3qHLCIgPtwZw7+hyhvecD5RlMLPBIjShv6dRol27x8C+qzJX1c6fpCtBNcc8SzfQ/Ry4Q
	ZONtVSQIIdOBWUC4F3mOsqN1H7IOK7QTB9X+BsiNlhNsiT
X-Google-Smtp-Source: AGHT+IHVj5/7lah0TGvVE6zyPu1B58rptjPgdldYkgOcVb9OgWJIwYAaYacpr2ejC9qUvEAECjGVeQ==
X-Received: by 2002:a2e:ac13:0:b0:37f:cb34:211b with SMTP id 38308e7fff4ca-381215ab664mr112653631fa.18.1767340330304;
        Thu, 01 Jan 2026 23:52:10 -0800 (PST)
Received: from LT-5CG5341NQ4.nordic.imtech.com ([83.245.248.13])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-381224de35bsm107688061fa.7.2026.01.01.23.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 23:52:08 -0800 (PST)
From: Kari Argillander <kari.argillander@gmail.com>
Date: Fri, 02 Jan 2026 09:51:42 +0200
Subject: [PATCH v2 2/2] rust: pwm: Simplify to_result call sites and unsafe
 blocks
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260102-pwm-rust-v2-2-2702ce57d571@gmail.com>
References: <20260102-pwm-rust-v2-0-2702ce57d571@gmail.com>
In-Reply-To: <20260102-pwm-rust-v2-0-2702ce57d571@gmail.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kari Argillander <kari.argillander@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767340323; l=6050;
 i=kari.argillander@gmail.com; s=20251219; h=from:subject:message-id;
 bh=2WoOtUgVnGngo1opEuioDWIeyb+NETiI002qJthENXc=;
 b=LoJkubWyNd2jMjezjwdbWhurEpJkfvtenzsBgKJbTe8DIMR+uSiA5DptNXTjaOJAyJwo1PxMs
 xWYZn4nKoKNAiVh8RCqCTzJ+4T4f4kRA5jbttOxL7yuEaq68pha+G8Z
X-Developer-Key: i=kari.argillander@gmail.com; a=ed25519;
 pk=RwSxyhTpE3z4sywdDbIkC3q33ZQLNyhYWxT44iTY6r4=

Remove unnecessary temporary variables around to_result() calls and move
trailing semicolons outside unsafe blocks to improve readability and
produce cleaner rustfmt output.

No functional change intended.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 rust/kernel/pwm.rs | 47 ++++++++++++++---------------------------------
 1 file changed, 14 insertions(+), 33 deletions(-)

diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
index 4f683158fc08..6c9d667009ef 100644
--- a/rust/kernel/pwm.rs
+++ b/rust/kernel/pwm.rs
@@ -129,8 +129,7 @@ pub fn set_waveform(&self, wf: &Waveform, exact: bool) -> Result {
         // SAFETY: `self.as_raw()` provides a valid `*mut pwm_device` pointer.
         // `&c_wf` is a valid pointer to a `pwm_waveform` struct. The C function
         // handles all necessary internal locking.
-        let ret = unsafe { bindings::pwm_set_waveform_might_sleep(self.as_raw(), &c_wf, exact) };
-        to_result(ret)
+        to_result(unsafe { bindings::pwm_set_waveform_might_sleep(self.as_raw(), &c_wf, exact) })
     }
 
     /// Queries the hardware for the configuration it would apply for a given
@@ -160,9 +159,7 @@ pub fn get_waveform(&self) -> Result<Waveform> {
 
         // SAFETY: `self.as_raw()` is a valid pointer. We provide a valid pointer
         // to a stack-allocated `pwm_waveform` struct for the kernel to fill.
-        let ret = unsafe { bindings::pwm_get_waveform_might_sleep(self.as_raw(), &mut c_wf) };
-
-        to_result(ret)?;
+        to_result(unsafe { bindings::pwm_get_waveform_might_sleep(self.as_raw(), &mut c_wf) })?;
 
         Ok(Waveform::from(c_wf))
     }
@@ -263,8 +260,8 @@ unsafe fn serialize_wfhw(wfhw: &T::WfHw, wfhw_ptr: *mut c_void) -> Result {
                 core::ptr::from_ref::<T::WfHw>(wfhw).cast::<u8>(),
                 wfhw_ptr.cast::<u8>(),
                 size,
-            );
-        }
+            )
+        };
 
         Ok(())
     }
@@ -284,8 +281,8 @@ unsafe fn deserialize_wfhw(wfhw_ptr: *const c_void) -> Result<T::WfHw> {
                 wfhw_ptr.cast::<u8>(),
                 core::ptr::from_mut::<T::WfHw>(&mut wfhw).cast::<u8>(),
                 size,
-            );
-        }
+            )
+        };
 
         Ok(wfhw)
     }
@@ -311,9 +308,7 @@ unsafe fn deserialize_wfhw(wfhw_ptr: *const c_void) -> Result<T::WfHw> {
         // Now, call the original release function to free the `pwm_chip` itself.
         // SAFETY: `dev` is the valid pointer passed into this callback, which is
         // the expected argument for `pwmchip_release`.
-        unsafe {
-            bindings::pwmchip_release(dev);
-        }
+        unsafe { bindings::pwmchip_release(dev) };
     }
 
     /// # Safety
@@ -413,9 +408,7 @@ unsafe fn deserialize_wfhw(wfhw_ptr: *const c_void) -> Result<T::WfHw> {
         match T::round_waveform_fromhw(chip, pwm, &wfhw, &mut rust_wf) {
             Ok(()) => {
                 // SAFETY: `wf_ptr` is guaranteed valid by the C caller.
-                unsafe {
-                    *wf_ptr = rust_wf.into();
-                };
+                unsafe { *wf_ptr = rust_wf.into() };
                 0
             }
             Err(e) => e.to_errno(),
@@ -614,16 +607,12 @@ pub fn new<'a>(
         })?;
 
         // SAFETY: `c_chip_ptr` points to a valid chip.
-        unsafe {
-            (*c_chip_ptr).dev.release = Some(Adapter::<T>::release_callback);
-        }
+        unsafe { (*c_chip_ptr).dev.release = Some(Adapter::<T>::release_callback) };
 
         // SAFETY: `c_chip_ptr` points to a valid chip.
         // The `Adapter`'s `VTABLE` has a 'static lifetime, so the pointer
         // returned by `as_raw()` is always valid.
-        unsafe {
-            (*c_chip_ptr).ops = Adapter::<T>::VTABLE.as_raw();
-        }
+        unsafe { (*c_chip_ptr).ops = Adapter::<T>::VTABLE.as_raw() };
 
         // Cast the `*mut bindings::pwm_chip` to `*mut Chip`. This is valid because
         // `Chip` is `repr(transparent)` over `Opaque<bindings::pwm_chip>`, and
@@ -645,9 +634,7 @@ unsafe impl<T: PwmOps> AlwaysRefCounted for Chip<T> {
     fn inc_ref(&self) {
         // SAFETY: `self.0.get()` points to a valid `pwm_chip` because `self` exists.
         // The embedded `dev` is valid. `get_device` increments its refcount.
-        unsafe {
-            bindings::get_device(&raw mut (*self.0.get()).dev);
-        }
+        unsafe { bindings::get_device(&raw mut (*self.0.get()).dev) };
     }
 
     #[inline]
@@ -656,9 +643,7 @@ unsafe fn dec_ref(obj: NonNull<Chip<T>>) {
 
         // SAFETY: `obj` is a valid pointer to a `Chip` (and thus `bindings::pwm_chip`)
         // with a non-zero refcount. `put_device` handles decrement and final release.
-        unsafe {
-            bindings::put_device(&raw mut (*c_chip_ptr).dev);
-        }
+        unsafe { bindings::put_device(&raw mut (*c_chip_ptr).dev) };
     }
 }
 
@@ -692,9 +677,7 @@ pub fn register(self) -> Result<ARef<Chip<T>>> {
 
         // SAFETY: `c_chip_ptr` points to a valid chip with its ops initialized.
         // `__pwmchip_add` is the C function to register the chip with the PWM core.
-        unsafe {
-            to_result(bindings::__pwmchip_add(c_chip_ptr, core::ptr::null_mut()))?;
-        }
+        to_result(unsafe { bindings::__pwmchip_add(c_chip_ptr, core::ptr::null_mut()) })?;
 
         let registration = Registration {
             chip: ARef::clone(&self.chip),
@@ -730,9 +713,7 @@ fn drop(&mut self) {
         // SAFETY: `chip_raw` points to a chip that was successfully registered.
         // `bindings::pwmchip_remove` is the correct C function to unregister it.
         // This `drop` implementation is called automatically by `devres` on driver unbind.
-        unsafe {
-            bindings::pwmchip_remove(chip_raw);
-        }
+        unsafe { bindings::pwmchip_remove(chip_raw) };
     }
 }
 

-- 
2.43.0


