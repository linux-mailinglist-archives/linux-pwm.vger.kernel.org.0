Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9509F747F0A
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Jul 2023 10:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbjGEIHO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 5 Jul 2023 04:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbjGEIHM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 5 Jul 2023 04:07:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690C11712
        for <linux-pwm@vger.kernel.org>; Wed,  5 Jul 2023 01:07:10 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qGxXO-0003pD-SO; Wed, 05 Jul 2023 10:06:58 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qGxXM-00CDNB-2g; Wed, 05 Jul 2023 10:06:56 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qGxXK-002Oar-Ns; Wed, 05 Jul 2023 10:06:54 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        linux-mips@vger.kernel.org, Lee Jones <lee@kernel.org>,
        George Stark <gnstark@sberdevices.ru>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        chrome-platform@lists.linux.dev
Subject: [PATCH v2 0/8] pwm: Get rid of pwm_[sg]et_chip_data()
Date:   Wed,  5 Jul 2023 10:06:42 +0200
Message-Id: <20230705080650.2353391-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2092; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=u4Z0GmFDTWtwLEP2HHVUlz+BVemZihHRxz0BXPl6pMI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkpSSMvXlGQ8oFjDHYdRsE/iDjQCfYp2AvrCWKK 1aP+qcQUR6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZKUkjAAKCRCPgPtYfRL+ TraOCACTPjXf8+TAzBnVeOY7qqFplcSzgSgICZsqqtlos7gZT1+KW9Ny9RQDN16wMQ6Q7ucg1Cp +xFa51wLHF5Pue9cn2xpppSO9+qXH416dIReCQRsf8l4tmegE796e7fzJ55unuda3e6Vit09PWg CiM5Xj5xbFu0o6f7erCJ+Vbt8jSTZAk5TQ7gN2TkJcsM3nh61vV/8fLZfoYK1VGomOr/e3wpc/8 43HfjI5oXyvs/4QjD9elp2Lf5aHTb4ytfeGkK4IyPd8G0epIhAGSPzoCBKgmjsCGaLIO5ne/am+ HiBadheZ/OiUvvU2Mus0sJLrzabNCCgTCK2oEuojih0o7QQo
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

Hello,

the changes since (implicit) v1 of this series[1] are:

 - Consistently write "per-channel" in the short log.
 - [jz4740] Make use of struct_size(), thanks to Paul Cercueil for
   pointing that out.
 - [cros-ec] Add missing kernel-doc for new struct member, thanks to
   Tzung-Bi Shih for pointing that out.
 - [cros-ec] Make use of devm_kcalloc.
 - [jz4740] Add Reviewed-by tag for Philippe Mathieu-Daudé.
 - [cros-ec] Add Reviewed-by tag for Tzung-Bi Shih.

The first seven patches have no interdependencies, the last depends on
all others.

The sti driver has two problems that are fixed by patch #6. You could
apply it earlier already, but given that the issues are already old
there is IMHO no urge.




[1] https://lore.kernel.org/linux-pwm/20230629094839.757092-1-u.kleine-koenig@pengutronix.de
[2] The newer issue was introduced with e926b12c611c ("pwm: Clear
    chip_data in pwm_put()") for v5.2-rc1 in May 2019.

Uwe Kleine-König (8):
  pwm: berlin: Put per-channel config into driver data
  pwm: samsung: Put per-channel data into driver data
  pwm: jz4740: Put per-channel clk into driver data
  pwm: lp3943: Drop usage of pwm_[gs]et_chip_data()
  pwm: renesas: Drop usage of pwm_[gs]et_chip_data()
  pwm: sti: Reduce number of allocations and drop usage of chip_data
  pwm: cros-ec: Put per-channel data into driver data
  pwm: Drop pwm_[sg]et_chip_data()

 drivers/pwm/core.c            | 31 -----------------------------
 drivers/pwm/pwm-berlin.c      | 37 ++++++-----------------------------
 drivers/pwm/pwm-cros-ec.c     | 33 +++++++++----------------------
 drivers/pwm/pwm-jz4740.c      | 11 +++++++----
 drivers/pwm/pwm-lp3943.c      | 21 +++++++-------------
 drivers/pwm/pwm-renesas-tpu.c | 22 ++++++++++-----------
 drivers/pwm/pwm-samsung.c     | 20 +++++--------------
 drivers/pwm/pwm-sti.c         | 29 +++++++++++++--------------
 include/linux/pwm.h           | 14 -------------
 9 files changed, 59 insertions(+), 159 deletions(-)


base-commit: 92554cdd428fce212d2a71a06939e7cab90f7c77
-- 
2.39.2

