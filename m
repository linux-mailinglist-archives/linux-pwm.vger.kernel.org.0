Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3F9770306
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Aug 2023 16:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjHDO3F (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Aug 2023 10:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbjHDO3E (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Aug 2023 10:29:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B7749C3
        for <linux-pwm@vger.kernel.org>; Fri,  4 Aug 2023 07:29:01 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qRvm6-0004IB-Ta; Fri, 04 Aug 2023 16:27:30 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qRvlq-0015pr-7N; Fri, 04 Aug 2023 16:27:14 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qRvlp-00AP9T-ET; Fri, 04 Aug 2023 16:27:13 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
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
        Anjelique Melendez <quic_amelende@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
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
Subject: [PATCH v2 0/2] pwm: Manage owner assignment implicitly for drivers
Date:   Fri,  4 Aug 2023 16:27:05 +0200
Message-Id: <20230804142707.412137-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3888; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=WJTkGffvizVTFrYhxlEwf33iXK2vZsfEyb81l68zhLY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkzQq2XhI0XPWVJKyF8jw9e0hP8cj3HpRdpwKrd oYg1lISRdWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZM0KtgAKCRCPgPtYfRL+ TlmxCACDstGNt8tomXEi1DwnNXDEZlZ/KVZke1AiXVnPIS/ZhVJ94U5aOYapSgAJmHQnzwqgK6z fFWv33dvGgXeSNfMfc82iKjHC0i9u6CpVTKzbkS7CkjLhfefThMzfQsEY6GCcrMBu/Hi+5qaaif ZRymzwLw6Gc4g1La1KPC1OIUlenMjcfHXUKhPwvyeIbrhx8wfU40+IFtYHvBhQqi9/e0I3woRF5 t77a20hH5LhbiKKLjmZ4ZMWDDvSLhjnPg8HbbOUIIqRM1op7uN5Uog1iEYusHzAGP9NsS1utfon xzuuuXTkvCvNrk46p97AVUuT3gZdhE7Ekvy+UO0zlQA3SpbS
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

(implicit) v1 of this series can be found at
https://lore.kernel.org/linux-pwm/20230803140633.138165-1-u.kleine-koenig@pengutronix.de .

Changes since then only affect documentation that I missed to adapt before.
Thanks to Laurent for catching that

Best regards
Uwe

Uwe Kleine-König (2):
  pwm: Manage owner assignment implicitly for drivers
  pwm: crc: Allow compilation as module and with COMPILE_TEST

 drivers/gpio/gpio-mvebu.c             |  1 -
 drivers/gpu/drm/bridge/ti-sn65dsi86.c |  1 -
 drivers/leds/rgb/leds-qcom-lpg.c      |  1 -
 drivers/pwm/Kconfig                   |  4 ++--
 drivers/pwm/core.c                    | 24 ++++++++++++++----------
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
 include/linux/pwm.h                   | 10 ++++++----
 70 files changed, 26 insertions(+), 85 deletions(-)


base-commit: 3ccb179aa40d931eb00ef8910d7b812a95659563
-- 
2.40.1

