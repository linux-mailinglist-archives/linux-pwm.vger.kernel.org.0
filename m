Return-Path: <linux-pwm+bounces-9085-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FQgIRKrEGrKcAYAu9opvQ
	(envelope-from <linux-pwm+bounces-9085-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 21:14:26 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D325B94CA
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 21:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 51848300A7F7
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 19:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802CC374E67;
	Fri, 22 May 2026 19:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="LU7WccnZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1207D3672B5
	for <linux-pwm@vger.kernel.org>; Fri, 22 May 2026 19:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779477263; cv=none; b=Fqw4vjPcbyyunxvwLAlhOyqz2oiTP6MuzcYJVHAJ4iG0BarQ5Oj0TvO+A1fMGA4P930laXjSrqMZ+H5zlFkT2oWnIBrv3LFqxQCvetiByRzjWPqAuxKsMbRW61jc4F3sRlY0XokG/MhIzPouFJt5hBgxhQR5EBbgDnQpPZ/RuFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779477263; c=relaxed/simple;
	bh=W95e8kqy+EUnTLn7yhNEZxHMkbNjEJlRwwDjiQMwjXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WfeQbn9KKpY7/zsRSwmKWukKFw4O3ezNOCPReNjWb7Zis4iBOhH7uLS2aEZVIYbGBjjcrLdrX/5aVUnTmcPPjT3B9OSClKLfbkmHUWk+27p8DRNJun9NaAi6fTSoHdcqU5aqWZFPLJ+iuWde1W924fIguTqAVj6UI/HJOVT1dnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=LU7WccnZ; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-57533363201so2535110e0c.0
        for <linux-pwm@vger.kernel.org>; Fri, 22 May 2026 12:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779477259; x=1780082059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bcQfxlYT0WdkNlclpO13skLK1pFgoPq0lf6iXLyTJ4A=;
        b=LU7WccnZN/e8j78afIIJ2gmr2De8Zy50nyQQbiRzS1qnNe0Pulb/HMmrwk1pXT2Mr3
         RTqAxn8guYYqNY+ahaMfcM89VhGqjvVfeqSF8NNGV1PDawy2qxLglR/BR1v4FbWmZxsd
         TCCFwGdcM5lva3hyD2beNxMp/JVNmWt5p+D0chQ/HvhcBMl8fTCnwfgBT+7jdbxnm/eP
         SdIyLaUuUMyu/8GWE/2xsqVj4kuVg7cQT3ouo2g64ngYHtruvagoQ9dAuhgV1qWpP/w2
         GsRosVnqwVktP3pfkNvbxCzaj8G1XxMja/Ybzz9pk7SDAqswGH9PtyNhmBCjI4AbkUoy
         +w+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779477259; x=1780082059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcQfxlYT0WdkNlclpO13skLK1pFgoPq0lf6iXLyTJ4A=;
        b=qldgsVsmllB2wI6WVrS2GvIctGMuoLOjRglPDxh81OGyn2ruLcllUESdEP5Zxc4UJd
         uQnheGT/3PlThAotQHhb0AyJ3MecKzC5qfMOlzVxPFeR1z5aDtdNkjk9vEeAVaSGZttW
         ftj6Xbmb9Ic4sHieeNXUR7Lq3i4j7GZQqghSFQmgvwm3WPGNZQY8onwB4ughrQUs1K2c
         qGkEAnh4UER9wanV0F3Twv+Pim7T1L6rU5TqMbQnt/KU/n+5JZz+P9Dy+CbirusxqgqT
         t7Fa3WQe57vYNPcVMgGlJOOiBp9/9tAnWOIdLlTwOI98gLruf/bJFDegWlUpVuUN9Sme
         qh5g==
X-Gm-Message-State: AOJu0YwhNPg+FMEnsIaETr/LrzwG42DzP4DKjIRS7ELNZk50JwIiJ0Sk
	9Q/mQWi5iFafjXri7o5H/A2YLLyBEn2c1pGflzYjO/hsv2ALUOradYW3CMXWyOnJN2/ea/75AcJ
	LBVJkiIrB6Q==
X-Gm-Gg: Acq92OHD9NznaNQy0O0hujIh7eOD5/ler+3hQOXDbLv6xlpZREBLNRrle1zXcSiN5Ya
	U77EKT3Ds7u9Ql4abbIAgnTYb3fGELSbXia268zDiFw0GTfMzNKTEKYtv3WHEL9QH0Ym/Os28so
	y/QxvsjtzrvEsBzmPM/fbOa4YyXBk91/G3i0hGwPatI8FpiGnIYiM/rSRkdtdrsvv8mIjmGVS+G
	NTVYSrlaSXG0pbDD/KZFfKm/tXyBhB/D1aN8XTDumTSu9t7NneUkqHC9NmFHWPQV+UW5Nw8nSui
	cqBiCLcHA1hfWeuO6ZiMq+8kTB6hEv7trTXqXchTOuo3eZSdfBXihnX2aLxfS2mSiagD+Cdg9tF
	dyAiZV4JghXbO0kZ6vpAiA2DQ5eCUBbOw/KrHR0f85TwXSi85vR91xaEhKTfoI7pK1tAPaxBaZU
	FDVDl8ZmDf00uATelBXJVyFJwqj3fww/ldslRJaH5BhQ==
X-Received: by 2002:a05:6122:330a:b0:56f:adb8:7c54 with SMTP id 71dfb90a1353d-5865e3aff5emr3335785e0c.3.1779477259066;
        Fri, 22 May 2026 12:14:19 -0700 (PDT)
Received: from acer-e1.tail6c460f.ts.net ([2804:7f0:7542:7b16:2880:ed6d:f5c:8b9e])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96173af3e82sm2741013241.10.2026.05.22.12.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 12:14:18 -0700 (PDT)
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
Subject: [PATCH v2] pwm: imx27: Fix variable truncation in .apply()
Date: Fri, 22 May 2026 16:13:48 -0300
Message-ID: <20260522191348.6227-1-rnunez@baylibre.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9085-lists,linux-pwm=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,baylibre.com];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[baylibre.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[rnunez@baylibre.com,linux-pwm@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F0D325B94CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix a variable truncation when calculating period in microseconds as
part of the solution for the ERR051198 in .apply() callback.

Example scenario:
 - Period of 3us (PWMPR = 196 and prescaler = 1)
 - Expected value in tmp: 198000000000 (NSEC_PER_SEC * (196 + 2) * 1)
 - Actual value is 431504384 (truncation to u32)

Signed-off-by: Ronaldo Nunez <rnunez@baylibre.com>
---
Changes in v2:
- Added example with actual PWMPR/prescaler values per Frank Li's feedback
- Dropped testing section
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


