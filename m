Return-Path: <linux-pwm+bounces-9250-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6MO/DGtPIWo5DAEAu9opvQ
	(envelope-from <linux-pwm+bounces-9250-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 04 Jun 2026 12:11:55 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 695A963EE18
	for <lists+linux-pwm@lfdr.de>; Thu, 04 Jun 2026 12:11:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Opfn+kfT;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9250-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9250-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9EB88307C7A9
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Jun 2026 09:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF0F3FE67B;
	Thu,  4 Jun 2026 09:57:00 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642293FDBEA
	for <linux-pwm@vger.kernel.org>; Thu,  4 Jun 2026 09:56:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780567020; cv=none; b=ELTyUVvL8owuRSpjrrqqIGFi4fFyTcWJlutoiD4MyTN1hTOYYCJiaLqN/RDOcoAu05jVY7Ske13SrLflYQlsTm5CYGAdCO1B4X3LzGxQNPEBlDAfj/WeGg6V3YYA4kiBFcBGwmD1e2KUFta+/7CcduNmlfCaOxTd5Y7SkD9GygU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780567020; c=relaxed/simple;
	bh=7k9zOJLQmwMA/uzYIEjXOvz20d0UsGHSnWUHZU6C/nA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dOKeP8riXcyYf94A5Zkz6VMi69RChhrCMtJcHq07V10iaPWeKAikwFTt7t24JzAjDDR6Z+Y84kf2NPmOJzSiWImoVOi88m7nu+mG8OjYvbYNCTfWpwso7TQcxZ+4IpAYGjYU/vW3fLSi+i2im1IGa9kI//9U2r434WOZjpc3tuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Opfn+kfT; arc=none smtp.client-ip=209.85.128.41
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490ae94a89eso4810845e9.1
        for <linux-pwm@vger.kernel.org>; Thu, 04 Jun 2026 02:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780567017; x=1781171817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5m4IybCJvRhAGS6FWlVTrHuns1jqnPal3+xcRsaPBs=;
        b=Opfn+kfTunl5vKIxlP7ahtKla8gu65LCou0ae0mOdksuCKYIYZimfx3ElTAv/FERrU
         rsujUIBbOZES1EupyVVxLWnfhlSbM/rYu0Mh0OVBfQ2tkX8OwkbDkZ8KsotkpViYZ3td
         8+h6LEl6XzSev2d5Az4HUpiOTUXnBLHN/RVxHGSIjpfhT4RPxYRZnGM6GEIe0oew0MGC
         BPHfvEsfR5VhUJZdzT/Z2oaJORJlfAALPMaKACgHtgEwVGB5+e9RNRQAMLA16TVLQtU6
         BrXN4ut/TB8xJB3sg/Osqr1ONjqkKEtzlr/LNdNXThmUndqmG5nMSxVsYrgO76DPhelM
         RRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780567017; x=1781171817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a5m4IybCJvRhAGS6FWlVTrHuns1jqnPal3+xcRsaPBs=;
        b=P4+LfWascgeoaa/FdSziN5xxAe8aewY2E+q+SF5kuYvY7DRUA3UwbrEBHqkpiXqz1d
         acL6BmvYiHfoRZh3iHleKIyZGq4tx1YMrzVu+4R2bReKhXT3WZvocHgPsXTAUaprTFiY
         +r4bgfSThL+N+Td3wlP09CK9isTj+sZW0lplSFb/QPz9IyJtx/4r+8Z1Um4lk5MM0/fG
         u7r94Gq7g8UbiRpb097QeO4VWndksQd7OCANO2WNn6Bi7pTe54sJKnlyDoJtfJdK3f1T
         yVUySAh90gqJOgsEAi3e1SGbq2oK7GnDAs+7UQ0jWvfPuHEUWSZBKBljsaUhZ8zjMHhg
         mxjw==
X-Forwarded-Encrypted: i=1; AFNElJ/SXy76UcAE9JwdLt/W5DjdfVq35KHzjoy6hA9hKAGGg5qkZhVD072Srd1oetisp44q+uEzyp9RA78=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj7iBFIDh9YemixzBigwpiBTc7lI4IBs3d8FrogHl9ohH1GP+Y
	Qm0iwYP0GuXZHrHPaqBKYL+yVe4cCjkP1Me4BakGsgYa4U0+/jPuDNla
X-Gm-Gg: Acq92OEvwAiDYpeRIZX4goa0LHske6SPgbZX9bavSCcgs0Z5/ylel5ANi1EIgBR0GNq
	b0vlPHIAesCCKsyg0xDeIZ1cx+ay/FwmH6Anb1VKnHmjPQc7etI4x3nBOuCQQAiwtvX1wcthA34
	g6zNt+1//Xsk0gykzuo8zDdHnbqZzDZuabteV6C5eHm/5EMbEjeeMQtgGuISGTAR5WpHfAJP1G6
	eAhfaGCBvlrpcINkkFGyV/VXoY1GzadsefIMcGu+Do0UTV/+oGb5jv0X5cMbXoDy9f+nWCnt2eb
	kHU61/ArcWcYfLPcaG9gtubsy1JaIUGHcVLSVs9kxxeyaxFmAnQWFGps6ekuLgpOvrgjGvT7KA4
	oI3QZXjgYEbCpziXMX/wxG89Q7Da0R5AO4atDOmkB1+V0fek3I0HnAS7I5F17vHcntdibhnz3CL
	rnN4REBXONVbFp/77Ls5HUMx/b0+HtbqopCJtF2r5K8Ksb1f77N18O9Af/AsI=
X-Received: by 2002:a05:600c:4fcc:b0:490:59cc:999f with SMTP id 5b1f17b1804b1-490b5ea1016mr120694265e9.4.1780567016697;
        Thu, 04 Jun 2026 02:56:56 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a700:7301:1615:3574:e0c0:837d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490be1f69bcsm38037335e9.8.2026.06.04.02.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 02:56:56 -0700 (PDT)
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
Subject: [PATCH v6 07/11] pwm: rzg2l-gpt: Add info variable to struct rzg2l_gpt_chip
Date: Thu,  4 Jun 2026 10:56:37 +0100
Message-ID: <20260604095647.108654-8-biju.das.jz@bp.renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9250-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[bp.renesas.com,vger.kernel.org,gmail.com];
	FORGED_SENDER(0.00)[bijudasau@gmail.com,linux-pwm@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ukleinek@kernel.org,m:geert+renesas@glider.be,m:magnus.damm@gmail.com,m:biju.das.jz@bp.renesas.com,m:linux-pwm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-renesas-soc@vger.kernel.org,m:prabhakar.mahadev-lad.rj@bp.renesas.com,m:biju.das.au@gmail.com,m:tommaso.merciai.xr@bp.renesas.com,m:geert@glider.be,m:magnusdamm@gmail.com,m:bijudasau@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,glider.be,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bijudasau@gmail.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,renesas];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,bp.renesas.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,renesas.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 695A963EE18

From: Biju Das <biju.das.jz@bp.renesas.com>

Introduce struct rzg2l_gpt_info to capture SoC-specific hardware
differences, starting with the gtcr_tpcs field mask for the prescaler
bitfield in GTCR. This is needed because the RZ/G3E GPT has a 4-bit
prescaler field versus the 3-bit field on RZ/G2L.

Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v5->v6:
 * No change.
v4->v5:
 * Updated commit description.
v3->v4:
 * Dropped field_{get,prep} as mainline now support it.
 * Updated commit description.
 * Retained RZG2L_GTCR_TPCS bit definitons
 * Replaced gtcr_tpcs_mask->gtcr_tpcs
v2->v3:
 * No change.
v1->v2:
 * Collected tag.
---
 drivers/pwm/pwm-rzg2l-gpt.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index 18e6c0f28e29..3ee5a70ca265 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -90,9 +90,14 @@
 #define RZG2L_MAX_POEG_GROUPS	4
 #define RZG2L_LAST_POEG_GROUP	3
 
+struct rzg2l_gpt_info {
+	u32 gtcr_tpcs;
+};
+
 struct rzg2l_gpt_chip {
 	void __iomem *mmio;
 	struct mutex lock; /* lock to protect shared channel resources */
+	const struct rzg2l_gpt_info *info;
 	unsigned long rate_khz;
 	u64 period_ticks[RZG2L_MAX_HW_CHANNELS];
 	u32 channel_request_count[RZG2L_MAX_HW_CHANNELS];
@@ -336,7 +341,7 @@ static int rzg2l_gpt_read_waveform(struct pwm_chip *chip,
 
 	guard(mutex)(&rzg2l_gpt->lock);
 	if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, pwm->hwpwm, &gtcr)) {
-		wfhw->prescale = FIELD_GET(RZG2L_GTCR_TPCS, gtcr);
+		wfhw->prescale = field_get(rzg2l_gpt->info->gtcr_tpcs, gtcr);
 		wfhw->gtpr = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTPR(ch));
 		wfhw->gtccr = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCCR(ch, sub_ch));
 		if (wfhw->gtccr > wfhw->gtpr)
