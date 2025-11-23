Return-Path: <linux-pwm+bounces-7674-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCCAC7DED6
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Nov 2025 10:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A8364E23CD
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Nov 2025 09:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149F828D8D0;
	Sun, 23 Nov 2025 09:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BK6HxJu8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD312206B1
	for <linux-pwm@vger.kernel.org>; Sun, 23 Nov 2025 09:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763890042; cv=none; b=QJVz8BbZA7RsjcFuINCEIV4EoStWLGkxsi3GOSBItE1iUn24CVUFOyxGVLeyIA/SbkrXWNLhMnCXWI7ZJJC5MKEakQchvp4UTPxoUPbWffeFiNYQyUCiXXZt7aFyalICpSPs8aOWKKrVzvBE+j2P6L1LnZsAmItKkMdxBmyh25s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763890042; c=relaxed/simple;
	bh=0T0m+vzVHWTBjikXdKLHTliy+liCTCohp1BbecNTmzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GMZQjMsjIy4vNQj313TgyMYMIXOwizLYeYl4Q0rNFiYkKUntiR/6KPH2+1XN2K+YOmhJwutKM9TVCMxCUHnTKz6LcgnnQb55BKZYISHd6VPMde8pLKJkmHMj8rLq+tNCqofARf8D50pMB29Y0j41FwRWIOpuWUPNdeYE0GKLZeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BK6HxJu8; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-299d40b0845so55318375ad.3
        for <linux-pwm@vger.kernel.org>; Sun, 23 Nov 2025 01:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763890040; x=1764494840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cuE/I+mSjy5RFqX89Pi5DjFF+u40p6VYH+8i+leWPLg=;
        b=BK6HxJu8klsBazdbsG2lf0ie3JYLn/L698A1rKw5A/Vq5mhZ06S0sWiXKKUDLQ9cbc
         EaPdiKjt0CHqRx1KPhUsmjr9jUABQTE8qP6DFMuR+o18KmEl3nVeig7aFrdnARYS2Q+h
         F41cf/ghn+cEukAlsxvEt/so/q9tm2nfpguCfTf0+erBS+qjzniFGgcMwKROsDTEwc2g
         e8Q6vmv9Ulx55qKrk5Fb3qS3YyRz0PAK5D1MGO86l0r8JmE/eMVLPp2xMed1IKqGIFdv
         7080TVJwaycuxrAyxFj7Y6uitFgPRg5OEEO0SfvsqT7OldinGtLHFwkSEqOa3jD5j9uQ
         V++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763890040; x=1764494840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cuE/I+mSjy5RFqX89Pi5DjFF+u40p6VYH+8i+leWPLg=;
        b=mZ/lhiX5xhjTSFk4oOUQ9DjSRt0bJJDFCNU5HH1BX+Ux0mHspVNzobjLEG9xhkULV6
         N+UiHj486obWrdw3CubtLpQPUb/p9H6xi97GCvt+YxZVkw8AY/SL4jDWYKzIOAFNj+cm
         k4QWmHF3V06Pe8xDpwB+JLe/MensxfAFrac4yorlkbcjcoZHr71E4QYSCaO4FB5DOkuP
         3zallu4bi/Wlq4i9WsLxIbij2SrZC7QlTpBNOcCfi2Og/7Te2gaJ9hzYcQEeAnT7CIt/
         SPK80e0wERxS6uEK/IG6hov4KD+m6xwOxQc5qc0YKthtyHFnTto80AIQvN8ml7iOp+51
         2bug==
X-Forwarded-Encrypted: i=1; AJvYcCXRRlkJSTOxbfxAk6SHZqw1k9K1o8QnGRssLeVY0EE5EoG2176ZY8dMqMPk5XM0VXCW0FC+k6vWYqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn/9wWhwZ+1FKAYmi5H2ZKk+SXh0k9HppkPCafG7Hl4EGj+qbv
	TYBQYzzyNS2vxvO8AXzzdIxKn9xUmzOUJllQfxdRKkHKdd4d3P87IoC3
X-Gm-Gg: ASbGncsDRDLXk+ZmNd72oSOCWwHpGR5OVC9Tf8Fyh6sDFsgbSRBSzDT/VNkFxlznk0z
	JbS7EN2SJGhDHul5YGP5UVdr06zGlUqlxAX6GTrc/UMIy/y+zfGt5Dg7KZJY433Dru3QpgkdsR1
	nwQcQaH3nspIs1+xgwLQ+UZijcF3SaFCdPcIGI88HwZ/xqFRdNlbbquXQymq0uq/PKYb6rcjSCy
	mfagDq8uPZTjmaE+vUG+qGMy2gVGKVmZE/8UoL4ZXr2Yj+euFPLXrh5eU5DZ6IunacoYLb+vIUk
	/2UjHShMMu/+mYYRMS09rPJ9I3c15jkiRUaLD4I7zgfhBMIlbB+jdauNlAQxNQ227W1pH1zPsoe
	DZBb5ssuMcejgH6IuNN0KisVIpGZx+Wk3Ssv/8w/ogmM3OeyT75H/N7w4MgsD5IfNszUTIE8kda
	G8GXP7I676xLioGbqq97RsCsY/jg==
X-Google-Smtp-Source: AGHT+IFMN2aUokRTTtS+sIFfNu4kcDd93MwuGAJrh+xf6L/Jjr+U1cR7WS31QoNboosVEzIBjpWEvQ==
X-Received: by 2002:a17:903:2c06:b0:297:fc22:3a9f with SMTP id d9443c01a7336-29b6bf19f1dmr93932225ad.38.1763890039910;
        Sun, 23 Nov 2025 01:27:19 -0800 (PST)
Received: from shankari-IdeaPad.. ([103.24.60.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b138c08sm100811105ad.25.2025.11.23.01.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 01:27:19 -0800 (PST)
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
Subject: [PATCH 08/10] rust: kernel: Update AlwaysRefCounted imports to use sync::aref
Date: Sun, 23 Nov 2025 14:54:36 +0530
Message-Id: <20251123092438.182251-9-shankari.ak0208@gmail.com>
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

Update call sites in `usb.rs` to import `AlwaysRefCounted`
from `sync::aref` instead of `types`.

This aligns with the ongoing effort to move `ARef` and
`AlwaysRefCounted` to sync.

Suggested-by: Benno Lossin <lossin@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1173
Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
---
 rust/kernel/usb.rs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
index d10b65e9fb6a..79ff2f881572 100644
--- a/rust/kernel/usb.rs
+++ b/rust/kernel/usb.rs
@@ -12,7 +12,8 @@
     error::{from_result, to_result, Result},
     prelude::*,
     str::CStr,
-    types::{AlwaysRefCounted, Opaque},
+    sync::aref::AlwaysRefCounted,
+    types::Opaque,
     ThisModule,
 };
 use core::{
-- 
2.34.1


