Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D79CD1A3654
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Apr 2020 16:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgDIOyt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Apr 2020 10:54:49 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38058 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbgDIOyt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Apr 2020 10:54:49 -0400
Received: by mail-wm1-f65.google.com with SMTP id f20so37212wmh.3;
        Thu, 09 Apr 2020 07:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bUVAJiI7CnjRovjyuXVwk+Z5EG5C/6vg9Zzpi2R5rto=;
        b=kVg3WbgUUXKImoSd9msWMe5f5VDBWmT6DK8Emfl/MuzVw0qowLqDOQBLTQxRPrzkjK
         DRLOovf4njFl/ffrt1nRh+BkTBAnO3DwZ0iNcBE6I7zh4xzbSn2lRfAaK7vRlDzs00jF
         ISC+DTIVaYgAHBYFHE8NXvJTFkaRlYdbqK+w7qRRHgqM3F0NatGPhSxgD5wCwMuRCb0p
         NaCPlGjT8eJ730BJrdW02WkPOkFSsb2lwgZzCQJXK+zq2Vy38sdIOts/nNi9vqeAzxDY
         yCGotF2pFqHJdBCCmp1p3h569j3nCPHujvUf+YRAfjCoggCVCrJNuv9drYrM/67lo8AV
         Ucuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bUVAJiI7CnjRovjyuXVwk+Z5EG5C/6vg9Zzpi2R5rto=;
        b=AGQgZIrs3RB23ipGDk0FzOA9uw1df8A9YN2fCZQFV9IU0GIDaUjCnmcgWQpjM/Zd+A
         YNM0v/xgLBDi+/6Y+DXtacO3Ji+DZ3XRxhN9Vj2k4oKc6W7VhsP3SKADiERAshrCiFro
         mCWQTgT/XBX19hliKo1VPw9JJRpvRCGEDOE6aeUidOhcMLJi1196rt3SVAkX8q6U9X0g
         ysr/07c19ZqYSBJvGvR6I9qMxxYz7saIriESu1nBEIXEewts3IOB0Pb6Z9sqSUEnbVd9
         X5/vgTMshzrBE8wj1lEewYkTirb3nEbm+TYGHFN1X1QhtBDQYfcMjgLB8PNbDosm/a5E
         5jiA==
X-Gm-Message-State: AGi0PubZh8u3CAr9AKBWwUfIl0OMxPTuX0ts4H9m+GFm2lmELUV14CKk
        dws2QT3v0BSfFSUrT3eOB1aMAkWk
X-Google-Smtp-Source: APiQypI0mL9f5L2xCt1gUzAKBMu6oHn6EEXZ+BTBRRAgqfnya95SQd+vhyuIcdawWkkBfzxUBzE2bg==
X-Received: by 2002:a1c:4946:: with SMTP id w67mr317784wma.38.1586444086266;
        Thu, 09 Apr 2020 07:54:46 -0700 (PDT)
Received: from localhost (pD9E51D62.dip0.t-ipconnect.de. [217.229.29.98])
        by smtp.gmail.com with ESMTPSA id p7sm7684566wrf.31.2020.04.09.07.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 07:54:44 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Changes for v5.7-rc1
Date:   Thu,  9 Apr 2020 16:54:43 +0200
Message-Id: <20200409145443.3494659-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Linus,

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.7-rc1

for you to fetch changes up to 9cc5f232a4b6a0ef6e9b57876d61b88f61bdd7c2:

  pwm: pca9685: Fix PWM/GPIO inter-operation (2020-04-03 21:41:42 +0200)

Note that this also pulls in a stable branch from the clocksource tree
to resolve a dependency in the OMAP dmtimer PWM driver. I've included
that in the shortlog below.

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v5.7-rc1

There's quite a few changes this time around. Most of these are fixes
and cleanups, but there's also new chip support for some drivers and a
bit of rework.

----------------------------------------------------------------
Anson Huang (3):
      pwm: imx-tpm: Remove unused includes
      pwm: imx27: Remove unused include of of_device.h
      pwm: mxs: Remove unused include of of_address.h

Colin Ian King (1):
      pwm: meson: Remove redundant assignment to variable fin_freq

Dafna Hirschfeld (1):
      dt-bindings: pwm: Convert google,cros-ec-pwm.txt to YAML format

Florian Fainelli (1):
      pwm: bcm2835: Dynamically allocate base

