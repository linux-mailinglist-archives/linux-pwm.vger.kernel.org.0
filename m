Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A4B7CBECA
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Oct 2023 11:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343503AbjJQJSG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Oct 2023 05:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343505AbjJQJSE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Oct 2023 05:18:04 -0400
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3657AB0;
        Tue, 17 Oct 2023 02:18:03 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 501)
        id 0702A10006C; Tue, 17 Oct 2023 10:18:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1697534281; bh=8akW38+dHJiNzaVosK2VDBMXY+aQwIKCMX5dwfZwrbc=;
        h=From:To:Cc:Subject:Date:From;
        b=A72IfsrI97efGXtj0+FFunSB+8e7ArNClNs5HiN6ixzgq5LcP/yXlYha0yog7cX/O
         cm9vCiGwTBbVmNOLncD1CYiBG9XRkcsvg11GJIhXSp0rO32tBw1RpSgEqD6TKQk1tx
         QrbIorIXbOB6ewUnjJ0beNdV0Ux9AHjw5GThLwoQ4L3XL67WTDkvR+V2dxu7WqGvDn
         b2fjN6+LPny9itnhQjJrA1lYN75K0fL+Ws2hrDWI3IaB9Bk94NS1TGOyJ0TpJ184fu
         WlF1Fa9BbOGrDkoRIeBsLrzzcY2JHDie0xLE0ky9WE/Y4HKDJ6OipQnSCMDvOQMnOZ
         AeR3uPdTY0DwQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from bigcore.mess.org (unknown [IPv6:2a02:8011:d000:212:ca7f:54ff:fe51:14d6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by gofer.mess.org (Postfix) with ESMTPSA id D8A2110006C;
        Tue, 17 Oct 2023 10:17:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1697534279; bh=8akW38+dHJiNzaVosK2VDBMXY+aQwIKCMX5dwfZwrbc=;
        h=From:To:Cc:Subject:Date:From;
        b=Yu3UhiYgHHIJ8S89sHmnZY6BAho5v5RNJf32ZGEbic393Gsy3DdchSJaDkcSLhR3V
         Z7VcLIBRGcRBo2/4EUOBFkitDa47b557/H87JE8zEKQHuUtGtOqfqcxjP6RawtN6lx
         +GewHRqQaUsnX0OXjGTaweYdzqnjTp4AqQwWD8gVGCGCnn6JDXCCfKxKpb5VuwBFAr
         NOAjk0wMn4Yray3oPwt9bEL0Bq6spLBS7VUIruf9ZG6sT/TTjlJgZxmRf5BI8CknVK
         G3MBks1cbbu/3SXCfnj8+e6pFWjN/sJHzp8NggTHyfhV+vUn1B4PFgmfehpOculvOA
         pDVlbwlKc15pg==
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Sean Young <sean@mess.org>
Subject: [PATCH v3 0/3] Improve pwm-ir-tx precision
Date:   Tue, 17 Oct 2023 10:17:36 +0100
Message-ID: <cover.1697534024.git.sean@mess.org>
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

Sean Young (3):
  pwm: make it possible to apply pwm changes in atomic context
  pwm: bcm2835: allow pwm driver to be used in atomic context
  media: pwm-ir-tx: trigger edges from hrtimer interrupt context

 Documentation/driver-api/pwm.rst              | 16 +++-
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
 23 files changed, 243 insertions(+), 89 deletions(-)

-- 
2.42.0

