Return-Path: <linux-pwm+bounces-5595-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F73CA946F6
	for <lists+linux-pwm@lfdr.de>; Sun, 20 Apr 2025 09:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CA277AB66F
	for <lists+linux-pwm@lfdr.de>; Sun, 20 Apr 2025 07:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4D01E0DE3;
	Sun, 20 Apr 2025 07:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="N3ZIWMYT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0904B1DF258
	for <linux-pwm@vger.kernel.org>; Sun, 20 Apr 2025 07:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745132774; cv=none; b=JdBMzJh0c5uIThAovr8WRsHEiVXDD8D7ctVLIedJzys3HQ6xubq2UIRTLYa8WeMFnJCgdY4PeG8Ldf8AQE5OT/KkMC80ceznbD3hAlK/9gAWkg8UdnDnaA2YMZ2k2/rMzFlLuX5A693j8xfn2tRdpNiTRWl5bAfMtsDFLVBAPVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745132774; c=relaxed/simple;
	bh=iTRDl9eIM1vHDXRz79uJ7GC6Y8TqkdFZFbsYIQKe0dE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KuVhLG17HSC30L+fLyBSlIBLpQrDHoOYSgQv3vSVC5O3jn7n/u4wFJfZai5EjlGNsdJupbFeeYsfo0/E2/cUmFBum956r2rNWk3edCbRUpe/vfl8HzeRQbxBUO20Rb2yamYYER8H+bZ5mEaYZQyytrcpO1ytgPAsog6g6pjkzKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=N3ZIWMYT; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-736b34a71a1so3438617b3a.0
        for <linux-pwm@vger.kernel.org>; Sun, 20 Apr 2025 00:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1745132771; x=1745737571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fcZq8o5SROXi3wQjym5oYgJNhmITCc4NsmF81Zj+a8=;
        b=N3ZIWMYT7WYg6o2oswnh9mWBD3/lr92fFqSpsSBKkOKYJuHJfFt93PULzu161OwmQy
         P1ZJrohuGcmOFtdLFYUrufCQ7gtZW0A8Dsr+mD0L1LnfRET1JGSbyKAJ82YvLwKwgU1W
         FpCYip81stmLB9nwOHCjxywC6eKF7hjYZeYkGUEIYlHHSX3ZUbFI5j0tTPo5qgc5BuLx
         4wAXTw9JtJ7lO9J9jRHmFtozgkcjmz83nQQDF526VongXKtc4U1L98oFAClDSXcXcDiC
         +FWQntTmrBjW/pQGMUdiUQWiw1SKHVbHnJjoON19h/YuRYrC+Xq8e8ycXR0lt1GRxuL4
         YqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745132771; x=1745737571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3fcZq8o5SROXi3wQjym5oYgJNhmITCc4NsmF81Zj+a8=;
        b=jVEo1p+mRTbyM7GBVgQVr7PcZZNRpNVnTetYdfBBRv2M4Do3WAIHFMYFNhrLr324Og
         QynnOhsA7xW/UJ5Z7K2EfSlQ+JyVgn8ZEiIWiDTclszzhjZqHOX6DZEJsVtVA1zLDU4H
         v/rhTL/mt75j7vDFslWNXuQ1tYpnMFHrVO/+TygMGlowd39ITs0rss7tFuRZm1W26j80
         +Tl2vc2kvXulQnenkTdBmM9WeLwdJ69KBcoKSzDuMoqL/rrMPTA45x4c9p5gFD3fc2H/
         tqh+cxOYiIVZohb/Z2t9Cv2zwkHwwVXfD2WQsjLnSTl8U66lRFW6mFmiORNn4meiiNft
         c4zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfuSfgOOrIoaQQnKP8M44Tk5RYiDj5lMefYcwGORK4+nYLBebfDWtDAjQtcOVlm1kfa6fEjqF/3RI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlpZAa8rkDaPGpg0t4r4cQXxGo33MW1MJ8scSOwdT3qUErxsxv
	QaCkgFWP0eQwgEmxFIQhpviT+Cm1PEJNfBkWj1XQ2WpQohcd2+bexO7BiMRqdtY=
X-Gm-Gg: ASbGncvfCTHMxGb0XLQ1fcZt539OSGZlhiEVQj8XDctGergaMBwCOJdm/NAbrj6N2kX
	Qd772qsmc8yxKqKJ2+vJl4A1gCjOa3Rvmb+/wdqg56upm6T8eO9Kt/ZOe7I93BK4t5kOapRSLQl
	ElQ7BQSIfb+Alt5wVTY94224G1YvxO64fNpTG9/DqyP7Z9fh6rP6hIX/uM7hWHGXVfmYeeji4bJ
	eJvw/go5XnXONUXdTZU4JOU/c8aZB7yV9CySDj8vMItaLf+20wSqYuRbnRmw9i2ppN92Rj5UDvc
	JKgDPvCZBIavxDzgEknQwMOuoE6ub07Y6s0zhj9I
X-Google-Smtp-Source: AGHT+IEE+OeQFiCCtU8Ee9YBkXu2dzO/ybh/igItlS4KQN0WO89uCSH/pwRn+/1oKh3T6c5poKcuYg==
X-Received: by 2002:a05:6a00:1305:b0:736:42a8:a742 with SMTP id d2e1a72fcca58-73dc14ccd73mr10174885b3a.11.1745132771298;
        Sun, 20 Apr 2025 00:06:11 -0700 (PDT)
Received: from localhost.localdomain ([2a11:3:200::40b3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0db12743afsm3742626a12.16.2025.04.20.00.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 00:06:10 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	dlan@gentoo.org,
	p.zabel@pengutronix.de,
	drew@pdp7.com,
	inochiama@gmail.com,
	geert+renesas@glider.be,
	heylenay@4d2.org,
	tglx@linutronix.de,
	hal.feng@starfivetech.com,
	unicorn_wang@outlook.com,
	duje.mihanovic@skole.hr
Cc: elder@riscstar.com,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	guodong@riscstar.com
Subject: [PATCH v2 6/6] riscv: defconfig: Enable PWM support for SpacemiT K1 SoC
Date: Sun, 20 Apr 2025 15:02:51 +0800
Message-ID: <20250420070251.378950-7-guodong@riscstar.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250420070251.378950-1-guodong@riscstar.com>
References: <20250420070251.378950-1-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable CONFIG_PWM and CONFIG_PWM_PXA in the defconfig
to support the PWM controller used on the SpacemiT K1 SoC.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v2: Changed PWM_PXA from built-in to a loadable module (=m)

arch/riscv/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 4888529df1d8..8a8b77a0ac5a 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -259,6 +259,8 @@ CONFIG_RPMSG_CTRL=y
 CONFIG_RPMSG_VIRTIO=y
 CONFIG_PM_DEVFREQ=y
 CONFIG_IIO=y
+CONFIG_PWM=y
+CONFIG_PWM_PXA=m
 CONFIG_THEAD_C900_ACLINT_SSWI=y
 CONFIG_PHY_SUN4I_USB=m
 CONFIG_PHY_STARFIVE_JH7110_DPHY_RX=m
-- 
2.43.0


