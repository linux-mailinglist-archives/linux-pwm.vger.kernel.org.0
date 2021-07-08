Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63FA3BF8A1
	for <lists+linux-pwm@lfdr.de>; Thu,  8 Jul 2021 13:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbhGHLEi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 8 Jul 2021 07:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbhGHLEh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 8 Jul 2021 07:04:37 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074CEC061574;
        Thu,  8 Jul 2021 04:01:56 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id k31-20020a05600c1c9fb029021727d66d33so2113686wms.0;
        Thu, 08 Jul 2021 04:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0q2XAc7CdT3TgB10pdJE5kx0YMb858f02LBVzXJ1O9Y=;
        b=ss+HVddi2Yb9LDcR0+4nqmaNNfSMMCBEuwH5VEm8nkmIqj/VHaxDODkvdVab2f01Lx
         +h8LDNtYHqLSXHSEX8j7lFv+yXf4A9ojDAhChPCpZEgQiqAMfj8qTSeh8wUezWDYsDkc
         PHwMizfh6GJO8lwmvj6QPvw4C8BdxBL+6h8SmCieMjsdAPB8dndHES0j9bc398Av8b4B
         yC+0BBrf0GozOU/Ljpr2O6FDx+CdirLYIo3oyBWgI/O70rDsqkrSegMv7kqK3qbu9p1R
         kTXobYhuwWg5+skAGn6tTBy3OWcEDc3gf/e4x4fJ4cq4flOAl3vaxQIVWPMjk+YU1YMA
         mxQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0q2XAc7CdT3TgB10pdJE5kx0YMb858f02LBVzXJ1O9Y=;
        b=M4BXFAVane9guNTTzX5bCtmOX2boqaOrhxdeCKT5BYk2wHGQg+BgZnYn7Z1IFBBwf3
         HbivWm5ZuSrVXOPrgX7tzBggkQ8zP4Y7xMGanFQn64OS1zddTbdHUFoikX5L9FrTULDZ
         iKfaCLYS0TubwD3He/7YRdh4BnH5xT+RzR79thaUylabEr+lGPxJQb5jq2QWzj1/dCHo
         dFCrsEbbNZIopvlysygVJPbAHQPMPikxbffGYRPRnP1qGQGR7kalVjW79VASdXpEmD+P
         E0sqeKMLUgk/mTQ6rsunz9vvlx2JfSxwmp5l5F692Yd+8h5Lq2rN3l4m94qxIygGxPAP
         NWsw==
X-Gm-Message-State: AOAM5320HHgOGi1sSs0GFj4zZPEdDkVcPIP5bBaoFkcdDV9924WCg1mP
        IT5bp9Sse0dz2SzI1S4E7hdhwAFF/3s=
X-Google-Smtp-Source: ABdhPJzIHy2aJCrUwjFIryceTbQUOXi3nwiQi+/7q1wuOGo8Qn77qPDzujrfbJ6GHPxvEvB5M2lX5Q==
X-Received: by 2002:a05:600c:4a09:: with SMTP id c9mr31946590wmp.11.1625742114583;
        Thu, 08 Jul 2021 04:01:54 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id c10sm1654010wmb.40.2021.07.08.04.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 04:01:53 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Changes for v5.14-rc1
Date:   Thu,  8 Jul 2021 13:04:15 +0200
Message-Id: <20210708110415.1785007-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Linus,

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.14-rc1

for you to fetch changes up to bebedf2bb4a9e0cb4ffa72cbc960728051b338a4:

  pwm: Remove redundant assignment to pointer pwm (2021-07-07 21:43:32 +0200)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v5.14-rc1

This contains mostly various fixes, cleanups and some conversions to the
atomic API. One noteworthy change is that PWM consumers can now pass a
hint to the PWM core about the PWM usage, enabling PWM providers to
implement various optimizations.

There's also a fair bit of simplification here with the addition of some
device-managed helpers as well as unification between the DT and ACPI
firmware interfaces.

----------------------------------------------------------------
Alexander Sverdlin (1):
      pwm: ep93xx: Prepare clock before using it

Andy Shevchenko (6):
      docs: firmware-guide: ACPI: Add a PWM example
      pwm: core: Convert to use fwnode for matching
      pwm: core: Reuse fwnode_to_pwmchip() in ACPI case
      pwm: core: Unify fwnode checks in the module
      pwm: core: Remove unused devm_pwm_put()
      pwm: core: Simplify some devm_*pwm*() functions

Clemens Gruber (4):
      pwm: core: Support new usage_power setting in PWM state
      pwm: pca9685: Support new usage_power setting in PWM state
      pwm: pca9685: Restrict period change for enabled PWMs
      pwm: pca9685: Add error messages for failed regmap calls

Colin Ian King (2):
      pwm: ep93xx: Fix read of uninitialized variable ret
      pwm: Remove redundant assignment to pointer pwm

Lokesh Vutla (4):
      dt-bindings: pwm: pwm-tiehrpwm: Convert to json schema
      dt-bindings: pwm: pwm-tiehrpwm: Add compatible string for AM64 SoC
      dt-bindings: pwm: pwm-tiecap: Convert to json schema
      dt-bindings: pwm: pwm-tiecap: Add compatible string for AM64 SoC