@@ -380,8 +385,8 @@ static int rzg2l_gpt_write_waveform(struct pwm_chip *chip,
 		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTUDDTYC(ch), RZG2L_GTUDDTYC_UP_COUNTING);
 
 		/* Select count clock */
-		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), RZG2L_GTCR_TPCS,
-				 FIELD_PREP(RZG2L_GTCR_TPCS, wfhw->prescale));
+		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), rzg2l_gpt->info->gtcr_tpcs,
+				 field_prep(rzg2l_gpt->info->gtcr_tpcs, wfhw->prescale));
 
 		/* Set period */
 		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTPR(ch), wfhw->gtpr);
@@ -525,6 +530,8 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 	if (IS_ERR(rzg2l_gpt->mmio))
 		return PTR_ERR(rzg2l_gpt->mmio);
 
+	rzg2l_gpt->info = of_device_get_match_data(dev);
+
 	rstc = devm_reset_control_get_exclusive_deasserted(dev, NULL);
 	if (IS_ERR(rstc))
 		return dev_err_probe(dev, PTR_ERR(rstc), "Cannot deassert reset control\n");
@@ -571,8 +578,12 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct rzg2l_gpt_info rzg2l_data = {
+	.gtcr_tpcs = RZG2L_GTCR_TPCS,
+};
+
 static const struct of_device_id rzg2l_gpt_of_table[] = {
-	{ .compatible = "renesas,rzg2l-gpt", },
+	{ .compatible = "renesas,rzg2l-gpt", .data = &rzg2l_data },
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rzg2l_gpt_of_table);
-- 
2.43.0


