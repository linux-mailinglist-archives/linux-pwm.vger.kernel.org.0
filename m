Return-Path: <linux-pwm+bounces-960-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 937F683C1C0
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B668290D5C
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056481CA83;
	Thu, 25 Jan 2024 12:10:48 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0B33D55F
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184647; cv=none; b=avUuFhDGrkJKVUfHt1B0RbR9KYmAzaKfWheA7AzqlDbonhZpDhD4P7FvI3nr+h30vwX/FS28ovqrywr2ZdrVkomCbNDNpHkHWy42D97PBIhGZVfB372v/4/3RdQwabBeh1M9DBqZFDUDO1raVczjtBxWTuhW59UOPDmBQ2Zallg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184647; c=relaxed/simple;
	bh=9I6mp43V59KeZtkOb5brm+FGGJoThb3S6V+ToYzCpe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RVi9I/XFQTlaEiUrFHr2AB7ZFImQonCV1gHiwqtTjWimEiTeD/0zdrRHMIQ1v6UHba5iKkLTQ/qnp9hoonDH+GQvbCvgYiOQ6pebOuBQUvFRiqD8nejCHyKsNnOK4gLunXGxsfuuJBsbvF7/ra/vBtVOcnyfk/HJlcOqlnC0WKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ9-0003hx-Bz; Thu, 25 Jan 2024 13:10:43 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ8-002HPh-Ut; Thu, 25 Jan 2024 13:10:42 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ8-007mzB-2p;
	Thu, 25 Jan 2024 13:10:42 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Vladimir Zapolskiy <vz@mleia.com>,
	linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v5 016/111] pwm: lpc18xx-sct: Make use of parent device pointer in driver data
Date: Thu, 25 Jan 2024 13:08:38 +0100
Message-ID:  <ab3e9f28f28948d18b672d1f35c2980867912c01.1706182805.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
References: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2273; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=9I6mp43V59KeZtkOb5brm+FGGJoThb3S6V+ToYzCpe4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk9MwAszs4qqG1xpjvFD+N8bFQMQi7skhk9rp 5kvuEUR4AWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPTAAKCRCPgPtYfRL+ TkDNB/9JGdinssjbOnuol9/1nla9F1EV08P1WRntSHIOsxptv6q/CgAxVnmeloQ9Zw55QfPS+Is 9/m0SJT+nmPovW8v8r8DWmFGmg6YFhQS9GSPuiYm/ECqXfnTnUgb9OG0sWRxRaUhl8kpGwyeuFY CIMpYh7WqyPFctr/RSv2bvYEOhPzSfYzDyQRdGqmLsLo3eE/6mfdY1eGcGkaqwZvdwSiOfCt+bI Yokv1NndTg1UKs1KRydWorUmuzwt1HH9O8uhcgixdchT4kZ4J5HUn4sSuSK326I02Z4JERbJ0so yitgngTcL/n2KMx8bd/gr28GX+EOp4S67Uvdk8uEsiQ/jrlf
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, make use of the
already existing pointer to the parent device in driver data. However
rename the pointer to "parent" for consistency with other drivers.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-lpc18xx-sct.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
index fe891fa71a1d..1d2d342c05fd 100644
--- a/drivers/pwm/pwm-lpc18xx-sct.c
+++ b/drivers/pwm/pwm-lpc18xx-sct.c
@@ -92,7 +92,7 @@ struct lpc18xx_pwm_data {
 };
 
 struct lpc18xx_pwm_chip {
-	struct device *dev;
+	struct device *parent;
 	struct pwm_chip chip;
 	void __iomem *base;
 	struct clk *pwm_clk;
@@ -198,7 +198,7 @@ static int lpc18xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	if (period_ns < lpc18xx_pwm->min_period_ns ||
 	    period_ns > lpc18xx_pwm->max_period_ns) {
-		dev_err(chip->dev, "period %d not in range\n", period_ns);
+		dev_err(lpc18xx_pwm->parent, "period %d not in range\n", period_ns);
 		return -ERANGE;
 	}
 
@@ -214,7 +214,7 @@ static int lpc18xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 */
 	if (requested_events > 2 && lpc18xx_pwm->period_ns != period_ns &&
 	    lpc18xx_pwm->period_ns) {
-		dev_err(chip->dev, "conflicting period requested for PWM %u\n",
+		dev_err(lpc18xx_pwm->parent, "conflicting period requested for PWM %u\n",
 			pwm->hwpwm);
 		mutex_unlock(&lpc18xx_pwm->period_lock);
 		return -EBUSY;
@@ -289,7 +289,7 @@ static int lpc18xx_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 				    LPC18XX_PWM_EVENT_MAX);
 
 	if (event >= LPC18XX_PWM_EVENT_MAX) {
-		dev_err(lpc18xx_pwm->dev,
+		dev_err(lpc18xx_pwm->parent,
 			"maximum number of simultaneous channels reached\n");
 		return -EBUSY;
 	}
@@ -358,7 +358,7 @@ static int lpc18xx_pwm_probe(struct platform_device *pdev)
 	if (!lpc18xx_pwm)
 		return -ENOMEM;
 
-	lpc18xx_pwm->dev = &pdev->dev;
+	lpc18xx_pwm->parent = &pdev->dev;
 
 	lpc18xx_pwm->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(lpc18xx_pwm->base))
-- 
2.43.0


