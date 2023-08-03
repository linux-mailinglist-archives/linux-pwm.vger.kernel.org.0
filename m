Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E1176EBED
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Aug 2023 16:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236587AbjHCOJu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 3 Aug 2023 10:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237142AbjHCOJD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 3 Aug 2023 10:09:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623FA212B
        for <linux-pwm@vger.kernel.org>; Thu,  3 Aug 2023 07:08:29 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qRYyZ-0006mV-Nr; Thu, 03 Aug 2023 16:06:51 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qRYyN-000rBF-In; Thu, 03 Aug 2023 16:06:39 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qRYyM-00A9kB-Jk; Thu, 03 Aug 2023 16:06:38 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Michael Walle <michael@walle.cc>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Hammer Hsieh <hammerh0314@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Sean Anderson <sean.anderson@seco.com>,
        Michal Simek <michal.simek@amd.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        chrome-platform@lists.linux.dev, linux-mips@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev
Subject: [PATCH 0/2] pwm: Manage owner assignment implicitly for drivers
Date:   Thu,  3 Aug 2023 16:06:30 +0200
Message-Id: <20230803140633.138165-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4136; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=fUIfC654WxtfT7CEJ8mGT4DHYTt22edc6EeQOO0mgBU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBky7RhOm8jkQTlEYB5GsZS8El0/H9apHFEdsZFO x8y+5Ja40OJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZMu0YQAKCRCPgPtYfRL+ TsJcB/90L6hN+ip+TjX3AzflYEmXfAvsD7DvqLlndSD4q7tLpczaexF3R7J6u81XciSqOUe2jgL ZFH92dwUdpov0xdqiWraRK+aZJ+b0W4jpGsrqqlhoMdolr0pAB7fIFytPguywOKD62dbKy1CvL1 Dhl29UAwsXqsIV7jcTR/3lRLsFUwN9/STI8/IVeD4JJHoLv16c1Q61uVC/I22L/ivskcK9F/YQX 7it5vFhz9lfLpr79GuNQ3+d+atoBJRDfjCnDak/HWaR9JRk7b7F8pb+oq6ih+R2INrvw1jlBxDW 1b3cg6OWSLaXTh/Y3/NSkgaZz/kG8/JbVRjAFD6tfDS0KfZO
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

while working on the pwm core I noticed that pwm-crc doesn't assign
.owner in its pwm_ops structure. This isn't a problem in practise though
as this driver can only be compiled built-in (up to now).

Still prevent future pwm drivers not assigning .owner by wrapping
pwmchip_add() in a macro that automates owner handling simplifying each
driver a (tiny) bit.

I also found that there is no hard reason to only compile pwm-crc as a
built-in on x86, so this limitation is lifted in the second patch.

Best regards
Uwe

