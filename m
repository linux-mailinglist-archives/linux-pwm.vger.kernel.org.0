Return-Path: <linux-pwm+bounces-9554-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S0laAW8YSmon+QAAu9opvQ
	(envelope-from <linux-pwm+bounces-9554-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 05 Jul 2026 10:40:15 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 505A97097F4
	for <lists+linux-pwm@lfdr.de>; Sun, 05 Jul 2026 10:40:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=mY1Xoi6J;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9554-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9554-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFF0F302572A
	for <lists+linux-pwm@lfdr.de>; Sun,  5 Jul 2026 08:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9908636F8EA;
	Sun,  5 Jul 2026 08:39:29 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2200A36F42B
	for <linux-pwm@vger.kernel.org>; Sun,  5 Jul 2026 08:39:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783240768; cv=none; b=ZyLbIZ/sw3sC3zo/xhTIfWrmcpBy78j1DabGmnVMb7aGbJTJ4GLbOKZvNiQHmu4JmGUS3QmzI98zD5z/kOt47RjVmKkGUu4e9zVtNrwRYmxGE0CPJAVeCeMgBIasWXcGHnHYrz38ayd34vcShRd1vy10aU5m1DMcFjOBf8xrig0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783240768; c=relaxed/simple;
	bh=xcO7pe3BTmwOdzui6/X6iJz8mN0Rp2hw3KbCd40pQDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WDquxNoJ/H4zPBZ50lHG0uF4/U5sJZHi0q77FdiG12AXZsyosgbJWWINKUV6ITMm1IBS4rT7xlWMQZnLk8NqqUh90v1Zh3YvAvZ9U+qtCHE0/0LrlcFLmWy480WZSSToakGM85OZwBOdRNpyOG1B1S/6JDkf3zxCDmo6FsLXbHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=mY1Xoi6J; arc=none smtp.client-ip=209.85.128.51
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493d1e8aa46so7551955e9.0
        for <linux-pwm@vger.kernel.org>; Sun, 05 Jul 2026 01:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783240760; x=1783845560; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K+ETHGSiohx0vpbbD7DSPe0/YRZrdLOm6Y1hu+YMerY=;
        b=mY1Xoi6JWIe4+Xsq5LXltRqlJISQoB89XG9OttTHZ/I7bCGOXaFgbXgnKitXh6nDU0
         DGMgYSK2Y8jQ9Ua6urxirgN5BDV+x/txrEFSG8oDCrn66as1Sepfn+URxglzCjg7hwDz
         GlPF+iJ9QCHoo50ujYxDOxMRXSDjiP2Iqjnohq00xN58nQ7XQztsTKfJoQ4C7VCCGLCq
         kIkG86xK/Vr4y7tP9MRaqpA8fw9fzR7Lzojm7LYaLZgVxwPjB8vme7+CEpMd7wTSgnSC
         b3XYXq43i8wI6+szHutUdofxCtfBO97zZLgF2gaJ+G/rXEHZV/2nUsXhgXpX+puDvY3P
         EcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783240760; x=1783845560;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K+ETHGSiohx0vpbbD7DSPe0/YRZrdLOm6Y1hu+YMerY=;
        b=aSEmIhlLFOVllzaKUreRQSGUTLg8edqnliHtaJ5JmbeOVuKIwrsCafD53WhnirHelw
         aRj9eHGAWOJNLWLfsse8ZCk2hWt32K7VVwIwXWW+VJGJk8bNtO3KtMrLKJflgjHhQj3U
         VWRPy2Pr3mWIquc6chCqXh+fyUOD+sEWlG+dIFMpYxLkHKiDOP8A3MNIc3HzvKXoKpRz
         FoRH0704RSjw5WTss7izmZetWK0Xzpu3ymMPVGAWNQgO55O7YnLcj0Tuc79SYAxGg2WE
         XYAjvh63N5oyX70Jq1xemABgkMcLcP5e5DgziDZMWCCGGPJByy9ektEh9HF/T67ZTMYC
         WYCQ==
X-Gm-Message-State: AOJu0YwyM27G1QNTFzz18My+DzP/kaZK2KGqslBzQ/Laet8pYzUshEW9
	0I3tnIjw0zTXX1TAjcOYk6zk9zfhX7bDp+L3Ee07PMuBBzVP5vRClLcSl7FhSsd1auc9PBChGNT
	UMch4
X-Gm-Gg: AfdE7cnIEoQ5srwcOJ+ldsXs2V7OXBaoBA0I7IH/wNbr5IRXRMJ1XAcSpRG1t2nC0L9
	7JNUPOAWUReoOwLXGuQwa7a+9AtcPXjJ3fdK6LPcmECfsvNb2AOzQTZjXUYrH5hztXH7yemftNn
	NXLGBdc0Q7M7Q8srGfD9VC+uBU4YZIqbg5/rXDnSmiNelKv7ZEToFcJkFskKrW+6o9IQvGJSFnz
	g+xLSqYBpIGryvy1E4DwfKnfdZRfDXMbSnDTyN8rUYYnKM6CrjVdPGC/inprjAVd4wKfyos1oU+
	SmR5F1cZIdnG7dIF/ht6nGQghBryZfhL9H90upf9G9wXPZPKPVsNu1Xbs6kQrd/5Vsub1a+YyD+
	HXuRvO9IaEZKah2CqI1lxdnOf8939dWWMIXamyQ9EZ3TZ1BjPdYbsjOzG0MTdTmMgaHdvGw2jb+
	UBnj4y+s2Dl3xlq+c49Q==
X-Received: by 2002:a05:600c:4e11:b0:493:b549:3be0 with SMTP id 5b1f17b1804b1-493d11dd1d9mr66980765e9.17.1783240759206;
        Sun, 05 Jul 2026 01:39:19 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493bef1807asm258611905e9.1.2026.07.05.01.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 01:39:18 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Lubomir Rintel <lkundrak@v3.sk>,
	linux-arm-kernel@lists.infradead.org,
	Yixun Lan <dlan@kernel.org>,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev
Subject: [PATCH] pwm: pxa: Depend on OF and simplify accordingly
Date: Sun,  5 Jul 2026 10:39:08 +0200
Message-ID: <20260705083910.3502207-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2488; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=xcO7pe3BTmwOdzui6/X6iJz8mN0Rp2hw3KbCd40pQDo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqShguPRcS1zwcItJ0B2kpRagpct3lTujC6gVxy YGvluRc5buJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCakoYLgAKCRCPgPtYfRL+ ThdWB/9BzmNcPE8phy3T4E0fYQBt4FVzBOGD42JLah32QnkergVTmb+90x4tK7Ok6JGqgkImXxL Ib9yagywAKum0x1E4zsfA2wWhgU4UARE2m0caZDTD6IkiGLHRbk+mBTS/NOf4lybTWQGqkJqezO BUs563Y26XZb/fclva2hGk6i2cSdjvg8bXpWKoHV37tLMO5D5q18oWFq+Jxbwyj6LTntS2ENNOm Wy21tdilDqvLzrCWOFHT2VasjSEiI0GRcj/rMqYemLSf/f1IakmrGaPsi19B5KWM8euV9qn8P/N buKhv+7derzV/lsUKBsM/iXUXqYqXfYjm2eR+bPx5IPkk5Xd
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9554-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-pwm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@zonque.org,m:haojian.zhuang@gmail.com,m:robert.jarzmik@free.fr,m:lkundrak@v3.sk,m:linux-arm-kernel@lists.infradead.org,m:dlan@kernel.org,m:linux-riscv@lists.infradead.org,m:spacemit@lists.linux.dev,m:haojianzhuang@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[baylibre.com];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,zonque.org,gmail.com,free.fr,v3.sk,lists.infradead.org,kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,baylibre.com:from_mime,baylibre.com:email,baylibre.com:mid,baylibre.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 505A97097F4

The SoCs that this driver actually works on all imply OF already. (ARM
selects USE_OF unless some archs are enabled that cannot be selected
together with ARCH_PXA or ARCH_MMP, ARM64 and RISCV select OF.)

With OF known to be enabled a few conditionals in the driver can be
simplified.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

while doing a treewide cleanup I wondered if these conditionals are
relevant at all. A bit of research found they are not. We will get over
losing compile coverage for COMPILE_TEST && !OF.

Best regards
Uwe

 drivers/pwm/Kconfig   |  2 +-
 drivers/pwm/pwm-pxa.c | 10 ++--------
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index e8886a9b64d9..729776086879 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -569,7 +569,7 @@ config PWM_PCA9685
 config PWM_PXA
 	tristate "PXA PWM support"
 	depends on ARCH_PXA || ARCH_MMP || ARCH_SPACEMIT || COMPILE_TEST
-	depends on HAS_IOMEM
+	depends on HAS_IOMEM && OF
 	help
 	  Generic PWM framework driver for PXA.
 
diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index 156c0c74cd80..c4d73acfac49 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -136,7 +136,6 @@ static const struct pwm_ops pxa_pwm_ops = {
 	.apply = pxa_pwm_apply,
 };
 
-#ifdef CONFIG_OF
 /*
  * Device tree users must create one device instance for each PWM channel.
  * Hence we dispense with the HAS_SECONDARY_PWM and "tell" the original driver
@@ -151,9 +150,6 @@ static const struct of_device_id pwm_of_match[] = {
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pwm_of_match);
-#else
-#define pwm_of_match NULL
-#endif
 
 static int pwm_probe(struct platform_device *pdev)
 {
@@ -165,7 +161,7 @@ static int pwm_probe(struct platform_device *pdev)
 	struct reset_control *rst;
 	int ret = 0;
 
-	if (IS_ENABLED(CONFIG_OF) && id == NULL)
+	if (id == NULL)
 		id = of_device_get_match_data(dev);
 
 	if (id == NULL)
@@ -191,9 +187,7 @@ static int pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(rst);
 
 	chip->ops = &pxa_pwm_ops;
-
-	if (IS_ENABLED(CONFIG_OF))
-		chip->of_xlate = of_pwm_single_xlate;
+	chip->of_xlate = of_pwm_single_xlate;
 
 	pc->mmio_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pc->mmio_base))

base-commit: 2b763db0c2763d6bf73d7d3e69665222d1f377cf
-- 
2.55.0.11.g153666a7d9bb


