Return-Path: <linux-pwm+bounces-7668-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B93C7DEB5
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Nov 2025 10:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F067134EC76
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Nov 2025 09:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4D92989A2;
	Sun, 23 Nov 2025 09:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nmj9gQSn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C4D284671
	for <linux-pwm@vger.kernel.org>; Sun, 23 Nov 2025 09:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763889964; cv=none; b=X0gjiRqTnh411uXXxxJRXSarhHFNWfATh18Dcbu7O47ussk5ogjD8fcKhj4BZ50rzgY3kuTFqVpNNzRHFNCFMpGH6yPl1n4cHy1Ww5onWtZapztc+jCDBriUgjMhHJn++m2kIa3jBGlNH9PebpEyz2HjBzNz1HxTsUHnrCLHrmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763889964; c=relaxed/simple;
	bh=IPEwVncrH6ErF+52BbShzNtxbAYEnVjh2jDi81dnwhs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AsGshEKcEirzDZ8Aw6yfpHiVl0GUhB6kiuO8pCAuRfEsD/gJQtJ1+NVOrFl05mTN5WdTLhmEACPOcvNT5VI9MHFoEKD+7UUNbul8jkCUx8rLbSKU1AJ3UPBHKi5y3UZCqDM1p41h90Q8y82rhFugvMtf2ME3/HRbbmBJ/yTUGBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nmj9gQSn; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29586626fbeso41368135ad.0
        for <linux-pwm@vger.kernel.org>; Sun, 23 Nov 2025 01:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763889961; x=1764494761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTc0MgLeOubcwcfQp1wa7TpaWq1ZdIbTR1ydG9HUjeU=;
        b=Nmj9gQSnA7QNCb1Dh+6/n0OnFhYZYyF9gh3vEx6tyGp8L+C3NNnyDfODYiUUmDEXXN
         ZzQUnpjaSGWFVnaUwww+HiswrApMKwErt252O2s4b6EttTal3WZoWy+optyYR0wHTKmM
         gCfjTUqd5ZF8paL+WldB4/oYL53CuawhPPIBMMO2yTQlGF4zGnafAErMmhpPtdP5pbDB
         u3bl/aSLDzgxONQ6mFuKJzEmJxb5j/CPY91ZAMuFYDiqEADqvayQ46T3D+qI2VpnFJK7
         CuMfrr9dQZ6+HdJ6Rjb91EP1yjvWFcIVC+HM3ob1pZdSfcclE3cQk4/XvwB/nbmpmKw6
         Nsew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763889962; x=1764494762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dTc0MgLeOubcwcfQp1wa7TpaWq1ZdIbTR1ydG9HUjeU=;
        b=Nz7+7xpDQPn2TeFlAB/CWIgPoDGDtzLUNs07p0hBo0MA4sxSV1IUik+yRl5mK0xD4u
         /20ftMddV7lCD9JqMRQRz1+T9i+pntRxe6AoxHeKknVVs/NnxUAV80X21JdxtjXJjR29
         r+pc+og/AQ/DMC17Fnff/pjvOrC+UbMAEDChnywXNDMhGy97hKbAFKX1ZX8cWJVUvTxS
         LXGg7/XBlFE+Io3n2E6n40LvKSp1uPH+OWU0ElQ1GETTRZDwUUIe0PH1h2rrEyeIkf1w
         P9Rd9ahGQ5DJkWbCavL5WJHC2/o7zFjhkQZ51G7zsg0qi4FRvmvLi1RuwEVZLoDjEJrS
         gJyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdnbvRpA6AdW4mHdxpeqwHaEPFdYjtEhU12RnOlnTrvnBIgkLh7Zg3jFGHm+w+jm1XkzUYAMamO44=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeeCfnK4gzmS484UQyba+24LX1xyz21CJYAmCTzOiOaPXQ99Zv
	A+rjO9CYDqVL3hOOHK1pEKqiyH5zWkSiX5V0BHy4OqdJBlYGqVBQhZ2r
