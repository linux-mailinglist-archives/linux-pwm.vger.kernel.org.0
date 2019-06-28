Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4036C5999C
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Jun 2019 14:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfF1MAM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Jun 2019 08:00:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39976 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfF1MAM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Jun 2019 08:00:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id p11so6002763wre.7;
        Fri, 28 Jun 2019 05:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zFhViWU2ix/FGtwFa2dw2ZghUA5CNul/fAu8w0UyxW8=;
        b=ARp+PRzs5JzuKsvLfkHkuhA2bBmmH2qEuAsiROw3mHouKomY2trDc2A1XPrxeo/0KR
         tHG3hS3pVUFyUc8UiEnzT59Bgt8mIOTl66vJZ2nNbcU4nzV8nHDKFMhK6lLil2j2JZ2y
         ITiI7ICg7ll7qf26pm/nmSRnJ6thM27BMscaaUheHMc8W/dET5lEabjWvXUn9K3k+jg3
         NJdhemc+u4dH3zxq3eP8r82yLzXgz+1M2kaEGFMF0Mq0LnC+ldngmS3GDzZgCDTH8KXu
         TFk/V+5wWbbUDikwlY7OHjxqGiNXfmGE+gJhk+TTE2wYV95LjxO2RTCHI4f/nI8gwkhg
         tMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zFhViWU2ix/FGtwFa2dw2ZghUA5CNul/fAu8w0UyxW8=;
        b=izG6XClqkuGB4gy2r/sqAPBboZgboeBYxG90QIPNvkNnONovmhI1Ib6hWp4B4+VmiR
         DAIYhP2vsnWsY+xEMse05AB+gseshVDdLd4flg37kx2cM4IJP150pYfvRppHRzQMYftK
         jidm+vxrbGOdcwhxTFwT+xKlaTGT0aR9/xXmm4kufxwm/g9g5tbTEEPyyZhX2Bq3S9m1
         ga8GmaQxByK9GY7WE+/H/4ghvYF9ydyaCGD9OGw/7MR5PUMYqVcQFlv7ehZr78R9z3qv
         X+Il7khejq5QSRc5OLnkpZmu2qo3T/oto5RN1Z7TZ9hYsUOKnoR/+z7td924yRa7CZ30
         Ibqw==
X-Gm-Message-State: APjAAAWkGlX246V8gSz4h79CW6PlDg6eMGT9amUbRjdG25fx9hA+58uf
        K2I6qKUmp+o9MpZmgFEQSCmu5Q3ZOEo=
X-Google-Smtp-Source: APXvYqwHNfcDEyvEEko3CDQl75vx4ggUJxH8AlV3szGQA1YFMXUfDlUD37+YRKrpHDNf9O4d+YFZ6A==
X-Received: by 2002:adf:cc85:: with SMTP id p5mr7204435wrj.47.1561723209234;
        Fri, 28 Jun 2019 05:00:09 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id t15sm2014117wrx.84.2019.06.28.05.00.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 05:00:08 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Changes for v5.3-rc1
Date:   Fri, 28 Jun 2019 14:00:02 +0200
Message-Id: <20190628120002.19597-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Linus,

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.3-rc1

for you to fetch changes up to 3d25025ce9c2f364ea4ee76f1461c8714b9c0b6d:

  pwm: fsl-ftm: Make sure to unlock mutex on failure (2019-06-26 11:39:25 +0200)

I'm sending this out early for this cycle because I have travel plans
that will likely intersect with the merge window.

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v5.3-rc1

This set of changes contains a new driver for SiFive SoCs as well as
enhancements to the core (device links are used to track dependencies
between PWM providers and consumers, support for PWM controllers via
ACPI, sysfs will now suspend/resume PWMs that it has claimed) and
various existing drivers.

----------------------------------------------------------------
Claudiu Beznea (1):
      pwm: atmel-hlcdc: Add compatible for SAM9X60 HLCDC's PWM

