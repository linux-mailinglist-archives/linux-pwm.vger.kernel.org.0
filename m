Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDBE4B4401
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Feb 2022 09:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbiBNIYL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 14 Feb 2022 03:24:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiBNIYK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Feb 2022 03:24:10 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA3425C41
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 00:24:02 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nJWeO-0007jv-Da; Mon, 14 Feb 2022 09:24:00 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nJWeM-00GVbS-OO; Mon, 14 Feb 2022 09:23:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nJWeL-002szO-EQ; Mon, 14 Feb 2022 09:23:57 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 0/2] pwm: brcmstb: Some cleanups
Date:   Mon, 14 Feb 2022 09:23:52 +0100
Message-Id: <20220214082354.295451-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1622; h=from:subject; bh=fto84kaKHKYtGjBgA68m5nVML9akH99Winy3n+Av3kI=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBiChGPJ1trYkbjABiuYTY4qV6gqO0y5jdSleIa2RXI 5jWAinSJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYgoRjwAKCRDB/BR4rcrsCUifCA CY6FSI2H4lMZgqAJpE7To2pQLdmR5tels7nUB88S5F030TXoHrwAx+TIyPFhEpDzTYa+o4e5UnhX8g c6dT3rI94p7iJ0r2xUl7DfY1V6UVK2Cei2oucow/UFSyXJb/WwiTsSUhdMFGVX/Jn/q9Xi/xRiy81l J3luy7DNFYvwdbcXiG1Sir2xgDeq32rivVFNlwEqDVJe0lqn6bA7Vs4SFObVJmdgn7qAAj4Qum5deO rIBDl0AOdn/G1kqZ/QuE4uwHTENiDqLFfcvnag4hvzVmtAj7654ptAeYmqiGh/5jGKvtgm30sqcrUT sHJE0le+mdoI5TvX8jgaUF6Tt6xf5z
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

here are a few cleanups for the brcmstb PWM driver. There are a few
issues left with it, that I'm not addressing for now. Just mention it in
case someone wants to work on this driver:

 - There is no .get_state() callback
   (That needs to be implemented by some with hardware and
   documentation)

 - There are a few places where an overflow can happen in
   brcmstb_pwm_config() that are not handled

 - The loop in brcmstb_pwm_config() to calculate cword is ineffective,
   cword could be calculated ad hoc.

 - I don't understand

                /*
                 * We can be called with separate duty and period updates,
                 * so do not reject dc == 0 right away
                 */
                if (pc == PWM_PERIOD_MIN || (dc < PWM_ON_MIN && duty_ns))
                        return -EINVAL;

   The usual policy is "With the selected period, pick the biggest
   possible duty_cycle that isn't bigger thatn the requested duty_cycle.
   So should this case be handled using dc = 0 instead?
   But as I don't understand the real issue here (is this about changing
   period and duty at the same time?), I don't want to touch that.

 - The driver uses SIMPLE_DEV_PM_OPS which is deprecated.

 - The driver defines pr_fmt(fmt) but doesn't use it.

Uwe Kleine-König (2):
  pwm: brcmstb: Implement .apply() callback
  pwm: brcmstb: Remove useless locking

 drivers/pwm/pwm-brcmstb.c | 52 ++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 28 deletions(-)


base-commit: 657e54e54ba5b3859848e0ea78d6384ebb7479d6
-- 
2.34.1