Uwe Kleine-König (2):
  pwm: Manage owner assignment implicitly for drivers
  pwm: crc: Allow compilation as module and with COMPILE_TEST

 drivers/gpio/gpio-mvebu.c             |  1 -
 drivers/gpu/drm/bridge/ti-sn65dsi86.c |  1 -
 drivers/leds/rgb/leds-qcom-lpg.c      |  1 -
 drivers/pwm/Kconfig                   |  4 ++--
 drivers/pwm/core.c                    | 20 +++++++++++---------
 drivers/pwm/pwm-ab8500.c              |  1 -
 drivers/pwm/pwm-apple.c               |  1 -
 drivers/pwm/pwm-atmel-hlcdc.c         |  1 -
 drivers/pwm/pwm-atmel-tcb.c           |  1 -
 drivers/pwm/pwm-atmel.c               |  1 -
 drivers/pwm/pwm-bcm-iproc.c           |  1 -
 drivers/pwm/pwm-bcm-kona.c            |  1 -
 drivers/pwm/pwm-bcm2835.c             |  1 -
 drivers/pwm/pwm-berlin.c              |  1 -
 drivers/pwm/pwm-brcmstb.c             |  1 -
 drivers/pwm/pwm-clk.c                 |  1 -
 drivers/pwm/pwm-clps711x.c            |  1 -
 drivers/pwm/pwm-crc.c                 |  5 ++++-
 drivers/pwm/pwm-cros-ec.c             |  1 -
 drivers/pwm/pwm-dwc.c                 |  1 -
 drivers/pwm/pwm-ep93xx.c              |  1 -
 drivers/pwm/pwm-fsl-ftm.c             |  1 -
 drivers/pwm/pwm-hibvt.c               |  1 -
 drivers/pwm/pwm-img.c                 |  1 -
 drivers/pwm/pwm-imx-tpm.c             |  1 -
 drivers/pwm/pwm-imx1.c                |  1 -
 drivers/pwm/pwm-imx27.c               |  1 -
 drivers/pwm/pwm-intel-lgm.c           |  1 -
 drivers/pwm/pwm-iqs620a.c             |  1 -
 drivers/pwm/pwm-jz4740.c              |  1 -
 drivers/pwm/pwm-keembay.c             |  1 -
 drivers/pwm/pwm-lp3943.c              |  1 -
 drivers/pwm/pwm-lpc18xx-sct.c         |  1 -
 drivers/pwm/pwm-lpc32xx.c             |  1 -
 drivers/pwm/pwm-lpss.c                |  1 -
 drivers/pwm/pwm-mediatek.c            |  1 -
 drivers/pwm/pwm-meson.c               |  1 -
 drivers/pwm/pwm-microchip-core.c      |  1 -
 drivers/pwm/pwm-mtk-disp.c            |  1 -
 drivers/pwm/pwm-mxs.c                 |  1 -
 drivers/pwm/pwm-ntxec.c               |  1 -
 drivers/pwm/pwm-omap-dmtimer.c        |  1 -
 drivers/pwm/pwm-pca9685.c             |  1 -
 drivers/pwm/pwm-pxa.c                 |  1 -
 drivers/pwm/pwm-raspberrypi-poe.c     |  1 -
 drivers/pwm/pwm-rcar.c                |  1 -
 drivers/pwm/pwm-renesas-tpu.c         |  1 -
 drivers/pwm/pwm-rockchip.c            |  1 -
 drivers/pwm/pwm-rz-mtu3.c             |  1 -
 drivers/pwm/pwm-samsung.c             |  1 -
 drivers/pwm/pwm-sifive.c              |  1 -
 drivers/pwm/pwm-sl28cpld.c            |  1 -
 drivers/pwm/pwm-spear.c               |  1 -
 drivers/pwm/pwm-sprd.c                |  1 -
 drivers/pwm/pwm-sti.c                 |  1 -
 drivers/pwm/pwm-stm32-lp.c            |  1 -
 drivers/pwm/pwm-stm32.c               |  1 -
 drivers/pwm/pwm-stmpe.c               |  1 -
 drivers/pwm/pwm-sun4i.c               |  1 -
 drivers/pwm/pwm-sunplus.c             |  1 -
 drivers/pwm/pwm-tegra.c               |  1 -
 drivers/pwm/pwm-tiecap.c              |  1 -
 drivers/pwm/pwm-tiehrpwm.c            |  1 -
 drivers/pwm/pwm-twl-led.c             |  2 --
 drivers/pwm/pwm-twl.c                 |  2 --
 drivers/pwm/pwm-visconti.c            |  1 -
 drivers/pwm/pwm-vt8500.c              |  1 -
 drivers/pwm/pwm-xilinx.c              |  1 -
 drivers/staging/greybus/pwm.c         |  1 -
 include/linux/pwm.h                   |  8 +++++---
 70 files changed, 22 insertions(+), 83 deletions(-)


base-commit: 3ccb179aa40d931eb00ef8910d7b812a95659563
-- 
2.39.2

