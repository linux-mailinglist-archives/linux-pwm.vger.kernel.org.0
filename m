Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08ABD7D3E40
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Oct 2023 19:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjJWRrF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Oct 2023 13:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjJWRrE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Oct 2023 13:47:04 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D557A3
        for <linux-pwm@vger.kernel.org>; Mon, 23 Oct 2023 10:47:03 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1quz0p-0001MC-OB; Mon, 23 Oct 2023 19:46:47 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1quz0n-003lPS-G2; Mon, 23 Oct 2023 19:46:45 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1quz0n-004VCf-67; Mon, 23 Oct 2023 19:46:45 +0200
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
Subject: [PATCH v3 00/11] pwm: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
Date:   Mon, 23 Oct 2023 19:46:17 +0200
Message-ID: <20231023174616.2282067-13-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1861; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=tgJTzh0/TB6FKMDbGnTB8E71HMJ4FWAbQpaUcMf/MkY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlNrFoWv/a/+umj+TsDnjVM+cbkmM/5oElj2Xbx sBR6y/N63aJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZTaxaAAKCRCPgPtYfRL+ ThC3CACH0tTuzBm5pKlTbQ1PnRQHVRu56R4oM3xe+zes4kU2Uu81vu6PIFBDpDd/qF6U32ngZRl QNJc+UZtBryi3hTqGLyP/tw4KnCQ7lT8tOIj+YRXNyO8XYlFhjVn9qzVLMe4LmX4lUVfKvNMjBn iiudzptDqz/zYjkxjmJyCrgQ+bKDrNK0kZoYW/vAanlrrRYtu0lBYVj312hY30FoLCriP/V6hr1 idb6H71aA0AidvWI5atKwzDQqfCwa7ZRU9LpzbNsD9oHzwNFyeM2au0vMG+wy6K8Wo+I7LhxsaY tGL5Y9dszUjdduw9+qxSa3l7TP/yyGJX85tv8H9sbxxbaTVt
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

this v3 was necessary because some lines in the commit log of a subset
of these patches were eaten. I think that happend during rebase -i where
git drops lines starting with # during git-commit. git-am isn't affected by
this "feature", so application should work fine. Still checking these
lines make it into the git commit is a good idea I think.

Other than the few additional lines in the commit logs, one Reviewed-by:
is added and the series is otherwise unchanged.

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

