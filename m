Return-Path: <linux-pwm+bounces-1365-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7068545B0
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 073AA1C26B64
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA8E17BA9;
	Wed, 14 Feb 2024 09:34:34 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4125A14004
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903274; cv=none; b=ibxWBCfLq5rHc9ucA20Tt2tStx1pSuojy40ZYDdOEluKemfM0NtrYONzjr+D6dcNW6UzlsCI5ng8mHmmBbqTtPAA870Pu/gF6QUgw/J5ZHDXQqmFgrvOdrQhMId79Aa+oWFe97eOi86rLJdZxcRupxWnzJHxYOJdoxukjSVxsEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903274; c=relaxed/simple;
	bh=OG+q6dnfbzsTUIplD6Wo6xf2sHixf9/1G5sdmHNlgtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hzWMuoW1zDr3WksEsgrRjHqs3wAMGpdRxzEQUNG6PPWun9xGGhMtYIPRls0EYpP1xRjuSdObb2TUiO4E+NEwN99nBCZPWBRHIV9V1474jgkUqPAEqe7Pa+g687yL3vhODAbxDdMER6Y7PyrMwdbbm0V6axizdoibAPG2Ewl7k48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeu-0004pD-3Z; Wed, 14 Feb 2024 10:34:28 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBes-000fC7-29; Wed, 14 Feb 2024 10:34:26 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBer-004Y3F-3B;
	Wed, 14 Feb 2024 10:34:25 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 053/164] pwm: iqs620a: Prepare removing pwm_chip from driver data
Date: Wed, 14 Feb 2024 10:31:40 +0100
Message-ID:  <e6b1636c0d26d8bcb02a66b2963e2cc394014d76.1707900770.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
References: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1767; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=OG+q6dnfbzsTUIplD6Wo6xf2sHixf9/1G5sdmHNlgtA=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtQzHe256R2FGtFHfq4Ptttlpu7P7W30qmFCl7PX/8niH pPj9Ks6GY1ZGBi5GGTFFFnsG9dkWlXJRXau/XcZZhArE8gUBi5OAZjIs2z2/76lCxtiVIwTr6tK LXzRW/t+0eac7XdTNrYqH1Pk7Mia8YWN5daUFyv/cvdamVtPteZ599GKT/ij6alci5g1ezQuLTU UYsh3PldseP914hsPeWaFJZPytPKXnnQ5tf6JZdVjh7PvjNyKMwzVwm79SvPcFCzoeENT87D1nw 5dZmme3dw37nksuuRe0jqlv//i25ddG08+a1l3LSh6zsv0LZavtPcs0TZjfJhgKVnbvnmL+fO/m 5W2sOSnhEZ+zKgXevBoxsqdLQyObzSXxr52be7x5RD4V+evZt95RZ41WXeGRte8be67myfIap6e OF91pbWLZYHg/7XPPj3zyHpoYJ6Y26myZul5+9sxbi2iAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the driver for further changes that will drop struct
pwm_chip chip from struct iqs620_pwm_private. The only two functions
that make use of struct iqs620_pwm_private::chip (apart from the probe
function that is handled later when converting to pwmchip_alloc()) only
use the chip's device pointer. Introduce such a pointer in driver data
and use that instead.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-iqs620a.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
index 98008cae6d70..faf52d3c2720 100644
--- a/drivers/pwm/pwm-iqs620a.c
+++ b/drivers/pwm/pwm-iqs620a.c
@@ -34,6 +34,7 @@
 
 struct iqs620_pwm_private {
 	struct iqs62x_core *iqs62x;
+	struct device *dev;
 	struct pwm_chip chip;
 	struct notifier_block notifier;
 	struct mutex lock;
@@ -160,7 +161,7 @@ static int iqs620_pwm_notifier(struct notifier_block *notifier,
 	mutex_unlock(&iqs620_pwm->lock);
 
 	if (ret) {
-		dev_err(iqs620_pwm->chip.dev,
+		dev_err(iqs620_pwm->dev,
 			"Failed to re-initialize device: %d\n", ret);
 		return NOTIFY_BAD;
 	}
@@ -181,7 +182,7 @@ static void iqs620_pwm_notifier_unregister(void *context)
 	ret = blocking_notifier_chain_unregister(&iqs620_pwm->iqs62x->nh,
 						 &iqs620_pwm->notifier);
 	if (ret)
-		dev_err(iqs620_pwm->chip.dev,
+		dev_err(iqs620_pwm->dev,
 			"Failed to unregister notifier: %d\n", ret);
 }
 
@@ -196,6 +197,7 @@ static int iqs620_pwm_probe(struct platform_device *pdev)
 	if (!iqs620_pwm)
 		return -ENOMEM;
 
+	iqs620_pwm->dev = &pdev->dev;
 	iqs620_pwm->iqs62x = iqs62x;
 
 	ret = regmap_read(iqs62x->regmap, IQS620_PWR_SETTINGS, &val);
-- 
2.43.0


