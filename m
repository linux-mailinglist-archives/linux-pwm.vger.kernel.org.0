Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA900766FF2
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Jul 2023 16:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236388AbjG1O6t (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Jul 2023 10:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235290AbjG1O6t (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Jul 2023 10:58:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7A82688
        for <linux-pwm@vger.kernel.org>; Fri, 28 Jul 2023 07:58:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qPOvL-00030M-Om; Fri, 28 Jul 2023 16:58:36 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qPOvH-002jO6-Bc; Fri, 28 Jul 2023 16:58:31 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qPOvG-008WkJ-Mm; Fri, 28 Jul 2023 16:58:30 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Javier Martinez Canillas <javierm@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jilin Yuan <yuanjilin@cdjrlc.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, kernel@pengutronix.de,
        linux-fbdev@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH 0/3] pwm: Drop useless member "pwm" from struct pwm_device
Date:   Fri, 28 Jul 2023 16:58:21 +0200
Message-Id: <20230728145824.616687-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1462; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=GgA+H1Gx/aannDv0LuSsWcVQWboA8zqkq9tUQR7Z/Sw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkw9eH3uUGN77+Vb2x0Jv1uy0u6Gs5UinZWoelT nMFN7o49rSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZMPXhwAKCRCPgPtYfRL+ TlJOB/45E9Q/4YPkfxStlxoyeLTuVRuH3gCksc56vWUC2p4S/LuW3GOQQzq1xi2EwE66OsCSdi5 oE2B1dcsd31s5x+P4tB+7A5+Jsjq/x4VCYiYn9BlFnVIHYIMrqKBrwFY5AZMl55B53uEa/ynhLD JEf0q4Frgt5btp9o90ShFYe7OpSv0fdbzB3evwhMLclXCgwP+DfsKys6+3BcIOhgx7BwvICH4RD 81/v6GV0JYh5qDmjAzXB7NYl0fMsp5Gv0qtIb4qLsKen6I6N84u0smJOeslMRHdplem6tIlCLYr rLyh0AiI1GHnbAtO3h5JMge8iikd4V1ytdj0ss/OOMvnJvQR
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

there are only two users of struct pwm_device::pwm in the tree; both use
it for some dev_dbg output. While this number allows to identify the
PWM, it's not trivial, for example the data currently available in
/sys/kernel/debug/pwm isn't enough. (You have to look in /sys/class/pwm,
pick the pwmchip with the highest number that isn't bigger than the
PWM's number.)

To be honest the label isn't always usefull either, but it's easy to use
and should be enough to identify the used PWM. The parent device + hwid
might be more useful?! On the other hand using that for a dev_dbg that
is probably only looked at by someone debugging the driver and thus
knowing the used PWM anyhow is of little value either.

Assuming this change is still considered worthwile I suggest that patches #1
and #2 go in via their respective maintainer trees and I resend patch #3 to go
via the pwm tree once these two are "in".

Best regards
Uwe

Uwe Kleine-König (3):
  drm/ssd130x: Print the PWM's label instead of its number
  video: fbdev: ssd1307fb: Print the PWM's label instead of its number
  pwm: Drop unused member "pwm" from struct pwm_device

 drivers/gpu/drm/solomon/ssd130x.c | 4 ++--
 drivers/pwm/core.c                | 1 -
 drivers/video/fbdev/ssd1307fb.c   | 4 ++--
 include/linux/pwm.h               | 1 -
 4 files changed, 4 insertions(+), 6 deletions(-)

base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
-- 
2.39.2

