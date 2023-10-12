Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601577C72A7
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379606AbjJLQbB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379512AbjJLQa5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:30:57 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19D7D8
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:30:54 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaK-0004hH-Va; Thu, 12 Oct 2023 18:30:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaK-001C5l-IK; Thu, 12 Oct 2023 18:30:52 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaK-00F5Mb-9F; Thu, 12 Oct 2023 18:30:52 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 008/109] pwm: cros-ec: Make use of pwmchip_parent() macro
Date:   Thu, 12 Oct 2023 18:28:36 +0200
Message-ID: <20231012162827.1002444-119-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1109; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=PT1MyS61hf9x8xFHAgsJLoZDngRCLfpQN0hA1F8HA+s=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB61AXs+4FTul/Qn9GUMG0UIXXpikASRpqPPl 1vOZEc5tDaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSgetQAKCRCPgPtYfRL+ ToPXB/sGxuy8YhG4g/G1GnmGekWtFdH8zH1/zfBjHuBqT/QhVDSL2K2vFrdywBzOIhvYqgDxCWu FjlFkWWMJn+/0aSgjUTkNXvOretZQmu8C5AY9w+qqr2M9xdN85v6qXYVTA30dimJ7CODZGC5kV1 ONrE/BagME5utMC2jNgXx4XIipnob9RqzftVOHRoNEFYJA8gCms0Aj0Z73ccJW/uMq3yZ5skEtV xF8H2nU4MXTxbjHkj6eczsDsyClUVJb4PGrOymamp2+H5obhpYADj6WwakQwkLNd3i8S0aIph9Y kiKs9b+baP8t/9z8O/pmo5Rf26jgPwXBNm7V//TbpbEOTaTB
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
 drivers/pwm/pwm-cros-ec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index 3f552a46cbbf..0598c9c6f5aa 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -25,7 +25,7 @@
  * @channel: array with per-channel data
  */
 struct cros_ec_pwm_device {
-	struct device *dev;
+	struct device *parent;
 	struct cros_ec_device *ec;
 	struct pwm_chip chip;
 	bool use_pwm_type;
@@ -174,7 +174,7 @@ static int cros_ec_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	ret = cros_ec_pwm_get_duty(ec_pwm->ec, ec_pwm->use_pwm_type, pwm->hwpwm);
 	if (ret < 0) {
-		dev_err(chip->dev, "error getting initial duty: %d\n", ret);
+		dev_err(pwmchip_parent(chip), "error getting initial duty: %d\n", ret);
 		return ret;
 	}
 
-- 
2.42.0

