Return-Path: <linux-pwm+bounces-7633-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FB4C5E0C0
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Nov 2025 17:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 479AD380B92
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Nov 2025 15:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549B532C95A;
	Fri, 14 Nov 2025 14:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjdxNwwy"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730DC32C957
	for <linux-pwm@vger.kernel.org>; Fri, 14 Nov 2025 14:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763132173; cv=none; b=s9JEJaM/eivhesIJIR+ctqFGa/7PCqX1pQhz77Xw0ZQ68FD4fvKLJwN3oLVTSQuCuvA/ZR3Nv2RRi9erh2W1Pqh2nrnAUhOzWDITgfKp9pekly+PFVV90SiBvUjdLj4+vrsc7lixHHdz8G6E8AViBXBEO3K4cD8qRH9Ak55z/rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763132173; c=relaxed/simple;
	bh=nhXoDjA1PWTMn6uiehqF3ffeV5CNc4kbk1M8EgQv+DQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kSCm+lC+eyKxgUpaqjIuFf6rlNtJZK2gNwZ6+7aLGo+0Feb8z9HFcX76SBBlXJxb8o+Ao0ArLRcdKLvafSSKxapFwbZjlxJisW8FG+R0lG8+j/g9cBrYPBwB05u4uy/+ekHdZb7YAttNAOZmSn2YR+DpHuSASS73CiISuTymopo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjdxNwwy; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4775638d819so12280775e9.1
        for <linux-pwm@vger.kernel.org>; Fri, 14 Nov 2025 06:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763132170; x=1763736970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WiVLm9glz9q/D2Y2GvnPtcV9YqAxrkU1bdmECATlQW4=;
        b=fjdxNwwy5XkzQ4nDATT1xxVdJWrOJWuLJUT5g2lx5qwLHHb02DdejrtfS7QJacKGRl
         T+HGwCakMQHCYnpLx6DhVxYkz3EwrsV95+YbAYat0ucJfDBFLIXX2FIGxsMtyNUoFCCu
         DjDZ/RoHvwKn006fWE6Jqhrs5DU6sboF8Z+f1uSOxs6tLtho8vCZ1DfEd1An1DZ9s7GY
         iMD6LT57JYKstTmZfINDdqZ9xxxol/MBVMF+IDkrxB6OkovouD7fooeFBQqgMonVyekt
         B4jXR3CdoQaZ18YWWmeGCqHtY5pCOLoAo6F/qJSXXfWh/EpPfFuYrnl2P8iwdNeWUrHT
         Fj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763132170; x=1763736970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WiVLm9glz9q/D2Y2GvnPtcV9YqAxrkU1bdmECATlQW4=;
        b=NJUKt+QqsTXqoZitDn85wAA0Z8NplDHlx7cC80iomED488fXARH0MzapFRYvfdI8Xw
         mlAcrG84KCtUBA68Na7gN94zpXhzFABtwZxCVPbZ0IEmglds1BkwN6uCd2EOdSKq+Zc7
         BMSa9zYjOMkYikzi7FsPKb03aE0i0M5thp/4TOmYyxPKcEEcAn+OGcGy1mtHqZUUsdOR
         MH24Q+RW4UBYxhBrwo+9yZcx3kXuBLVN5gGCrylRswoB9gmWDU7qATgNLpT+URci3ci2
         bWDAFjDm0V5vqz2tP2+zHmLUjcyUAZFTuis6qAwMARshLuBKFrM3mCCXAa+MvrumM0H2
         274g==
X-Forwarded-Encrypted: i=1; AJvYcCXCnbkdUfimbZsSgCMTCq5PiECUYVI+4cl52Hlxi+ulmhm+fA0DYTstBJpyVqNjElTBR02abanSOJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUgMVi52aZlzk3UowBMlAYMIVRzZGhzCq1DI3OsViKDP5Yo3A/
	JWROindrZAZP3sAXTVD3NbBogCc1Tq+wZVagOzCj6FewgZm9CGhZ0a92
