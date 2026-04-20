Return-Path: <linux-pwm+bounces-8643-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WC1cBfwE5mkJqgEAu9opvQ
	(envelope-from <linux-pwm+bounces-8643-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 12:50:36 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C33142999C
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 12:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C86B3090842
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 10:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1377339EF0B;
	Mon, 20 Apr 2026 10:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qe6bMvOB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E774939DBE2
	for <linux-pwm@vger.kernel.org>; Mon, 20 Apr 2026 10:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776681828; cv=none; b=UumzXtAeGudOrbP5BeVRRLn7s3dhKUrtpT1I1SCFYyVjUmT7T3BzGl6+m4VXVrQaH8iLOcvon9XhARAXWo/7EDB4PutBGYWzbncNCw9pBtG9v7Sy2A6ur8q54t2hsRvfxlrvWe71Fb2D9m+5n+pDB8Am9tmafc8vAmf+DKpxe38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776681828; c=relaxed/simple;
	bh=2izCtwVg2FbMrCF9D0GFBTIEFINhlDmb1BO3OtT2pMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KRxdBYICv9B2d9Ha6Z5zZPxdntISZ49g8w8qqx/IL03MHUfH8HOWyjqGbjuh650FmMunfzMeXcJOMP1ZEjUq/V7t9BfAG0sAo8/782fnZmAyE0gkOrv57pcbgUZjfuJyKQjtxe3AgCN0ynYeNz6fDdFGACuiwe7yQzglYhZ1hmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qe6bMvOB; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43cfbd17589so2173846f8f.0
        for <linux-pwm@vger.kernel.org>; Mon, 20 Apr 2026 03:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776681824; x=1777286624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aaXdFUrPKp/aeXuJhYhtKOEu72sa7QrupczRt752uE0=;
        b=Qe6bMvOBdtpLbY53loJ+cQkepeWM4SIg/K10YTyJEagIWcPJcJsH9GsLdQbeKR0ACi
         yXY0f5CrS8kDdif2gTIXcET3mXWEOPcecK3Hns+4dJhBuu/TkPtEOHTfJqjdlTfBGWx4
         M4Q8INcvzeTVkJ1zZIrehYoTs/eyF4npqj8m5UnCU+4c0odrm13WBWxQI++V6cUoyOso
         c9AwYF4daauEUQpP7FwpliSYhrgUS44Blvs9O3Ed0OuwkpKOe0BCdgmHwFEJmQsj05Hc
         2iN4LNDgjlke/PD3/A8GXqmseb7Avty0z6MO8hX4boWJJHQPJF8w+GWFbmmwyEKGkYbe
         GECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776681824; x=1777286624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aaXdFUrPKp/aeXuJhYhtKOEu72sa7QrupczRt752uE0=;
        b=D4oHWSjBq3EqJgtzKVf07FazJ0JmOq6LkXwvMvnJ7JDvnpK8U50FyrpGZesw/wfqQl
         dVvx8Y/978loiWZms0KTapaiolOsnqqBYDonlW487IJ7KBl6chEkDUt002QSW0ro8jmp
         T8L1SkeUtmrdApYaWTZrRxCBc0b3q36tcrJlFxFy6sE417TAw3jpbwauM3QRXLuhHeAo
         eamTAbVT1PbVcCvR7PtjKJUydkpQVuLZeHupMOTkgrnJCVGj1VVlFzQ7m/rV4XLJT8gW
         nnCqePwM1JJjFswgWkObW6omEUSJafaVLdTV78xImWhQKC2cSwmRoXsDE/N3T4rZ8A7k
         3+2w==
X-Forwarded-Encrypted: i=1; AFNElJ8/M5Rz+tFyDYZHjz7RiT2nm+PMNg/g61ya0FbKJ2hB4P+hTQQxhAqLYhUrnsUMJRxLZ95m7SHPZC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv3W4aByNAUB+umHdix76YBdJFbnOk6uFMZDpQ7t0FuGSUh4Fk
	nEl9wY8OBpkxj4idLvxudSthBgG6p4VZ+qEvyG5XhZW/KC7nbYl40Ycq
X-Gm-Gg: AeBDievVrBGVJxtVPRYrpZnA3EJT6FK4nBTatYIk2Dk1ojxWdwDKMsVU5sy1YxyPhvV
	PpuFBuCZECp+7cp1SJQ1/3bh5XHz9OrL2H8OfTo5SS4LOr8UvDYvVXcr6uBULSbV7tovTHECsBD
	lK0CNhcbX0iv2ySzTsRZaL16xgis9zhU/3ViJwIjn07ciSz0wRx+rA2+pNPTorctb4LC3PqeNLy
	ZxuiShjjY8Kv8e+Mj2PkK/qeF2kw+wPBpPJZHFFQUOQHbPguerLF9n5pfuH76ulzuyxfqMfmsVO
	vPv8EZI0uuucqYSUMsTlQU9V2ECdSsuLCz4o5GCFSrcZJQq5K/zz/qO5qtIs9wi1sh0OssNRo6+
	JZhR8N1ro4lwkoSz5zQlxRkRdAqjsE+PvUjZTy0lP/xojbHH0CSiNNrjdID2KIKrlYj7c8e03TU
	AgTc1bIjAub1V612QOn3Ll+/QC9/v5GIEKiZVHqGCATTIs6SzOY1SlcvPjpUU=
X-Received: by 2002:a05:6000:288c:b0:43e:a69b:d804 with SMTP id ffacd0b85a97d-43fe3df26b1mr20158317f8f.29.1776681824064;
        Mon, 20 Apr 2026 03:43:44 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:5f3e:f914:6f8c:72c3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4c221cdsm28038301f8f.0.2026.04.20.03.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 03:43:43 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Subject: [PATCH v5 9/9] pwm: rzg2l-gpt: Add RZ/G3E support
Date: Mon, 20 Apr 2026 11:43:26 +0100
Message-ID: <20260420104332.153640-10-biju.das.jz@bp.renesas.com>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8643-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[bp.renesas.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,pengutronix.de,glider.be,gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bijudasau@gmail.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,renesas];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6C33142999C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Biju Das <biju.das.jz@bp.renesas.com>

Add RZ/G3E GPT support. It has multiple clocks and resets compared to
RZ/G2L. Also prescale field width and factor for calculating prescale
are different.

Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v4->v5:
 * No change.
v3->v4:
 * Added RZG3E_GTCR_TPCS bit definition for RZ/G3E and added to
   rzg3e_data.
v2->v3:
 * No change.
v1->v2:
 * Added link to hardware manual
 * Updated limitation section
 * Collected tag 
---
 drivers/pwm/pwm-rzg2l-gpt.c | 47 +++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index de68c02b2d50..8cb3e67f4fdb 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -6,15 +6,21 @@
  *
  * Hardware manual for this IP can be found here
  * https://www.renesas.com/eu/en/document/mah/rzg2l-group-rzg2lc-group-users-manual-hardware-0?language=en
+ * https://www.renesas.com/en/document/mah/rzg3e-group-users-manual-hardware
  *
  * Limitations:
  * - Counter must be stopped before modifying Mode and Prescaler.
  * - When PWM is disabled, the output is driven to inactive.
  * - While the hardware supports both polarities, the driver (for now)
  *   only handles normal polarity.
- * - General PWM Timer (GPT) has 8 HW channels for PWM operations and
- *   each HW channel have 2 IOs.
+ * - For RZ/G2L, the General PWM Timer (GPT) has 8 HW channels for PWM
+     operations and each HW channel have 2 IOs (GTIOCn{A, B}).
  * - Each IO is modelled as an independent PWM channel.
+ * - For RZ/G3E, the General PWM Timer (GPT) has 16 HW channels for PWM
+     operations (GPT0: 8 channels, GPT1: 8 Channels) and each HW channel
+     have 4 IOs (GTIOCn{A,AN,B,BN}). The 2 extra IOs GTIOCnAN and GTIOCnBN
+     in RZ/G3E are anti-phase signals of GTIOCnA and GTIOCnB. The
+     anti-phase signals of RZ/G3E are not modelled as PWM channel.
  * - When both channels are used, disabling the channel on one stops the
  *   other.
  * - When both channels are used, the period of both IOs in the HW channel
@@ -48,6 +54,7 @@
 #define RZG2L_GTCR_CST		BIT(0)
 #define RZG2L_GTCR_MD		GENMASK(18, 16)
 #define RZG2L_GTCR_TPCS		GENMASK(26, 24)
+#define RZG3E_GTCR_TPCS		GENMASK(26, 23)
 
 #define RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE	FIELD_PREP(RZG2L_GTCR_MD, 0)
 
@@ -160,6 +167,27 @@ static u8 rzg2l_gpt_calculate_prescale(u64 period_ticks)
 	return prescale;
 }
 