Uwe Kleine-König (32):
      pwm: Make of_pwm_xlate_with_flags() work with #pwm-cells = <2>
      pwm: Drop of_pwm_simple_xlate() in favour of of_pwm_xlate_with_flags()
      pwm: Autodetect default value for of_pwm_n_cells from device tree
      pwm: Simplify all drivers with explicit of_pwm_n_cells = 3
      pwm: visconti: Fix and simplify period calculation
      pwm: spear: Don't modify HW state in .remove callback
      pwm: spear: Free resources only after pwmchip_remove()
      pwm: spear: Implement .apply() callback
      pwm: Add a device-managed function to add PWM chips
      pwm: lpss: Simplify using devm_pwmchip_add()
      pwm: meson: Simplify using devm_pwmchip_add()
      pwm: clps711x: Simplify using devm_pwmchip_add()
      pwm: imx1: Don't disable clocks at device remove time
      pwm: imx1: Simplify using devm_pwmchip_add()
      pwm: crc: Simplify using devm_pwmchip_add()
      pwm: Drop irrelevant error path from pwmchip_remove()
      pwm: tiecap: Drop .free() callback
      pwm: tiecap: Implement .apply() callback
      pwm: berlin: use consistent naming for variables
      pwm: berlin: Implement .apply() callback
      pwm: berlin: Don't check the return code of pwmchip_remove()
      pwm: pxa: Drop if with an always false condition
      pwm: pxa: Always use the same variable name for driver data
      pwm: sprd: Don't check the return code of pwmchip_remove()
      pwm: tegra: Drop an if block with an always false condition
      pwm: tegra: Don't modify HW state in .remove callback
      pwm: tegra: Don't needlessly enable and disable the clock in .remove()
      pwm: tegra: Assert reset only after the PWM was unregistered
      pwm: vt8500: Drop if with an always false condition
      pwm: vt8500: Only unprepare the clock after the pwmchip was removed
      pwm: ep93xx: Implement .apply callback
      pwm: ep93xx: Unfold legacy callbacks into ep93xx_pwm_apply()

Zou Wei (1):
      pwm: img: Fix PM reference leak in img_pwm_enable()

 .../devicetree/bindings/pwm/pwm-tiecap.txt         |  51 -----
 .../devicetree/bindings/pwm/pwm-tiecap.yaml        |  64 ++++++
 .../devicetree/bindings/pwm/pwm-tiehrpwm.txt       |  50 -----
 .../devicetree/bindings/pwm/pwm-tiehrpwm.yaml      |  65 ++++++
 Documentation/driver-api/driver-model/devres.rst   |   3 +-
 Documentation/driver-api/pwm.rst                   |   7 +-
 Documentation/firmware-guide/acpi/enumeration.rst  |  32 +++
 drivers/pwm/core.c                                 | 222 +++++++--------------
 drivers/pwm/pwm-atmel-hlcdc.c                      |   2 -
 drivers/pwm/pwm-atmel-tcb.c                        |   2 -
 drivers/pwm/pwm-atmel.c                            |   2 -
 drivers/pwm/pwm-bcm-iproc.c                        |   2 -
 drivers/pwm/pwm-bcm-kona.c                         |   2 -
 drivers/pwm/pwm-bcm2835.c                          |   2 -
 drivers/pwm/pwm-berlin.c                           | 165 ++++++++-------
 drivers/pwm/pwm-clps711x.c                         |  12 +-
 drivers/pwm/pwm-crc.c                              |  12 +-
 drivers/pwm/pwm-ep93xx.c                           | 167 ++++++++--------
 drivers/pwm/pwm-fsl-ftm.c                          |   2 -
 drivers/pwm/pwm-hibvt.c                            |   2 -
 drivers/pwm/pwm-img.c                              |   2 +-
 drivers/pwm/pwm-imx-tpm.c                          |   2 -
 drivers/pwm/pwm-imx1.c                             |  14 +-
 drivers/pwm/pwm-imx27.c                            |   3 -
 drivers/pwm/pwm-jz4740.c                           |   2 -
 drivers/pwm/pwm-lpc18xx-sct.c                      |   2 -
 drivers/pwm/pwm-lpss-pci.c                         |   4 -
 drivers/pwm/pwm-lpss-platform.c                    |   4 +-
 drivers/pwm/pwm-lpss.c                             |   8 +-
 drivers/pwm/pwm-lpss.h                             |   1 -
 drivers/pwm/pwm-meson.c                            |  14 +-
 drivers/pwm/pwm-mxs.c                              |   2 -
 drivers/pwm/pwm-omap-dmtimer.c                     |   2 -
 drivers/pwm/pwm-pca9685.c                          | 198 ++++++++++++++----
 drivers/pwm/pwm-pxa.c                              |  40 ++--
 drivers/pwm/pwm-renesas-tpu.c                      |   2 -
 drivers/pwm/pwm-rockchip.c                         |   5 -
 drivers/pwm/pwm-samsung.c                          |   3 -
 drivers/pwm/pwm-sifive.c                           |   2 -
 drivers/pwm/pwm-spear.c                            |  40 +++-
 drivers/pwm/pwm-sprd.c                             |   4 +-
 drivers/pwm/pwm-stm32-lp.c                         |   2 -
 drivers/pwm/pwm-stm32.c                            |   2 -
 drivers/pwm/pwm-sun4i.c                            |   2 -
 drivers/pwm/pwm-tegra.c                            |  24 +--
 drivers/pwm/pwm-tiecap.c                           |  58 ++++--
 drivers/pwm/pwm-tiehrpwm.c                         |   2 -
 drivers/pwm/pwm-visconti.c                         |  17 +-
 drivers/pwm/pwm-vt8500.c                           |  10 +-
 include/linux/pwm.h                                |  15 +-
 50 files changed, 710 insertions(+), 642 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-tiecap.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.yaml