Geert Uytterhoeven (4):
      dt-bindings: pwm: renesas-tpu: Document more R-Car Gen2 support
      pwm: rcar: Fix late Runtime PM enablement
      pwm: renesas-tpu: Fix late Runtime PM enablement
      pwm: renesas-tpu: Drop confusing registered message

Jason Yan (1):
      pwm: Make pwm_apply_state_debug() static

Krzysztof Kozlowski (2):
      pwm: Enable compile testing for some of drivers
      pwm: meson: Fix confusing indentation

Lokesh Vutla (10):
      clocksource/drivers/timer-ti-dm: Convert to SPDX identifier
      clocksource/drivers/timer-ti-dm: Implement cpu_pm notifier for context save and restore
      clocksource/drivers/timer-ti-dm: Do not update counter on updating the period
      clocksource/drivers/timer-ti-dm: Add support to get pwm current status
      clocksource/drivers/timer-ti-dm: Enable autoreload in set_pwm
      pwm: omap-dmtimer: Drop unused header file
      pwm: omap-dmtimer: Update description for PWM OMAP DM timer
      pwm: omap-dmtimer: Fix PWM enabling sequence
      pwm: omap-dmtimer: Do not disable PWM before changing period/duty_cycle
      pwm: omap-dmtimer: Implement .apply callback

Matthias Schiffer (1):
      pwm: pca9685: Remove unused duty_cycle struct element

Pascal Roeleven (1):
      pwm: sun4i: Remove redundant needs_delay

Paul Cercueil (4):
      pwm: jz4740: Use clocks from TCU driver
      pwm: jz4740: Improve algorithm of clock calculation
      pwm: jz4740: Obtain regmap from parent node
      pwm: jz4740: Allow selection of PWM channels 0 and 1

Rishi Gupta (2):
      pwm: pca9685: Replace CONFIG_PM with __maybe_unused
      pwm: pca9685: Use gpio core provided macro GPIO_LINE_DIRECTION_OUT

Sandipan Patra (1):
      pwm: tegra: Add support for Tegra194

Sven Van Asbroeck (1):
      pwm: pca9685: Fix PWM/GPIO inter-operation

Thierry Reding (1):
      Merge branch 'timers/drivers/timer-ti-dm' of https://git.linaro.org/people/dlezcano/linux into for-next

Tony Lindgren (1):
      clocksource/drivers/timer-ti-dm: Prepare for using cpuidle

Uwe Kleine-König (5):
      pwm: imx27: Fix clock handling in pwm_imx27_apply()
      pwm: imx27: Simplify helper function to enable and disable clocks
      pwm: imx27: Don't disable clocks at device remove time
      pwm: imx27: Ensure clocks being on iff the PWM is on
      pwm: Implement some checks for lowlevel drivers

 .../devicetree/bindings/pwm/google,cros-ec-pwm.txt |  23 ---
 .../bindings/pwm/google,cros-ec-pwm.yaml           |  40 ++++
 .../devicetree/bindings/pwm/nvidia,tegra20-pwm.txt |   1 +
 .../devicetree/bindings/pwm/renesas,tpu-pwm.yaml   |   4 +
 drivers/clocksource/timer-ti-dm.c                  | 184 ++++++++++-------
 drivers/pwm/Kconfig                                |  58 +++---
 drivers/pwm/core.c                                 | 135 ++++++++++++-
 drivers/pwm/pwm-bcm2835.c                          |   1 +
 drivers/pwm/pwm-imx-tpm.c                          |   2 -
 drivers/pwm/pwm-imx27.c                            |  32 +--
 drivers/pwm/pwm-jz4740.c                           | 162 ++++++++++-----
 drivers/pwm/pwm-meson.c                            |   4 +-
 drivers/pwm/pwm-mxs.c                              |   1 -
 drivers/pwm/pwm-omap-dmtimer.c                     | 219 ++++++++++++++-------
 drivers/pwm/pwm-pca9685.c                          |  97 ++++-----
 drivers/pwm/pwm-rcar.c                             |  10 +-
 drivers/pwm/pwm-renesas-tpu.c                      |  11 +-
 drivers/pwm/pwm-sun4i.c                            |  13 +-
 drivers/pwm/pwm-tegra.c                            |   6 +
 include/clocksource/timer-ti-dm.h                  |   7 +-
 include/linux/platform_data/dmtimer-omap.h         |   6 +-
 include/linux/platform_data/pwm_omap_dmtimer.h     |  90 ---------
 include/linux/pwm.h                                |   4 +-
 23 files changed, 682 insertions(+), 428 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
 delete mode 100644 include/linux/platform_data/pwm_omap_dmtimer.h
