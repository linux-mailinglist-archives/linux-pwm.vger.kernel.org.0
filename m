Return-Path: <linux-pwm+bounces-8582-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AIgONRb32n1RwAAu9opvQ
	(envelope-from <linux-pwm+bounces-8582-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Apr 2026 11:35:16 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7CF402A3D
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Apr 2026 11:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DAC6C3012CDC
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Apr 2026 09:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC2131B80E;
	Wed, 15 Apr 2026 09:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="lpHlEmA7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0938C33A71B
	for <linux-pwm@vger.kernel.org>; Wed, 15 Apr 2026 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776245693; cv=none; b=Cm2Y+topP4yjVLv+JSVEMYnp5FBLhq65CNdpXzda7IFA9ILV9ukBCvWW0/DKjqVOe3vMHKY0ckW0fewOZrHm94tI7KWU+1JcREUXda5PoTYryBf7dJ+3F85ZCPNmsS5q3RjnmHVW7tb2tfaTNxOJcn9vv6JKd5v2x2bRIFYG4pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776245693; c=relaxed/simple;
	bh=jVmeTwzk9PJAUrS4SAHiGQddsG+3lg47R5zNpb3K/Rg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iHsEcvXYGf7ZOAup/GouUYLCPFd5ENRyVvVlA1v32gCZatdeKWR4nG5aOVEjb/ejoThVmqy37s3dFbKp9bYd148d/j5rr65rCoQ31ja4gFNEks3paPiTD9Ix+Vd8Ls78XdbYz4O4D1W/Nt8blQOEVKoLZqwvaF1OYITgobxScN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=lpHlEmA7; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ad9a9be502so40088645ad.0
        for <linux-pwm@vger.kernel.org>; Wed, 15 Apr 2026 02:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1776245688; x=1776850488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b3b8a9yRsPwuBMnRE7k+9xNpDjqVfRCXwrD7bmNetW0=;
        b=lpHlEmA7YmA1epbGH1jUegZ0n+QtskT70HqAu8QGrffpuFldfQUXkjAHQPl9O8pMsS
         o7ikp5TCm/Dw65Kur990XAr0Sib6svkgm2H7NZfZMIggIL2Am/m1NJ/SqknCVVDzBvUz
         nrofrnlaDjXQN1p4j4TGJ3Dfcj4Fs2FR0So0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776245688; x=1776850488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3b8a9yRsPwuBMnRE7k+9xNpDjqVfRCXwrD7bmNetW0=;
        b=p6ia2fpma261ffjdMFA6+zbLJ+qRPHb0IhxtBxBvj/ZAfEXnq6zbnhyelTb1h/uGjc
         1qqH/rT0BFW60bsWFAEYMxHvP0Sc3x4AxTWCk1Ti4FDvCpGIQwcWDQAXmSxDmhqI+dVQ
         cSlyMm4NzF9lByD14xIwyYRmznfeOJapLLn4CBS4y4bKjtzBElYugA/5vJDWDr4ocmz9
         TRFBPQDUQqoGdWIJANxMt3Yu/7f7oVrMBh7zlrBc8j0eHOb9HykIMF9VLgkcbIz5eETp
         JUpSnDQ9qx1N/yrkQvkPyMHBEARzLSuPUFoJCZOfJKf7jef9tNvRYQBuwA2A7pIDFNRq
         Px3A==
X-Forwarded-Encrypted: i=1; AFNElJ+s08dwIMhjAOmUGAjPaTQDVVupJDdkTCOTir4ERqAy4cgZpkadc69kOTTj+RVbEPHIQxkVL+ZYeJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZkPPpzDhCU/9na9WCU9eRuoV3/Ltr5TrIUavfP2m9gCtZpTot
	swQMQI9F8HWpjFRRTyTG/lKgy7e4BKascKGkynrG2p0nPPilFjl4V8toPvbjE0KIyt4=
X-Gm-Gg: AeBDievX4mhaLW7DHoRlb/mPdD6lNEyyxGDsgpWnSZZZ5Unv5NuKQjtKnf8dXJorDx/
	PgZXZ9YeD69i14z/n8NCGINLaFDM7wqXpIznuXC+AoKll2qFN6TLI4UbKdjdqQhRs82VF1YMUQF
	a4MKuW/UOfEgcLlxLkJqg6w4KlFXvL3F5I/UXeGel6lXKFhjQa9IYMgKkd7ojFJmRkNEfZCipVb
	lr03E+0qHCOwN+6eELdcaJqM1AR8PN1d+wPNdwEjfjg0BN9sQTnJRhYZpRYg8k6/lHQIypTRhUM
	4/63I1p+NImmJDY8GkpRYBHmJitAB2pPuJxl6QdRiZemBveMIfPChS9QE906dNsbVfDGf1MRyh7
	Mp07aTnSq6c+GTSh6uQnEcyQBWDrvtB3qPJ+13IIggAimYPtJuAPUaAW2q4FTCU07mM0qirJBWd
	cp7cCYlaaF3mB5cf4Y0712c9D8X9fLaGXIdG3r1l2/tzIYy+sufkesfC3HUsAAxed1yZgZPaWTk
	Scme/rH
X-Received: by 2002:a17:902:d507:b0:2b4:5cd0:b6c3 with SMTP id d9443c01a7336-2b45cd0bb63mr148252015ad.29.1776245688376;
        Wed, 15 Apr 2026 02:34:48 -0700 (PDT)
Received: from nunu.. (nunu.snu.ac.kr. [147.46.112.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b47826e1b7sm15311575ad.49.2026.04.15.02.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 02:34:47 -0700 (PDT)
From: Sangyun Kim <sangyun.kim@snu.ac.kr>
To: ukleinek@kernel.org
Cc: nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pwm: atmel-tcb: Fix sleeping function called from invalid context
Date: Wed, 15 Apr 2026 18:34:33 +0900
Message-Id: <20260415093433.2359955-1-sangyun.kim@snu.ac.kr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[snu.ac.kr,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[snu.ac.kr:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sangyun.kim@snu.ac.kr,linux-pwm@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8582-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[snu.ac.kr:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EB7CF402A3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

atmel_tcb_pwm_apply() holds tcbpwmc->lock as a spinlock via
guard(spinlock)() and then calls atmel_tcb_pwm_config(), which calls
clk_get_rate() twice. clk_get_rate() acquires clk_prepare_lock (a
mutex), so this is a sleep-in-atomic-context violation.

On CONFIG_DEBUG_ATOMIC_SLEEP kernels every pwm_apply_state() that
enables or reconfigures the PWM triggers a "BUG: sleeping function
called from invalid context" warning.

All callers of tcbpwmc->lock (the .request and .apply callbacks) run in
process context and only need mutual exclusion against each other, so
use a mutex instead of a spinlock and allow the sleeping calls inside
atmel_tcb_pwm_config().

Fixes: 37f7707077f5 ("pwm: atmel-tcb: Fix race condition and convert to guards")
Signed-off-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
---
 drivers/pwm/pwm-atmel-tcb.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index f9ff78ba122d..6405e82d9f10 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -17,6 +17,7 @@
 #include <linux/ioport.h>
 #include <linux/io.h>
 #include <linux/mfd/syscon.h>
+#include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 #include <linux/of.h>
@@ -47,7 +48,7 @@ struct atmel_tcb_channel {
 };
 
 struct atmel_tcb_pwm_chip {
-	spinlock_t lock;
+	struct mutex lock;
 	u8 channel;
 	u8 width;
 	struct regmap *regmap;
@@ -81,7 +82,7 @@ static int atmel_tcb_pwm_request(struct pwm_chip *chip,
 	tcbpwm->period = 0;
 	tcbpwm->div = 0;
 
-	guard(spinlock)(&tcbpwmc->lock);
+	guard(mutex)(&tcbpwmc->lock);
 
 	regmap_read(tcbpwmc->regmap, ATMEL_TC_REG(tcbpwmc->channel, CMR), &cmr);
 	/*
@@ -335,7 +336,7 @@ static int atmel_tcb_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	int duty_cycle, period;
 	int ret;
 
-	guard(spinlock)(&tcbpwmc->lock);
+	guard(mutex)(&tcbpwmc->lock);
 
 	if (!state->enabled) {
 		atmel_tcb_pwm_disable(chip, pwm, state->polarity);
@@ -438,7 +439,7 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 	if (err)
 		goto err_gclk;
 
-	spin_lock_init(&tcbpwmc->lock);
+	mutex_init(&tcbpwmc->lock);
 
 	err = pwmchip_add(chip);
 	if (err < 0)
-- 
2.34.1

