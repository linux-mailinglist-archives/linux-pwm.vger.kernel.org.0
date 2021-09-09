Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207E1404805
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Sep 2021 11:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbhIIJuI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Sep 2021 05:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbhIIJuG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Sep 2021 05:50:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7844BC061575
        for <linux-pwm@vger.kernel.org>; Thu,  9 Sep 2021 02:48:57 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mOGfv-0000GQ-DX; Thu, 09 Sep 2021 11:48:55 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mOGft-0007fP-K6; Thu, 09 Sep 2021 11:48:53 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mOGft-0005mw-It; Thu, 09 Sep 2021 11:48:53 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH 0/2] pwm: add might_sleep annotations
Date:   Thu,  9 Sep 2021 11:48:47 +0200
Message-Id: <20210909094849.313936-1-u.kleine-koenig@pengutronix.de>
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

earlier today I noticed that the samsung PWM driver uses
spin_lock_irqsave() which made me wonder if the PWM functions are used
in atomic context at all. To find out I suggest adding a might_sleep()
and look if anyone complains.

The first patch should be indisputable, if you know a valid atomic use
case for pwm_apply_state, please speak up (which would make the second
patch wrong).

Best regards
Uwe

Uwe Kleine-König (2):
  pwm: Add might_sleep() annotations for !CONFIG_PWM API functions
  pwm: Make it explicit that pwm_apply_state() might sleep

 drivers/pwm/core.c  |  9 +++++++++
 include/linux/pwm.h | 13 +++++++++++++
 2 files changed, 22 insertions(+)


base-commit: 3f2b16734914fa7c53ef7f8a10a63828890dbd37
-- 
2.30.2

