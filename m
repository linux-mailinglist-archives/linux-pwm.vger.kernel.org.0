Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCA675847E
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jul 2023 20:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjGRST3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 18 Jul 2023 14:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjGRST2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 18 Jul 2023 14:19:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FECF0
        for <linux-pwm@vger.kernel.org>; Tue, 18 Jul 2023 11:19:25 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHp-0001nt-Mw; Tue, 18 Jul 2023 20:19:01 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHj-000QmT-V6; Tue, 18 Jul 2023 20:18:55 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHj-005unQ-2j; Tue, 18 Jul 2023 20:18:55 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        James Clark <james.clark@arm.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Vladimir Zapolskiy <vz@mleia.com>,
        =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-doc@vger.kernel.org, kernel@pengutronix.de,
        linux-pwm@vger.kernel.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-mips@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        Wolfram Sang <wsa@kernel.org>
Subject: [PATCH 00/18] pwm: Provide devm_pwmchip_alloc() function
Date:   Tue, 18 Jul 2023 20:18:31 +0200
Message-Id: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=7254; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=AxfhHB+fj8t4rKmZJukUKFb5Sqv1bFVe4073b7F6ck8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkttbnsyazXoY5AyJi9CUCvzEzscD5RBfgEwDVu VerhHjJzZeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZLbW5wAKCRCPgPtYfRL+ Tr3xCACcU04pnKPPnWb1xNYxGVIeETJrNq96AlZYktxEZpHV+g+4bjLTFR9Y3UETN+L3L/B4neP Bstfhxzb35BgXjja9zHTiqSbbQn3pGGwcUldCkZVLZ6EqIThVWpLZhnX+RsFoRvAsNYr2KgICU9 f9uLIQ9AfYjttFTCOK4UJyIZ+iAcv/NFSz1YSHzX13bitcZLgHYA8f78KypxlA51Z+bgL2QXBYU cSvmkhM8ja8cS3cgTTsP/lIm8bP8gkIrSA0PoZmO/GitlNN63nQ3Aomc3yZnb0k6qyvgyUplxcR jtzp4AEKi8UXfPNh8tfWLpYJJxGCbVUQNnVT5C/9u7DyMXE3
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

my eventual goal is to provide a chardev API to PWMs similar to the gpioctl
API. For that to work flawlessly it's required that a pwmchip stays
around while the corresponding device is opened even if the respective
lowlevel driver goes away. See Wolfram's EOSS talk[1] for some more
details.

This series provides a new function devm_pwmchip_alloc() that allocates
a struct pwm_chip together with driver data. Currently this is still
using devm_kzalloc and so goes away when the device is unbound from the
driver. However this can be changed without having to touch all drivers
again.

The function devm_pwmchip_alloc() is modelled after similar functions
from spi, counter and networking code. The first patch provides the
allocator function and an accessor for driver data, the following
patches convert a subset of the available drivers to this new API.

The series is fully bisectable and the only interdependency is that
patch #1 is needed for all other patches. The idea is to complete
conversion of all remaining drivers and then add a struct device to
struct pwm_chip and so make pwm_chip reference counted. There are still
a few more drivers to convert, but I thought to send out the current
patch set to get some early feedback.

The base for this series is v6.5-rc1 plus the following series:

[PATCH v2 0/8] pwm: Get rid of pwm_[sg]et_chip_data()
        20230705080650.2353391-1-u.kleine-koenig@pengutronix.de
[PATCH 0/2] pwm: stm32: A (small) fix and a cleanup
        20230713155142.2454010-1-u.kleine-koenig@pengutronix.de
[PATCH 00/10] pwm: Constistenly name pwm_chip variables "chip"
        20230714205623.2496590-1-u.kleine-koenig@pengutronix.de
[PATCH] staging: greybus: pwm: Drop unused member from driver struct
        20230714201622.2490792-1-u.kleine-koenig@pengutronix.de
[PATCH] pwm: lpc18xx-sct: Simplify using devm_clk_get_enabled()
        20230718144128.371818-1-u.kleine-koenig@pengutronix.de
[PATCH] pwm: lpc32xx: remove handling of PWM channels
        20230717155257.2568627-1-u.kleine-koenig@pengutronix.de
[PATCH] pwm: pxa: Don't reimplement of_device_get_match_data()
        20230718150657.1728166-1-u.kleine-koenig@pengutronix.de
[PATCH] pwm: ntxec: Drop a write-only variable from driver data
        20230718152327.2583886-1-u.kleine-koenig@pengutronix.de
[PATCH] gpio: mvebu: Make use of devm_pwmchip_add
        20230717142743.2555739-1-u.kleine-koenig@pengutronix.de
[PATCH] pwm: ntxec: Use device_set_of_node_from_dev()
        20230718175310.3946687-1-u.kleine-koenig@pengutronix.de
[PATCH] pwm: berlin: Simplify using devm functions
        20230718175545.3946935-1-u.kleine-koenig@pengutronix.de

I'm not sure the build bots can properly handle that, so it would be
great to get these base series into next soon.

Best regards
Uwe

[1] https://static.sched.com/hosted_files/eoss2023/e3/LifecycleIssues_WolframSang_2023.pdf

