Return-Path: <linux-pwm+bounces-9036-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFIxCHpLDmrL9gUAu9opvQ
	(envelope-from <linux-pwm+bounces-9036-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 21 May 2026 02:02:02 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A8A59D1DB
	for <lists+linux-pwm@lfdr.de>; Thu, 21 May 2026 02:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 350E1303976E
	for <lists+linux-pwm@lfdr.de>; Thu, 21 May 2026 00:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BE372618;
	Thu, 21 May 2026 00:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="LnzEF2is"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D57039FD4
	for <linux-pwm@vger.kernel.org>; Thu, 21 May 2026 00:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779321677; cv=none; b=omjZ2Gt4XXq+dS5KGPxLhemM4SD/7D7ozNSW8WNNoJYCjWbM9/2sC7nCBzWHmUDEAckes8rQjlWYF3Ee6YG0oqORjn2pHYYbTDcScm7BvH7wR7j7v2Tu0CIug/WyGHQDZNcBjZAsZ6R3aJtlUqk2OWRuO3qu36NTm02aem/5Dvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779321677; c=relaxed/simple;
	bh=3Z1/s8TDKCJg12TEEASVieUkMtbUhhy151++MGS6sgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rKUzjdnK+hhavqdsPVkkMazGqTv/LxHZj+bMpBVbsBQikFo1AumUTwhwvaHOZqvyZjusSwxYrwUmEm/OrdRvDVW/ORrUSVLw+OxgJ2W0QpoZ8Euq9pd/cqRCBwZIZPUSWAOst4KsEFKyM/2jkcxDmQ6d0ghy+uLIpB6g3uReHYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=LnzEF2is; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-56f72d27e7eso6826410e0c.0
        for <linux-pwm@vger.kernel.org>; Wed, 20 May 2026 17:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779321674; x=1779926474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lg+UFUjX2TWBvKvhX5SvfRqht7iHN6Ihdh9sMBKt2/o=;
        b=LnzEF2isaSB/NOqY7hyYBDWDxrEx5PqfOY1sABqKNvXZgsoCRbeCeBvSeEF9ql5DN0
         8F9U7SgnB30QRXZTfQvyqfmgKFOd0PYJIHbU/pgt4bn7D30AwHFPBWsCXslrjvZJZ0Ep
         uvXk4tQT+EA6SEGqqxaEXllojFh3dQ/bzjM+GY4E47DE5m+NBPTFVhWOi9/3AJAvOmBP
         M6cayqx/3vRAYEU0+NHOkbB93wEkaSHVbbQsHpjf4cKaD6imM4LudCCXegzSFea6GLHJ
         FqDc/7zXq6gwSh2vl2OVgmyQ2U8ZPc8iOLQnsc+Jr54lxGCwj9oPIE8G6PDGdb6QcZh9
         R3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779321674; x=1779926474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lg+UFUjX2TWBvKvhX5SvfRqht7iHN6Ihdh9sMBKt2/o=;
        b=QBx6jgJqp6EKs3iKUQW+5MESon8ufrBgA6nvjKzTBHdicoz0c7FIZBbsKGbPs3Zln+
         WGmGOIA3NBWscbgfOBIKdEMiLR4NVnUSDH3+jd4fLEnf+d2jFMMTQU0pMzkLwlJSb2vJ
         pcDHo6K3N+mJ9l/VI7u2f2dDmnW1AKSAH1kc2jclUa2cx/tmcCYleWl7YxITbbaD0PQD
         ZpaIuEC7L0vWA4M8c7Rfl/vLnuXhGbyIdG3Tp43TrxfkodhvmpmH33PtIbd1S8dPSXpw
         L4iiXirQTVBrU0mobHLF8ijxv75jiIlV5o7otHaVKziZ5M7C6XDNdCdBh1auHsq2iCX2
         1Xmw==
X-Gm-Message-State: AOJu0Yx8waVTZMGamlSQWsHknlKQ9vWcieSCAJUm7ZGZ3IGjkwzxSH/f
	/sRFetU5c34n0gaj53kCCsDPNB1vVv8s6HwArRjxsPQp/U4dce2+LbFfw8O+/c0uiTBDGPFVxFD
	coHcRea9iLw==
X-Gm-Gg: Acq92OFPq691Qk8xXaIHhPEn/RhNPgPSRh2a/7wrQqZuSTuQF63410rWuSEPczpowMP
	yVhclTCdycqt7VqMIiAyvbdtGu6q5hjH8z5K7F0lekVrZnjRdEqLLkKnyMTrggdkQPE4mHmtH3B
	E35YV8RXtccFJnEP1ZDyo2p7l0Ky4gCE5K5y7BeDcq8UzhHMlu5zvfzh36fZo7RJMIwWT+tUNKT
	sUgbW/AA4tJEdk+kmu0wxuTZhDqHgp2FK3tCKghMaTMgJrBgc+2f+FIWMVDE5Q27YG+dEFyvLTZ
	jY8pLeiNaZUfcSuxcoTT4pRAWpvSlp3XMn+OVXa2uzVhxBVs89chyEiBfa/fH7aLRP52Y9olk2l
	0pxPNTi0f5OQq1efPe1vLEhJv3ycNBpBSyPuyf6EdqDsXw3i5rpqpqUPZlHgvi1nqmDpltc/IVR
	41f4kbpiTUlWG3M1KuUJRYo39Na+FCj1BLpW7bU3rOzA==
X-Received: by 2002:a05:6122:235:b0:575:fa0b:bc23 with SMTP id 71dfb90a1353d-5841b77d3bemr288066e0c.2.1779321673711;
        Wed, 20 May 2026 17:01:13 -0700 (PDT)
Received: from acer-e1.tail6c460f.ts.net ([2804:7f0:7542:7b16:2880:ed6d:f5c:8b9e])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95fc2d278a8sm10206321241.6.2026.05.20.17.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 17:01:12 -0700 (PDT)
From: Ronaldo Nunez <rnunez@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ronaldo Nunez <rnunez@baylibre.com>
Subject: [PATCH] pwm: imx27: Fix variable truncation in .apply()
Date: Wed, 20 May 2026 21:00:54 -0300
Message-ID: <20260521000054.4790-1-rnunez@baylibre.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9036-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,baylibre.com];
	DMARC_NA(0.00)[baylibre.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rnunez@baylibre.com,linux-pwm@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[baylibre.com:+];
	TAGGED_RCPT(0.00)[linux-pwm];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D5A8A59D1DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch fixes a variable truncation when calculating period in
microseconds as part of the solution for the ERR051198 in .apply()
callback.

The problem was identified when reducing the duty cycle through sysfs,
with enable set to 1. The condition to fix errata ERR051198 for period
smaller than 2us is always being met, due to a truncation on tmp,
variable from .apply() callback, caused by the multiplication of
NSEC_PER_SEC, PWMPR (period register) and the prescaler which can easily
overflow u32. Declaring tmp as u64 makes it large enough to accommodate
larger multiplication results.

Testing:
- Hardware: Udoo Neo Extended with iMX6SoloX SoC
- Tools: Verified with a logic analyzer

Signed-off-by: Ronaldo Nunez <rnunez@baylibre.com>
---
 drivers/pwm/pwm-imx27.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 3d34cdc4a3a5..c8b801fcb525 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -200,7 +200,7 @@ static void pwm_imx27_wait_fifo_slot(struct pwm_chip *chip,
 static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			   const struct pwm_state *state)
 {
-	unsigned long period_cycles, duty_cycles, prescale, period_us, tmp;
+	unsigned long period_cycles, duty_cycles, prescale, period_us;
 	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
 	unsigned long long c;
 	unsigned long long clkrate;
@@ -208,6 +208,7 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	int val;
 	int ret;
 	u32 cr;
+	u64 tmp;
 
 	clkrate = clk_get_rate(imx->clks[PWM_IMX27_PER].clk);
 	c = clkrate * state->period;
@@ -249,6 +250,11 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	val = readl(imx->mmio_base + MX3_PWMPR);
 	val = val >= MX3_PWMPR_MAX ? MX3_PWMPR_MAX : val;
 	cr = readl(imx->mmio_base + MX3_PWMCR);
+
+	/*
+	 * tmp stores period in nanoseconds. Result fits in u64 since
+	 * val <= 0xfffe and prescaler in [1, 0x1000].
+	 */
 	tmp = NSEC_PER_SEC * (u64)(val + 2) * MX3_PWMCR_PRESCALER_GET(cr);
 	tmp = DIV_ROUND_UP_ULL(tmp, clkrate);
 	period_us = DIV_ROUND_UP_ULL(tmp, 1000);
-- 
2.53.0


