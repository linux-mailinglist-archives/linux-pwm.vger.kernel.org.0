Return-Path: <linux-pwm+bounces-1832-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E25CC8916E9
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Mar 2024 11:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 083871C23F16
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Mar 2024 10:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BACB52F61;
	Fri, 29 Mar 2024 10:36:00 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9776F4AEDF
	for <linux-pwm@vger.kernel.org>; Fri, 29 Mar 2024 10:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711708560; cv=none; b=RNXc85Y7s0oItGWjXbytpu/zyORMXMiac0ESxG5f84JtsewlWV0xWm6/pVzMdJVcTGlFuaty8n7yzZOLxZf701sxwr2xUwxq0/V2diTlug2axs2S12NBVMqrC7KfZMzHk5+3kGJ+3tXDfP7nyFVpR7P2rZGs5dJqbM9cZTwykNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711708560; c=relaxed/simple;
	bh=6P4ij8pT/jNEACKbrUbJM3jRpTlCNw9gLFxqsaz9cV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n1002lGY2RRknj3WWzDlOhZdAMcq7a84pLv5wHDT8GKsmG5D+P30bCR/ih5qEwdL+2ZwfjcBDmnqbiNuDweZYoFbAjWBILIxREtI2PIEZpYs4DHXQ4ZSr3rf/lfPWet3WLBxgSu7pizWgi6l8T0frRottFaSGceqrrJJ5RiRkqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rq9aQ-0004f2-TX; Fri, 29 Mar 2024 11:35:50 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rq9aQ-009Asp-3Y; Fri, 29 Mar 2024 11:35:50 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rq9aQ-00DP36-05;
	Fri, 29 Mar 2024 11:35:50 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Karel Balej <balejk@matfyz.cz>
Cc: regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: [PATCH] pwm: Fix setting period with #pwm-cells = <1> and of_pwm_single_xlate()
Date: Fri, 29 Mar 2024 11:35:40 +0100
Message-ID: <20240329103544.545290-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <D05IVTPYH35N.2CLDG6LSILRSN@matfyz.cz>
References: <D05IVTPYH35N.2CLDG6LSILRSN@matfyz.cz>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=938; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=6P4ij8pT/jNEACKbrUbJM3jRpTlCNw9gLFxqsaz9cV8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmBpmBCEoSmv3VGGugvF7Gd5MBYCphgMHVAzK7z yVJOvs/9lqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZgaZgQAKCRCPgPtYfRL+ TgoZB/9Wc2chrVBgffMrFoojo//TTLQpy82n2mlMdKpvfBXEHPmMInm59WGWzalK92If3Wu7DHx F8ybG6Th4PtWK6zoQ3IhzMgDlYsybKkt3CLOMUoTZXhPI2ci9CV6kTtm/6Yxp6RxAZfN7n/fteE mEZZz7k82CMJHlsr/tumXJhzkuEULm/gJnMgiRke+u+jmbE07CTjx0cRiz+oHIL8nKa3TEeTM2Z 4J9jVd9UUPRUTzqDkAo9P5f4J4GXkg4fKPKuvH4K6QZU+6oczy525RY76qRvYPLHSKErhSuWg2s VgBHA+Ao65Y/xwx98bHgt3A0E7TiZXBJT+x4qnOEWj+A2GqU
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

For drivers making use of of_pwm_single_xlate() (i.e. those that don't
pass a hwpwm index) and also don't pass flags, setting period was
wrongly skipped. This affects the pwm-pxa and ti-sn65dsi86 drivers.

Reported-by: Karel Balej <balejk@matfyz.cz>
Fixes: 40ade0c2e794 ("pwm: Let the of_xlate callbacks accept references without period")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 54a62879fffa..ee3ef3f44bc5 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -512,7 +512,7 @@ of_pwm_single_xlate(struct pwm_chip *chip, const struct of_phandle_args *args)
 	if (IS_ERR(pwm))
 		return pwm;
 
-	if (args->args_count > 1)
+	if (args->args_count > 0)
 		pwm->args.period = args->args[0];
 
 	pwm->args.polarity = PWM_POLARITY_NORMAL;
-- 
2.43.0


