Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 566C0442A63
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Nov 2021 10:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbhKBJas (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 2 Nov 2021 05:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhKBJas (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 2 Nov 2021 05:30:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D605C061714
        for <linux-pwm@vger.kernel.org>; Tue,  2 Nov 2021 02:28:13 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mhq5T-00034z-GW; Tue, 02 Nov 2021 10:28:11 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mhq5O-0008TI-76; Tue, 02 Nov 2021 10:28:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mhq5O-0005HR-65; Tue, 02 Nov 2021 10:28:06 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        Tony Prisk <linux@prisktech.co.nz>
Subject: [PATCH 0/2] pwm: vt8500: Implement .apply() callback
Date:   Tue,  2 Nov 2021 10:28:02 +0100
Message-Id: <20211102092804.296089-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

this series implements .apply for the vt8500 pwm driver and fixes a
function name that I stumbled over while doing that.

One thing that could be improved (but probably only with hardware
available which I don't have) is:

 - vt8500_pwm_apply() calls the old callbacks now, it might be possible
   to improve clk handling such that the clk is at most once enabled and
   once disabled.

 - .probe() doesn't handle the PWM already being on.

 - There is no .get_state() callback.

Best regards
Uwe

Uwe Kleine-König (2):
  pwm: vt8500: Implement .apply() callback
  pwm: vt8500: Rename pwm_busy_wait() to make it obviously
    driver-specific

 drivers/pwm/pwm-vt8500.c | 73 +++++++++++++++++++++++++++++++---------
 1 file changed, 58 insertions(+), 15 deletions(-)


base-commit: 8bb7eca972ad531c9b149c0a51ab43a417385813
-- 
2.30.2

