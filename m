Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64BE6A9FCC
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Mar 2023 19:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjCCSzp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Mar 2023 13:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjCCSzj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Mar 2023 13:55:39 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70D31422A
        for <linux-pwm@vger.kernel.org>; Fri,  3 Mar 2023 10:55:36 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYY-0006AS-EQ; Fri, 03 Mar 2023 19:55:02 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYT-001cTO-L9; Fri, 03 Mar 2023 19:54:57 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYS-001ujd-Vg; Fri, 03 Mar 2023 19:54:56 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sean Anderson <sean.anderson@seco.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     kernel@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org
Subject: [PATCH 00/30] pwm: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 19:54:15 +0100
Message-Id: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4518; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=0T84eVJj5zms3XJcCemeo6tbGagiWg7FsqOn9O28VD8=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAkHgL+hOWzMEGr3pJ+k7l131cW/u0VRGYd/bj C6SJ3/IMe2JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAJB4AAKCRDB/BR4rcrs CaChB/9690Y0j69SwC7ah25tZA8zQepQ8HC5QoKJRtoGAE18zwPCd9i6Ah2GskRAHqpYY0uNm04 Ofb+Baq5kb52LxrrBMQmedZl3aJYZWofch+1g4d/hEf9ipUk1cY0J534mp4cGBxRfPQgNmj16IF Tz/dORDGUT6OLi4ZeGBhKRuh6aZBIqkrcvRyINJxJlgmQA0q2BGM2qwLZ5OSrCnu3bmCMIkxRWw 2x28v+TFl6h7Cz/hIoA/Z/10PnlupKviCktbI5hdQj824S0rA4YCq307ujpcdKH73fHV5YQNuKp y+q2ulHmEZ8gwbJaQYr3UGERAiuKSo1A/FmH1rTX55+FSi4U
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

Hello,

this patch series adapts the platform drivers below drivers/pwm to use
the .remove_new() callback. Compared to the traditional .remove()
callback .remove_new() returns no value. This is a good thing because
the driver core doesn't (and cannot) cope for errors during remove. The
only effect of a non-zero return value in .remove() is that the driver
core emits a warning. The device is removed anyhow and an early return
from .remove() usually yields a resource leak.

By changing the remove callback to return void driver authors cannot
reasonably assume any more that there is some kind of cleanup later.

All drivers touched here returned zero unconditionally in their remove
callback, so they could all be converted trivially to .remove_new().

Note that this series depends on commit 5c5a7680e67b ("platform: Provide
a remove callback that returns no value") that is already in Linus' tree
but not yet included in a tagged version.

Best regards
Uwe

Uwe Kleine-König (30):
  pwm: atmel-hlcdc: Convert to platform remove callback returning void
  pwm: atmel-tcb: Convert to platform remove callback returning void
  pwm: atmel: Convert to platform remove callback returning void
  pwm: bcm-iproc: Convert to platform remove callback returning void
  pwm: bcm2835: Convert to platform remove callback returning void
  pwm: berlin: Convert to platform remove callback returning void
  pwm: brcmstb: Convert to platform remove callback returning void
  pwm: clk: Convert to platform remove callback returning void
  pwm: cros-ec: Convert to platform remove callback returning void
  pwm: hibvt: Convert to platform remove callback returning void
  pwm: img: Convert to platform remove callback returning void
  pwm: imx-tpm: Convert to platform remove callback returning void
  pwm: lpc18xx-sct: Convert to platform remove callback returning void
  pwm: lpss-platform: Convert to platform remove callback returning void
  pwm: mtk-disp: Convert to platform remove callback returning void
  pwm: omap-dmtimer: Convert to platform remove callback returning void
  pwm: rcar: Convert to platform remove callback returning void
  pwm: rockchip: Convert to platform remove callback returning void
  pwm: samsung: Convert to platform remove callback returning void
  pwm: sifive: Convert to platform remove callback returning void
  pwm: spear: Convert to platform remove callback returning void
  pwm: sprd: Convert to platform remove callback returning void
  pwm: sti: Convert to platform remove callback returning void
  pwm: stm32: Convert to platform remove callback returning void
  pwm: sun4i: Convert to platform remove callback returning void
  pwm: tegra: Convert to platform remove callback returning void
  pwm: tiecap: Convert to platform remove callback returning void
  pwm: tiehrpwm: Convert to platform remove callback returning void
  pwm: vt8500: Convert to platform remove callback returning void
  pwm: xilinx: Convert to platform remove callback returning void

 drivers/pwm/pwm-atmel-hlcdc.c   | 6 ++----
 drivers/pwm/pwm-atmel-tcb.c     | 6 ++----
 drivers/pwm/pwm-atmel.c         | 6 ++----
 drivers/pwm/pwm-bcm-iproc.c     | 6 ++----
 drivers/pwm/pwm-bcm2835.c       | 6 ++----
 drivers/pwm/pwm-berlin.c        | 6 ++----
 drivers/pwm/pwm-brcmstb.c       | 6 ++----
 drivers/pwm/pwm-clk.c           | 6 ++----
 drivers/pwm/pwm-cros-ec.c       | 6 ++----
 drivers/pwm/pwm-hibvt.c         | 6 ++----
 drivers/pwm/pwm-img.c           | 6 ++----
 drivers/pwm/pwm-imx-tpm.c       | 6 ++----
 drivers/pwm/pwm-lpc18xx-sct.c   | 6 ++----
 drivers/pwm/pwm-lpss-platform.c | 5 ++---
 drivers/pwm/pwm-mtk-disp.c      | 6 ++----
 drivers/pwm/pwm-omap-dmtimer.c  | 6 ++----
 drivers/pwm/pwm-rcar.c          | 6 ++----
 drivers/pwm/pwm-rockchip.c      | 6 ++----
 drivers/pwm/pwm-samsung.c       | 6 ++----
 drivers/pwm/pwm-sifive.c        | 6 ++----
 drivers/pwm/pwm-spear.c         | 6 ++----
 drivers/pwm/pwm-sprd.c          | 6 ++----
 drivers/pwm/pwm-sti.c           | 6 ++----
 drivers/pwm/pwm-stm32.c         | 6 ++----
 drivers/pwm/pwm-sun4i.c         | 6 ++----
 drivers/pwm/pwm-tegra.c         | 6 ++----
 drivers/pwm/pwm-tiecap.c        | 6 ++----
 drivers/pwm/pwm-tiehrpwm.c      | 6 ++----
 drivers/pwm/pwm-vt8500.c        | 6 ++----
 drivers/pwm/pwm-xilinx.c        | 5 ++---
 30 files changed, 60 insertions(+), 118 deletions(-)

base-commit: 2eb29d59ddf02e39774abfb60b2030b0b7e27c1f
-- 
2.39.1