+static u8 rzg3e_gpt_calculate_prescale(u64 period_ticks)
+{
+	u32 prescaled_period_ticks;
+	u8 prescale;
+
+	prescaled_period_ticks = period_ticks >> 32;
+	if (prescaled_period_ticks >= 64 && prescaled_period_ticks < 256) {
+		prescale = 6;
+	} else if (prescaled_period_ticks >= 256 && prescaled_period_ticks < 1024) {
+		prescale = 8;
+	} else if (prescaled_period_ticks >= 1024) {
+		prescale = 10;
+	} else {
+		prescale = fls(prescaled_period_ticks);
+		if (prescale > 1)
+			prescale -= 1;
+	}
+
+	return prescale;
+}
+
 static int rzg2l_gpt_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(chip);
@@ -545,6 +573,14 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 	if (IS_ERR(rstc))
 		return dev_err_probe(dev, PTR_ERR(rstc), "Cannot deassert reset control\n");
 
+	rstc = devm_reset_control_get_optional_exclusive_deasserted(dev, "rst_s");
+	if (IS_ERR(rstc))
+		return dev_err_probe(dev, PTR_ERR(rstc), "Cannot deassert rst_s reset\n");
+
+	clk = devm_clk_get_optional_enabled(dev, "bus");
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "Cannot get bus clock\n");
+
 	clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(clk))
 		return dev_err_probe(dev, PTR_ERR(clk), "Cannot get clock\n");
@@ -587,6 +623,12 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct rzg2l_gpt_info rzg3e_data = {
+	.calculate_prescale = rzg3e_gpt_calculate_prescale,
+	.gtcr_tpcs = RZG3E_GTCR_TPCS,
+	.prescale_mult = 1,
+};
+
 static const struct rzg2l_gpt_info rzg2l_data = {
 	.calculate_prescale = rzg2l_gpt_calculate_prescale,
 	.gtcr_tpcs = RZG2L_GTCR_TPCS,
@@ -594,6 +636,7 @@ static const struct rzg2l_gpt_info rzg2l_data = {
 };
 
 static const struct of_device_id rzg2l_gpt_of_table[] = {
+	{ .compatible = "renesas,r9a09g047-gpt", .data = &rzg3e_data },
 	{ .compatible = "renesas,rzg2l-gpt", .data = &rzg2l_data },
 	{ /* Sentinel */ }
 };
-- 
2.43.0


