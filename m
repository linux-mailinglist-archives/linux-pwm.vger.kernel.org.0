Return-Path: <linux-pwm+bounces-9252-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 49vKL9dPIWpWDAEAu9opvQ
	(envelope-from <linux-pwm+bounces-9252-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 04 Jun 2026 12:13:43 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AF663EE51
	for <lists+linux-pwm@lfdr.de>; Thu, 04 Jun 2026 12:13:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="EO/2fHqq";
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9252-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9252-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 052BA30DE22A
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Jun 2026 09:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB963FFAB3;
	Thu,  4 Jun 2026 09:57:01 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF493FE65D
	for <linux-pwm@vger.kernel.org>; Thu,  4 Jun 2026 09:56:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780567021; cv=none; b=a3g/JnQz1dPYNffZobZlx8or7cYLBn3nb1Ap2YoMD7fzv+homRo8g88oC8ESwhm8yoaDEiluiLVs72c3bY6WtzMDknmfcfndO0YV0ErE2Eo0cVx8ppS41hjrghC8JPkCm7+NAekZUuBuGfptFxH3nMN54rJ+SWlbRPTr/L0BTTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780567021; c=relaxed/simple;
	bh=DSOrnh+y1FR5hznD6d87goguRPCs/nf79LO/QwtZvLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=efLMvCnn2a8zTp5Y1mddEGxMlv7kIkDnWyvt0Tj9gBtxiJQdzFRq0bcRPA1Oy3iP+fTW+B6K+79GJRJUa7AMZeiqEJEk0w/Z7IjEXWOd9Ifb/64ZF58qBZzbLrlhoP0mOEda44TfogGaLcfV80C2gItzOQiyFpCvFDMZ8MFqEto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EO/2fHqq; arc=none smtp.client-ip=209.85.128.50
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490ac10e337so2863635e9.3
        for <linux-pwm@vger.kernel.org>; Thu, 04 Jun 2026 02:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780567018; x=1781171818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+OfL2gz90L3t0N5J/m3NQlBjpG1dV2rmeosaocF/dE=;
        b=EO/2fHqqptII7S5/MbSpi4XZB7E0hoqgA2NM3CtTdNMP9oca9lAdJcieDRZAMjL0o4
         oDjuw4HLpWRoOJu7iaxJvSAvtTVefmhT0EaL5b/Eogbm0qnWvzexlXZz4xBv9A7TO3wv
         OpJ7iDlxXPtqOIGxuZoZHrhzTt+iOe5Wp0pkopQL2MgtxZgg9t4kq2crWR7hXJFM2z8+
         U9QnEgJPBc5jV9zBZvQQk9gHCwap3apcPZCGAhVyzQVncbLZSlyPP209TwFyoM6xliMM
         5BCL9vQTCWI2mtWhYNJOxM6VnlXNvA2kVZzv1T+T6uErxPjS5zIJNuNGh1u6i5FkhKTV
         nTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780567018; x=1781171818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0+OfL2gz90L3t0N5J/m3NQlBjpG1dV2rmeosaocF/dE=;
        b=jJ79YAGhAmydZ7Dkaf1zrUDX3p1sBnh3vLqEFGc7KhHMKpeD/nBCs2dbuIre+DhUQT
         9FUrSbsQg1TQ2SeJi/yzo9T3B/bcMJpSfNdLER/bUh1BzgMvi8bZ26GdwsJ3QnET6TH0
         2PKE7HKVrGBkvbC+bQNmP4oRre/DbxrQwuTIMFG54qHq/jH5D8exCRrSiIFsmojOIGIl
         Q15gy+DMr/OMdglDr7JdyxWLoUU71YkpKT5yslUnP50ny7SOON+q/nkP0+FKED51dm6w
         zYYj6dVrmobICTKiF/gWkCrl1rxiuoh3cJ8F9r6S9QEb7nEaww71YT3MRVlODMFATAix
         pdBA==
X-Forwarded-Encrypted: i=1; AFNElJ/hxoghOfWVIbS5igipMzxCyVsCONvkp5zikDYkJW46OyiAS4omn12GoZpdChyBkgZBi8QuAK4LnnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZOuSBwm59cOYVqV8uz7fe130LUIFJa60nbaJOhhzRV2q7eb4P
	R8q9LCjmObm9RjogB4uN3OgH2M5I+xLuQTmprjGluQG14jT7fQUOeWJE
X-Gm-Gg: Acq92OF+x4Vxu/+04y1hsm0M4dScdMNeRIUaiFf4yCkHCoIawmXBEXc0uAtFbt/9sat
	X3bDKxnwBtPh88YHBTkM1Wsc1M1lSHXpDB2uinJi+sDgw9IJ0Aa1z2MoCgerGTs7PAvIUqbV6Sg
	m9hXaFJ+O15msw7BxlnQOQ5ncSBDe7N5AfLa7wpYvZ64zgese3ssu1tclOWtQqp1AckpFLTMqX+
	kG1cX/jz6UNzFkDbo31Tdylk/tFu2QtDryUbSd9e221xn7pNEO6+Boz0SoD7z+2eeYAF9S+FAeo
	AaZJsxKUYXJpZMpV6tWIYMYDYykC1OkfhvhBGsF/yOv1urZXwJXM9B+K/j9GjYJqAjZvuZuJtSl
	s3H3LYFO4j6vf7ckNh31+Xfi6+IWFeToQpXHpXbAj65U2jCm8d6evmjuvaQtFnHZofJiUleyGRf
	sD3JqaDV6GjY6iPHbp40GEQm5u8Zp1JRsFjSnAOVf0XJooEIoT4My/jd2U0iGm3OtQBm7F1w==
X-Received: by 2002:a05:600c:354e:b0:48a:75b9:b0bc with SMTP id 5b1f17b1804b1-490b60edb8bmr112259485e9.29.1780567018421;
        Thu, 04 Jun 2026 02:56:58 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a700:7301:1615:3574:e0c0:837d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490be1f69bcsm38037335e9.8.2026.06.04.02.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 02:56:58 -0700 (PDT)
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
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Subject: [PATCH v6 09/11] pwm: rzg2l-gpt: Add calculate_prescale() callback to struct rzg2l_gpt_info
Date: Thu,  4 Jun 2026 10:56:39 +0100
Message-ID: <20260604095647.108654-10-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604095647.108654-1-biju.das.jz@bp.renesas.com>
References: <20260604095647.108654-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[bp.renesas.com,vger.kernel.org,glider.be,gmail.com];
	TAGGED_FROM(0.00)[bounces-9252-lists,linux-pwm=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ukleinek@kernel.org,m:biju.das.jz@bp.renesas.com,m:linux-pwm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:geert+renesas@glider.be,m:prabhakar.mahadev-lad.rj@bp.renesas.com,m:biju.das.au@gmail.com,m:linux-renesas-soc@vger.kernel.org,m:tommaso.merciai.xr@bp.renesas.com,m:geert@glider.be,m:bijudasau@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[bijudasau@gmail.com,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bijudasau@gmail.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,renesas];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 14AF663EE51

From: Biju Das <biju.das.jz@bp.renesas.com>

The RZ/G2L GPT prescaler steps are continuous powers of 4, while RZ/G3E
uses powers of 2 but with a discontinuous sequence. Add a
calculate_prescale function pointer to struct rzg2l_gpt_info to allow
per-SoC prescaler selection logic. Replace the direct call to
rzg2l_gpt_calculate_prescale() in rzg2l_gpt_round_waveform_tohw() with an
indirect call through info->calculate_prescale(). Wire the existing
rzg2l_gpt_calculate_prescale() into rzg2l_data to preserve current RZ/G2L
behaviour.

Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v5->v6:
 * No change.
v4->v5:
 * Updated commit description.
v3->v4:
 * No change.
v2->v3:
 * No change.
v1->v2:
 * Collected tag.
---
 drivers/pwm/pwm-rzg2l-gpt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index 4f3b4dd959e6..7e669406dcdd 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -91,6 +91,7 @@
 #define RZG2L_LAST_POEG_GROUP	3
 
 struct rzg2l_gpt_info {
+	u8 (*calculate_prescale)(u64 period);
 	u32 gtcr_tpcs;
 	u8 prescale_mult;
 };
@@ -305,7 +306,7 @@ static int rzg2l_gpt_round_waveform_tohw(struct pwm_chip *chip,
 		}
 	}
 
-	wfhw->prescale = rzg2l_gpt_calculate_prescale(period_ticks);
+	wfhw->prescale = info->calculate_prescale(period_ticks);
 	wfhw->gtpr = rzg2l_gpt_calculate_pv_or_dc(info, period_ticks, wfhw->prescale);
 	wfhw->gtccr = 0;
 	if (is_small_second_period)
@@ -588,6 +589,7 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 }
 
 static const struct rzg2l_gpt_info rzg2l_data = {
+	.calculate_prescale = rzg2l_gpt_calculate_prescale,
 	.gtcr_tpcs = RZG2L_GTCR_TPCS,
 	.prescale_mult = 2,
 };
-- 
2.43.0


