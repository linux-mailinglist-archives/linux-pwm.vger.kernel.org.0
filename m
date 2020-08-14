Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBAE244A12
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Aug 2020 15:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgHNNDj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 14 Aug 2020 09:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgHNNDh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 14 Aug 2020 09:03:37 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB08EC061384;
        Fri, 14 Aug 2020 06:03:36 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id p14so7420152wmg.1;
        Fri, 14 Aug 2020 06:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YjeThY52rXpwMKfP2wevk8gHf5Xz/Qc/OsJwCnOcXD8=;
        b=BcRrC2HmiDGeWy5XNjDuKjr5ulFMr0fZBAldTKaMCIBx3XK9+HnUUzXqMJWF273PQl
         q6dYxXzYryLby3BgE5/F6MYr/poybHtSrAXPnZU8SPhXY64gqEAKyyTjpXXmKcM98C9J
         km/bhv0cXlzPWI6lyyM7tazPN+nQV6g+eoqJBK0RuoBZ/u86vllWrnCFabu+eIEAMQhV
         0IZx/xQvS3tRpYvLrceAtxIUnP5TRQp2348FLRZko/fvA3OXUrTGwMOZ+c1PvDIHkVi1
         Io9x2Whwl8FzkEU4LMLpnUdQuyyFemqWGtMDADl8pI5nRWysU0ezfSW+ujU3YzC8YU/T
         oTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YjeThY52rXpwMKfP2wevk8gHf5Xz/Qc/OsJwCnOcXD8=;
        b=joAVxGZOfmXwDuQbaY31jboYdIBd8yef+/ofw1NICbRNlDPUyny2qpDhUaR5dIi92/
         +jajCCUVfinJtjTCVthShYAB3e0OKnUgXKPA4mNNm1QQ2jjaOTAHJtJbBH56UlM20bv5
         O1oc/UhcXs8etaNQS0+bJcMpERN6O/nnvxfrk2m5w/9Q1xfhLisiAl4LZs2aO+yTnkw/
         GYcpbbauKQUom4XlERLv8YuwX051ZkA5bc70aKDc0sjJT60pJ0qwBJuAwgp0d43VQhxY
         3ZHtTe9xYEZjc9tXZfsPbJFAFBNg5fehUImCOeSZ1qOwdSsth2yQqgpEZgH36pd5cFyH
         msvA==
X-Gm-Message-State: AOAM530PENH3fdQDXBwXG8/DrHA6DNbgdOWq1iTovKev+Dx0kksxqdZ9
        eoqg+msNu0Np/bvifmJvRxQ=
X-Google-Smtp-Source: ABdhPJynBgjlJD314NI3Pbn1hXJMX2Bk1/F8iskEG/6SXz5gOGWKq5X5fMsr1XAZhHwM0zMV8WA7Dw==
X-Received: by 2002:a1c:4c17:: with SMTP id z23mr2593430wmf.49.1597410214760;
        Fri, 14 Aug 2020 06:03:34 -0700 (PDT)
Received: from localhost (p200300e41f10ca00f451c56750ebc625.dip0.t-ipconnect.de. [2003:e4:1f10:ca00:f451:c567:50eb:c625])
        by smtp.gmail.com with ESMTPSA id l18sm15673647wrm.52.2020.08.14.06.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 06:03:33 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Changes for v5.9-rc1
Date:   Fri, 14 Aug 2020 15:03:32 +0200
Message-Id: <20200814130332.557034-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Linus,

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.9-rc1

for you to fetch changes up to 6ced5ff0be8e94871ba846dfbddf69d21363f3d7:

  pwm: bcm-iproc: handle clk_get_rate() return (2020-07-30 11:27:13 +0200)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v5.9-rc1

The majority of this batch is conversion of the PWM period and duty
cycle to 64-bit unsigned integers, which is required so that some types
of hardware can generate the full range of signals that they're capable
of. The remainder is mostly minor fixes and cleanups.

----------------------------------------------------------------
Alexander A. Klimov (1):
      pwm: Replace HTTP links with HTTPS ones

Guru Das Srinagesh (10):
      drm/i915: Use 64-bit division macro
      hwmon: pwm-fan: Use 64-bit division macro
      pwm: clps711x: Use 64-bit division macro
      pwm: imx-tpm: Use 64-bit division macro
      pwm: imx27: Use 64-bit division macro
      pwm: sifive: Use 64-bit division macro
      pwm: sun4i: Use nsecs_to_jiffies to avoid a division
      backlight: pwm_bl: Use 64-bit division function
      clk: pwm: Use 64-bit division function
      pwm: Convert period and duty cycle to u64

Lee Jones (4):
      pwm: bcm-iproc: Remove impossible comparison when validating duty cycle
      pwm: bcm-kona: Remove impossible comparison when validating duty cycle
      pwm: mediatek: Provide missing kerneldoc description for 'soc' arg
      pwm: omap-dmtimer: Repair pwm_omap_dmtimer_chip's broken kerneldoc header

Rayagonda Kokatanur (1):
      pwm: bcm-iproc: handle clk_get_rate() return

Thierry Reding (2):
      pwm: iqs620a: Use 64-bit division
      pwm: iqs620a: Use lowercase hexadecimal literals for consistency

 drivers/clk/clk-pwm.c                      |  7 ++++++-
 drivers/gpu/drm/i915/display/intel_panel.c |  2 +-
 drivers/hwmon/pwm-fan.c                    |  2 +-
 drivers/pwm/core.c                         | 14 +++++++-------
 drivers/pwm/pwm-bcm-iproc.c                | 12 ++++++++----
 drivers/pwm/pwm-bcm-kona.c                 |  2 +-
 drivers/pwm/pwm-clps711x.c                 |  2 +-
 drivers/pwm/pwm-imx-tpm.c                  |  2 +-
 drivers/pwm/pwm-imx27.c                    |  2 +-
 drivers/pwm/pwm-iqs620a.c                  | 15 ++++++++-------
 drivers/pwm/pwm-mediatek.c                 |  1 +
 drivers/pwm/pwm-omap-dmtimer.c             |  4 ++--
 drivers/pwm/pwm-sifive.c                   |  2 +-
 drivers/pwm/pwm-stm32-lp.c                 |  2 +-
 drivers/pwm/pwm-sun4i.c                    |  2 +-
 drivers/pwm/pwm-tiecap.c                   |  2 +-
 drivers/pwm/pwm-tiehrpwm.c                 |  2 +-
 drivers/pwm/sysfs.c                        |  8 ++++----
 drivers/video/backlight/pwm_bl.c           |  3 ++-
 drivers/video/fbdev/ssd1307fb.c            |  2 +-
 include/linux/pwm.h                        | 12 ++++++------
 21 files changed, 56 insertions(+), 44 deletions(-)