X-Gm-Gg: ASbGncs2f0NsR574lT/qzszqpT10Ag35Vm2t4f9mWA79HiaAwJc/5xNVGPrOHKS/BrY
	XKVYoqNByHI+omKAn62DD6nBpnKBvACPrE08irqFhpoKWFRw3AG9AzL7so26pBXdXCmxitNhXT4
	6YjJ8TF2WxQYuTJeF80FDs4/8wtBWYS/+MIk42nhaikeTSmA7fyboQYkcGvddAIi3m+yM7zZUR9
	1eoGT+j5Piw6iK7dkHxS3GrlxXW0ED9FSZU1Wq+8+5OOoQrR2zs6q1UD+I10pevJHJlVuK+giTy
	LJLXmrrAdKeey/7cbHpTOgrtlPS8HxgBGrN3KDgXm7Y7WCFStiZmpc71m7ZyTwzXATtyo+/iXIi
	vPSVn1gtLi17H/SaIq3Jx60Nw+EoDsRcQpj/5L7U6zYWAvQnbMD2sc1iWZEj3Nz6zV0LilInRAY
	2K88GKveE1YF12n7C3hB6pNGnJFM8RaB83RdVz8kvUcRgCcUl6s1n1Kg+wjR9+ulYkkj6RVvw+l
	BzMI721m3amp6G6
X-Google-Smtp-Source: AGHT+IFzsL9fkHuLUlOZ0H7+bcguyZLzKvaRulLdHVAWsB/gVcOA7RfTg5kpkh6+zj/vIpjFoqRACQ==
X-Received: by 2002:a05:600c:1387:b0:477:7b30:a6fc with SMTP id 5b1f17b1804b1-4778feb13femr39245125e9.30.1763132169611;
        Fri, 14 Nov 2025 06:56:09 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778bd27e97sm47073115e9.7.2025.11.14.06.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 06:56:09 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	stable@kernel.org
Subject: [PATCH v4] pwm: rzg2l-gpt: Reinitialize the cache value in rzg2l_gpt_disable()
Date: Fri, 14 Nov 2025 14:56:01 +0000
Message-ID: <20251114145606.200948-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

The rzg2l_gpt_config() test the rzg2l_gpt->period_tick variable. This
check is not valid, if enabling of a channel happens after disabling all
the channels as it test against the cached value. Therefore, reinitialize
the variable rzg2l_gpt->period_tick to 0 in rzg2l_gpt_disable(), when
all the logical channels of a hardware channel is disabled.

Cc: stable@kernel.org
Fixes: 061f087f5d0b ("pwm: Add support for RZ/G2L GPT")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3->v4:
 * Split the patch as separate from [1] for easy merging.
 * Updated commit description
 * Added comments about the fix in rzg2l_gpt_disable()
v3:
 * New patch

[1] https://lore.kernel.org/all/20250915163637.3572-1-biju.das.jz@bp.renesas.com/#t
---
 drivers/pwm/pwm-rzg2l-gpt.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index 360c8bf3b190..ab91bfd7da48 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -190,8 +190,17 @@ static void rzg2l_gpt_disable(struct rzg2l_gpt_chip *rzg2l_gpt,
 	/* Stop count, Output low on GTIOCx pin when counting stops */
 	rzg2l_gpt->channel_enable_count[ch]--;
 
-	if (!rzg2l_gpt->channel_enable_count[ch])
+	if (!rzg2l_gpt->channel_enable_count[ch]) {
 		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), RZG2L_GTCR_CST, 0);
+		/*
+		 * The rzg2l_gpt_config() test the rzg2l_gpt->period_tick
+		 * variable. This check is not valid, if enabling of a channel
+		 * happens after disabling all the channels as it test against
+		 * the cached value. Therefore, reinitialize the variable
+		 * rzg2l_gpt->period_tick to 0.
+		 */
+		rzg2l_gpt->period_ticks[ch] = 0;
+	}
 
 	/* Disable pin output */
 	rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTIOR(ch), RZG2L_GTIOR_OxE(sub_ch), 0);
-- 
2.43.0


