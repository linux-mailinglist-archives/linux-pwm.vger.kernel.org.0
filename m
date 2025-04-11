Return-Path: <linux-pwm+bounces-5451-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5101AA85E8B
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Apr 2025 15:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67D7C467751
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Apr 2025 13:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796311B21BF;
	Fri, 11 Apr 2025 13:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="fq/5lXZ2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0CC1922C4
	for <linux-pwm@vger.kernel.org>; Fri, 11 Apr 2025 13:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744377354; cv=none; b=sdFk0DZZm5C2aW+OLEES6F2jEeSsGPBueKETtKPKQtN5Z7a3OWj8yZeDeUQFWGac23U0Sh6/URdyrBa1enno3Gbj7g9H6v5wq31OYoORaiVb6pwzT+YKidBvs8SSK8Y8y9/XcA87QO1rJ8+f2YVM/71qJph/mT/mPN1EEmgFsOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744377354; c=relaxed/simple;
	bh=11u6eTuG07TD8K0EqLQCl5SKsVXXOKBL7vzcLCZC0DE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rFZL+Suo3bdTkeut9MpNTrM0LCEqYH79tP7O2awcLrFqcRuI9Weoxb/pkwqOLv3FhgxaRfnlSussvZQJk/qA5iPu/6XtCU/AeE/B0Q1j4Np6Ig2ydnZgl9bnSjhYcubAEec4PwKVzlYMAZXDGEtBYjD7ui+CSBCu053SsJIrTfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=fq/5lXZ2; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-223f4c06e9fso19658475ad.1
        for <linux-pwm@vger.kernel.org>; Fri, 11 Apr 2025 06:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1744377352; x=1744982152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMxmUF14/8mW48hBEyGMdh9vHYA4geBoHm6tUaBcjb4=;
        b=fq/5lXZ2QLA+mjGuxcM2i8ep89cyd1SEgdxFRWW1P1oVSc4unOIa2T5MzAITggSRCH
         KSRzyHHIV5Fi9IDypOA8/RouAJLwKyY2y5HiN8K/B1DVIM/CLlIktCl6I23JB2L1W8aE
         JyRcRL3w4d0ZOTgJsaRufmkeJIN5iOM0ePUS8ACi53+rMu1wvjavJMloZkw3b7b1cUdo
         yloKQL2Ed9BvEEwfkh9JLYzOibD2PNgkyCv9Z3z/hAxQGoaElGGHvlI15+l0o/M6kxzx
         hadHTkw3LZR089G1arDvUw6scOtNO31Burl50yMZyIW1SR/qHzdcKv2o2buwwpzRuQfS
         Zbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744377352; x=1744982152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wMxmUF14/8mW48hBEyGMdh9vHYA4geBoHm6tUaBcjb4=;
        b=dnydsd2MxElj3/hEaW9mBVZjDDvJ6Zd5uINQoUclk11uUFcAFoN+yXAbA2V9jvO5PR
         UFSX62qU7Wqqc4Arbb3YYmCGdAPVgCdXpX7OEB0EiGUqR6aEzpzpIzoxk9mLFOTE16jc
         R1SE5SniWsGRvxQ6i21PhLsMYk2VzAKl7KPtz/oefbAlyDLG0QFy+cjAsDWpLFVFWJPR
         78m5KVGXNfO+7x7MYEkBUXoOEXxfg4tcCaC6E1pNL1FCPjfpxgwMVe8B6ACQxBkdQ867
         e6Sh3ZGfFelBXv2vd4EFVDNwAVM9QKIWO8y26UjhSUZmNEkuNuTNCy4tLorsm9+ZICxg
         hA+g==
X-Forwarded-Encrypted: i=1; AJvYcCVy4aiaU9tthq43AljefRBWPqYmDUqMj/cq3J/litEXPfOrktJpAv7Zw8p8TylOmJ9lhzkrCubDjzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiET/0AHEhsyMdDbCU/APLaCQgS49ySEsR3h/JNh9fRvW2PWdz
	T5AAr+T85viFUkQx9JUKA65CC/1A3lizJ2B3joKyE2io745W9U2CyIDV3/sCj08=
X-Gm-Gg: ASbGncvj/rDJf3UuFwG+FPX9PUEUmh8E6O3AbD4v9At61gCvSboipFY6bC/Mxaj8IDF
	nuF0gBjjD7YwJsx08uBZpuXn3h0l8QPRisFpFFnXDu51TSvYl2SmgT6SCTJMShAeNH4C468Sziw
	gUik/oEkTaphgmfLYFbjqLSTSSHCwlj+4he9brJu6VuXQPXNvvTfquoxiBUIbq9xuwq5Lx5vyVq
	Rn3iCHoS3/fdpDDlcnpiCURDQ35TArbbS+GMdjSPhQ+M8dfRhDL42QvqRqztKAS8LOwTY9Kc304
	gfnGEc0SfVpoeT1B7UNLKY1FfmKc9QQ=
X-Google-Smtp-Source: AGHT+IF38ohQyrU5BVLNrtAgCLmegI1hrqaZkZmcE1Ga97hpdeODRbY1vYS67kKK1t7zEi3qN8rF9A==
X-Received: by 2002:a17:903:1b2f:b0:221:751f:cfbe with SMTP id d9443c01a7336-22bea0abfecmr45250655ad.19.1744377352063;
        Fri, 11 Apr 2025 06:15:52 -0700 (PDT)
Received: from localhost.localdomain ([2a12:a305:4::308a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7c95cc6sm48245005ad.122.2025.04.11.06.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 06:15:51 -0700 (PDT)
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
Subject: [PATCH 4/9] pwm: pxa: add support for spacemit K1
Date: Fri, 11 Apr 2025 21:14:18 +0800
Message-ID: <20250411131423.3802611-5-guodong@riscstar.com>
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

Add SpacemiT K1 support to the PWM PXA driver by extending the
of_match table with the appropriate compatible string.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
 drivers/pwm/pwm-pxa.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index dd9c6af0f672..3835eba824b9 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -37,6 +37,7 @@ static const struct platform_device_id pwm_id_table[] = {
 	{ "pxa27x-pwm", HAS_SECONDARY_PWM },
 	{ "pxa168-pwm", 0 },
 	{ "pxa910-pwm", 0 },
+	{ "spacemit-k1-pwm", 0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(platform, pwm_id_table);
@@ -149,6 +150,7 @@ static const struct of_device_id pwm_of_match[] = {
 	{ .compatible = "marvell,pxa270-pwm", .data = &pwm_id_table[0]},
 	{ .compatible = "marvell,pxa168-pwm", .data = &pwm_id_table[0]},
 	{ .compatible = "marvell,pxa910-pwm", .data = &pwm_id_table[0]},
+	{ .compatible = "spacemit,k1-pwm",    .data = &pwm_id_table[0]},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pwm_of_match);
-- 
2.43.0


