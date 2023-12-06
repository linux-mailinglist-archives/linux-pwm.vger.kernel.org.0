Return-Path: <linux-pwm+bounces-402-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E96E806ECF
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1279CB20F3D
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756A934CEA;
	Wed,  6 Dec 2023 11:49:03 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606ECD73
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:45 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOR-0007nZ-2y; Wed, 06 Dec 2023 12:48:43 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOO-00DwyY-Vi; Wed, 06 Dec 2023 12:48:40 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOO-00FR48-Ml; Wed, 06 Dec 2023 12:48:40 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	linux-pwm@vger.kernel.org
Subject: [PATCH v4 114/115] pwm: Make pwmchip_[sg]et_drvdata a wrapper around dev_set_drvdata
Date: Wed,  6 Dec 2023 12:45:08 +0100
Message-ID:  <d8eaf46b8219a2f367e4c8aa81905662a657367b.1701860672.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
References: <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1454; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=56nbuB6AzvG8w4+sWRxsCPOBjz6JkWq45AVPl/N0HqY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF9z9mMjlqPUJZV7kS6fuE2vYTQDoUlOS5WWU FBQzl+cRuiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBfcwAKCRCPgPtYfRL+ TtRYCACdi+WHxDfRdWNrmox35BTFzcAuS8nAkmtoEwFd609PjOv7uuf8jcylm29O5PxzTXUy2I8 RYvz4PSwhu25OWUmQw1lJsqJ2Hk5LdrPUzv1QxRVc5Vs9GATspykBgota3U2TjIR6wl7gA1tFuZ hIr6XMvmpezLYnV2oOJ6x5KEfJBxYxiF3VWKv1DET04iYxAjbOIrXh61sZqMUJjQbsx81iIy4XC gaTpyplIUpstpaGlOKtujOGEIEQejsWq0DSqstLtg6wfSq7k8g57B0tv1SBkjzqMTlqqBMvMaym XJ6ODGPc7AipZSyt3sHTZ43/aaRIlfC6TxOnVdllPb6auXu6
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

Now that a pwm_chip has a dedicated struct device, pwmchip_set_drvdata()
and pwmchip_get_drvdata() can be made thin wrappers around
dev_set_drvdata() and dev_get_drvdata() respectively and the previously
needed pointer can be dropped from struct pwm_chip.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 include/linux/pwm.h | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 1860225ab45b..535bd5fea52a 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -307,7 +307,6 @@ struct pwm_chip {
 	struct mutex lock;
 	bool uses_pwmchip_alloc;
 	bool operational;
-	void *driver_data;
 	struct pwm_device pwms[] __counted_by(npwm);
 };
 
@@ -318,20 +317,12 @@ static inline struct device *pwmchip_parent(struct pwm_chip *chip)
 
 static inline void *pwmchip_get_drvdata(struct pwm_chip *chip)
 {
-	/*
-	 * After pwm_chip got a dedicated struct device, this can be replaced by
-	 * dev_get_drvdata(&chip->dev);
-	 */
-	return chip->driver_data;
+	return dev_get_drvdata(&chip->dev);
 }
 
 static inline void pwmchip_set_drvdata(struct pwm_chip *chip, void *data)
 {
-	/*
-	 * After pwm_chip got a dedicated struct device, this can be replaced by
-	 * dev_set_drvdata(&chip->dev, data);
-	 */
-	chip->driver_data = data;
+	dev_set_drvdata(&chip->dev, data);
 }
 
 #if IS_ENABLED(CONFIG_PWM)
-- 
2.42.0


