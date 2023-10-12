Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6657C72A5
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379525AbjJLQbA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379552AbjJLQa5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:30:57 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112C3D6
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:30:54 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaK-0004gZ-Iv; Thu, 12 Oct 2023 18:30:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaK-001C5c-6V; Thu, 12 Oct 2023 18:30:52 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaJ-00F5MT-Td; Thu, 12 Oct 2023 18:30:51 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 006/109] pwm: bcm-kona: Make use of pwmchip_parent() macro
Date:   Thu, 12 Oct 2023 18:28:34 +0200
Message-ID: <20231012162827.1002444-117-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1156; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=a6rdmbZKU11BMNMtNYdQhs2WfPNB8F0MjUDfYmBxZiI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB6zXEm9MHfbrkRBNCwCvgiAbbpbymYTz+9Un lMk9iqgyEKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSgeswAKCRCPgPtYfRL+ Tue1B/sGMC6kWrqR5GwUVvLP6CH2u9AB7e6AkcrxsrRvNvdnWdymACQ9dWElUT9RSWE7FCacMgT u04lEY4ttPnN8hP2s2V6/9M5hKuM1s/+vPEUOGtzRlnfbjt8QPsI7K75QRyILiQ4llnjYz9wRsl ErYx4Sq3NGqIP+QLYI31x8+mQA4EnHRHVv7cXGV8Sf3ZKmzP2G8kyOx+xyf8VZj028r9sOo7u/0 fwBGWIOTeOPsprZ64AKV5Nnv0V9Bd5u0cnGhkXt6UCRUK4VYoCeAMwZtnVhY6Iahtlu0Td2x9WV ArPunFpw32yxaPlZaMDenAJulivI3+6O2X6N585v9qPD/kvx
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, use the macro
provided for exactly this purpose.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-bcm-kona.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
index 15d6ed03c3ce..53bb52c9da08 100644
--- a/drivers/pwm/pwm-bcm-kona.c
+++ b/drivers/pwm/pwm-bcm-kona.c
@@ -164,7 +164,7 @@ static int kona_pwmc_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	ret = clk_prepare_enable(kp->clk);
 	if (ret < 0) {
-		dev_err(chip->dev, "failed to enable clock: %d\n", ret);
+		dev_err(pwmchip_parent(chip), "failed to enable clock: %d\n", ret);
 		return ret;
 	}
 
@@ -193,7 +193,7 @@ static int kona_pwmc_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ret = clk_prepare_enable(kp->clk);
 	if (ret < 0) {
-		dev_err(chip->dev, "failed to enable clock: %d\n", ret);
+		dev_err(pwmchip_parent(chip), "failed to enable clock: %d\n", ret);
 		return ret;
 	}
 
-- 
2.42.0

