Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAF463D933
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Nov 2022 16:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiK3PWF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 30 Nov 2022 10:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiK3PWC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 30 Nov 2022 10:22:02 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948E97E40A
        for <linux-pwm@vger.kernel.org>; Wed, 30 Nov 2022 07:22:01 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p0OuM-0000A1-B6; Wed, 30 Nov 2022 16:21:58 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p0OuK-001Ldi-Qe; Wed, 30 Nov 2022 16:21:57 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p0OuK-001Vqt-Vr; Wed, 30 Nov 2022 16:21:57 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, linux-pwm@vger.kernel.org,
        chrome-platform@lists.linux.dev
Subject: [PATCH v2 06/11] pwm: cros-ec: Propagate errors in .get_state() to the caller
Date:   Wed, 30 Nov 2022 16:21:43 +0100
Message-Id: <20221130152148.2769768-7-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221130152148.2769768-1-u.kleine-koenig@pengutronix.de>
References: <20221130152148.2769768-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=753; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=dA7z6aSFnUkyMKNJy+EOpHKrbXNekynzu3WA3GRuAUg=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjh3TzeUc9Of7MBAi+DPwXyoqqgifeqdQZMNnh9H5F a8iX9gqJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY4d08wAKCRDB/BR4rcrsCRuQCA CMeu+y7ncJdW4KwlPf/5b7K2zf1v4F9xQddd3zjRPBGtEgUDZkdPY9PxgyL/I2EPc5+rIyUshjACKm iC85RJyXAvY319QE4br4GyJpgIFIa61HOQf4kTXmJRuZSzrvQuwvpEdShGSSgjrj4oF+YJExFdSavO f0CMB3tuVaLndgKURloCFlGOpVIhEtddnEi70QAu4ksN5Cfp+gWmMl0ciP0qu0La6vSvv55uZ6X7Vj 4pnKrmJggXtbGKjECVO0V+gXeo0rnQmMJ02bxU5S5e/O2UQ/LqcHrbturMGMQj/18/iHZjT8B8V0Xn pvp5a1/Uzw+2GVxJaEEmOJ8rIP4K3a
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

.get_state() can return an error indication. Make use of it to propagate
failing hardware accesses.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-cros-ec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index 11684edc0620..86df6702cb83 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -193,7 +193,7 @@ static int cros_ec_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	ret = cros_ec_pwm_get_duty(ec_pwm, pwm->hwpwm);
 	if (ret < 0) {
 		dev_err(chip->dev, "error getting initial duty: %d\n", ret);
-		return 0;
+		return ret;
 	}
 
 	state->enabled = (ret > 0);
-- 
2.38.1

