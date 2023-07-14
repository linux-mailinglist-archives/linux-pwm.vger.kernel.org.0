Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64AB754409
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Jul 2023 22:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236173AbjGNU4t (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 14 Jul 2023 16:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236023AbjGNU4s (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 14 Jul 2023 16:56:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7275B2690
        for <linux-pwm@vger.kernel.org>; Fri, 14 Jul 2023 13:56:47 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKPq6-000842-LE; Fri, 14 Jul 2023 22:56:34 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKPq3-00EQSG-90; Fri, 14 Jul 2023 22:56:31 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKPq2-004u3i-Cn; Fri, 14 Jul 2023 22:56:30 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Benson Leung <bleung@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Michael Walle <michael@walle.cc>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev,
        linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev
Subject: [PATCH 00/10] pwm: Constistenly name pwm_chip variables "chip"
Date:   Fri, 14 Jul 2023 22:56:13 +0200
Message-Id: <20230714205623.2496590-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2799; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=V7W84rybwTdl40fJ1/AnlC1GGwwH+0UF4315YjbNZQU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBksbZmu/FZ2fPKgYn+/w94O57gxudeeMLxEF38z Ka6/i36EPaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZLG2ZgAKCRCPgPtYfRL+ Tr4aB/4kqY/a6BiMImBSLY61OyPOnkuRIsinCl91rdovh7+kgX2bxm4NOx2HpmLCkpbLgvTTGfe pVoVy7stf8h8nsV1bDVdAvTTRwse8oJGC/KcNH/sHxM3suaq6DIGhGo1Nb32+md2vc1LlWLslH2 mszcZlFV4BmYbl1jQUVOQ8KxfllFgtJPyHa/nvdjgeu2YzuxgkbzF/M2GD5dVEhcFao9uRXgbBy JgeRdj3szzC/ywFnL+GeqYi7Zi0gJ+OPi6SPnmUpUbfh1BKgTJJbF7+vSqoiSXx5vHLr3j7azgv tTi4ObF/obQigO4ODWvuMSwUJ01I3X/+sHgjtV0FaFfolv/W
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

while working on an extension for the pwm framework, I noticed that some
drivers and even the core only nearly consistently named all variables
and struct members holding a pointer to a struct pwm_chip "chip":

$ git grep -Pho 'struct pwm_chip \**[a-z0-9_]+(*nla:[\(a-z0-9_])' v6.5-rc1 | sort | uniq -c | sort -n
      1 struct pwm_chip *pwm
      1 struct pwm_chip pwm
      1 struct pwm_chip pwm_chip
      2 struct pwm_chip *_chip
      4 struct pwm_chip *c
      8 struct pwm_chip *pc
     57 struct pwm_chip chip
    358 struct pwm_chip *chip

With this series applied these are all called "chip" with one exception:
The led driver drivers/leds/rgb/leds-qcom-lpg.c uses "pwm". Maybe
"pwmchip" would be a better name, but I'm not sure that using "chip" was
an improvement there as this isn't a pure pwm driver. I'm not touching
that one.

The first offenders I found were the core and the atmel-hlcdc driver.
After I found these I optimistically assumed these were the only ones
with the unusual names and send patches for these out individually
before checking systematically.

The atmel-hlcdc patch is included here unchanged, the core patch now
also adapted the declaration of the changed functions in <linux/pwm.h>.
I marked these two as "superseded" in patchwork already.

All patches in this series are pairwise independent of each other. I
don't know if the staging patch should better go in via the greybus tree
or via pwm. Both is possible without needing coordination.

Best regards
Uwe


Uwe Kleine-König (10):
  pwm: Use a consistent name for pwm_chip pointers in the core
  pwm: atmel-hlcdc: Use consistent variable naming
  pwm: bcm-kona: Consistenly name pwm_chip variables "chip"
  pwm: crc: Consistenly name pwm_chip variables "chip"
  pwm: cros-ec: Consistenly name pwm_chip variables "chip"
  pwm: lp3943: Consistenly name pwm_chip variables "chip"
  pwm: rockchip: Consistenly name pwm_chip variables "chip"
  pwm: sifive: Consistenly name pwm_chip variables "chip"
  pwm: sl28cpld: Consistenly name pwm_chip variables "chip"
  staging: greybus: pwm: Consistenly name pwm_chip variables "chip"

 drivers/pwm/core.c            | 28 +++++++--------
 drivers/pwm/pwm-atmel-hlcdc.c | 64 +++++++++++++++++------------------
 drivers/pwm/pwm-bcm-kona.c    |  4 +--
 drivers/pwm/pwm-crc.c         |  4 +--
 drivers/pwm/pwm-cros-ec.c     | 10 +++---
 drivers/pwm/pwm-lp3943.c      |  4 +--
 drivers/pwm/pwm-rockchip.c    |  4 +--
 drivers/pwm/pwm-sifive.c      |  4 +--
 drivers/pwm/pwm-sl28cpld.c    | 10 +++---
 drivers/staging/greybus/pwm.c | 12 +++----
 include/linux/pwm.h           |  6 ++--
 11 files changed, 75 insertions(+), 75 deletions(-)

base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
-- 
2.39.2

