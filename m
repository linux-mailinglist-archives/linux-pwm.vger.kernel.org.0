Return-Path: <linux-pwm+bounces-1349-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A23F85459D
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55B13286366
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5092818E1F;
	Wed, 14 Feb 2024 09:34:30 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660BB17591
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903270; cv=none; b=Ff9I28wZMEzWUKRPZHdzaS6thX+rHqjdC2KfxSrXL7xVFX0cqM8glYHl9IqZxy7rcri4RRvwhBmMESFughV8YpO9nTtPsxnFZUceQh8BFMGP5tPaQWzmL9cXrGLjQT2BmOYKYS6Nt80Fgb0sv5CwItvfOBucW56Y5lig55eH/IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903270; c=relaxed/simple;
	bh=lcEci39Wjge0pVyrVzkQpcy6IwiYW2W1loDXoOIPqnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CZkFvI8abVu2NAx6zchC4N5y0A8LdlAyhU1UTQG6dpNrK4p0GTu08Q54PDVfVPpE6as+eUpVIStCZ7/fncVtHQH8e2M+ZiH7ECP+ZPn8zDjEEaxrJyX5mwZFz+Jo7K0nhWlp/T1wCTiejGEdYeZhnM/z4qpuQiOEM21g/effzMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeq-0004gc-Vw; Wed, 14 Feb 2024 10:34:25 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeq-000fBT-HU; Wed, 14 Feb 2024 10:34:24 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeq-004Y2b-1V;
	Wed, 14 Feb 2024 10:34:24 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 043/164] pwm: img: Drop write-only variable from driver private data
Date: Wed, 14 Feb 2024 10:31:30 +0100
Message-ID:  <7b7de753caa453c7fe591228c9a45d0baf8b5878.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=859; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=lcEci39Wjge0pVyrVzkQpcy6IwiYW2W1loDXoOIPqnM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIh7AeSD9ARXjtl01p0JljZj+K2RbeSuCMJS9 seNcDZronGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIewAKCRCPgPtYfRL+ ThrHCACowVlmNU/K9n2tx6F2UbkF3TIRPQ0J0Fr01EZFvsIM19x2jZ6p4LCmnvYRKLICStlSK2M OgyTE699PTmXrqrf5Zf/SxIbKjvUlWqByr1RXaTOqxVbMQsBj2oiF7xeYknBEp2KqrdOyjbBa0J nkQ0GFui1T5zMam3DOm5HNflm4OLMYc3yhLNIO0q8FtZ0qddL0HL2DGtIJKHv/7i2k2VCuPHfZd lp9p+MZPpwTrKLghKQzGs1uZI/sx+1BXzcU0ehMDRmNNSTjzm7I7EB/WsCn7xJWA4+XOUOZZf+E pBbc8uQnvphip6e5QOzt+zuAAgb0vB1T40qQGyYPL3PhybiU
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

struct img_pwm_chip::dev is only assigned to, but the member variable is
never used. So drop it.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-img.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
index 5965ac35b32e..5f423445873d 100644
--- a/drivers/pwm/pwm-img.c
+++ b/drivers/pwm/pwm-img.c
@@ -59,7 +59,6 @@ struct img_pwm_soc_data {
 };
 
 struct img_pwm_chip {
-	struct device	*dev;
 	struct pwm_chip	chip;
 	struct clk	*pwm_clk;
 	struct clk	*sys_clk;
@@ -265,8 +264,6 @@ static int img_pwm_probe(struct platform_device *pdev)
 	if (!imgchip)
 		return -ENOMEM;
 
-	imgchip->dev = &pdev->dev;
-
 	imgchip->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(imgchip->base))
 		return PTR_ERR(imgchip->base);
-- 
2.43.0


