Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9AA742376
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Jun 2023 11:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjF2JtF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 29 Jun 2023 05:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjF2JtB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 29 Jun 2023 05:49:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811A42682
        for <linux-pwm@vger.kernel.org>; Thu, 29 Jun 2023 02:49:00 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qEoGj-0006UO-Aj; Thu, 29 Jun 2023 11:48:53 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qEoGf-00Arnv-Fd; Thu, 29 Jun 2023 11:48:49 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qEoGe-000kwe-N9; Thu, 29 Jun 2023 11:48:48 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Benson Leung <bleung@chromium.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        linux-mips@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev
Subject: [PATCH 0/8] pwm: Get rid of pwm_[sg]et_chip_data()
Date:   Thu, 29 Jun 2023 11:48:31 +0200
Message-Id: <20230629094839.757092-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1592; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=vTBoe0szjeRFsJmSFfrm4GaXs0V1pmwEr32Z/7UAAN8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBknVNk4mOQNpCLEXK0ne8XaGGCwFjHjCatJMuWf 3M1nytIn7yJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZJ1TZAAKCRCPgPtYfRL+ TqhrCACxH7/c/rG9EsJOq2kZfE8KqdHhgxYFZnTCfLZSdCPc2S4dwMBYBati++HUbOlkNjrLmlY RRdUW82a6HKM0TtRQUqNpUPPNAOvLm7/YKQskKdnhKgz1sbCEqt2smiDaTHieSrjnO1AE0WHYVj /K2bmL7vh5yvazlD7JlSjE97/dWf84YH68ZME+qblM1N7GGVvZMrEboKeS6cr8zAm9Ur8X29P3i 4s0FjnZ7PP2R3r73RyP/LdwTPrpH56rF6kVtZBL4IWWQUGNS70Ntx+kKXGCE12boRR6Au3hvyaU bKrEc++TeAMhO9tOV/V1SR2pdkgr5xf0Ao3SHG0dL8ctiIB5
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

the semantic of pwm_[sg]et_chip_data() overlaps with that of the
standard dev_[sg]et_drvdata() functions. Also as noted by George Stark
there is a problem in pwm-sti that relies on chipdata being available
even after a pwm_put (which clears chipdata).

To improve the situation this series converts all drivers that make use
of pwm chipdata to use well-known driver data instead and drop chipdata
support from the pwm framework.

Best regards
Uwe

Uwe Kleine-König (8):
  pwm: berlin: Put channel config into driver data
  pwm: samsung: Put channel data into driver data
  pwm: jz4740: Put per-channel clk into driver data
  pwm: lp3943: Drop usage of pwm_[gs]et_chip_data()
  pwm: renesas: Drop usage of pwm_[gs]et_chip_data()
  pwm: sti: Reduce number of allocations and drop usage of chip_data
  pwm: cros-ec: Put per channel data into driver data
  pwm: Drop pwm_[sg]et_chip_data()

 drivers/pwm/core.c            | 31 -----------------------------
 drivers/pwm/pwm-berlin.c      | 37 ++++++-----------------------------
 drivers/pwm/pwm-cros-ec.c     | 31 +++++++----------------------
 drivers/pwm/pwm-jz4740.c      | 11 +++++++----
 drivers/pwm/pwm-lp3943.c      | 21 +++++++-------------
 drivers/pwm/pwm-renesas-tpu.c | 22 ++++++++++-----------
 drivers/pwm/pwm-samsung.c     | 20 +++++--------------
 drivers/pwm/pwm-sti.c         | 29 +++++++++++++--------------
 include/linux/pwm.h           | 14 -------------
 9 files changed, 57 insertions(+), 159 deletions(-)


base-commit: 92554cdd428fce212d2a71a06939e7cab90f7c77
-- 
2.39.2

