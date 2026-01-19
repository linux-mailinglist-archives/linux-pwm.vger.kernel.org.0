Return-Path: <linux-pwm+bounces-7949-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE68D3B8E4
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jan 2026 21:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00297301DB85
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jan 2026 20:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1882EE607;
	Mon, 19 Jan 2026 20:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="n2FVzFYX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660FF2DB784
	for <linux-pwm@vger.kernel.org>; Mon, 19 Jan 2026 20:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768856166; cv=none; b=jJotnH0WKReHa/UDnl+d5c+QUyUGgOQC4CQACl2e022AZFhOUqt+9uS5OnbT+pLso82PFWIWNtnPFYK+g3gQxbWmj/FXEWRyRwk73ft84SjUzwenSygX90ifSoSuc3v0hsyeJ8TYfCe/0eFDEmjw17IW5lfbwce1Cn3duXtc+yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768856166; c=relaxed/simple;
	bh=ZGyfjuoV0pGqAkhYWc4X1RmPsSRDdR0nbwNMOa248SI=;
	h=From:Date:Subject:MIME-Version:Message-Id:To:Cc:Content-Type:
	 References; b=YN/yNxUn4t2tQTc/U8/KwtEG2vgG+UQmS4h4Ke/2Ep+5/sQ0/xv4jOApQmsSGfD07CKoTePVCZKNYXi/P6FN9cX85ACcOx6x01R3bkVH7WBEUuTconWWOMOq8U3dZGx87BsaXtooffV5PKcwqaxk2hTb05bSn5ptuYPWRxFsMcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=n2FVzFYX; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260119205602euoutp0160285448a2d024665b25bc508686aa31~MPU7VOcqY2356623566euoutp01B
	for <linux-pwm@vger.kernel.org>; Mon, 19 Jan 2026 20:56:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260119205602euoutp0160285448a2d024665b25bc508686aa31~MPU7VOcqY2356623566euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1768856162;
	bh=ancGqnWxMtrqnStuUtSLY1vRl+hz5OHaEgso+Y524JU=;
	h=From:Date:Subject:To:Cc:References:From;
	b=n2FVzFYXUcA1bnCIFGZoFkNcMxx83deuwGbHZj5HgdlVfRLzC69AEbUzBR2MgzcYy
	 fhjP1AGaUcPJnTAYBlnebI5jenceHEDsoVHvdp0uZA5a8LR3GSud5G9OO7B1RPY7A/
	 /1Ovt2iChfaiZ74fn3oya+ACrhasSaDwbj/KX+E8=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260119205601eucas1p159c1d9e17776f68d0367058f1d97e3ea~MPU6f5MnV1867918679eucas1p1L;
	Mon, 19 Jan 2026 20:56:01 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260119205600eusmtip15b9a2a7f07c2515fdc4ee2ef2d7e20d0~MPU5985up2256922569eusmtip11;
	Mon, 19 Jan 2026 20:56:00 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Mon, 19 Jan 2026 21:54:58 +0100
Subject: [PATCH] MAINTAINERS: Add myself as reviewer for PWM rust drivers
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-maintain_rust_drivers-v1-1-88711afc559e@samsung.com>
X-B4-Tracking: v=1; b=H4sIACGabmkC/x2MuwqAMAwAf0UyW2h8gf6KSCk2agarJCqC+O8Wh
	xtuuHtASZgUuuwBoYuVt5gE8wzGxceZDIfkUNiisYitWT3HI+Hk1MMF4YtETTWNhN7WoWwQUrs
	LTXz/33543w+tKr44ZwAAAA==
X-Change-ID: 20260119-maintain_rust_drivers-4fce1a05d361
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,  Miguel Ojeda
	<ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,  Gary Guo
	<gary@garyguo.net>,  =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
	<bjorn3_gh@protonmail.com>,  Benno Lossin <lossin@kernel.org>, Andreas
	Hindborg <a.hindborg@kernel.org>,  Alice Ryhl <aliceryhl@google.com>, Trevor
	Gross <tmgross@umich.edu>,  Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-pwm@vger.kernel.org, Michal Wilczynski <m.wilczynski@samsung.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=998;
	i=m.wilczynski@samsung.com; h=from:subject:message-id;
	bh=ZGyfjuoV0pGqAkhYWc4X1RmPsSRDdR0nbwNMOa248SI=;
	b=owGbwMvMwMWoY/uld7nT7DzG02pJDJl5sxJmWN/ZP/Wc9dES31/ai469D5pirK1+dXGSeGIwx
	0LR3PbATkZjFgZGLgZZMUWWsiMid33ehde1Cns8gxnEygQyhYGLUwAmIq7J/s/i9VurkjrFm5yJ
	25w7H/sHTn27kOsZv1Zi4t60on49+y8HvKd1z63fMi0w7dHMmMic9MDgtuxfm9gt5M9XLuoU545
	bziJVen/JIqUFS2tuKl8QaZiz88XU1ZuunuydpBgu7juhpSxGsTr5xImyww0OLUUnr1oH5SxRrk
	7xYmF3dkicqr7s+FfxHZ8feCm2CXkpZApPLln5tMzpf22gaartpvmGH4vPX2dwjpko9eVUufb0E
	4ovL3T3ub8PyDDkMI/izE4/fMqC5SL/ptX8z+dcDHd7+ZzDt8Df8cGfPKXUnhmsfkHb5uvv8VVh
	Er6R6KqUFvKF2eG/6sK1XkbaX3adjpfcWLZPZGeYWoo4AA==
X-Developer-Key: i=m.wilczynski@samsung.com; a=openpgp;
	fpr=76C414DD4CEE577E851348E62C3DF48DA7429B6E
X-CMS-MailID: 20260119205601eucas1p159c1d9e17776f68d0367058f1d97e3ea
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260119205601eucas1p159c1d9e17776f68d0367058f1d97e3ea
X-EPHeader: CA
X-CMS-RootMailID: 20260119205601eucas1p159c1d9e17776f68d0367058f1d97e3ea
References: <CGME20260119205601eucas1p159c1d9e17776f68d0367058f1d97e3ea@eucas1p1.samsung.com>

I would like to help with reviewing the Rust part of the PWM drivers.
While I maintain the Rust bindings, adding this separate entry ensures I
am automatically CC-ed on the driver implementations (drivers/pwm/*.rs)

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index da9dbc1a40194523a919ea0af7f53cf6fb3aad42..ebc2f1bc0ade3241e312ae1cd4537122a8b6bf0d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21103,6 +21103,10 @@ S:	Maintained
 F:	rust/helpers/pwm.c
 F:	rust/kernel/pwm.rs
 
+PWM SUBSYSTEM DRIVERS [RUST]
+R:	Michal Wilczynski <m.wilczynski@samsung.com>
+F:	drivers/pwm/*.rs
+
 PXA GPIO DRIVER
 M:	Robert Jarzmik <robert.jarzmik@free.fr>
 L:	linux-gpio@vger.kernel.org

---
base-commit: 24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7
change-id: 20260119-maintain_rust_drivers-4fce1a05d361

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>


