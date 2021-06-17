Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCD43AB049
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Jun 2021 11:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhFQJyG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Jun 2021 05:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhFQJyG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Jun 2021 05:54:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F38EC061574
        for <linux-pwm@vger.kernel.org>; Thu, 17 Jun 2021 02:51:58 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ltogm-0007OL-C6; Thu, 17 Jun 2021 11:51:56 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ltogl-0005N6-Hi; Thu, 17 Jun 2021 11:51:55 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v1 0/6] pwm: tegra: several improvements
Date:   Thu, 17 Jun 2021 11:51:39 +0200
Message-Id: <20210617095145.163694-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This series improves the tegra-pwm driver. There are a few problems left though:

 - if the PWM is configured to a 100% duty cycle it writes bit 24 which is
   either bogus or needs a comment.

 - clock handling is broken: If pwm_disable() is called without calling
   pwm_enable() before, this triggers a warning in clk_disable(). This also 
   might trigger a HW fault as the register is accessed without enabling the
   clock first.

 - The calculation of period and duty_cycle is imprecise as it divides by the
   result of a division and it discards relevant bits from pc->clk_rate without
   rounding. (I bet there are more problems, I only checked quickly
   trying to implement .get_state(), but I gave up.)

I didn't address these because I have neither any hardware to test nor
documentation. So this series is only compile tested.

Best regards
Uwe

Uwe Kleine-König (6):
  pwm: tegra: Drop an if block with an always false condition
  pwm: tegra: Don't modify HW state in .remove callback
  pwm: tegra: Don't needlessly enable and disable the clock in .remove()
  pwm: tegra: Assert reset only after the PWM was unregistered
  pwm: tegra: Implement .apply callback
  pwm: tegra: unfold legacy callbacks into tegra_pwm_apply()

 drivers/pwm/pwm-tegra.c | 246 ++++++++++++++++++----------------------
 1 file changed, 112 insertions(+), 134 deletions(-)

-- 
2.30.2

