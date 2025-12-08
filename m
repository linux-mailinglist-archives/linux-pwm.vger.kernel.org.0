Return-Path: <linux-pwm+bounces-7782-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A40CAD928
	for <lists+linux-pwm@lfdr.de>; Mon, 08 Dec 2025 16:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C6143053FC6
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Dec 2025 15:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB03D2EC563;
	Mon,  8 Dec 2025 15:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNOr3P8e"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F123D2C3271
	for <linux-pwm@vger.kernel.org>; Mon,  8 Dec 2025 15:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765207304; cv=none; b=ZaLOV5x4CAMq3LUYF0FOMPq1FrEuOia08uNE3VIPx2sYt574eU7+0fZmrHN7+kFUKIGfSlyFObSh50q/jeYX0H0iFC2PF0VmGxNSVP8tjRUMD/bUfOxZNRFFVCKSxNXIu4j16KMXi1q3rbZDbmoRvjz7yoOravF63Zqlin1hd1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765207304; c=relaxed/simple;
	bh=zLLetJqM12TY1c7+MFbtwNOwfn3AnlzzYAStgZhqwt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MLXarb15AuLvSs4dmhUqolg877zQpWTZeDm5ndvQKfQAyNmXzJ9YOdC0r66cN4FE93H2EcHn+C1jNtzDI8Pjo7GkG+gE1TrgPc7A5q26p3ilwbkfJxHgP96ecxK68/ehnmi0S6MkdrgHmnz4JcvvpuZpV1P+lF2xDyW3YoLcyLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNOr3P8e; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b7277324054so645505166b.0
        for <linux-pwm@vger.kernel.org>; Mon, 08 Dec 2025 07:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765207300; x=1765812100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUXCkzxCQ0NLPbJywbDmd+GQ+c8nxVNpBJevzMxZvNw=;
        b=KNOr3P8eerR2Pm60KQhgHiYqYRDrU/w8F/X/b8I7d/qnOYQbVavz164pm7yVWlzzlF
         d0GkctEzTvN7cOxKAZk1ys0A7lvKhOVrVIVZzX0hCYvjp09KTve18+Wguxv12YiXe1Ln
         T6RS/BZ01saz3+SfbDq74/Q1gmAMQWPTclG10XBg3ZNHrcWa1MQpPR2jXROUdbwT9iBz
         dT3+xcKUUIizV9cjF+WLhUqYzLkU4ZN38Z6u7EZ2oSkErsseKL3uH3uwEB3qHSMejLcE
         olnFrJcOuFrUayI4P2fJXLzPvab6KEPIewtjegEMojsjzYFJSQd5PfZizAjV6SuutjSv
         g57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765207300; x=1765812100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GUXCkzxCQ0NLPbJywbDmd+GQ+c8nxVNpBJevzMxZvNw=;
        b=Ns7qvvPB+8lpbpu4oYuC+cUX9IWiaGaMYro3Dn835BuHBomSGyVYyRbCO9V/44u2b+
         erYuO2dfiyr8xb7SUEG8wixuvtvuyPcUHZN2iyYN+W0YH5dPZqauK/slKdDrHteC7zCa
         blffxdzeXFG1QkdDHjWqqbqbhO65WwB/NvdZlk1Q+Fba8g5xYYPs541V2O+LLNo1yq/m
         V2BxqfJArLbcQ1YHjn6qPoL0VBtc/SERF+NNlC48DguCoVp7gtPkCV/x1v1AnJ+f7tvK
         lX4UfOy78CzujzHIHU+xDsoKcutovsXs0XOtKPRX1K0Y3PDtuxmacFwYFTX215+EJv1+
         wuqg==
X-Forwarded-Encrypted: i=1; AJvYcCWppGoe8/4iUheDPMs9WG+DSylQWAE3MO0PBT8KNQm7Y5vOwttCG8tsIzrKhakNEtQWNfT1Ikmc4Xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVR7gO7XhYCiXUlUq1BjUDxvqW3+z+0x0YSBmu66Rt2cQC+ycu
	Un50DtfqpphqaYPGRkPVBrk3mb8lnOI2J9eoK8pja/33qqAkNSP+n2Df
