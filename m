Return-Path: <linux-pwm+bounces-7670-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D25C7DEBE
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Nov 2025 10:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BC3E734EA51
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Nov 2025 09:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313B228D8D0;
	Sun, 23 Nov 2025 09:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g08ung1u"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEB52206B1
	for <linux-pwm@vger.kernel.org>; Sun, 23 Nov 2025 09:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763889990; cv=none; b=LjvffYLd0f2Ve/9YaCVbfE54nKaf825n/0g8CUJjdxQcTH30ZRFgdATS7coIStEUiDbAMYMYKHE3yuEVFr8G5ONo1fYjaZ1PO5gBH19QSylcCbbT6DAAPlHoOfZbDyJa0KlQY4EbdadfKlK+IHr8yROd4bmm1qV4nWIZ7x/Nt6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763889990; c=relaxed/simple;
	bh=jKBvFpuQLngjk0nEFK1PjUNzyF0X15TDwoo+drtNhv0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FVlrBnzUxgY2XjDel3VikKA5oKwOfMVPWowbJOwko8Co68Ti6JXQpNuFPqfnjPwUXvAu0M7yU+NagXdHyJvc7zxB81mJA1dpDdHor3+HIKDXWeZMYJzGD8YNfTtQmEq+LaOQtrp0H5xZOdymVp3t3NYry7WIEdiVboln+bUgy4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g08ung1u; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-29845b06dd2so42260675ad.2
        for <linux-pwm@vger.kernel.org>; Sun, 23 Nov 2025 01:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763889988; x=1764494788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xs0t3Szo5vFHo7IPg5XaI/zhW3TrAdFJK24NyqJJsf8=;
        b=g08ung1uBsv/G0ED/cmalHaD4lENygaTCaXM5fwTBcoMyLZpY5PvGozrxH1KZknDYd
         pTmRSALl66e6tSKeLseZMUnMfjJSUOQtIEtAIuzcqo9btW4pWkXPqwg+CY+LELsRzqNt
         UnGjvcNDEjKlRI3Wk+N/vK2z3R8tfrub7pQbyr0CygxrLzbauMpuv3pPgJPE4Jpb5WQT
         E0sJpPCT/2H/x9JWKbO9XNgRcG+aLksur5M+9vpu4XSqTR7uxqGX6kJ4xBxnBh85PkdF
         RRsj65bjrENsAVa7pKKOaGt/fwVtIIxnq13MmkNZ75MdSOmC/k7mWKqJ8wouhfcc4Qbr
         X88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763889988; x=1764494788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xs0t3Szo5vFHo7IPg5XaI/zhW3TrAdFJK24NyqJJsf8=;
        b=sJ2jOHfLzT7ezrEA+Vxs+2aXI/4PrizezQ8LvhFaXmeRMymzGcoTgWfvzPAqhftV3M
         meHvEj8hCrCMEhkty5wV/orqSu8Mq2nTsUUaPFXP0I8krOHaKvEgcL4i9EWZPc9D0QkU
         kvYyqM7J4d0TQ1DlQFMqb8o2BHscShpSj8iw2R1rkP6QzVi2ADwWAWUqBRuIXJz4TLrP
         YZnKbFHn41SpalRxMiLqEJIhC3jflLGl9laC4Rh+ytUQlYVZVjoPPWdLQ3mqHJV0nUV9
         n3QxwQEXhNPxhWo/6gbhEdv6SlE745xzNxF0Th7xSjcBBFiTPj95yHX9Rdht2Gi+rVq/
         J1HA==
X-Forwarded-Encrypted: i=1; AJvYcCURiZb1t9L9ee7zxpGJHw5nwZVKYK2VWgvlXrzHF89Bp+vgv+poaQ970DqoNy46gzoxOf0iks6dCFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwTL53UIvr0GPaqBy7hWbhyqnF5cuqd1hScgzhytbqdtoTnggp
	AD/LX6+pSxz1fH7O4Hd9pbQqzL3V9OKrMK0RkIgsL2gw/CnnBw6Gt3tY
X-Gm-Gg: ASbGnctmK+gsGQBJkjZwbXI3ZpedmlOyOKBR8Scy0CaEMqV9tUi4ZXXr4smzn01PEfy
	HpahlqrW6VOVgkD/Jc4FA0fspIOPtgCTd15T4tuTZRYFRQ1Fu9S1UPQG4LvasFrmIdUKwhFP28m
	SdIY3HMbrakc06ACZ2/WXpKWM55q9xRhsXlHpC7BHkSO3p0RHPBjJ6wiXOm30K6NCqwVbdQ/l9D
	+33+nUYc2/hifP3ky8QJ2wCMWW5mzg28shEtZoFilCKHaZfPv05nqydSb39LrJN6Lb3CBHhEqiu
	er0FMvgV8yQSc9CfgyFV5sCCN2kGNC7Z/lXFE9OiQoyub/vkFlAcQ7v9n7AcapL6dJfUnfGqSz5
	HUeLM+w3/xhwHp062hpRJ/7lEhtlAcRhZLrmufM84Q9ZBxLQWgViJStEOAY+6NxDDe11sqghZ07
	ABp5o+0ThpVUxD3i+mAt8busryvw==
X-Google-Smtp-Source: AGHT+IHrOOJNJDa2GgrTIgoioCLDvBuXEfSk2IH1c+DBdbSr+pLO2PBSd1zxccfzPHswbjyfTYl0aA==
X-Received: by 2002:a17:902:ccca:b0:297:f2e7:96f3 with SMTP id d9443c01a7336-29b6c6b693cmr97059755ad.50.1763889987877;
        Sun, 23 Nov 2025 01:26:27 -0800 (PST)
Received: from shankari-IdeaPad.. ([103.24.60.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b138c08sm100811105ad.25.2025.11.23.01.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 01:26:26 -0800 (PST)
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
Subject: [PATCH 04/10] rust: drm: Update AlwaysRefCounted imports to use sync::aref
Date: Sun, 23 Nov 2025 14:54:32 +0530
Message-Id: <20251123092438.182251-5-shankari.ak0208@gmail.com>
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

Update call sites to import `AlwaysRefCounted`
from `sync::aref` instead of `types`.

This aligns with the ongoing effort to move `ARef` and
`AlwaysRefCounted` to sync.

Suggested-by: Benno Lossin <lossin@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1173
Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
---
 rust/kernel/drm/gem/mod.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index a7f682e95c01..76e6c40d525e 100644
--- a/rust/kernel/drm/gem/mod.rs
+++ b/rust/kernel/drm/gem/mod.rs
@@ -253,7 +253,7 @@ extern "C" fn free_callback(obj: *mut bindings::drm_gem_object) {
 }
 
 // SAFETY: Instances of `Object<T>` are always reference-counted.
-unsafe impl<T: DriverObject> crate::types::AlwaysRefCounted for Object<T> {
+unsafe impl<T: DriverObject> crate::sync::aref::AlwaysRefCounted for Object<T> {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
         unsafe { bindings::drm_gem_object_get(self.as_raw()) };
-- 
2.34.1


