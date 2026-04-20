Return-Path: <linux-pwm+bounces-8641-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zfUbEJMD5mnwqQEAu9opvQ
	(envelope-from <linux-pwm+bounces-8641-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 12:44:35 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE164429774
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 12:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B6342301BA68
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 10:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3229239DBD6;
	Mon, 20 Apr 2026 10:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TR6d7U1v"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB6C39C65C
	for <linux-pwm@vger.kernel.org>; Mon, 20 Apr 2026 10:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776681825; cv=none; b=FUdSGyQiQ8vBnhuZAurBNRISLjMrD0487pG9aXic7IRc59dt7pw3uhBum/6LOJeMe/yZzeGAHDyMISMnqzGa/lALkqMVra6dyXm+bdoAsazc0CbgGSTSUAhcTt7I7jJa2P1NnULbbNaBeYzSpAFTNnR/6lxP8PSnceggAoEM4aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776681825; c=relaxed/simple;
	bh=CzNdLIlMDStTIZ7BBa1Bsq0Y9eD8RZUhGL/aLMqsKLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E+71ipQu6r0jtLRllHLurt8iQJCfDxEsbZCD8D9fuGJ5Mex3OyrhfHoeWxKk/HliqijETBxwVfmM6Hyw2zT5H88/c8byNj5DeRsGtdEkI6+LfnsQ2pbVOdZ3qSpgJ5iJ5bw4/VrJKryX/2fN0GLh/rrTsZuRBspAgP7arlQTBxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TR6d7U1v; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4891f625344so6581945e9.0
        for <linux-pwm@vger.kernel.org>; Mon, 20 Apr 2026 03:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776681822; x=1777286622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nd03d915YFFbDDS7Gpno90+cH614IrY41lAzLURzwnU=;
        b=TR6d7U1vsOaB8FPOnHu12YAz4JmZFyaa0vVhlSR16IzkLgtp/qE4ivCZ3w7lWdoy0b
         eVqmgfLL3hinsDpBE2NTmPdMcYxuSVRvjJo+mxzbieIxTCiIW3Bws9+mePkptoXHnMQ9
         5r2IFZvFpmOtp9GSph6ztttP9et1O2QGhjZKb4KgOws3BLHsqyWbdmvEwhAHFDMXsJIP
         KEFJNKMgaNUpO6NFKWdN43GcgupiTvxjvz7yUhzObTcM/R3xIa+Z6uYBsGgBRF9RoJQg
         iswSX9qUNw6EIMXsKGHy4WCaXsEkEwR+J8OgOy4uCBw4lviuEcwdxm+8nwxvA+QWlh2n
         0NbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776681822; x=1777286622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nd03d915YFFbDDS7Gpno90+cH614IrY41lAzLURzwnU=;
        b=aOp4VQGtlEPZgbzch6W/5biD3g8l0P1pw2UnhP88+WrOOkHO/tMljHgOuOgTlN/Hgg
         ucQQ1W7ZQF9ZpBpRZ0cxofxND62f4dVyre9M5I8gHwH7QbNq60XUhPdIti7Xsja5H5JD
         +U4kdhTG0aiDbtvKOAg59Ti+iKcH1eWxnl6eL5vcb7MJmFAqHpSC+gK5y5iIwx2bpyzP
         GaAeDLRMMP1+40E1+atbRcG5uExwAg+rYQb9mfFpaxfSnnpG9EyyBtZCR03pnDlfEZUs
         iusUDgHVn6+5RcKC0P8WnTI1VHlYPB7DqGS/sXUJ8iW25jnnBKM0eOtSTBeq3nKkeY+L
         yhWQ==
X-Forwarded-Encrypted: i=1; AFNElJ8m9+zLb8Mghys/77isUns7kGUNQxCUJoQ7XdaaaQUrXXUuLU1ihAMGrmZT6ed7gAz8is0M9iI1xmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOeQ7D58nzduSCNiywNqBKoLAoPwUXUs6PGV5W+JnkO7wUBwpQ
	+jXZSgJXHMc3Pu+iEXYEQ59PjLMMJTKk/RonXJBqtjJKDiZGqact5JUH
X-Gm-Gg: AeBDieto7aYArQfdIKcUx7unD2XSysJAruMd8XeZOxmZ6vf/0JzClI7Eh1obmiJNQoX
	o6QWDKFVIRWC99KDiu3FGI4JiKoXwF01TNTys8bx4epkn9y5M9LRt87xWYkwaj3MPf2kBYL48+w
	cpbGpu3HyOcKzuIrkdv958RDH+bYxw13hiLEmow+d65qKaSBP9QsRQPq222vxrHf3j5JGfLDbzh
	7pqtIAGIK4iheppkV8QHRmQ+tWS1G3GxjvRmKHRt0mnv/l4G0J0raQrn1ljiEL/NCLH6X/rxYqw
	2AvnEROAKgvlmMMdh9UAMno/bPl9EtNfrgCHKZR0k/SDYB2M/9RroJoDcY9RB4fyM3m4enmZaFt
	ovK4UYWew/+3C5XO7YVeqPPxn1smK23TqueA+Dj7HP6FCxeiC8XJqwUzwsnlVuNC+bUi6gnefz3
	YQr7hxjftjKaOPgMtD3DTcoBbfyqQ3spmjhv86Z4SqKUOuFddsupskZ/hSFljtORzvPg3yug==
X-Received: by 2002:a05:600c:8a1a:20b0:485:3038:72c2 with SMTP id 5b1f17b1804b1-488fb8bcdf6mr130455095e9.17.1776681821758;
        Mon, 20 Apr 2026 03:43:41 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:5f3e:f914:6f8c:72c3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4c221cdsm28038301f8f.0.2026.04.20.03.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 03:43:41 -0700 (PDT)
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
Subject: [PATCH v5 7/9] pwm: rzg2l-gpt: Add calculate_prescale() callback to struct rzg2l_gpt_info
Date: Mon, 20 Apr 2026 11:43:24 +0100
Message-ID: <20260420104332.153640-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260420104332.153640-1-biju.das.jz@bp.renesas.com>
References: <20260420104332.153640-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8641-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[bp.renesas.com,vger.kernel.org,glider.be,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bijudasau@gmail.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-pwm,renesas];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: AE164429774
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 4324ffc8629d..de68c02b2d50 100644
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
 
-	wfhw->prescale = rzg2l_gpt_calculate_prescale(rzg2l_gpt, period_ticks);
+	wfhw->prescale = info->calculate_prescale(period_ticks);
 	pv = rzg2l_gpt_calculate_pv_or_dc(info, period_ticks, wfhw->prescale);
 	wfhw->gtpr = pv;
 	wfhw->gtccr = 0;
@@ -587,6 +588,7 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 }
 
 static const struct rzg2l_gpt_info rzg2l_data = {
+	.calculate_prescale = rzg2l_gpt_calculate_prescale,
 	.gtcr_tpcs = RZG2L_GTCR_TPCS,
 	.prescale_mult = 2,
 };
-- 
2.43.0


