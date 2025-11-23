Return-Path: <linux-pwm+bounces-7676-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B549C7DEE2
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Nov 2025 10:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D22254E297D
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Nov 2025 09:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FD829A309;
	Sun, 23 Nov 2025 09:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nP14G4Ei"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0ECE296BC1
	for <linux-pwm@vger.kernel.org>; Sun, 23 Nov 2025 09:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763890068; cv=none; b=jXujIEn5ZinOypX4YQhSg8TKCDa3fna1ClvbRweOrpyiMZB+3ksNhbIwLT6+Fg7ummkCgrCPEdhqw9NA0BZm8O93xyTcEJwU1GJ/0thOlMWtNUH74Ng1IT5FN8yX+7N6MCSLBp2ogqGW7kBGPJ0ZUUNLVUGG+WCU61sw+B4DKz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763890068; c=relaxed/simple;
	bh=EtbIa6WcARTT+W4TNMAMANC6i+cL8dmR+u7Z213Dj/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bwMUHddfipilRPB634WeNB+Vezx3fzkZZ0H1VQemaaYI7KYSPYFJ/gAw1NDVMZfkY4icSX4Vgon37CwMgjINuoCzYNq7wHYyHSKhenRTt7g2CARNZNCGzhg+EfwnH/hkctGXEnn6A+SMicKTF0AgDIREmddtEvz7iaCptF2lDSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nP14G4Ei; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-29586626fbeso41374655ad.0
        for <linux-pwm@vger.kernel.org>; Sun, 23 Nov 2025 01:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763890066; x=1764494866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YfyBoPWUbKIvicMj0KWg+NHqLc+OcZyzD61cN8gqS4k=;
        b=nP14G4EiAIxsFMqXc5VQa9Sod/12GminXv9/Ql5T3ogm+HUDRKYf0HODr1VmGsflJw
         Q9bhdstzJ8131cHjBGerQW96hC8NZEMD2gz2GKq8l8Xy3l2bv4BSnqCcGQJXX6jtIae9
         Z4rAwGEkcj1dSa2vJTYoec0PrliO+Uet4Sh7hTXZOszvjv2guy9TCEBWTSlKd66lFK+p
         6qf/KpF+wRdn4UghuFeMpseXYXtDP7dxWctTdr+Wpv2lNIj3qss5ilcShlWZZASX1u/J
         r0R8VIQfpGB54XDrLsZyvpooJNUDG/Ha//01SKtpQ3PjUfiwgnV43uucvaOX+pPuuHZP
         JnKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763890066; x=1764494866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YfyBoPWUbKIvicMj0KWg+NHqLc+OcZyzD61cN8gqS4k=;
        b=SYWPMb8nks4MNCzoOMwzBDfqQ8ld63bx2HFhzt8gdeORqrdLG+hIeJUGjqRGUUSCxe
         xmyog1C16purSYDc/2fXOTLrjMA2ms0W3pad8Pa64sPwBJt66EklcJf8azWyWGAixAcz
         +0jYK4e9U3NMTB63NwVWGXIBo8ZDSBH+gK0vSOP/BxuuP6o6jtX5uurDijsiFwuBLqNB
         KPT4jDlPmYQbgp3b63nHFLA9pxSKoXIckD0Y/CbRHJ22vhDgs/tHloj/+QQgMmsetnHk
         wnBPjZD3GmZtSP80qtJHTPKHWjLH6S7hliKdTiIAbi/HenUNfbYkkwbLHHkgydx/7mRc
         x+8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVgZowG+1s0ywsAKfNtu8+yLAYYwbn13In3EQq144F8Tmh8Fkp44oJ1c7ETUbgSyM7PFcBuZY6wrio=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw+1cz7zRDrNweHSDtudg2zFjRPkRtTS/6Q1edbwEvYwVG6mr2
	KEfx0Uje+47EVzguX+rKdK92TIu3Kq5W+H/6Fqvst/6Xippl3aBSWNzD
X-Gm-Gg: ASbGnctEnxy0qKoienxgM51DCMOQ7fhQhYrYPa2d8t6l2wDIagzTi0CLuIXN+cIaYRn
	9TfE466M82EzydHVNGp3mxWQ8ZOmLq72O/2533bo2nfBEnpTx6FSZKrXJn3CopB2w7IpTGVIaCq
	PRPsV0tuBZPIO0soDJthfVstgvBhbKyYm0cWBXI/mc0eptdW8qWenbmvEblRrRZo3RooGZkowiJ
	fV9ECSpZ/cxDCdmtM8WydCE1JjQPuhB41LlmXI2wGA/f+I6QcH8NOfKUvxiK4vVbLGgmEc74GRq
	OpDdxPhRZ46zmiWyGxS8ZdV2dB+35YyJocR05GjnAQ8S7116C3xMssZxYH6iiie3IqEd63LyiGg
	3Z69Lyww9alXV9aLQXk7CHFRs2NLg00JbcVKZsyuOi+nDLIDwKoLKumGLLXQjlgNLebQQVqgUl8
	51JjtVvJU8o3S2eB9S99f1Ag46jg==
X-Google-Smtp-Source: AGHT+IExQFsNPtBs1Xj5miLvxmintvWHhiICyxn8q5+dbslUtcud5J24RqOaI8yRZ14HHbP/D4VKng==
X-Received: by 2002:a17:902:db0b:b0:295:28a4:f0aa with SMTP id d9443c01a7336-29b6bf5f036mr89773335ad.43.1763890065882;
        Sun, 23 Nov 2025 01:27:45 -0800 (PST)
Received: from shankari-IdeaPad.. ([103.24.60.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b138c08sm100811105ad.25.2025.11.23.01.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 01:27:45 -0800 (PST)
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
Subject: [PATCH 10/10] rust: kernel: remove temporary re-exports of ARef and AlwaysRefCounted
Date: Sun, 23 Nov 2025 14:54:38 +0530
Message-Id: <20251123092438.182251-11-shankari.ak0208@gmail.com>
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

Remove the temporary re-exports of `ARef` and `AlwaysRefCounted`
from `types.rs` now that all in-tree users have been updated to
import them directly from `sync::aref`.

These re-exports were originally added to avoid breaking the
kernel build during the transition period while call sites were
incrementally migrated. With all users updated, they are no
longer needed.

Suggested-by: Benno Lossin <lossin@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1173
Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
---
 rust/kernel/types.rs | 2 --
 1 file changed, 2 deletions(-)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 9c5e7dbf1632..4329d3c2c2e5 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -11,8 +11,6 @@
 };
 use pin_init::{PinInit, Wrapper, Zeroable};
 
-pub use crate::sync::aref::{ARef, AlwaysRefCounted};
-
 /// Used to transfer ownership to and from foreign (non-Rust) languages.
 ///
 /// Ownership is transferred from Rust to a foreign language by calling [`Self::into_foreign`] and
-- 
2.34.1


