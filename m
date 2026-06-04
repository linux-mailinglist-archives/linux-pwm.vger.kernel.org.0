Return-Path: <linux-pwm+bounces-9248-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LjTqEnRMIWosCwEAu9opvQ
	(envelope-from <linux-pwm+bounces-9248-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 04 Jun 2026 11:59:16 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2196D63EBF0
	for <lists+linux-pwm@lfdr.de>; Thu, 04 Jun 2026 11:59:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=VQe6f7bo;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9248-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9248-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 32A1B308861B
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Jun 2026 09:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBE23CB902;
	Thu,  4 Jun 2026 09:56:58 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A2D3DB632
	for <linux-pwm@vger.kernel.org>; Thu,  4 Jun 2026 09:56:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780567018; cv=none; b=nOe6RMQ15oiIzGa7bUgTUZUwrWWu+XmCKQI42R/In0kM5gvLvBaRQauFR8o/ymZqmwL130pE99UMmLNY2VtgVyUeQ9nPBOIWCrOsXwvKAPA8JhQo0vvflK4jnqMBudSC28KlMt4QIOfUaTnzZRyZhg20eNCKOrOBvQC6WSQvh9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780567018; c=relaxed/simple;
	bh=ormcBKXgtMUbxhPH8flZunLMCWwtspwzC/31OfGnHNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nxxI6fG2HVSaCytPbiejJ8oh5335257JsZahPFDLjFjbr2M5ZeXE5sg0ND5TfMvDTCfgM19JV56G2Y4TBnwzz7oa+DPOkJYcAe6M8Fhmdt5GxoKDMiHGbKM4gWU05jwDR8vnsuECDBXDGtpb2gZrisFjCFeg2LwiLuG0RUyzT3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQe6f7bo; arc=none smtp.client-ip=209.85.128.52
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490b3e03939so4045685e9.1
        for <linux-pwm@vger.kernel.org>; Thu, 04 Jun 2026 02:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780567014; x=1781171814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRHuLwRJMvtvIKprdTuRI74u8tyjnb0ERZ60XzwxUP4=;
        b=VQe6f7bon18+7QGKbdzoaphzaYbDRWjE82U1lnsUKukrj6AhWfqavsECmqK5mwt6Jp
         zzilVHMarGcY60iHp66zx+z4BYmy/iUlq1t1S5od6LgdyDlwQY51Vy5sVvjFfSYBUXH1
         NaONf7TYElPn3goeaa/OEY2TwYdogf56wAM0R7qzoDpsTs/j87lIj4JJzM8yxnAXN/zz
         Xzx04jA1wnFSNHBt3pjLMzlquuF8PJWBhUwPwS2MogPxg8cKt+jy3QHJZcI2BwuVJ1NR
         i0KD9uyu3+kYNS7jNz/1nc2HfpiE6YexFdmWm0IWaBFbdWGWoSd2N4sxGyTqu6VSOGhn
         aEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780567014; x=1781171814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WRHuLwRJMvtvIKprdTuRI74u8tyjnb0ERZ60XzwxUP4=;
        b=SH5uE7ad62TGDjPorKj/0vZH7UjRYyMqjfSyTitCjNE8Iuxg9GAcrELJLZkkWfG50+
         b5mDzAF4kVM2X1kO3oorhP1nmH/cr7obD9gWlh5dwavjbNCWBi1uYSIJaR/okJ4mwFjn
         rE9IM2NdOxArF5tSjJgMEBQgkly3Q/tcXf+6uum4MKYa/ivC/vRu3N8tIROCtTgpTp6f
         XsOk5VAZ/wtS1z0dpW6Q5DTXyG0QWF9UwF25puZFUEcChe3pcXjVvQhExk/ogNfyS1Ca
         wxr5UflzBUrglClLb6V00TaJQChr6rnwV4UTHDmqN8apTO6PRzcKsFXW+uJ62UbKserx
         engQ==
X-Forwarded-Encrypted: i=1; AFNElJ+MWkFs5wYKPKJ3Dj+thOA10JNIjqXmKPkgJVJyri5c2yumiI+SkmKejVv6J1Wtt52CrZtUIPnGokg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwerOCTp9RyEq/a6HJoUijILcftfYWR1c9Tltsi+OxT4CLqQGsm
	fYNhjWCgtvVBRM6QiSJeF6KsJ1vZubd/zuZnNyC0Ayp06ARDPLY99iZT
X-Gm-Gg: Acq92OE/W7UWAZjTtedK3ZcABggJnnwd2zNcuXy8MGtd1+E7l2hXeb0MNFssOfJhkEk
	ergdBWNGI8EH9sEuMqBFXLmBMqSGjU3ceScZiknx9knabAl7560eSP6PvBV4GTt3WKE+0pd/ZQG
	YHEl/AiyowN3MiISPVcEKRlECp+MW+XQrOO7wO+27SnJDJtOqdyhzJPWV6Zhma17iMW/GPm0GTI
	S2iVtRwCHmTYG6uYBKU8G25PNqJhxBfvqtVNW/+IGYz7yjswvGG8u0rd/UPSKcUHWO0o/xM2twJ
	I0+Y2HJbp0RkA0KJiYIjROglSMRjCukqMrzCtmOBCkd4qWFZlDX6FLZlQYg4W3jnO2CywCJt7x6
	NH6ZmGMuybNOW8IsfaDwv5YWAghnVZBIRfI3eMaQ/0uoUk+/TBW4V5YErJ5cND2WFkAwqY1mNZc
	P0BY1jc0SeVhqiHWCHbhlx3s6tHhJGh+nitvt9Iw9O6rnkTTzkP0N/no4nj/w=
X-Received: by 2002:a05:600c:83c6:b0:48a:53cb:8604 with SMTP id 5b1f17b1804b1-490bc5001e0mr48514435e9.14.1780567014180;
        Thu, 04 Jun 2026 02:56:54 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a700:7301:1615:3574:e0c0:837d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490be1f69bcsm38037335e9.8.2026.06.04.02.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 02:56:53 -0700 (PDT)
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
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v6 04/11] pwm: rzg2l-gpt: Add missing newlines to dev_err_probe() messages
Date: Thu,  4 Jun 2026 10:56:34 +0100
Message-ID: <20260604095647.108654-5-biju.das.jz@bp.renesas.com>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[bijudasau@gmail.com,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-9248-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ukleinek@kernel.org,m:p.zabel@pengutronix.de,m:geert+renesas@glider.be,m:magnus.damm@gmail.com,m:biju.das.jz@bp.renesas.com,m:linux-pwm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-renesas-soc@vger.kernel.org,m:prabhakar.mahadev-lad.rj@bp.renesas.com,m:biju.das.au@gmail.com,m:geert@glider.be,m:magnusdamm@gmail.com,m:bijudasau@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,pengutronix.de,glider.be,gmail.com];
	FREEMAIL_CC(0.00)[bp.renesas.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bijudasau@gmail.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bp.renesas.com:mid,renesas.com:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2196D63EBF0

From: Biju Das <biju.das.jz@bp.renesas.com>

dev_err_probe() internally calls dev_err() which uses pr_fmt() and
printk(). Kernel log messages should end with a newline character
to ensure proper log formatting. Add missing '\n' at the end of
the error strings in rzg2l_gpt_probe().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v6:
 * New patch.
---
 drivers/pwm/pwm-rzg2l-gpt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index 233e5ff2d04d..47c6c2eb3067 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -497,14 +497,14 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 
 	rate = clk_get_rate(clk);
 	if (!rate)
-		return dev_err_probe(dev, -EINVAL, "The gpt clk rate is 0");
+		return dev_err_probe(dev, -EINVAL, "The gpt clk rate is 0\n");
 
 	/*
 	 * Refuse clk rates > 1 GHz to prevent overflow later for computing
 	 * period and duty cycle.
 	 */
 	if (rate > NSEC_PER_SEC)
-		return dev_err_probe(dev, -EINVAL, "The gpt clk rate is > 1GHz");
+		return dev_err_probe(dev, -EINVAL, "The gpt clk rate is > 1GHz\n");
 
 	/*
 	 * Rate is in MHz and is always integer for peripheral clk
@@ -513,7 +513,7 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 	 */
 	rzg2l_gpt->rate_khz = rate / KILO;
 	if (rzg2l_gpt->rate_khz * KILO != rate)
-		return dev_err_probe(dev, -EINVAL, "Rate is not multiple of 1000");
+		return dev_err_probe(dev, -EINVAL, "Rate is not multiple of 1000\n");
 
 	ret = rzg2l_gpt_poeg_init(pdev, rzg2l_gpt);
 	if (ret)
-- 
2.43.0


