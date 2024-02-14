Return-Path: <linux-pwm+bounces-1466-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6086854626
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AF1A1F2E12E
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F9419472;
	Wed, 14 Feb 2024 09:34:53 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40645134D9
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903293; cv=none; b=ixwRfPMbtZYvc+yTtlH8YsQcZZvJgVdj8NMwl+f2dHffWXAyzghxuKT2AXX1cGpRZmKTjruoepOrJYXB990e6Ng+DtXLgdQVIbKMVvEFp967F2uwPwvKmPwl+n/w2KhvsTPKrP6ghDHZYt2fNEBImRgVlrJUpbxS0LgHt7TJIeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903293; c=relaxed/simple;
	bh=z+L8+hqUgmZZu+s65iyKxbmf3RXXx30nrI6+QzhdI1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YeeLmE9r+zTiraLq96c3CWt6Ta/dBPAhiI+zp9u3ltK9zQ1JfbCq7NWJzE245E92/i32VxTIth+zfX2lZYKQBhG3tdyPq/2F/AWQgtqtmS5zpfTyjcmKmmrSui5W1lQ1ixQKp03XtJgn+FxL2oPYIM4F9zgkbS0nBhm/jnqqgTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBfB-0006JJ-RJ; Wed, 14 Feb 2024 10:34:45 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf8-000fIn-Ch; Wed, 14 Feb 2024 10:34:42 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf8-004YAd-10;
	Wed, 14 Feb 2024 10:34:42 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v6 160/164] staging: greybus: pwm: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:33:27 +0100
Message-ID:  <3206ab7f49c2c1704ea69446f3b7a7d1e71200fa.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2534; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=z+L8+hqUgmZZu+s65iyKxbmf3RXXx30nrI6+QzhdI1A=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIkCavGDdXYL8zJhU3P466g+Ze3aOU0hm2VoS Bb55Ag1NpuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyJAgAKCRCPgPtYfRL+ TiHsB/0UOGLm89ANiWtXK0DXgEHs7uQI9oyTPuhdWzei4CgPqEg+fLIUstRMAilDUMeo71tnvm/ uunUafJ6WJox3fKb0NSwmNYfPZ7ZhdyR0f9buo3Mp6KHDVuCdW+V7rm4rH5VvmSHDKy8PN0FAqM 5KnDpvuBThvfAedsiRUkiBzDTux9acbgdyQ4qSfVBv8dSoMAQmarIbAUXy21ftOVPY0aiieyVqs fhQRiIYsxRldQR7dRpAUr9D0dqWpKiB3kw+6+rtZT4M0qkLK3HQWYWpG8nrOyqsvEVxeVH/jTV2 v3Eiug3dR6jafOg2snVa1cIfliuciNsrGyAgsWuz3eofYS5f
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the greybus pwm driver to further changes of the pwm core
outlined in the commit introducing pwmchip_alloc(). There is no intended
semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/staging/greybus/pwm.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/greybus/pwm.c b/drivers/staging/greybus/pwm.c
index 35e98e7c00c1..01883fbcd79b 100644
--- a/drivers/staging/greybus/pwm.c
+++ b/drivers/staging/greybus/pwm.c
@@ -249,20 +249,11 @@ static int gb_pwm_probe(struct gbphy_device *gbphy_dev,
 	struct pwm_chip *chip;
 	int ret, npwm;
 
-	pwmc = kzalloc(sizeof(*pwmc), GFP_KERNEL);
-	if (!pwmc)
-		return -ENOMEM;
-
 	connection = gb_connection_create(gbphy_dev->bundle,
 					  le16_to_cpu(gbphy_dev->cport_desc->id),
 					  NULL);
-	if (IS_ERR(connection)) {
-		ret = PTR_ERR(connection);
-		goto exit_pwmc_free;
-	}
-
-	pwmc->connection = connection;
-	gb_gbphy_set_data(gbphy_dev, chip);
+	if (IS_ERR(connection))
+		return PTR_ERR(connection);
 
 	ret = gb_connection_enable(connection);
 	if (ret)
@@ -274,28 +265,34 @@ static int gb_pwm_probe(struct gbphy_device *gbphy_dev,
 		goto exit_connection_disable;
 	npwm = ret;
 
-	chip = &pwmc->chip;
+	chip = pwmchip_alloc(&gbphy_dev->dev, npwm, sizeof(*pwmc));
+	if (IS_ERR(chip)) {
+		ret = PTR_ERR(chip);
+		goto exit_connection_disable;
+	}
+	gb_gbphy_set_data(gbphy_dev, chip);
+
+	pwmc = pwm_chip_to_gb_pwm_chip(chip);
+	pwmc->connection = connection;
 
-	chip->dev = &gbphy_dev->dev;
 	chip->ops = &gb_pwm_ops;
-	chip->npwm = npwm;
 
 	ret = pwmchip_add(chip);
 	if (ret) {
 		dev_err(&gbphy_dev->dev,
 			"failed to register PWM: %d\n", ret);
-		goto exit_connection_disable;
+		goto exit_pwmchip_put;
 	}
 
 	gbphy_runtime_put_autosuspend(gbphy_dev);
 	return 0;
 
+exit_pwmchip_put:
+	pwmchip_put(chip);
 exit_connection_disable:
 	gb_connection_disable(connection);
 exit_connection_destroy:
 	gb_connection_destroy(connection);
-exit_pwmc_free:
-	kfree(pwmc);
 	return ret;
 }
 
@@ -311,9 +308,9 @@ static void gb_pwm_remove(struct gbphy_device *gbphy_dev)
 		gbphy_runtime_get_noresume(gbphy_dev);
 
 	pwmchip_remove(chip);
+	pwmchip_put(chip);
 	gb_connection_disable(connection);
 	gb_connection_destroy(connection);
-	kfree(pwmc);
 }
 
 static const struct gbphy_device_id gb_pwm_id_table[] = {
-- 
2.43.0


