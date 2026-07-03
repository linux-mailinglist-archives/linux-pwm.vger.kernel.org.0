Return-Path: <linux-pwm+bounces-9542-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 82OrE/LTR2psfwAAu9opvQ
	(envelope-from <linux-pwm+bounces-9542-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 17:23:30 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BEB703D00
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 17:23:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=tEU7CuTo;
	dmarc=pass (policy=reject) header.from=bootlin.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9542-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9542-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BDC923036ACF
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2026 15:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809704189AC;
	Fri,  3 Jul 2026 15:22:44 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED5641736F;
	Fri,  3 Jul 2026 15:22:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783092164; cv=none; b=B9poMBVx4FEw3o5HSrA8yTAHStve5FT/NzJHm/FJUEER8BoijPtjxZtTGN3CJzXWdywD1Z3gJsmYuWXgCgR+YBr8HUgHYX3UVPBBMid5DQL6xSu/t9N7gI9YpgXKCJvwJsIq4LTO9pKHVWQCQhkO7XZxRum94ixHYKbZR3iHqyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783092164; c=relaxed/simple;
	bh=MRk7T34qq7Mf7d7vlIOGFMY9Y3mCwOhsyhmn2szKuNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p1F9UMEnYZ7FbhkDlwIaF7MS5maqzNSgUz1ehhlxoA94GlIHJdy7Wx8YFPgFjgkzIiB+m4LpM6OH4QUfIJ0yvQICDj9lvtoZhVOsK+WMyCHDdmntlaW/cfM69GasmAkyJN8MQdMixr5O375CrAWWSoUrxo6/NKIOLWwdTccNFQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tEU7CuTo; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D153F4E40C70;
	Fri,  3 Jul 2026 15:22:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A645760300;
	Fri,  3 Jul 2026 15:22:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 14CC5104C952E;
	Fri,  3 Jul 2026 17:22:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783092160; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=qIVGJcDfvA5ZwpQKNPuEjeP78VvaCq6n4AxhxUcG/F8=;
	b=tEU7CuTohFUte7Uxofd/BDZ3rp9SvjYA1AV43V/vdIK0AI6NUgHSOdIGWTcXPE8hHkWCJ2
	piOyMPm2BEpZOFvoVk8A1cdRW2cv8kGUqRhLmvkCMeNzeq71CGfvrHgDVwGCdSaAqs1uyK
	ycQ8m5CFW2e8y+gwsrmzgijSmhAAjqGn19zxXzCNopcsy6oMxvWin2A/yXFwFrV43frexP
	1AIE4WAsUZw5fqAIcELgWUa+lNYCueOGCViHPyD1aBU357XO4oa6BD9yhAVN5caKeicIeS
	31km40s2sgu47abjUfUz+Y9RbJTAGrOLMAlDiVsru8ftZFVRuTQiLTAS8bb3fg==
From: Richard Genoud <richard.genoud@bootlin.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>
Cc: Paul Kocialkowski <paulk@sys-base.io>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	John Stultz <jstultz@google.com>,
	Joao Schim <joao@schimsalabim.eu>,
	bigunclemax@gmail.com,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH v7 4/4] MAINTAINERS: Add entry on Allwinner sun8i/H616 PWM driver
Date: Fri,  3 Jul 2026 17:22:15 +0200
Message-ID: <20260703152215.192859-5-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260703152215.192859-1-richard.genoud@bootlin.com>
References: <20260703152215.192859-1-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9542-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ukleinek@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:samuel@sholland.org,m:p.zabel@pengutronix.de,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:bmasney@redhat.com,m:paulk@sys-base.io,m:thomas.petazzoni@bootlin.com,m:jstultz@google.com,m:joao@schimsalabim.eu,m:bigunclemax@gmail.com,m:linux-pwm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-clk@vger.kernel.org,m:richard.genoud@bootlin.com,m:krzk@kernel.org,m:conor@kernel.org,m:jernejskrabec@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,sholland.org,pengutronix.de,baylibre.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[richard.genoud@bootlin.com,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[sys-base.io,bootlin.com,google.com,schimsalabim.eu,gmail.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[richard.genoud@bootlin.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bootlin.com:from_mime,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C4BEB703D00

Add myself as maintainer of Allwinner SUN8I PWM driver.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 15011f5752a9..51ca159bcaf1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -919,6 +919,11 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml
 F:	drivers/hwspinlock/sun6i_hwspinlock.c
 
+ALLWINNER SUN8I PWM DRIVER
+M:	Richard Genoud <richard.genoud@bootlin.com>
+S:	Maintained
+F:	drivers/pwm/pwm-sun8i.c
+
 ALLWINNER THERMAL DRIVER
 M:	Vasily Khoruzhick <anarsoul@gmail.com>
 M:	Yangtao Li <tiny.windzz@gmail.com>
-- 
2.47.3