Uwe Kleine-König (18):
  pwm: Provide devm_pwmchip_alloc() function
  pwm: ab8500: Make use of devm_pwmchip_alloc() function
  pwm: apple: Make use of devm_pwmchip_alloc() function
  pwm: berlin: Make use of devm_pwmchip_alloc() function
  pwm: clk: Make use of devm_pwmchip_alloc() function
  pwm: fsl-ftm: Make use of devm_pwmchip_alloc() function
  pwm: hibvt: Make use of devm_pwmchip_alloc() function
  pwm: imx1: Make use of devm_pwmchip_alloc() function
  pwm: imx27: Make use of devm_pwmchip_alloc() function
  pwm: jz4740: Make use of devm_pwmchip_alloc() function
  pwm: keembay: Make use of devm_pwmchip_alloc() function
  pwm: lpc18xx-sct: Make use of devm_pwmchip_alloc() function
  pwm: lpc32xx: Make use of devm_pwmchip_alloc() function
  pwm: mxs: Make use of devm_pwmchip_alloc() function
  pwm: ntxec: Make use of devm_pwmchip_alloc() function
  pwm: pxa: Make use of devm_pwmchip_alloc() function
  pwm: stm32: Make use of devm_pwmchip_alloc() function
  gpio: mvebu: Make use of devm_pwmchip_alloc() function

 .../driver-api/driver-model/devres.rst        |  1 +
 Documentation/driver-api/pwm.rst              | 10 ++--
 drivers/gpio/gpio-mvebu.c                     | 17 +++----
 drivers/pwm/core.c                            | 23 +++++++++
 drivers/pwm/pwm-ab8500.c                      | 17 +++----
 drivers/pwm/pwm-apple.c                       | 17 +++----
 drivers/pwm/pwm-berlin.c                      | 28 ++++++-----
 drivers/pwm/pwm-clk.c                         | 26 +++++-----
 drivers/pwm/pwm-fsl-ftm.c                     | 47 ++++++++++---------
 drivers/pwm/pwm-hibvt.c                       | 26 +++++-----
 drivers/pwm/pwm-imx1.c                        | 16 +++----
 drivers/pwm/pwm-imx27.c                       | 19 ++++----
 drivers/pwm/pwm-jz4740.c                      | 25 +++++-----
 drivers/pwm/pwm-keembay.c                     | 16 +++----
 drivers/pwm/pwm-lpc18xx-sct.c                 | 24 +++++-----
 drivers/pwm/pwm-lpc32xx.c                     | 18 +++----
 drivers/pwm/pwm-mxs.c                         | 19 ++++----
 drivers/pwm/pwm-ntxec.c                       | 27 +++++------
 drivers/pwm/pwm-pxa.c                         | 20 ++++----
 drivers/pwm/pwm-stm32.c                       | 42 +++++++++++------
 include/linux/pwm.h                           |  4 ++
 21 files changed, 249 insertions(+), 193 deletions(-)


base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
prerequisite-patch-id: c856e0baabfc22d250b7ce881427cdb74613e69a
prerequisite-patch-id: 2a5f9c04e4b5794b5a5d0b30280f75b76a05092b
prerequisite-patch-id: a48b05b94b61f8029b4bb9a78ae1f2cd8c476d80
prerequisite-patch-id: c7dfd3798f024b27b6e236da1eae40b79bb3e281
prerequisite-patch-id: 313ada72ab57438a8d54df0df9c0926bb4f69b36
prerequisite-patch-id: 318824c08f3e7d6500e3c5a47a11c5daffaea34a
prerequisite-patch-id: ea75bfd48ea4d0132c637172564bc1a57061377a
prerequisite-patch-id: 278b25a8d5fef49f7e5c46b627d4862d0b24baaf
prerequisite-patch-id: a3b11e0a7c8f6564e668e2ed1b637351e5fd9dd2
prerequisite-patch-id: 55588b25ea7ce69d716a33a7aaed662d75bb9687
prerequisite-patch-id: 399d7e94bafc5dc970a0f213745e4982066b8583
prerequisite-patch-id: 87aca1beb6efdaab95ddce7e2d9eed89a89252a1
prerequisite-patch-id: e13e3db807f2c5b49180e24492f496f8e945e42d
prerequisite-patch-id: 8712b17dee2a5f2441908e2de260ceec8ce6ff37
prerequisite-patch-id: 987b0a351801b1e361932beeeedbc5245540037c
prerequisite-patch-id: 869d3932983f3ae6a8982e186b27df11c56e9e5e
prerequisite-patch-id: 4f60b0afb435011b58b7cc6bead1d385db7d8e11
prerequisite-patch-id: 0e86da52c02300d407d4c0b6f2b9f8293e3320dc
prerequisite-patch-id: a731856f5d7dee7f3465f021e5c56981a803b22d
prerequisite-patch-id: b759d036cf578083ec76aa7ba01dd8643667d4f6
prerequisite-patch-id: 9abd8b16e74625e2630655da7d22e75bbe0c6231
prerequisite-patch-id: 6ad03ceb505a293f2308235161c54ff6b508e59f
prerequisite-patch-id: cb6d75be9b72cc04069b6952ba9e5ac80a26a1ab
prerequisite-patch-id: c8fa7296a736f42ec49ab1334cb19947d647a2b4
prerequisite-patch-id: b601ea695815fb65ed704349302ba66442277fc3
prerequisite-patch-id: 7a0daa2918f8a317333e57c1d1698078a1968720
prerequisite-patch-id: b6762f6deeb74aaf73afe2d8dd816d48cec4e1ee
prerequisite-patch-id: a0c8d63424241e64c3e5f9991ea04018a51fcc94
-- 
2.39.2

