Return-Path: <linux-pwm+bounces-1743-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3735B87772E
	for <lists+linux-pwm@lfdr.de>; Sun, 10 Mar 2024 14:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78884B20BBB
	for <lists+linux-pwm@lfdr.de>; Sun, 10 Mar 2024 13:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736041EB23;
	Sun, 10 Mar 2024 13:47:40 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6CE28DDE
	for <linux-pwm@vger.kernel.org>; Sun, 10 Mar 2024 13:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710078460; cv=none; b=kA+U1izTS1y2MeOeXdP61EOB96/fTyoQP93lqiU3o1/6g8hYeSbKPqSMPJLq03pWJSUZ3rXt2dchi3oSEBIMNIoQw2mHDSuL476sv8Z9BYElc/ObaYT4N6sdgMGpYk7kDVkXFRLN97PyED3L0xObT+SZGEkUXxaRjmwwrLDGPSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710078460; c=relaxed/simple;
	bh=79AmYYZEOLbzvbNiEIIV8+diN3zkJyqKVCdZ4iuPKdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KHbCUw3HKGl33hctOq3DU9ksr0Yxaqh0JO6zW8iFh5ntTC7vzEd4kPVPlvLqP+oiMQRGLUWHmAvPX16doFvxpzAQczUdESZOrjvGXOIaexR9XbzJ8R6qfqjGrktwYiEzfpyffAF/JmZgZ1eCHesov2ifNeeOpkpu98e58EkTM10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjJWY-0000zS-Hz; Sun, 10 Mar 2024 14:47:34 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjJWY-005WrM-5F; Sun, 10 Mar 2024 14:47:34 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjJWY-003SKC-0E;
	Sun, 10 Mar 2024 14:47:34 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-pwm@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH 2/2] pwm: bcm2835: Drop open coded variant of devm_clk_rate_exclusive_get()
Date: Sun, 10 Mar 2024 14:47:20 +0100
Message-ID:  <8e1a5151a7bcd455996c873bb3d13ab86def3490.1710078146.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1710078146.git.u.kleine-koenig@pengutronix.de>
References: <cover.1710078146.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1472; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=79AmYYZEOLbzvbNiEIIV8+diN3zkJyqKVCdZ4iuPKdU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl7bnrmLEyB+GTwBPINh8dcmnkHqGw5+Zd/jTs4 cHZN1/kvyWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZe256wAKCRCPgPtYfRL+ Tjw6CACdSW2/oqMiil35Ct2BPwBxq3vQ9/ihg0LsM6L0MzzZLnj2Il8lBgyORX2peNbWFGF81gE ttppqD01XO6sNlq8tR06RieweKXpBX5RGR04QL9+6p/TqONzTl4bl9ansGLmwDv1E+cy74zBtot roNFXz1yD90c1hsITRmucRONsNqGQRcvlvdA39dijiUHIt9i69ofzfgtf03QACwdj1N5SDBWv+D /obKJM8Vy5l7KcFOggyA3ug9kQGnumrcgSvtRth8fd6Sf4P7n6oQkFqQJHnUiVCi+efZSGpnLI5 IiHo++qviX4hQgRGswJCPZRDNpLdLVVDIStAZgRAm4JUXm46
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

Since commit b0cde62e4c54 ("clk: Add a devm variant of
clk_rate_exclusive_get()") the clk subsystem provides
devm_clk_rate_exclusive_get(). Replace the open coded implementation by
the new function.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-bcm2835.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index 3d0c089c9ef0..578e95e0296c 100644
--- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -124,13 +124,6 @@ static const struct pwm_ops bcm2835_pwm_ops = {
 	.apply = bcm2835_pwm_apply,
 };
 
-static void devm_clk_rate_exclusive_put(void *data)
-{
-	struct clk *clk = data;
-
-	clk_rate_exclusive_put(clk);
-}
-
 static int bcm2835_pwm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -152,16 +145,11 @@ static int bcm2835_pwm_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(pc->clk),
 				     "clock not found\n");
 
-	ret = clk_rate_exclusive_get(pc->clk);
+	ret = devm_clk_rate_exclusive_get(dev, pc->clk);
 	if (ret)
 		return dev_err_probe(dev, ret,
 				     "fail to get exclusive rate\n");
 
-	ret = devm_add_action_or_reset(dev, devm_clk_rate_exclusive_put,
-				       pc->clk);
-	if (ret)
-		return ret;
-
 	pc->rate = clk_get_rate(pc->clk);
 	if (!pc->rate)
 		return dev_err_probe(dev, -EINVAL,
-- 
2.43.0


