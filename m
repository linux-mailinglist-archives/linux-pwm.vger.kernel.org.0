Return-Path: <linux-pwm+bounces-1196-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8269D84909C
	for <lists+linux-pwm@lfdr.de>; Sun,  4 Feb 2024 22:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34F921F21AB8
	for <lists+linux-pwm@lfdr.de>; Sun,  4 Feb 2024 21:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3592C1B5;
	Sun,  4 Feb 2024 21:21:05 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6275C2C1A5
	for <linux-pwm@vger.kernel.org>; Sun,  4 Feb 2024 21:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707081665; cv=none; b=jUqjAk+CJxlDnr3R00gWOPCe0m2PVXMVlGKKZ/5zIzTqeGljXdl/z1f5iRJQHmLB7a9FTXzzppUYkN3LCFQTYZDosQlEcA8hqfLZQxE5vAEXu3qnpC4Z9v5euOH4iBNvamGwOcvzakJp0PSu2yHK8G/GecA0Na9KLepmsXdpx9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707081665; c=relaxed/simple;
	bh=znBJ4HvTEH7LlC8OzDSWvAk5dHEpEUaClIrUDbTqHCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g2BCbxwYgD2lamfy60SVrHeM4gLie7N9turbK8xh4d8x5Tuue1XqzvdhVu0tat6IgIQQq9BWf0djXwz5u1bRyPqV9/GQZkhVwXBjRHsOFeevvZRDZvnvUnN/qHKe0v6y5xzKee3H3+fB9F+tmz4zulNmsbESxPf+fy+9vvq+rnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rWjv3-00010J-W6; Sun, 04 Feb 2024 22:20:54 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rWjv3-004Vd9-2M; Sun, 04 Feb 2024 22:20:53 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rWjv2-00F1px-3A;
	Sun, 04 Feb 2024 22:20:52 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	kernel@pengutronix.de,
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH] pwm: sti: Fix capture for st,pwm-num-chan < st,capture-num-chan
Date: Sun,  4 Feb 2024 22:20:43 +0100
Message-ID: <20240204212043.2951852-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2217; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=znBJ4HvTEH7LlC8OzDSWvAk5dHEpEUaClIrUDbTqHCk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlv/+ssxeT0/jsauV8Isrf9HeWJ3V0+LjXj6ca0 ymRJMKJTq2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZb//rAAKCRCPgPtYfRL+ Ti9NB/0ZRd1UZzP0yhjKQn1b0N0TIEvXZd7wjvSDlY5LUQ6Ank56n7FXmeoP0j+FL5JrMHC4gN8 IfAe98VZXtaCP72iagl3m3A7TV0kXM0bCKJOq3faxsopTfoZwGC2bmJYYFuGik2HoAFWIz61VKV X+LeLLLZcfA+Nc5qCFhfJwWyKe+JLMsQMTzkWqOPtHT+MNi3qCu7uAzREIFc0LCR6T1qr0JZUlN zc6ytRXe3VNI9BORTF7MFv6tXTyJRoZx9W7gk8xzMNxieov+BuR+O4s4IjsHNGIINXqDBS/nP0Y eNa9dP6JWhEJRQwsh9XD+4oZhk0Y1VjVxH+LqN0jUhaXhD6p
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

The driver only used the number of pwm channels to set the pwm_chip's
npwm member. The result is that if there are more capture channels than
PWM channels specified in the device tree, only a part of the capture
channel is usable. Fix that by passing the bigger channel count to the
pwm framework. This makes it possible that the .apply() callback is
called with .hwpwm >= pwm_num_devs, catch that case and return an error
code.

Fixes: c97267ae831d ("pwm: sti: Add PWM capture callback")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

the code that is fixed here was actually introduced a bit earlier than the
commit specified in the fixes line. See the commits immediately proceeding the
pointed out commit. This problem only gets relevant once the capture callback
is actually available, so the blamed commit is correct. In this regard the
commit log of 85a834c42a49 ("pwm: sti: It's now valid for number of PWM
channels to be zero") is bogus however.

Best regards
Uwe

 drivers/pwm/pwm-sti.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index 6cf55cf34d39..69b1113c6b82 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -395,8 +395,17 @@ static int sti_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 static int sti_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			 const struct pwm_state *state)
 {
+	struct sti_pwm_chip *pc = to_sti_pwmchip(chip);
+	struct sti_pwm_compat_data *cdata = pc->cdata;
+	struct device *dev = pc->dev;
 	int err;
 
+	if (pwm->hwpwm >= cdata->pwm_num_devs) {
+		dev_err(dev, "device %u is not valid for pwm mode\n",
+			pwm->hwpwm);
+		return -EINVAL;
+	}
+
 	if (state->polarity != PWM_POLARITY_NORMAL)
 		return -EINVAL;
 
@@ -646,7 +655,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
 
 	pc->chip.dev = dev;
 	pc->chip.ops = &sti_pwm_ops;
-	pc->chip.npwm = pc->cdata->pwm_num_devs;
+	pc->chip.npwm = max(cdata->pwm_num_devs, cdata->cpt_num_devs);
 
 	for (i = 0; i < cdata->cpt_num_devs; i++) {
 		struct sti_cpt_ddata *ddata = &cdata->ddata[i];
-- 
2.43.0


