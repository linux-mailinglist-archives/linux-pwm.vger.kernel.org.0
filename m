Return-Path: <linux-pwm+bounces-7673-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C9451C7DECB
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Nov 2025 10:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4DFD934E9C0
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Nov 2025 09:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E5D284671;
	Sun, 23 Nov 2025 09:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHUaIegI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D6921CA02
	for <linux-pwm@vger.kernel.org>; Sun, 23 Nov 2025 09:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763890029; cv=none; b=iNMn/1bMvY24BiIqP0e5eG5WkdWxRHl5comeraDIEeqz8+vWTLvoox/XiwF4jZxR5o6hI6+bUZziN0g6QpBXI7k0aBhAnVPUPzjJaHceml4GUlvxHRAoI9tYP2GJCYcJ9LeGA4++nsNXhDugqbjD2iILxd0etsmxvpZpQIYISpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763890029; c=relaxed/simple;
	bh=hswRjYzI10zhUsDjz+wkVowHp0MANy7svfXMu6AA6rA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gSzbNbKiZIvMFIZL0Co2d8F4ociYp/YFxp+z3HfspmIyAJrmgZPrl2K1vXhKYULP/brziRZJxc0SGV2DpYoefvo6qYP0nqe3LN+qHgDI5C4lwhzbPNqpgGECFDyT9lXhBQXTmubDxdZC/bzsFJDXClAEXoAtJJYcP7v6/OiPlsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHUaIegI; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-297dd95ffe4so28688175ad.3
        for <linux-pwm@vger.kernel.org>; Sun, 23 Nov 2025 01:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763890026; x=1764494826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxofK3PIJmJGptGWmPl6GxImW1KehJK8Ra0bi1cA/KY=;
        b=MHUaIegIDQOCo43fmEKY3VfYaRjaHxMRCjEJdRctUgEoSGnjge2xscSRhxisxU8SLl
         NJOeH6ADpX8QYPEvx01Jwf16k1rSrrqsN4O0MpZ20Zdv+4CSNKUTyvoIW56eoxd8Dpmp
         pYUoTjjP37fFEf70a3UvPetXiuceifTyDKvPplAmaqND2Tb4DY0t2PjixqOMwoODTu6n
         Sfh2RkxmKFUMoSkEh2cvc5S6paa6Tu5jIws+SKUMNGGdFdKR6VVSMvI17kni9GyERYCZ
         wsL4lT313URpHaa10qovYCCJauAnzm3FzwCqZjnTAPi2qR8mQeZUUFlKP2B1HTh460TS
         VMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763890026; x=1764494826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SxofK3PIJmJGptGWmPl6GxImW1KehJK8Ra0bi1cA/KY=;
        b=jPe3ueW6EfSAnzCXxC38G9R35v0RSy4H4xbCWhialbn6d98n+rO1fcVL/0lZmvIsb2
         ormiku1xL1LKZ3QikVK5Sk8Y2KxweaN5dCRAibbhbariyVF4rB+bdSLaLGH1PcEfFdJp
         w4l6BSNE3WDLN2X7WR4hB7zXPVecx2XhIioV1uaP5SAJGl8erK2/oxbvI2yKUuqpPWzx
         pK2s1kChwO2uzSCJfphH7vJXE0weR2q/zNfsYvNjAfZIXPvf36jL99V9bO7P4jBDYuvc
         FYAerw3C0zSvjHJCDhLPGQcS5y7Ti9uMedYPJCFrXcXE9n0YbOg5xVQUFkrdJDljyM1J
         2JAw==
X-Forwarded-Encrypted: i=1; AJvYcCUXiEwbHXUcwvCZuD9M3V7mQDisqC+Qj8TJ/9WxB50hyVW+nOQ2iuave/cnTzFCRtsm59IfCbzCYTk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi4KfkL3sJfH62TzcDJ+ZjrM6qhVj1DzMuGWJoIPcAWyRPMu5y
	iY+sCf8DnIsr4Nd3rKBPLASpKHl0pk03PWEuANneG4Tkg45joLNuMJxf
X-Gm-Gg: ASbGncvFmY0mZhaAfyTcc/7j5RDyxnpxs7pJblM7KVExas+1GwbdHTwZggURVNZde8s
	pl/gXWfcC+ZxS7ll8KcH8SYlKskbxOxjv3hQG4wWHdeyZeM0WiNf7KW1RlRfScZlZmG1+N5OWTE
	JtWEzNyuL8byJclrNFowgY86K5ni4yvbexX2X1ZJlVOwonrIUldO+tbUpUFTEJuoBgywyC6Rq28
	ZLzbHWyQTtEWZnH19qDsekMw0CUG+xbTpoXCvOZSyHJg1/Rw6wsqF/OGbrevODoQfzKJLt1ABOt
	YhGd/Gx1+NhmTk0U6aZHPmNt70r44ewsiGwEjaQ0MNK6GVO+JgRWk6Z9vAIgs6XlbXB2sD3D/c3
	vPcUShv9OS5e49PnYK7LWz4BVEJccXWIcSEXs6IcGvXzS4nOec0+31dYDthVP3EcDVSK/GtuO3Z
	954jc+hyB+eV4gDV5Y0iFNPl8FOw==
X-Google-Smtp-Source: AGHT+IH1U8t8hCw2WDyvXF/0DPfy18rrujnj6Em/QND/b9i4osv8+SLy39cyAfSRsaedSvrbycJTtA==
X-Received: by 2002:a17:903:290:b0:297:c048:fb60 with SMTP id d9443c01a7336-29b6bedf343mr95210775ad.25.1763890025910;
        Sun, 23 Nov 2025 01:27:05 -0800 (PST)
Received: from shankari-IdeaPad.. ([103.24.60.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b138c08sm100811105ad.25.2025.11.23.01.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 01:27:05 -0800 (PST)
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
Subject: [PATCH 07/10] rust: kernel: Update ARef imports to use sync::aref
Date: Sun, 23 Nov 2025 14:54:35 +0530
Message-Id: <20251123092438.182251-8-shankari.ak0208@gmail.com>
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

Update call sites in `scatterlist.rs` to import `ARef`
from `sync::aref` instead of `types`.

This aligns with the ongoing effort to move `ARef` and
`AlwaysRefCounted` to sync.

Suggested-by: Benno Lossin <lossin@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1173
Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
---
 rust/kernel/scatterlist.rs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/scatterlist.rs b/rust/kernel/scatterlist.rs
index 196fdb9a75e7..b83c468b5c63 100644
--- a/rust/kernel/scatterlist.rs
+++ b/rust/kernel/scatterlist.rs
@@ -38,7 +38,8 @@
     io::ResourceSize,
     page,
     prelude::*,
-    types::{ARef, Opaque},
+    sync::aref::ARef,
+    types::Opaque,
 };
 use core::{ops::Deref, ptr::NonNull};
 
-- 
2.34.1


