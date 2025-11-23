Return-Path: <linux-pwm+bounces-7667-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79851C7DEAF
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Nov 2025 10:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3151334EBBC
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Nov 2025 09:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9457328D8D0;
	Sun, 23 Nov 2025 09:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQDo6+PD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD7F273D81
	for <linux-pwm@vger.kernel.org>; Sun, 23 Nov 2025 09:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763889948; cv=none; b=bZQIR+1tJzOg1fAQIE2zM9t4xvXNft/1ySuSKwHC59ttiEHQ7SMj9csemOiwqRR8AFTpbwalhWB0d+BzUy1eVYPMclA6FJlozOXhxZnXfUNmZHNlMEUsabIZzLWnt0s3AJb+Ijb9IaHLweKX3Hwl/O734x1ujsrswYXbEFCUjew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763889948; c=relaxed/simple;
	bh=wTWM3QKYInKA4bBe2L2dZ9eCGX4hj8ZHtci5RLiYGQU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m+WbyCde+PUauc6u0gwiVT81RWtKfhU+nBhe+wgAPrxaV38IoDnNPBrOAuw8lAU25GMuRp58iDVRqlKudK1Fcky3U6S+iP2q7BJAua9aKg7Qr3KKQISLEzYHgcJpP/oAiXGvybp0CJoyQAc5sA/ylOUlvplhZR6mWt2YsW0a0u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQDo6+PD; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2981f9ce15cso40083765ad.1
        for <linux-pwm@vger.kernel.org>; Sun, 23 Nov 2025 01:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763889946; x=1764494746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHBuqhkFJfYaNnj9M7q8FhjsYY3lIhigbe8268nPJsA=;
        b=aQDo6+PDcehdU8I5RKMouIxayplKOMMKfEcBz2lZB87b0cCOPIwVTTdGf6uoyRETbu
         HUDeAw9lYgtVwww6rNOlYQhozpKSax6WoLl/uwtTLmS5Mu0M350ACJxhzcoQOYtnDeZ9
         Bb+jFItkhpqLWFQcBSFqXljdjvcfoYdYlMgnSEKItzZ/vttipCbqWIN+AOzxp+++GzDi
         17KGvz5FiE45TbgELI5exD0AZ+/Lom0He3rzCBV5IWuaRecEO5qcnpwCcqzATvi9rp/2
         rE27TrdO6thYIFsBds7i4Tso2u/DcHcog2g6wHXwxbRfg3qMo0MwWocQ93Q41/D4Q41N
         potA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763889946; x=1764494746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BHBuqhkFJfYaNnj9M7q8FhjsYY3lIhigbe8268nPJsA=;
        b=nwZxdN1T4vhCiwB7BitRXTaseXoHJfzbjTfqr1gICjI5wTIfQJU0vg/paxdSC2nH1o
         ThBQQN1zcjiaFugtNBHSXrWzo+uHisITfj8RcKEz0R9JClH/7bVQg/Q0D/p8NJEi1ftX
         Gmf1zrvjENuuC/BJrG3VhLP7YJmeDzw5/xzfIIRMIrWKwe91MCcqeAwhWnvg3L6oiN6C
         wHEQvMtrhfaLPHc9gKL+egUiw+IEYBizrJDxTIniVKlZlTkHxNFiCiKtciSXJaBt2MlZ
         8KUlO0yqKlotQle9/1M+CzVEy0gXDxlWWKMlQnI+YdyO1nzB5dljoToe/npUIVzPpIOY
         WPgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBD36adgATGTUo5nbUBacrsvqBAxp6sB4lLE1ImnZWmQdRDIBCojGiS4QBKUgyIXNphEcuBRnC0Ls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx84IdG+/NVFvYbb/mUX7yexatttKOCIIsMsfFhyV1J83y6Rjz7
	FFloIsVm2nKMDOdBtDi7SE2wRg57y8tiS7AdCnAieWQzp2akqVOToBmN
X-Gm-Gg: ASbGncvjmpWZnqOtr2WL7UZaZsAgR3oMmKpGF5SGBxVcnXv9IuhSJOjjIM9Z+XJDcWY
	Dtwc0YI3lWlfwXTyQpI8iwsIFqV9O6pR4Jdw2fa6V7482ARms2IlnIqMMu0lO9OGM99uPFtComN
	DJx5uOtz01HilTS1VbkzRqo+IQyUGaIA7JUw8Wowe5sKituxncG1afu/V/WcwQdaLvjMbau65/b
	mqR2tyHUOWticcsyxcXySJb0tng+4DqN4W/JZjJyDAanQbnwnht6Z5+u5aazvEjjRxY+scEhtOt
	Awzalp+3nBeCPm8WtPuz+kG8vZuizRQgjcjTNyqpcrDzRiCQtZCXCerPs1F4L7SabWyvtxou1d3
	J/x6P57p5c6bs4g+YXNNdaiEsNLY1ylltwLZXLXnUg+Z7yDsks6ifhqSIhk6lKnRy028BbLrFwG
	UriaOHSGXI5ap4OYFb2M5ST013lA==
X-Google-Smtp-Source: AGHT+IHeRFkTHVTA6Srefmm0HL5WijnlyHgpdTjb/dQ8CxktDbPnk0dZz+0OIDZ55NxQOWacfTdN2A==
X-Received: by 2002:a17:903:947:b0:28e:a70f:e879 with SMTP id d9443c01a7336-29b6be8cb2dmr88701485ad.1.1763889946269;
        Sun, 23 Nov 2025 01:25:46 -0800 (PST)
Received: from shankari-IdeaPad.. ([103.24.60.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b138c08sm100811105ad.25.2025.11.23.01.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 01:25:45 -0800 (PST)
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
Subject: [PATCH 01/10] drivers: android: binder: Update ARef imports from sync::aref
Date: Sun, 23 Nov 2025 14:54:29 +0530
Message-Id: <20251123092438.182251-2-shankari.ak0208@gmail.com>
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

Update call sites in binder files to import `ARef`
from `sync::aref` instead of `types`.

This aligns with the ongoing effort to move `ARef` and
`AlwaysRefCounted` to sync.

Suggested-by: Benno Lossin <lossin@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1173
Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
---
 drivers/android/binder/process.rs | 2 +-
 drivers/android/binder/thread.rs  | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/android/binder/process.rs b/drivers/android/binder/process.rs
index e5237e9ec552..1409129ff82a 100644
--- a/drivers/android/binder/process.rs
+++ b/drivers/android/binder/process.rs
@@ -27,11 +27,11 @@
     seq_print,
     sync::poll::PollTable,
     sync::{
+        aref::ARef,
         lock::{spinlock::SpinLockBackend, Guard},
         Arc, ArcBorrow, CondVar, CondVarTimeoutResult, Mutex, SpinLock, UniqueArc,
     },
     task::Task,
-    types::ARef,
     uaccess::{UserSlice, UserSliceReader},
     uapi,
     workqueue::{self, Work},
diff --git a/drivers/android/binder/thread.rs b/drivers/android/binder/thread.rs
index 7e34ccd394f8..033af3ce352e 100644
--- a/drivers/android/binder/thread.rs
+++ b/drivers/android/binder/thread.rs
@@ -16,9 +16,8 @@
     seq_file::SeqFile,
     seq_print,
     sync::poll::{PollCondVar, PollTable},
-    sync::{Arc, SpinLock},
+    sync::{aref::ARef, Arc, SpinLock},
     task::Task,
-    types::ARef,
     uaccess::UserSlice,
     uapi,
 };
-- 
2.34.1


