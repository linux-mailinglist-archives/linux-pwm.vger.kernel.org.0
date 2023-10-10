Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621FF7BF4CE
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Oct 2023 09:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442599AbjJJHvd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 Oct 2023 03:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442582AbjJJHvc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 Oct 2023 03:51:32 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E714A4
        for <linux-pwm@vger.kernel.org>; Tue, 10 Oct 2023 00:51:29 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qq7WS-00085v-Dq; Tue, 10 Oct 2023 09:51:20 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qq7WO-000big-7a; Tue, 10 Oct 2023 09:51:16 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qq7WN-00CvmQ-Tt; Tue, 10 Oct 2023 09:51:15 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 00/11] pwm: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
Date:   Tue, 10 Oct 2023 09:51:01 +0200
Message-Id: <20231010075112.755178-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1674; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=A8HP9dusodcVd01/oywSk7GyIKXIzSNIx/3Y74BCkPc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlJQJcnufZamylMhsh8sHRAmnhUy5NU96BFuv1Y +e804696reJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSUCXAAKCRCPgPtYfRL+ Tjh6CACMY4DrmuQjpMLEcju7BTHj+1LkPQrPGzvdAqhyOjGVgG6nn1jcf2VaamQObZChkefRgLs oGITc8kXXHSZrBoDCl/3UmmLnAvW5k3tjbcea5fGxJiYwtHMEHeNP8QN3KvDPJfHdaSBXRSjFxG qeSWUlbgXAxCXPOs+4g2lYNASWm34COaFAlVOM6+RVayhDGxrwp1VpVzb3FoaFsKxd23l6ro6F7 rfSbpRLt9/8ksOGpw8hOrWkkX+yr4FYnGFjHigSeTR3+Pa4R/8DYRXBsd7tiaO4TtfGaE1juULa wGYbs9wy/RogDPwlSXCYddDhVrgS0MNXIWr8BbqF6xiyXxC3
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

Hello,

Florian added pm support to the pwm-bcm2835 driver[1]. This made me
check what is the "modern" way to add pm support. This series modernizes
the other pwm drivers with the things I learned.

Best regards
Uwe

[1] https://lore.kernel.org/linux-pwm/20231009204226.3224521-1-florian.fainelli@broadcom.com

Uwe Kleine-König (11):
  pwm: atmel-hlcdc: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
  pwm: atmel-tcb: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
  pwm: berlin: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
  pwm: brcmstb: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
  pwm: dwc: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
  pwm: imx-tpm: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
  pwm: samsung: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
  pwm: stm32-lp: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
  pwm: stm32: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
  pwm: tiecap: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
  pwm: tiehrpwm: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions

 drivers/pwm/pwm-atmel-hlcdc.c |  8 +++-----
 drivers/pwm/pwm-atmel-tcb.c   |  8 +++-----
 drivers/pwm/pwm-berlin.c      |  8 +++-----
 drivers/pwm/pwm-brcmstb.c     | 12 ++++--------
 drivers/pwm/pwm-dwc.c         |  6 ++----
 drivers/pwm/pwm-imx-tpm.c     | 10 +++++-----
 drivers/pwm/pwm-samsung.c     |  6 ++----
 drivers/pwm/pwm-stm32-lp.c    | 10 +++++-----
 drivers/pwm/pwm-stm32.c       |  8 ++++----
 drivers/pwm/pwm-tiecap.c      |  6 ++----
 drivers/pwm/pwm-tiehrpwm.c    |  8 +++-----
 11 files changed, 36 insertions(+), 54 deletions(-)

base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
-- 
2.40.1