X-Gm-Gg: ASbGncuvV4/24Y9TcablIKDub+sTvkvZSdcr31jn9nP1mBwxtKgdDynUR5rHUH1Eas7
	3ruvhKo8mTy4WQgfuIcKUwpu1A/C/gzFEnkl6WAqmnL9F0TL+UlHNGMPMZJ68AwCoFLumlotr/F
	ae47q3ZtK3mWClmra+QKH2Q+UzASr7IFxfzyKLpixu3sqoiC3Z7r0peHP3/NXZ9ZV8CYNuBJwsL
	RsiZkEa9xaQD1KMWGsYtONp7AN6ShkX6tXqZoDn0lLuzarZM3a01xtkT7MxbW6OPe2HpSOz3s+U
	wktcvshVl/Ou40c0VzOfkHDeHE53bgWXZ9qSkk4drtoEjm/kjVM2n7jD6bAuP0nLBcolP3nF/jd
	0bpTXTEv7MlJRgx4qoTUhrjHV7zeO8+2NhZYOaRWgA76NOGZ69lBiQ5aP7XYL903mU/KrrpED9E
	biYkjA5UKySgvyLCwKAFg8NFDyqg==
X-Google-Smtp-Source: AGHT+IFojSe5onG6l0184Qd+32Us2flx99qw215kwkBj86ninqiLXlY2kvADM9/iJBS4TWCcsIsZyA==
X-Received: by 2002:a17:902:f548:b0:295:4d97:84fc with SMTP id d9443c01a7336-29b6bf3bcc0mr89250955ad.32.1763889961522;
        Sun, 23 Nov 2025 01:26:01 -0800 (PST)
Received: from shankari-IdeaPad.. ([103.24.60.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b138c08sm100811105ad.25.2025.11.23.01.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 01:26:01 -0800 (PST)
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
Subject: [PATCH 02/10] drivers: gpu: Update ARef imports from sync::aref
Date: Sun, 23 Nov 2025 14:54:30 +0530
Message-Id: <20251123092438.182251-3-shankari.ak0208@gmail.com>
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

Update call sites to import `ARef` from `sync::aref`
instead of `types`.

This aligns with the ongoing effort to move `ARef` and
`AlwaysRefCounted` to sync.

Suggested-by: Benno Lossin <lossin@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1173
Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
---
 drivers/gpu/drm/tyr/driver.rs          | 2 +-
 drivers/gpu/nova-core/gsp/sequencer.rs | 2 +-
 drivers/gpu/nova-core/vbios.rs         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 0389c558c036..264c2362237a 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -16,10 +16,10 @@
 use kernel::regulator;
 use kernel::regulator::Regulator;
 use kernel::sizes::SZ_2M;
+use kernel::sync::aref::ARef;
 use kernel::sync::Arc;
 use kernel::sync::Mutex;
 use kernel::time;
-use kernel::types::ARef;
 
 use crate::file::File;
 use crate::gem::TyrObject;
diff --git a/drivers/gpu/nova-core/gsp/sequencer.rs b/drivers/gpu/nova-core/gsp/sequencer.rs
index 2d0369c49092..9c689f0b21ab 100644
--- a/drivers/gpu/nova-core/gsp/sequencer.rs
+++ b/drivers/gpu/nova-core/gsp/sequencer.rs
@@ -14,12 +14,12 @@
     device,
     io::poll::read_poll_timeout,
     prelude::*,
+    sync::aref::ARef, //
     time::{
         delay::fsleep,
         Delta, //
     },
     transmute::FromBytes,
-    types::ARef, //
 };
 
 use crate::{
diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index abf423560ff4..7c26e4a2d61c 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -11,8 +11,8 @@
         Alignable,
         Alignment, //
     },
+    sync::aref::ARef,
     transmute::FromBytes,
-    types::ARef,
 };
 
 use crate::{
-- 
2.34.1


