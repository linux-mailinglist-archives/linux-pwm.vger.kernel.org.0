Return-Path: <linux-pwm+bounces-7675-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9105FC7DEF7
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Nov 2025 10:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 079A43ABC1A
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Nov 2025 09:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EB32C1786;
	Sun, 23 Nov 2025 09:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FP1BbOBV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42A52C15A5
	for <linux-pwm@vger.kernel.org>; Sun, 23 Nov 2025 09:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763890054; cv=none; b=R4K1U2dWMDdwk+rAD0iBX9MhZG9G1cjcdPo+u46xYWh/qZMciQ81BgrwUJa8p+8RMP0OR0LSc/jTacWddJX7uZ3VNkjW3M29DAr1lnIJB5PFnVEqt63OE2Eb+CiFpGpb4nEJ/A9HLC9n2IVlwU+kc3Ge1nuDny/lZeu1wBHGv+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763890054; c=relaxed/simple;
	bh=ndUkYRFd3yqWPhWv94jjccTuEH5SGi2NSroSJ8hHhOE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KNd17DcHyStMyX3m34ZoYaCApzitCBvHS2bmvGfCrW/jfI4iiDsEzSAM61kliV2G68COFq7K1zxhtXWAvWAlfWwy3m4mLwhvA/zGYbQOEmBMc86zbzM5Q5T1xqluUzS7nnc6d6gop18GUj+L1WZVWCQAEe5Op8OrhFeV/vjhKQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FP1BbOBV; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2953e415b27so41071905ad.2
        for <linux-pwm@vger.kernel.org>; Sun, 23 Nov 2025 01:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763890052; x=1764494852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNN0MI0LidT4OFHOALkJ5vSdl55jONLNA9sdMaqYtkE=;
        b=FP1BbOBVYS89MpArDQSf3fUmFv2jQn3p6sCIFFH1s4fvAQ6l5O1gYjE9tFrEOlRpM0
         dHyZLFt6Wr972ScT7DBKn7lT14D4of+CH4AKw3gdAcyDxpQXOHwiJmWNlVfOknIt3iN2
         kDC/3hOFvDXq03Zu5NOxrM3l/X0BWs7UqrR12WSXBExsJweS/2m0jI4lf5LvJoDEwA4+
         YkE5KSsjXDSAWxQz8e2gHih/UEQ/aaPiJ3Fc5eHHnh8GLE+PT6oSsKNB0/R77bwb76fm
         boH7w3Xf7m1L91c0wW6WzkGqDr0dZTDMmEUZ3nYpRZOisL5IEQBwyfSYF5BooTljWdqi
         lbSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763890052; x=1764494852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kNN0MI0LidT4OFHOALkJ5vSdl55jONLNA9sdMaqYtkE=;
        b=f5OQukiLoNGasLzjV4HDWPiKFvt5VuciCe/PdG+ICjRnQYAIMA0YKl0wL6fmbnaguW
         zaA1ZxFyFcmxZ0jLhnqG8WJGCI81wNFqJvgOTiEhfGK+iIn7E34OpbPSKEJUQxriJq9s
         Z6Sm1zlIo23T75G3olXiS9uvKH3tWRuqpK1d79qT7HhJpChsqpME9Tl8lVHO2mTb7YgX
         CIwF4KwSGVlAazaSsMSaujUEJcFjX5OVOsgymikSaNRQKmGliX5hpbGtF6iSXfL5N/wI
         jdkP8emjMSvfCrm4IaS7hmJofML3GGfLsaFvmqIYs6yRpexixmWYt3UnBpzmLBLOvkLk
         tFGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXI/zMvAG6T0ItEsyuPSaq98YTxy1tAepnKyixn1qehH0+3xOEN2vYatlT3f7SIJCh/NCB3MHuXTQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdBm6DDiIz/lez0rmNS9VA+C+4Awt94N+Cu6akO8XxgDrBZ/fB
	09D17QFfTUzqs0I9oikjsoaT+43Z7A3Fca6cEv1SW3Y4uMFysZupRuLM
X-Gm-Gg: ASbGnctUkKFr+8nkxUYn3RJW2ZuEiLFgj/LFHnrCK0Tgg/iOra3BirLf42dokrodmfY
	hgWcfAlroiRmNNArMbgzhu4c9DzuI3iw9pqJj/Wx2VipXHydGB9EwoJW6zwsRVe+3pSEnp9rtMJ
	Qvw3EJRelBeqiB3IK2cG1D7Ap4mCYbq63i2qpP+NW2F2gB1JTdQSXr2a8OVptrogGKUua9ZM52J
	9AWQIg9UodmbuuZdk8fZtDsr54Ba+OMXC4pbC4umWpwNosD3/P48/9WXZ90YMe3P730K/mzFmFu
	whbdp4GLVpn+U/8uGXdhiTQT6e+F3h5RzdVO6FU6zEcnoa89U7JYHqmK/1suc8cK3XD12yCoBSB
	uY0B3xhYb0Zifjvri8yVFTbO3TIRgCb9vdtKmPyzi1kZMK0QtqovZ8iWjb2NO0Dgt6xtSTUcZjG
	GiArtH+rnL6dShqzYx1FSUxPQblA==
X-Google-Smtp-Source: AGHT+IFee8cb2TNSz47vMFblRZKC7Ldla9Ih927BxHiIgXSYRbtyZ2DKKrYa3dNyowUaxQz5HqlIJw==
X-Received: by 2002:a17:903:2f86:b0:295:7806:1d7b with SMTP id d9443c01a7336-29b6bf37e59mr102978025ad.45.1763890052139;
        Sun, 23 Nov 2025 01:27:32 -0800 (PST)
Received: from shankari-IdeaPad.. ([103.24.60.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b138c08sm100811105ad.25.2025.11.23.01.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 01:27:31 -0800 (PST)
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
Subject: [PATCH 09/10] samples: rust: Update ARef imports to use sync::aref
Date: Sun, 23 Nov 2025 14:54:37 +0530
Message-Id: <20251123092438.182251-10-shankari.ak0208@gmail.com>
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

Update call sites in `rust_debugfs.rs` to import `ARef`
from `sync::aref` instead of `types`.

This aligns with the ongoing effort to move `ARef` and
`AlwaysRefCounted` to sync.

Suggested-by: Benno Lossin <lossin@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1173
Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
---
 samples/rust/rust_debugfs.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/rust/rust_debugfs.rs b/samples/rust/rust_debugfs.rs
index 025e8f9d12de..be245da577a1 100644
--- a/samples/rust/rust_debugfs.rs
+++ b/samples/rust/rust_debugfs.rs
@@ -39,7 +39,7 @@
 use kernel::sizes::*;
 use kernel::sync::atomic::{Atomic, Relaxed};
 use kernel::sync::Mutex;
-use kernel::{acpi, device::Core, of, platform, str::CString, types::ARef};
+use kernel::{acpi, device::Core, of, platform, str::CString, sync::aref::ARef};
 
 kernel::module_platform_driver! {
     type: RustDebugFs,
-- 
2.34.1


