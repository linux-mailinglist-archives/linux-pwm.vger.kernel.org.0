Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0BB3B8E2A
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Jul 2021 09:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhGAHcE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 1 Jul 2021 03:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234733AbhGAHcE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 1 Jul 2021 03:32:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2157DC0617A8
        for <linux-pwm@vger.kernel.org>; Thu,  1 Jul 2021 00:29:33 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lyr8c-00038x-Ot; Thu, 01 Jul 2021 09:29:30 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lyr8b-0006xy-Ht; Thu, 01 Jul 2021 09:29:29 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 0/3] pwm: Some improvements for legacy drivers
Date:   Thu,  1 Jul 2021 09:29:24 +0200
Message-Id: <20210701072927.328254-1-u.kleine-koenig@pengutronix.de>
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

Hello,

this is the successor of my earlier patch "pwm: Ensure for legacy
drivers that pwm->state stays consistent" that was applied shortly to
next until Geert found a problem with it.

I split the patch in three parts now: First the legacy handling is just
moved to a separate function without any semantic change. Then a glitch
is fixed, but without the regression I introduced initially. In the
third and last patch the longstanding FIXME about breaking pwm->state if
a callback fails is addressed.

Uwe Kleine-König (3):
  pwm: Move legacy driver handling into a dedicated function
  pwm: Prevent a glitch for legacy drivers
  pwm: Restore initial state if a legacy callback fails

 drivers/pwm/core.c | 139 ++++++++++++++++++++++++++-------------------
 1 file changed, 79 insertions(+), 60 deletions(-)


base-commit: 6efb943b8616ec53a5e444193dccf1af9ad627b5
-- 
2.30.2

