Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948475087DC
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Apr 2022 14:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352795AbiDTMPt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 20 Apr 2022 08:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352934AbiDTMPn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 20 Apr 2022 08:15:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096C0403C6
        for <linux-pwm@vger.kernel.org>; Wed, 20 Apr 2022 05:12:58 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nh9CT-00022F-QD; Wed, 20 Apr 2022 14:12:50 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nh9CT-0049d6-GR; Wed, 20 Apr 2022 14:12:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nh9CR-004TjM-6T; Wed, 20 Apr 2022 14:12:47 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-renesas-soc@vger.kernel.org, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v2 0/6] pwm: renesas-tpu: Various improvements
Date:   Wed, 20 Apr 2022 14:12:34 +0200
Message-Id: <20220420121240.67781-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1220; h=from:subject; bh=opyfJ7S5Ryxq8QbdPqxRSrC9QkGpuJslluznrZ+FBbw=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBiX/ifjLukT+1ISHUjQ98UEVjMqkzR5uDe0RrqBSDP 8SPM6G6JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYl/4nwAKCRDB/BR4rcrsCaEmB/ 9zazWz6PUUTFaiN2N5wIhBHSWWIwNvHKXUVH5j/Ghq+EVL6bz3QylH1ZudOFgVCPnb9vI81dobFHBI v66zEI2AbsvnA9H92dmZ8sjIsHuhbQQgH29hJQfHIm2roeAne054lDs4EiESkkM4a12OhXJAkWtl46 VyUUhApnDBx1krVa2vS5j9VMFGRQFIpPgDwqiCya2Du/oZ6gMbg+ZucuVhoUDzB+rW/LyaOLADEuG1 1aQfTOvQ+lf53OeolyxI7Ml5M4GvYV6z+uoKXKUM9n8aVCCiwhEzneo7rPePNWw8qeIJFIa+VK6gdo vMQQWMhMtoJs9kZgGOfUcYTP9UACqz
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

I reworked the series to improve the renesas-tpu PWM driver after
feedback I got from Geert. The changes are:

 - Add Geert's tags for the first two patches
   (I didn't add them for the other patches as I changed these enough to
   not carry the tags forward.)
 - Use tpu_pwm_disable instead chip->ops->disable (which is NULL now)
   fixing a crash in v1.
 - The calculation now uses a switch instead of ilog2.
   Looking at the compiled code for ARM this is more effective and I
   assume the same holds true for other platforms.

Thanks again to Geert for his valuable feedback and testing.

Best regards
Uwe

Uwe Kleine-König (6):
  pwm: renesas-tpu: Make use of dev_err_probe()
  pwm: renesas-tpu: Make use of devm functions
  pwm: renesas-tpu: Implement .apply() callback
  pwm: renesas-tpu: Rename variables to match the usual naming
  pwm: renesas-tpu: Improve maths to compute register settings
  pwm: renesas-tpu: Improve precision of period and duty_cycle
    calculation

 drivers/pwm/pwm-renesas-tpu.c | 317 +++++++++++++++++++---------------
 1 file changed, 180 insertions(+), 137 deletions(-)


base-commit: 3123109284176b1532874591f7c81f3837bbdc17
-- 
2.35.1

