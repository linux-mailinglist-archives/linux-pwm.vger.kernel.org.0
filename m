Return-Path: <linux-pwm+bounces-1114-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FE083FFB9
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jan 2024 09:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F03981F2119F
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jan 2024 08:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B88B524C3;
	Mon, 29 Jan 2024 08:10:45 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAB3524D5
	for <linux-pwm@vger.kernel.org>; Mon, 29 Jan 2024 08:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706515845; cv=none; b=m/61PxHkUxFMHaulBalIlVRvq35ZXiB/ZqppdnTNvowBhngrWOnKITKpr0lFWlfF86fa1TfZkfPwtKZ/hzMP6ARVGtO4/pphkt5NH39O6SL30ASLUCJ/RcOW0W+URHCw+PJyJDtoWBpnbosDycGcZBMtIj1EPSFtLm5tMFkT1N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706515845; c=relaxed/simple;
	bh=9GpK8si9NtXQNTcpJpV6R7onUdc9t4d3xgZFanwJ2So=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jweNpq5JlmlJOn+nULimYCXKfLRUmFKtH6+G4LaTFM9AGy6nT1Wl92MXJk+zHJ/wgQ0Bp/G81ILlqplhMWmCoDk01nAiQOQxCHolWUl8TRM3vywBi8tdGYw92hYvRQyAgw3WqJeB2fTNBFuCN0tKU+/jXBjFCEptdIE5HgorTME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rUMj2-0006Jx-Og; Mon, 29 Jan 2024 09:10:40 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rUMj1-0037qy-Tl; Mon, 29 Jan 2024 09:10:39 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rUMj1-00AiVL-2f;
	Mon, 29 Jan 2024 09:10:39 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Sean Young <sean@mess.org>,
	Thierry Reding <thierry.reding@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH] pwm: bcm2835: Drop write-only member of driver private data
Date: Mon, 29 Jan 2024 09:10:30 +0100
Message-ID: <20240129081029.2355612-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1005; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=9GpK8si9NtXQNTcpJpV6R7onUdc9t4d3xgZFanwJ2So=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlt111v+gzC/avIuhOZJyFNvmlX7ezIFRpUYxnq ci87SG9R+uJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbdddQAKCRCPgPtYfRL+ TgTPB/4s7vMFZ6cVEDLf4ZwoE8/komE9fI1liwUpfRi5upQZybavy3t/XZkPGDlq9FOuAB2YPXt R0WzWJmy5SQnxFhmVYclpJuqPsywZTS91YWQs0vP9A5dsL1zfCg02B0NvQ+DNClflDSq+tc5OqK SCIMHGcqhfE5xLLqB3OhLoCqAbrtXz5fknaKVsZnwI9iuX8cpS75yy7AsFjM9VozRow0kUMdaX0 Z1yZTwnKQLbIqXmK7gE6CXoGorAtIBxVWHuJZEpkEvPdDf+m4EiQxfJPHaGjP5b4ONYn7W4rbNk Ibl0JqRnoQEuz51MkI3TjYkG/CEmcqdcQPOnID4/+9r2bxi/
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

Since commit fcc760729359 ("pwm: bcm2835: Allow PWM driver to be used in
atomic context") struct bcm2835_pwm::dev is only assigned a value, but
it's never used. So the dev member can just be dropped.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-bcm2835.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index 283cf27f25ba..711c174bbe23 100644
--- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -25,7 +25,6 @@
 
 struct bcm2835_pwm {
 	struct pwm_chip chip;
-	struct device *dev;
 	void __iomem *base;
 	struct clk *clk;
 	unsigned long rate;
@@ -142,8 +141,6 @@ static int bcm2835_pwm_probe(struct platform_device *pdev)
 	if (!pc)
 		return -ENOMEM;
 
-	pc->dev = &pdev->dev;
-
 	pc->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pc->base))
 		return PTR_ERR(pc->base);

base-commit: 979c6fe7e799d2cab0a99c4b8c41cc48f10aca0c
-- 
2.43.0


