Return-Path: <linux-pwm+bounces-5456-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 030ECA85EAD
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Apr 2025 15:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EF2017A47D
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Apr 2025 13:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C0118D65E;
	Fri, 11 Apr 2025 13:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="07hwH+bv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2703A13635E
	for <linux-pwm@vger.kernel.org>; Fri, 11 Apr 2025 13:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744377412; cv=none; b=rZ3Wz36jOVFwGMcSxViknRG8UGaHVBf64V2S8pMj+6JB7PXlOfTIXx7WfncuQ815z4H0LdB9cKulDfmSH6W6/lD0+VXzA5+qoabE7v3ly0ACNSf+UMmhj9C8cis5rTC4jR+GL5oKsmldfKnz/i5beUC3Xn3sieayvlwRkw6fD9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744377412; c=relaxed/simple;
	bh=3q6LzsDwiE+yVVac9evuQozKO150MG55tmEaBUnFpq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MwmMMo/C0Qb6PNIP9KNqrMFfjhgduDQgYS83tedtGtMMH7ycMAMwgBltL/5XflgtUXwXb4tWdj9GWHsE5y8f3/PvDb4YuLKNOTurcsADvphVpkTY9RAhiLj5hwzEpn45u/7NfCi1c/x0Hx7IMHOrU2QsqCgZnPm61l12+bYXCqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=07hwH+bv; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-227aaa82fafso15909845ad.2
        for <linux-pwm@vger.kernel.org>; Fri, 11 Apr 2025 06:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1744377410; x=1744982210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8UqYwabiGCbW0lFM+J6bILwkNakAnqe4wz5kWFQbMVg=;
        b=07hwH+bvvpQ+98Tv/g2XwiE/ZR1TXJsbuhS5fgEIj6zK8JiTOEvGZWB+DZUX7ewvqL
         84GRMIclHqZyc8UKll2c2rZxp0aqMhi38kMIFmiRpptS3s13KXyiDW7nQFT5xCR7lJE4
         ogANPTWxk8slDLbIhUUcoFYyYF7+u3MLpPRrn3LvpvC0mFb3FFdgJs2gLmuovMuUPaWe
         Bv3OgllDX8bMWHjmfSCfdEX8zTFBPgghBybALJt/n6v/Rs7iHnswNlJZ855PAjBNVVJq
         w3VrIoyUnfXF5uNr1X81X027cDy19b77oZBNgCLrddswxbHhZHbC83dBk62tGlJB3/Zo
         T6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744377410; x=1744982210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8UqYwabiGCbW0lFM+J6bILwkNakAnqe4wz5kWFQbMVg=;
        b=He2YNVSB3Txgp6qqLGqb+lpxmwr360lNtmUoJH82HDEhKEnkPHRQnDlhsoM1kKQyro
         vNadouUcyh2G8hK8OjBEXQn5viN8ByKMV3R2dSNpbDMeP/+VerFdBfRhjQFGZJkFhe/x
         7ypoplSbg/zIBm+SDxnuy1PymQKztfhdB74RN0RGywMKxdH2kY++ND5l3Hf9XPQ69lrU
         ugqOfoW/TzJfH3+dsQnl0rdoZKYhLX92CDDvf9f9gXjifcg7pXiT1FiB7W8pc8PaxgGh
         FJLVTUbmxF3hoIC/8oA+EYTzDuk6tmioVA8DCgB9FxupQieCycAqHj2RPed1oOvJGZyD
         cvsw==
X-Forwarded-Encrypted: i=1; AJvYcCVnGbFTCbijArTIxwbKRgZ393fgSxBAvrLGuBS6RPEXK740uC0R/mOvgsRgjjc6c0OSJBGfq9ZE5qY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjPySdaTd7FWzD3yQ94DJkMi1i2XVl6/gWuRAyTWL8vEVVKQDV
	gN3aoCN781O0PKwi0OX2ZXF7Je8pIq5/M+m/w5vO/aOpvRoVmwHl8f/OQMFIhRw=
X-Gm-Gg: ASbGncu0KcENk4dVDyPnFB20T1Z16rST00xuGSelF458Ogltky+YE+sSnuyjztt0LrP
	PTsESRXefE3oZKYlSIuPDcRPpKVkV1USIixlqmZmkVCts82lk0VCJNOztuu+nWfq5QhCNwWeEes
	Yh1B/rKenpaZh94p5s7uzmrw4+88SK31/LSUsFk6alY60dOKR0C3zhBEGB38+x6QWYtmt6dzWHS
	gghkcz5s/xRd5hTAn3azOnKduz3RN6Lx1Y0v2OjmfI7Qq4ocGFRfD7gupEg68IFRezlEIjARz6b
	Wig8ihQ/heJgHld23oG5CJN2r8U6mD0=
X-Google-Smtp-Source: AGHT+IECvokSxW4TE1t/6GjH2KzEiHk/fDfcTN3ty6UKV6n7k5pcSeZTqv5IfUu12KUb+He4PBCOnQ==
X-Received: by 2002:a17:902:e545:b0:224:1157:6d26 with SMTP id d9443c01a7336-22bea49616dmr42095625ad.4.1744377410365;
        Fri, 11 Apr 2025 06:16:50 -0700 (PDT)
Received: from localhost.localdomain ([2a12:a305:4::308a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7c95cc6sm48245005ad.122.2025.04.11.06.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 06:16:49 -0700 (PDT)
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
	spacemit@lists.linux.dev
Subject: [PATCH 9/9] riscv: defconfig: Enable PWM support for SpacemiT K1 SoC
Date: Fri, 11 Apr 2025 21:14:23 +0800
Message-ID: <20250411131423.3802611-10-guodong@riscstar.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250411131423.3802611-1-guodong@riscstar.com>
References: <20250411131423.3802611-1-guodong@riscstar.com>
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
 arch/riscv/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 4888529df1d8..9bd972867e0a 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -259,6 +259,8 @@ CONFIG_RPMSG_CTRL=y
 CONFIG_RPMSG_VIRTIO=y
 CONFIG_PM_DEVFREQ=y
 CONFIG_IIO=y
+CONFIG_PWM=y
+CONFIG_PWM_PXA=y
 CONFIG_THEAD_C900_ACLINT_SSWI=y
 CONFIG_PHY_SUN4I_USB=m
 CONFIG_PHY_STARFIVE_JH7110_DPHY_RX=m
-- 
2.43.0


