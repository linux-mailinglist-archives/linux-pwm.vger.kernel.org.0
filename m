Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078357D936F
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Oct 2023 11:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjJ0JV2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 27 Oct 2023 05:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjJ0JV1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 27 Oct 2023 05:21:27 -0400
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198D5187;
        Fri, 27 Oct 2023 02:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1698398481; bh=MMsc7TfO6KKWgcdZUBImYN8muUXO0P+KGh9hoBHNO8w=;
        h=From:To:Cc:Subject:Date:From;
        b=BfXtVvhlXF8Kgq7ho38Sk/7tvKQ8qRthu1KMANflbSBnGrrm9S4lExvBZOrduodhf
         fWYNmg8yb6ExN/Fhco8riE/8ix8YJUsIeWbJuSfIKr4ftfwB30r63RNF1cVH92m//a
         ShXq+baA9+saGNL4LWRSxEnTRabuhYlpB9Nw1PmcxtPb53dknbJvaNyl9lqhbKG8Dm
         SdyfMWT/7ZLMjuv3kORc5ay+rd9+1qX0zB14GX5AQnelHLhOtW+YsEuzX6NwY0TaKR
         QbkfVQZTAf5/kvVHUIPXLVJ7SmMLGJl1eFu4qt2+gslORTxNnFZnzXtL6MrmzdMBQe
         CUdKD6CLZKnlA==
Received: by gofer.mess.org (Postfix, from userid 501)
        id B73541000C2; Fri, 27 Oct 2023 10:21:21 +0100 (BST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1698398480; bh=MMsc7TfO6KKWgcdZUBImYN8muUXO0P+KGh9hoBHNO8w=;
        h=From:To:Cc:Subject:Date:From;
        b=C3GyALXmyfs/HVwPl+btP/LqSOtOzxceEqg7J3oROCbhfp9t3uOLOsxCpAqz6Exn2
         M3Yh+8DVi+ij9m/l0QLlWcWbS7FOZMuDbu76zN3vplLLrLcRetpETf/uIWm/zq9tlN
         uR0nT5HI9It5TiqgkGU5MAsdH119WISfYw+AJ6mK45sb6sInMVmcSgXY9Hrz1FetIq
         Vo9SGp275DBcSNyDdFOrDWf9580LFHFXREueGFwAXHNOBn+E626YShs++2klcPZYrW
         DNUentSNEIEV1JwFowUrI8+6aSNTY+eAVcw7MMzAcJXoQx/q3BHRGJfdaq/tNomqUX
         alkzzOoUTimTg==
Received: from bigcore.mess.org (unknown [IPv6:2a02:8011:d000:212:ca7f:54ff:fe51:14d6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by gofer.mess.org (Postfix) with ESMTPSA id 3D6611000C2;
        Fri, 27 Oct 2023 10:21:20 +0100 (BST)
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Sean Young <sean@mess.org>
Subject: [PATCH v4 0/4] Improve pwm-ir-tx precision
Date:   Fri, 27 Oct 2023 10:20:43 +0100
Message-ID: <cover.1698398004.git.sean@mess.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The pwm-ir-tx driver has to turn the pwm signal on and off, and suffers
from delays as this is done in process context. Make this work in atomic
context.

changes:

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
 drivers/pwm/pwm-bcm2835.c                     | 30 ++++---
 drivers/pwm/pwm-renesas-tpu.c                 |  1 -
 drivers/pwm/pwm-twl-led.c                     |  2 +-
 drivers/pwm/pwm-vt8500.c                      |  2 +-
 drivers/pwm/sysfs.c                           | 10 +--
 drivers/regulator/pwm-regulator.c             |  4 +-
 drivers/video/backlight/lm3630a_bl.c          |  2 +-
 drivers/video/backlight/lp855x_bl.c           |  2 +-
 drivers/video/backlight/pwm_bl.c              |  6 +-
 drivers/video/fbdev/ssd1307fb.c               |  2 +-
 include/linux/pwm.h                           | 57 +++++++++----
 23 files changed, 244 insertions(+), 89 deletions(-)

-- 
2.42.0

