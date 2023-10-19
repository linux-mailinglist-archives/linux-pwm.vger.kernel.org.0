Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FEC7D0304
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Oct 2023 22:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjJSUH4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 19 Oct 2023 16:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235532AbjJSUHz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 19 Oct 2023 16:07:55 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E6A12D
        for <linux-pwm@vger.kernel.org>; Thu, 19 Oct 2023 13:07:52 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qtZJ6-0000Af-V6; Thu, 19 Oct 2023 22:07:48 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qtZJ5-002rfp-9F; Thu, 19 Oct 2023 22:07:47 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qtZJ4-001ve0-W0; Thu, 19 Oct 2023 22:07:47 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 0/5] pwm: stm32: Cleanups, get_state() and proper hw take over 
Date:   Thu, 19 Oct 2023 22:06:59 +0200
Message-ID: <20231019200658.1754190-7-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=962; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=SfkOOu4xgfaM/hozY/FdeBH1secC/s7CyzGx/50FQpc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlMYxioDQkrC8dFLuY+p314hq7oHwBjo2vCmYsU hq+LOuoHwCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZTGMYgAKCRCPgPtYfRL+ TnEVCACrZ8wLtZBRX2W64BhKcFJbJ1JMRPVmUvkOB6ZU0RKLsXYyHsbm2fbrwohmIZe3En93F2C RTvFMa3MOPQLddOjaUG7WaF+iYBXyN5opMn2Xb9uYTxRpzpbQVeH9qzVuShb/1j7ZoAg3kpwNlA fqUMGj3ZkNSNR2HRaYBPhTMTp8CknsK3Ig2il8hZY/wmK/qFxjcM7ZCupUo4hO1d+WOOVfn3x4y 7GSvLyfNhMjbAwEe9+R+YXnn5NFIccznZWHTlvd8Hc10CVfO+v0uHtrTZbfTFDjIWFlh9hhf3ix AIrfkUJDGvYCQpOT5DXp0lSaWjK4kYBnB0PPYJIiJ1vhHxrz
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

some time ago Philipp already sent an implementation of .get_state() for
the stm32 PWM driver. He created this series from the feedback but
didn't come around to send it out. The goal of this series is to allow
to take over a pwm-backlight from the bootloader without flickering on
an stm32mp157 based machine.

The only thing I did here to Philipp's series was to split one of the
patches in two. Philipp had the contents of patches 4 and 5 in a single
patch.

Best regards
Uwe

Philipp Zabel (5):
  pwm: stm32: Replace write_ccrx with regmap_write
  pwm: stm32: Make ch parameter unsigned
  pwm: stm32: Use hweight32 in stm32_pwm_detect_channels
  pwm: stm32: Implement .get_state()
  pwm: stm32: Fix enable count for clk in .probe()

 drivers/pwm/pwm-stm32.c | 98 +++++++++++++++++++++++++----------------
 1 file changed, 61 insertions(+), 37 deletions(-)

base-commit: 4bb36d126cb3147d6bbfd00242a5b846dacad595
-- 
2.42.0