X-Gm-Gg: ASbGncu4WSyx9nzzQfgFN703XKwBGI3XU/w8IG0zAToVU2nEE5Aa78R++3o/RujKNn2
	Z1H/wzrhyJnjTdrdd7hbgw5vfpRWlipAGRnFRUNKYylQYKwMh5w3whludsasET8mVyjHLisg4a7
	jwbwjr8JpJrXapu/u+LB6qpCt7I08e/SNN9I0ireGILCkcupmPVl/aiSV/t1q7P8TU4dlb9TCMm
	AnLcw8n9s4lM4w9nEGXHQduvXbZh7IJWcUQ3JyhPq301/bSW8UjgQtxSZ6+zoT8jGS7IdpjN2BU
	A0GFOlKZXOIKNw8E+fk7MHAccQLhwaHI6+HpmvSmz8K9tRiRUdtXDIm2MZaqhSELGRc9sQHqNSO
	mcJqnIf330iliWUaGJgkn7U73jvXk0uF8o+6S1CcjdBtCJ41BtBpHEapeg0ON502NVoza5IlKWU
	0JztNbcccJtFqsyATAp4eO3Pdyod6eZJoBrLvRfxv8pzuaX54lhYSldQESl8SjQ58N1RJyM2n5u
	6jqvWphGOS97e3K
X-Google-Smtp-Source: AGHT+IFxf04tp4ZANgUPLE9H0eJNVOFCAkMovTKf8QoOV0OScvm/yK9ltFfxmGvGU9Bx0es0K3wD/g==
X-Received: by 2002:a17:906:478a:b0:b73:6d57:3e06 with SMTP id a640c23a62f3a-b7a2428bd90mr702125066b.7.1765207299441;
        Mon, 08 Dec 2025 07:21:39 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647b412deddsm11547484a12.31.2025.12.08.07.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 07:21:39 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Subject: [PATCH v4 5/9] pwm: rzg2l-gpt: Add calculate_prescale() callback to struct rzg2l_gpt_info
Date: Mon,  8 Dec 2025 15:21:22 +0000
Message-ID: <20251208152133.269316-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251208152133.269316-1-biju.das.jz@bp.renesas.com>
References: <20251208152133.269316-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

RZ/G2L GPT the prescale factors are continuous power of 4 whereas on RZ/G3E
it is power of 2 but discontinuous. Add calculate_prescale() callback to
struct rzg2l_gpt_info for handling this difference.

Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3->v4:
 * No change.
v2->v3:
 * No change.
v1->v2:
 * Collected tag.
---
 drivers/pwm/pwm-rzg2l-gpt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index 47324c9fa6dd..791900f6de3d 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -78,6 +78,7 @@
 #define RZG2L_MAX_TICKS		((u64)U32_MAX * RZG2L_MAX_SCALE_FACTOR)
 
 struct rzg2l_gpt_info {
+	u8 (*calculate_prescale)(u64 period);
 	u32 gtcr_tpcs;
 	u8 prescale_mult;
 };
@@ -131,8 +132,7 @@ static void rzg2l_gpt_modify(struct rzg2l_gpt_chip *rzg2l_gpt, u32 reg, u32 clr,
 			(rzg2l_gpt_read(rzg2l_gpt, reg) & ~clr) | set);
 }
 
-static u8 rzg2l_gpt_calculate_prescale(struct rzg2l_gpt_chip *rzg2l_gpt,
-				       u64 period_ticks)
+static u8 rzg2l_gpt_calculate_prescale(u64 period_ticks)
 {
 	u32 prescaled_period_ticks;
 	u8 prescale;
@@ -292,7 +292,7 @@ static int rzg2l_gpt_round_waveform_tohw(struct pwm_chip *chip,
 		}
 	}
 
-	wfhw->prescale = rzg2l_gpt_calculate_prescale(rzg2l_gpt, period_ticks);
+	wfhw->prescale = info->calculate_prescale(period_ticks);
 	pv = rzg2l_gpt_calculate_pv_or_dc(info, period_ticks, wfhw->prescale);
 	wfhw->gtpr = pv;
 	if (is_small_second_period)
@@ -494,6 +494,7 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 }
 
 static const struct rzg2l_gpt_info rzg2l_data = {
+	.calculate_prescale = rzg2l_gpt_calculate_prescale,
 	.gtcr_tpcs = RZG2L_GTCR_TPCS,
 	.prescale_mult = 2,
 };
-- 
2.43.0


