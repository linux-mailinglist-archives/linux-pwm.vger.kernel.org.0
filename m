Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43DC7F00DC
	for <lists+linux-pwm@lfdr.de>; Sat, 18 Nov 2023 17:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjKRQQr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 18 Nov 2023 11:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKRQQr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 18 Nov 2023 11:16:47 -0500
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10EEC0;
        Sat, 18 Nov 2023 08:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1700324201; bh=TbyBy9m0d9jULVS5yI832xaLc5u65iiOEGuBD5bHlNM=;
        h=From:To:Cc:Subject:Date:From;
        b=PLFePGTJYUfJsnZa+spu2rw/J58n3tZehqbv/bRSUnZ/DuNP+RpbYJnaGp7/NJMQL
         PyZ1qUnOgjFJ+hMABRcvsMdTr8UfZ73e/baUANGklXC47K38OR7kQbTWaVoWuPNTl8
         pX0gt4PfqBqOmmfPInwuONOv3YDvaOh0Nj8bxwMpaRfeIrP09MDOMC3vaYP5XJfBxV
         t3ymV/HkuJ2RGz0y9KrhmgUMP7cyLAmTylNyrEUDUhDJDQ26qs5sJ3kz3EuVaGp0qB
         1sUmRsRS+3KCGaHOVoqKUcRZauxKG2pAdfo/OECDJIJNvV8ASAkZnkGfeLkQruhI+T
         0GHMisimL0p/Q==
Received: by gofer.mess.org (Postfix, from userid 501)
        id 1FE49100105; Sat, 18 Nov 2023 16:16:41 +0000 (GMT)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1700324198; bh=TbyBy9m0d9jULVS5yI832xaLc5u65iiOEGuBD5bHlNM=;
        h=From:To:Cc:Subject:Date:From;
        b=oTGl5NKhXMTt0l+U7k+FprBUobCPuuWoIrSune/IBrfmLyF8X6c/6KgV7bPj8nZJU
         wKMt/Ral2Mc4LbFzPcjjBhNEIrjQ4pkZaqES6+cl9gtHYV/qSl+5I5XNMECt9B3G8x
         fT5+kopb22VCIU6CGH2zBrlvRHNgmU3RyX8r1Te6Sb19QEJW7zn5jlAMvVH0THgwQG
         t7kA94YYE8RcyyAfaJo6Qaq6hhUSpnn9nkO7i5Nol/TuQS57Qopm8bErazhWBbWV4C
         hCDMi5rgSjRy4a+L4W9b1P+BVEqVoh6ZQAkvUt9MamFRGFrq8xn4HHuqJBGdCNqIzk
         6foPC8AsmllEw==
Received: from bigcore.mess.org (bigcore-239.local [IPv6:2a02:8011:d000:212:ca7f:54ff:fe51:14d6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by gofer.mess.org (Postfix) with ESMTPSA id E781E100064;
        Sat, 18 Nov 2023 16:16:38 +0000 (GMT)
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Sean Young <sean@mess.org>
Subject: [PATCH v5 0/4] Improve pwm-ir-tx precision
Date:   Sat, 18 Nov 2023 16:16:16 +0000
Message-ID: <cover.1700323916.git.sean@mess.org>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The pwm-ir-tx driver has to turn the pwm signal on and off, and suffers
from delays as this is done in process context. Make this work in atomic
context.

changes:

v5:
 - Use dev_err_probe() as Uwe suggested
 - rebase

v4:
 - Split out the pwm_apply_state() rename into seperate commit
 - Atomic pwm function is called pwm_apply_atomic() and sleeping
   counterpart pwm_apply_cansleep()
 - Fix commit messages

v3:
 - Renamed pwm_apply_state() to pwm_apply_cansleep()
 - Moved pwm atomic to struct pwm_chip
 - Fixed pwm docs
 - Other minor code review comments

v2:
 - Simplified the pwm ir tx based on Ivaylo Dimitrov suggestions
 - Renamed pwm_can_sleep() to pwm_is_atomic
 - Fix sleeping issue in pwm-bcm2835 (clk_get_rate() can sleep)
 - use non_block_start() in pwm to check atomic-ness


Sean Young (4):
  pwm: rename pwm_apply_state() to pwm_apply_cansleep()
  pwm: make it possible to apply pwm changes in atomic context
  pwm: bcm2835: allow pwm driver to be used in atomic context
  media: pwm-ir-tx: trigger edges from hrtimer interrupt context

 Documentation/driver-api/pwm.rst              | 17 +++-
 .../gpu/drm/i915/display/intel_backlight.c    |  6 +-
 drivers/gpu/drm/solomon/ssd130x.c             |  2 +-
 drivers/hwmon/pwm-fan.c                       |  8 +-
 drivers/input/misc/da7280.c                   |  4 +-
 drivers/input/misc/pwm-beeper.c               |  4 +-
 drivers/input/misc/pwm-vibra.c                |  8 +-
 drivers/leds/leds-pwm.c                       |  2 +-
 drivers/leds/rgb/leds-pwm-multicolor.c        |  4 +-
 drivers/media/rc/pwm-ir-tx.c                  | 83 +++++++++++++++++--
 drivers/platform/x86/lenovo-yogabook.c        |  2 +-
 drivers/pwm/core.c                            | 75 +++++++++++++----
 drivers/pwm/pwm-bcm2835.c                     | 31 ++++---
 drivers/pwm/pwm-renesas-tpu.c                 |  1 -
 drivers/pwm/pwm-twl-led.c                     |  2 +-
 drivers/pwm/pwm-vt8500.c                      |  2 +-
 drivers/pwm/sysfs.c                           | 10 +--
 drivers/regulator/pwm-regulator.c             |  4 +-
 drivers/video/backlight/lm3630a_bl.c          |  2 +-
 drivers/video/backlight/lp855x_bl.c           |  2 +-
 drivers/video/backlight/pwm_bl.c              | 12 +--
 drivers/video/fbdev/ssd1307fb.c               |  2 +-
 include/linux/pwm.h                           | 57 +++++++++----
 23 files changed, 248 insertions(+), 92 deletions(-)

-- 
2.42.1

