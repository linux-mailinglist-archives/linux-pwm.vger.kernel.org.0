Return-Path: <linux-pwm+bounces-5753-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 763C8AA0640
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Apr 2025 10:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0BEC841621
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Apr 2025 08:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77C229C33B;
	Tue, 29 Apr 2025 08:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="FVgfckb3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA9E28A1F3
	for <linux-pwm@vger.kernel.org>; Tue, 29 Apr 2025 08:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745916698; cv=none; b=RSaveOAWU0tEbOiHjesoFt8uiQNItuJOiluRnysll40PTNDST6JN0OK6ceK5rqmf05OBW327L60Bs8jAXf05VZ+bcidl1G1unMKYMQN55/p4t0Y29LnB/R9g7H3cRemJbIJXZ8GvnyyvR27FQy+Hy1LpzBQ/iC1V6VG4AjcyNAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745916698; c=relaxed/simple;
	bh=ZLqnNRXBAVw2yotWdLMWiDrIuKC3zLz8bFoRIWISSAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R4ZzY1Shx3n7wBjXsuHHofpxinGRs27ZurASOSSF1Vqg/fHFJUNasgzzk93QkRgLUGETGaFFMdJ+qZapgjMFyVGb1zV+/GBpHqptjcvh5Mk+fthWw/rxO+aOpR/KQsttz7Dlhpgh44CHVr8E5WTh/acqqeox/ZcxOw6Fp9cDA7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=FVgfckb3; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22c33e4fdb8so60657725ad.2
        for <linux-pwm@vger.kernel.org>; Tue, 29 Apr 2025 01:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1745916695; x=1746521495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jf1MyA5jv2WhmjchTZbgQeXneBCKmWDUyNLFyQlB0MY=;
        b=FVgfckb3G4qRocEXzpi9VY9rR44o4E6MDwkZS0FuKU68mKed9zDU5TCGT88EHyacpM
         mMz1EjDMimL6S2+/YBfllzipMX/YYp/wIcReav4D5kdFlE33D3x6hJzsyG+8r6rlzGKE
         YyrPmR1JTLR5P4pogZ5FAgsMZiAe/X1NjKgIdB2UYX3fpJvZWq5lb/thQKfHLVeZ35zB
         RM7ZMlOsjX/DQjgaFiwzuBCBObICU9IOLnr03SY+JRPNEGmWlCDzWTo1xZmnVwiDqirG
         YpmADvZyq7v7x3F351NzMJbd51cS+l6o7mn6bQUJ1cL6DpnHXB8FKVCIW5QvqwkoaEnq
         8AUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745916695; x=1746521495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jf1MyA5jv2WhmjchTZbgQeXneBCKmWDUyNLFyQlB0MY=;
        b=Ix5gZbZp+bprRciJJb5drOmbww8iXX1DDhkCuMq47ywJdDeXG+tBbm6tep78XhDKeg
         rs33M5F0ZhQ1Di33mJrQ6NfUDwdsq2HOu74UwYR1vDEvv7z3TEF6quykqkhOXnLqQt6A
         osVLv9CilgP0YoxH72k6Ai04+CRTr7s2L+QKRLsmCYTNTlQN47lfOL//CTD+xucMxZTb
         e9ulizHYQUH36iYYi9PXEbef7KJyDytBBo2SoD/kx8CvAgYjFGULkQdujD9T5BZZi0ZW
         IHeEP83h6VHaXmVBuSfStuX4GG8yDBe/7KGT/2OxuNckWCVNluMPhIplRRSLhjboaZbs
         V5fQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0exI6yPoRYZu13JYptTPl2OTPWYpAsFnNSNziWRDN3lzFH5/ntpZPDzVEU/27zcbFmXzv2k8w5AM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPN2J4IHbvVkKMKGosGcMplkuVK0ecs7F3jvSK8XXqmmP/nhjO
	Lq9KWavKSyu8nMy+waqJB4/01fwDzUArd3LV1JjuNb8e7xd1Kdbl/InppfTCZ+s=
X-Gm-Gg: ASbGnctcONoU0KyrNfXEWbbammf6vI/uWNgYTaIdvii6cqmZ2wkmpHmaw9NnD7OeMCT
	LP3adRndyqkib4ETHfJAzs7Av4y8rEc3+wZa6RzXczpwQk4YrztGOSk1rLxIksI6eBkHMGticOs
	xVKw8lp719nAWDYXPWLVE1mLF6caJGlJcHIMOBh1l3Sgh1QL9cRmKgvi7xsP+4NxnlLBhUyS5z3
	hf2EysaFlnQamlLKJTvtxPZaHmZmTs+8lLZPpBnixMwfSW+gUcm2Mbr2+d+QkaXxKfjy/Bhk1da
	nGwXrOuG0EVICcBKDm3/7waeEKcJG2vlTwAm5dS5KHW3zIyZ/+OCg3VVEX3vt/Wz/SaxHcjJKhx
	U50D4cQ9+G6RNjPY=
X-Google-Smtp-Source: AGHT+IF/YTb11QJo7KHbzLovwGKhpZslh/Bu4+pqk61lazM/ExJSKXK7osXi8PFQQCc7TGaXhCoayw==
X-Received: by 2002:a17:902:cf07:b0:224:23ab:b88b with SMTP id d9443c01a7336-22de5eca712mr35763465ad.8.1745916695179;
        Tue, 29 Apr 2025 01:51:35 -0700 (PDT)
Received: from localhost.localdomain (210-61-187-174.hinet-ip.hinet.net. [210.61.187.174])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15f8597e0bsm8550119a12.44.2025.04.29.01.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 01:51:34 -0700 (PDT)
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
	duje.mihanovic@skole.hr,
	heikki.krogerus@linux.intel.com
Cc: elder@riscstar.com,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	guodong@riscstar.com
Subject: [PATCH v3 2/6] pwm: pxa: add optional reset control
Date: Tue, 29 Apr 2025 16:50:44 +0800
Message-ID: <20250429085048.1310409-3-guodong@riscstar.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429085048.1310409-1-guodong@riscstar.com>
References: <20250429085048.1310409-1-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support optional reset control for the PWM PXA driver.

During the probe, it acquires the reset controller using
devm_reset_control_get_optional_exclusive_deasserted() to get and deassert
the reset controller to enable the PWM channel.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v3: Dropped the addition of a reset_control field to the struct pxa_pwm_chip
    Using a local variable for reset in pwm_probe() instead
v2: No change

 drivers/pwm/pwm-pxa.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index 430bd6a709e9..f6a862531601 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -25,6 +25,7 @@
 #include <linux/io.h>
 #include <linux/pwm.h>
 #include <linux/of.h>
+#include <linux/reset.h>
 
 #include <asm/div64.h>
 
@@ -160,6 +161,7 @@ static int pwm_probe(struct platform_device *pdev)
 	const struct platform_device_id *id = platform_get_device_id(pdev);
 	struct pwm_chip *chip;
 	struct pxa_pwm_chip *pc;
+	struct reset_control *rst;
 	int ret = 0;
 
 	if (IS_ENABLED(CONFIG_OF) && id == NULL)
@@ -179,6 +181,11 @@ static int pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(pc->clk))
 		return PTR_ERR(pc->clk);
 
+	rst = devm_reset_control_get_optional_exclusive_deasserted(&pdev->dev,
+								   NULL);
+	if (IS_ERR(rst))
+		return PTR_ERR(rst);
+
 	chip->ops = &pxa_pwm_ops;
 
 	if (IS_ENABLED(CONFIG_OF))
-- 
2.43.0


