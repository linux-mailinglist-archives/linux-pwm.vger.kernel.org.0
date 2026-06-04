Return-Path: <linux-pwm+bounces-9254-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QfnTI9hMIWpGCwEAu9opvQ
	(envelope-from <linux-pwm+bounces-9254-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 04 Jun 2026 12:00:56 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EBB63EC23
	for <lists+linux-pwm@lfdr.de>; Thu, 04 Jun 2026 12:00:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=a+AzEdAv;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9254-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9254-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 077AE30AF6F1
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Jun 2026 09:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DBD4014B4;
	Thu,  4 Jun 2026 09:57:05 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80273FFAA7
	for <linux-pwm@vger.kernel.org>; Thu,  4 Jun 2026 09:57:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780567024; cv=none; b=U31qRhVGc4fQBeGohDPUFi6n+MDZac7Etwv9KGf2+cjJ0NphNiW5LSYw4pr5b6uMZ4buruDz0dCUFLqqGHvuAe6o9udpZs3OG7Iwe7YxS3vWKtlH7KQ/HQ1Wu2QAxKPB2xIxCe2jl4QFwHN3nzpB1QZXENmJiqHIoWlE4gpix40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780567024; c=relaxed/simple;
	bh=2g9nbNkTUzWdHdIPzC+Vgp2uzTMblT+4A1ma6K2JYGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=saBDS9be/Jkr9znJaU8xoXkBhOdPweV8ayx9vJmFlo3vDoqbLnIGXo87ZhSMdsuMox3nEMGpMdvyj5RBvtVEHVqEdwGZTt1CGOjymzrf/xGx5nukLmUWcaudOsN8LeBm1lhXr/ZYgFB2124N0d3gHRpHpzDcks5P45ZjIYGj2gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+AzEdAv; arc=none smtp.client-ip=209.85.128.53
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490b9318997so3588325e9.2
        for <linux-pwm@vger.kernel.org>; Thu, 04 Jun 2026 02:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780567020; x=1781171820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTNA9VHVpA1LS/HbVfTfBi8FzZd1SoiTkIbiSRSf3Fc=;
        b=a+AzEdAvFWSs2fCSeNOsY/WY8dW3yMa9AO0jcZsfy5TOoGITQbph7WYKONYSLQXhto
         RQjlgb69BxgVd6y+IdqBmwQAeqaOYPx9enXLlM24ccK7ylI4cPVJd4eZsElk9pFEpQ1n
         gtN4uf2CN3CGoLP00WG8ydAh8ZkdKL3ECOFp+FYRHm15e97thqriMyiFZ3EZkHMTfEMM
         R6o610ssVwTHFcCkrCk+rrLGUe5U8N3lrXCourVjZfY7mRwaO9njctg9bwAVZHFETAsT
         1tutIJNeors7ouF5YTlte6XvMrMD01Z9HVTSwGYgXPe30Ns3IBNfOZT7BegbscyXuju5
         usSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780567020; x=1781171820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wTNA9VHVpA1LS/HbVfTfBi8FzZd1SoiTkIbiSRSf3Fc=;
        b=on8BWL5QE5iQQJuiuQ1r5zSkNkiqFjSLZXo2CF8AfSE/ByW959qkceT+y1y4KYlSgF
         La1E9WaIhNzGnBWR6JL1lyyBUtPXMkpPl7LHxsXNlyMuq3CfMrTdQy/BD+hmzoPJ6I5g
         kObKkiCMdhmduFpugQhneA2n6w8/RiK+4dudlRut15fWyl5vM5L8OVlmN6YQbHmSuumG
         p3Gs4MRQqAtE/96ZQdPSLIkfGA0vNbYTzQJ36PbRj8lobX0RI4pDO1BUSb6f4Wn+lKdo
         Y3pbWNm7pHDGFyIOE3yLMtck8XjJiOm565GLSJB6y6qPTg2sgDg0LKcppBFrTYLZowQo
         UKlA==
X-Forwarded-Encrypted: i=1; AFNElJ8g0xHVbgNQllgRCz4HVtgLWDOq9MRa48X5WwxNgeqvVml0rm3XXo55zHGb0NL9nxja3YGyAkM5Xqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCewPxnU8d0tyMB2QJoLb+HlFGyGVvT4QKgcEsu2s/A+ZGrqvS
	m9BSQItWqABsRgYnHy+Lyj4vyaeJjoJEk3KaT1nBcwQ8AK0av4lahHR2
X-Gm-Gg: Acq92OHdgIcf3PlJal2dTr4r4nrmCX8aVRoyCrMXeGAm2vCt16znQdoTGl9uUv/Qxhf
	C8fs1DQ0px0cnOsBne7seLFA0wXn2AieR+SOi/15X9edjmTPkPdcSpIsrQS0mJ43RxIPfWqjF3t
	62oVfdByAwNLaOW+pVXOk76F4P4/Gfq3dIejvlNM6cd3o67HfeCP7TkIe90ztk7bjesy2Jjyi+x
	XgmS3ivnzvlfjq1CyIbYGaRpJUdB21zNiMivyuA2idy7YkuNnfro4apzl56FQk6eDmaIkenc6cB
	rfj9Ek5UiB65VmQrk9m4UPd2fqVdrzhhs18sSAmaXI+neX2GJ4dhSClPjM7RjIKXn7qrdY13DZB
	QtConXNI3JrpEoIxBY7rXhRUqYH78fA+2NrcoI/GnQsZ3Tg+qmZnqeNa/P1qKK4GEULnNuaretb
	4YyJZHP3RnBM6DLQz8X9mmi4vA2VHv9VbNL2aA6EBIDsW9IlOBIr3fKoskOz8=
X-Received: by 2002:a05:600c:1910:b0:490:bb3e:30c2 with SMTP id 5b1f17b1804b1-490bb3e32f9mr76102615e9.18.1780567020226;
        Thu, 04 Jun 2026 02:57:00 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a700:7301:1615:3574:e0c0:837d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490be1f69bcsm38037335e9.8.2026.06.04.02.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 02:56:59 -0700 (PDT)
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
Subject: [PATCH v6 11/11] pwm: rzg2l-gpt: Add RZ/G3E support
Date: Thu,  4 Jun 2026 10:56:41 +0100
Message-ID: <20260604095647.108654-12-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604095647.108654-1-biju.das.jz@bp.renesas.com>
References: <20260604095647.108654-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9254-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ukleinek@kernel.org,m:p.zabel@pengutronix.de,m:geert+renesas@glider.be,m:magnus.damm@gmail.com,m:biju.das.jz@bp.renesas.com,m:linux-pwm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-renesas-soc@vger.kernel.org,m:prabhakar.mahadev-lad.rj@bp.renesas.com,m:biju.das.au@gmail.com,m:tommaso.merciai.xr@bp.renesas.com,m:geert@glider.be,m:magnusdamm@gmail.com,m:bijudasau@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,pengutronix.de,glider.be,gmail.com];
	FORGED_SENDER(0.00)[bijudasau@gmail.com,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[bp.renesas.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bijudasau@gmail.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bp.renesas.com:mid,vger.kernel.org:from_smtp,renesas.com:url,renesas.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 27EBB63EC23

From: Biju Das <biju.das.jz@bp.renesas.com>

Add RZ/G3E GPT support. It has multiple clocks and resets compared to
RZ/G2L. Also prescale field width and factor for calculating prescale
are different.

Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v5->v6:
 * Updated rzg3e_gpt_calculate_prescale().
 * Updated comment in rzg2l_gpt_calculate_period_or_duty().
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
 drivers/pwm/pwm-rzg2l-gpt.c | 45 ++++++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index 7e669406dcdd..f84de41e1360 100644
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
 
@@ -160,6 +167,22 @@ static u8 rzg2l_gpt_calculate_prescale(u64 period_ticks)
 	return prescale;
 }
 
+static u8 rzg3e_gpt_calculate_prescale(u64 period_ticks)
+{
+	u32 prescaled_period_ticks;
+	u8 prescale;
+
+	prescaled_period_ticks = period_ticks >> 32;
+	if (prescaled_period_ticks > 64 && prescaled_period_ticks < 256)
+		prescale = 8;
+	else if (prescaled_period_ticks >= 256)
+		prescale = 10;
+	else
+		prescale = fls(prescaled_period_ticks);
+
+	return prescale;
+}
+
 static int rzg2l_gpt_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(chip);
@@ -241,7 +264,8 @@ static u64 rzg2l_gpt_calculate_period_or_duty(struct rzg2l_gpt_chip *rzg2l_gpt,
 
 	/*
 	 * The calculation doesn't overflow a u64 because,
-	 * prescale ≤ 5 for info->prescale_mult = 2 and so
+	 * prescale ≤ 5 for info->prescale_mult = 2,
+	 * prescale ≤ 10 for info->prescale_mult = 1, and so
 	 * tmp = val << (info->prescale_mult * prescale) * USEC_PER_SEC
 	 *     < 2^32 * 2^10 * 10^6
 	 *     < 2^32 * 2^10 * 2^20
@@ -546,6 +570,14 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
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
@@ -588,6 +620,12 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
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
@@ -595,6 +633,7 @@ static const struct rzg2l_gpt_info rzg2l_data = {
 };
 
 static const struct of_device_id rzg2l_gpt_of_table[] = {
+	{ .compatible = "renesas,r9a09g047-gpt", .data = &rzg3e_data },
 	{ .compatible = "renesas,rzg2l-gpt", .data = &rzg2l_data },
 	{ /* Sentinel */ }
 };
-- 
2.43.0


