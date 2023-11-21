Return-Path: <linux-pwm+bounces-18-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B00767F2F5C
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 667821F2411E
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DBC53809;
	Tue, 21 Nov 2023 13:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFBF10D5
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:51:51 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAM-0005HU-13; Tue, 21 Nov 2023 14:51:50 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAL-00Aaxn-GZ; Tue, 21 Nov 2023 14:51:49 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAL-004xcA-7e; Tue, 21 Nov 2023 14:51:49 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v3 023/108] pwm: rcar: Make use of pwmchip_parent() macro
Date: Tue, 21 Nov 2023 14:49:25 +0100
Message-ID: <20231121134901.208535-24-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1007; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=u7VyIWqdVHbmuZe1jcG6zXrm7SUTQzA8yhVAYBguXFI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLVmZb6lCdHclI6f41hHXA2j9bvOqtey9DYwJ +eJrEogIBWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1ZgAKCRCPgPtYfRL+ TrwECACPoZy0SvG7G2JZeL205K5ZnB7yWPhxEWLrPyg5dfdTiL2mmtsvCUAcBv3vAqKLQgH4kpx AqGWDezUvkWGWPhlh+biijBOVtqg/0mjY8Kn3Dv55pETAHc0OGerRuWNop7PqXA9wPX2GYaCAcp P03JtaOlaELNAdEyCw7Pr6XymRiUMHG2hs35oLYSxunu+uQuRcxbaCPLl7GCKUGGTFqcYRi5wQP BLRyb800zzrSrL84x+626Jk0PJcwPgSSTquwluGvyl/YvnYl1L835wHmlsQG0Ln073R2AsDJ+EA nR1j37nXlK0dGz4ctw/S+o0K1x0igthlAYnZaFE8lda6q/IJ
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, use the macro
provided for exactly this purpose.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-rcar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 13269f55fccf..4838762137d1 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -132,12 +132,12 @@ static int rcar_pwm_set_counter(struct rcar_pwm_chip *rp, int div, int duty_ns,
 
 static int rcar_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	return pm_runtime_get_sync(chip->dev);
+	return pm_runtime_get_sync(pwmchip_parent(chip));
 }
 
 static void rcar_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	pm_runtime_put(chip->dev);
+	pm_runtime_put(pwmchip_parent(chip));
 }
 
 static int rcar_pwm_enable(struct rcar_pwm_chip *rp)
-- 
2.42.0


