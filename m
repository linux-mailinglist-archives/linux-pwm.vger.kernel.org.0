Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3308F7C8C85
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Oct 2023 19:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjJMRmo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 13 Oct 2023 13:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJMRmn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 13 Oct 2023 13:42:43 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367F5BE
        for <linux-pwm@vger.kernel.org>; Fri, 13 Oct 2023 10:42:42 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrMBA-0004VF-BU; Fri, 13 Oct 2023 19:42:28 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrMB7-001RgQ-76; Fri, 13 Oct 2023 19:42:25 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrMB6-00FilQ-T7; Fri, 13 Oct 2023 19:42:24 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
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
Subject: [PATCH v2 00/11] pwm: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
Date:   Fri, 13 Oct 2023 19:42:05 +0200
Message-ID: <20231013174204.1457085-13-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2024; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Jw1sN5icL+aTGXegL1KKLnEOKhic0UKDh73rtiw7rKU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKYFskKTqtssqZIdgk+76YyHvwGsNASsaoY5Eb qXb+aYndMWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSmBbAAKCRCPgPtYfRL+ TnpUB/94Rb7ImJa1JHBMssTYaC01OTNC4YG3y0XfXKLaKUW9Zoch0nSYruPX9hsjmRDfcptFkku yI0lj61TABbNziRqdmBbOAcEsma/sTiWDKKFb+X1LPU7h8tmBgt2ZkzgrPpAyomodmKCk+GM4Nw kPEOFGvciGa55RE5Yzp/Hc8XL0P0I2LFsmMS/IrMOLBBSUytgEJ/Z4GlCJMeivTcguoCbtDbBwc gsL3JROcqSwc4TfNeVL0NwOS7GdfOc7SxDMdruSsCFX5lYnzgO9owMDS38QhzkXeqYVusGcnNoY j8xun9IT/ww179rPuZ6kPTCN3h3IGFJR9nBTmFFG3VYzga/n
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

the only change here compared to (implicit) v1 sent with Message-Id:
20231010075112.755178-1-u.kleine-koenig@pengutronix.de is a rebase on
Thierry's current for-next branch and I added the tags I recieved on the
previous submission.

In v1 I did a small improvement for the brcmstb PWM driver en passant,
which was already done by Florian in a patch that is now commit
aacbd6543669 ("pwm: brcmstb: Checked clk_prepare_enable() return
value"). So the brcmstb patch in this series simplified to be similar to
the other patches here and so the commit log improvement that I promised
on Jonathan Cameron's feedback was dropped again.

Best regards
Uwe

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
 drivers/pwm/pwm-brcmstb.c     |  8 +++-----
 drivers/pwm/pwm-dwc.c         |  6 ++----
 drivers/pwm/pwm-imx-tpm.c     | 10 +++++-----
 drivers/pwm/pwm-samsung.c     |  6 ++----
 drivers/pwm/pwm-stm32-lp.c    | 10 +++++-----
 drivers/pwm/pwm-stm32.c       |  8 ++++----
 drivers/pwm/pwm-tiecap.c      |  6 ++----
 drivers/pwm/pwm-tiehrpwm.c    |  8 +++-----
 11 files changed, 35 insertions(+), 51 deletions(-)


base-commit: 4bb36d126cb3147d6bbfd00242a5b846dacad595
-- 
2.42.0