Fabrice Gasnier (5):
      dt-bindings: pwm: stm32-lp: Document pin control sleep state
      pwm: stm32-lp: Add power management support
      pwm: Add consumer device link
      dt-bindings: pwm: stm32: Add #pwm-cells
      pwm: stm32: Use 3 cells ->of_xlate()

Martin Blumenstingl (14):
      pwm: meson: Unify the parameter list of meson_pwm_{enable, disable}
      pwm: meson: Use devm_clk_get_optional() to get the input clock
      pwm: meson: Use GENMASK and FIELD_PREP for the lo and hi values
      pwm: meson: Change MISC_CLK_SEL_WIDTH to MISC_CLK_SEL_MASK
      pwm: meson: Don't duplicate the polarity internally
      pwm: meson: Pass struct pwm_device to meson_pwm_calc()
      pwm: meson: Add the meson_pwm_channel data to struct meson_pwm
      pwm: meson: Add the per-channel register offsets and bits in a struct
      pwm: meson: Move pwm_set_chip_data() to meson_pwm_request()
      pwm: meson: Simplify the calculation of the pre-divider and count
      pwm: meson: Read the full hardware state in meson_pwm_get_state()
      pwm: meson: Don't cache struct pwm_state internally
      pwm: meson: Add support PWM_POLARITY_INVERSED when disabling
      pwm: meson: Add documentation to the driver

Neil Armstrong (2):
      pwm: meson: Update with SPDX Licence identifier
      pwm: meson: Fix the G12A AO clock parents order

Nikolaus Voss (2):
      pwm: Add support referencing PWMs from ACPI
      leds: pwm: Support ACPI via firmware-node framework

Patrick Havelange (2):
      pwm: fsl-ftm: More relaxed permissions for updating period
      pwm: fsl-ftm: Use write protection for prescaler & polarity

Paul Cercueil (4):
      dt-bindings: pwm: jz47xx: Remove unused compatible strings
      pwm: jz4740: Remove unused devicetree compatible strings
      pwm: jz4740: Apply configuration atomically
      pwm: jz4740: Force TCU2 channels to return to their init level

Sean Young (1):
      pwm: bcm2835: Improve precision of PWM

Thierry Reding (1):
      pwm: fsl-ftm: Make sure to unlock mutex on failure

Yash Shah (2):
      pwm: sifive: Add DT documentation for SiFive PWM Controller
      pwm: sifive: Add a driver for SiFive SoC PWM

Yoshihiro Shimoda (3):
      pwm: Add power management descriptions
      pwm: sysfs: Add suspend/resume support
      pwm: rcar: Remove suspend/resume support

 .../devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt |   5 +-
 .../devicetree/bindings/pwm/pwm-sifive.txt         |  33 ++
 .../devicetree/bindings/pwm/pwm-stm32-lp.txt       |   9 +-
 .../devicetree/bindings/pwm/pwm-stm32.txt          |   3 +
 Documentation/pwm.txt                              |   7 +
 drivers/leds/leds-pwm.c                            |  45 ++-
 drivers/pwm/Kconfig                                |  11 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/core.c                                 | 172 ++++++++-
 drivers/pwm/pwm-atmel-hlcdc.c                      |   1 +
 drivers/pwm/pwm-bcm2835.c                          |   8 +-
 drivers/pwm/pwm-fsl-ftm.c                          | 383 ++++++++++----------
 drivers/pwm/pwm-jz4740.c                           |  49 ++-
 drivers/pwm/pwm-meson.c                            | 386 ++++++++++-----------
 drivers/pwm/pwm-rcar.c                             |  39 ---
 drivers/pwm/pwm-sifive.c                           | 339 ++++++++++++++++++
 drivers/pwm/pwm-stm32-lp.c                         |  25 ++
 drivers/pwm/pwm-stm32.c                            |   2 +
 drivers/pwm/sysfs.c                                | 102 ++++++
 include/linux/pwm.h                                |  16 +-
 20 files changed, 1154 insertions(+), 482 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt
 create mode 100644 drivers/pwm/pwm-sifive.c
