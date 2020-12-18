Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A7D2DE72D
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Dec 2020 17:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbgLRQEq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 18 Dec 2020 11:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbgLRQEp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 18 Dec 2020 11:04:45 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E335C0617A7;
        Fri, 18 Dec 2020 08:04:05 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id c133so2799617wme.4;
        Fri, 18 Dec 2020 08:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ssb9oDY6JLJ6LtlJesOLG/3TxqB19nvyO2Oco8zaxlY=;
        b=REvs7QtjbQAYVWbWXEJeqwNk9KRR3eamB7v8oulnCtVE29t8h7/GYCvqnD2N4FVGQx
         HdJ1TMQ2lMI+OG6Prbs7IBmgAa8zlJlineFsVnPv5Cd4rhBGCPnh33YXN0Zbsblq4G1E
         F/HbSvqB8ajXB/SjX7hSM2EHP4XM6GOZnrKqfhuuW33LDT+8zjbFe5seuaMQP2juGRJM
         +NbntNtG4gqNHBWpGdC13Im7hTihjSaeAlRnrVrQEEA9BrkZhuM4dtMSLbnl4swqyDo2
         mAlKiSaKVlnbeMopSQHWMzM9JeS7n6ihzJVALr9gHmZ08BIWxfvaMFYn1qGkxWiKxOKh
         ZXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ssb9oDY6JLJ6LtlJesOLG/3TxqB19nvyO2Oco8zaxlY=;
        b=Lly/sel2AXb0O1AewyoLgz4Ma+WYf3z0n+hTiivlOTn3MWtGR87NrKaGHRhT1DrOy4
         uIC8peeX1RIaA6w+XHrSlf/LLtnSmZ64IthJTt+rsL9Cl/wweyd37eo0/1w7w9BHP8mG
         bGU/9fFzSY+RzMPcjRnDK1CPlOAfmb4mtri3UAPdqEbxed5FoaLzSUCJHnTlyb4Oo8Gq
         PBIS6uZ1kyIOBiu/CK3aFt4bS3YjEqMLFU8oYhtALcr9SZZ4t7cewtsh7hcfxF88Paeg
         oC2kiZItoOk3lsTnDODmH5/nu0hD34lf01OdWU3EQrXey3ThNVnJy+rgOBMVV+mojA9k
         jcmA==
X-Gm-Message-State: AOAM533nAduhVwLoVG0zwNNVfJ8ovqO0WXBgklZUbhB61+zbCFnktkZC
        LJXCHa1MRgZmRpaE+AShPeTBpjvQocY=
X-Google-Smtp-Source: ABdhPJxzFyjjmt4lTofsVoxyY9/A0wI2JzN/lk14o5Mm/OxSSmBj9AufvIpQ85G34gTw6KWDp1/aUQ==
X-Received: by 2002:a1c:ba41:: with SMTP id k62mr4941450wmf.86.1608307443992;
        Fri, 18 Dec 2020 08:04:03 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id f7sm18200365wmc.1.2020.12.18.08.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 08:04:02 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Changes for v5.11-rc1
Date:   Fri, 18 Dec 2020 17:04:01 +0100
Message-Id: <20201218160401.2478999-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Linus,

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.11-rc1

for you to fetch changes up to 6eefb79d6f5bc4086bd02c76f1072dd4a8d9d9f6:

  pwm: sun4i: Remove erroneous else branch (2020-12-17 14:23:49 +0100)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v5.11-rc1

This is a fairly big release cycle from the PWM framework's point of
view. There's a large patcheset here which converts drivers to use the
new devm_platform_ioremap_resource() helper and a bunch of minor fixes
to existing drivers. Some of the existing drivers also add support for
more hardware, such as Atmel SAMA 5D2 and Mediatek MT8183.

Finally there's a couple of new drivers for Intel Keem Bay and LGM SoCs
as well as the DesignWare PWM controller.

----------------------------------------------------------------
Alexandre Belloni (3):
      dt-bindings: microchip: atmel,at91rm9200-tcb: Add atmel,tcb-pwm
      pwm: atmel-tcb: Switch to new binding
      pwm: atmel-tcb: Add sama5d2 support

Anson Huang (3):
      pwm: imx-tpm: Use dev_err_probe() to simplify error handling
      pwm: imx27: Use dev_err_probe() to simplify error handling
      pwm: imx1: Use dev_err_probe() to simplify error handling

Fabien Parent (4):
      dt-bindings: pwm: pwm-mediatek: Add documentation for MT8183 SoC
      pwm: mediatek: Always use bus clock
      pwm: mediatek: Add MT8183 SoC support
      dt-bindings: pwm: mtk-disp: add MT8167 SoC binding

Grygorii Strashko (1):
      pwm: tiehrpwm: Handle deferred probe with dev_err_probe()

Hans de Goede (3):
      pwm: lpss: Log error from pwm_lpss_is_updating() if the update bit is still set
      pwm: lpss: Use DPM_FLAG_NO_DIRECT_COMPLETE instead of declaring a prepare handler
      pwm: lpss: Set DPM_FLAG_SMART_SUSPEND on Cherry Trail devices

Jarkko Nikula (1):
      pwm: Add DesignWare PWM Controller Driver

Lino Sanfilippo (1):
      pwm: bcm2835: Support apply function for atomic configuration

Lokesh Vutla (1):
      pwm: lp3943: Dynamically allocate PWM chip base

Rahul Tanwar (2):
      Add DT bindings YAML schema for PWM fan controller of LGM SoC
      pwm: Add PWM fan controller driver for LGM SoC

Soham Biswas (1):
      pwm: core: Use octal permission

Thierry Reding (5):
      pwm: sti: Avoid conditional gotos
      pwm: sti: Remove unnecessary blank line
      pwm: Use -EINVAL for unsupported polarity
      pwm: sl28cpld: Set driver data before registering the PWM chip
      pwm: sun4i: Remove erroneous else branch

Uwe Kleine-König (8):
      pwm: ab8500: Add error message if pwmchip_add() fails
      pwm: zx: Add missing cleanup in error path
      pwm: ab8500: Explicitly allocate pwm chip base dynamically
      pwm: Fix dependencies on HAS_IOMEM
      pwm: lpss: Make compilable with COMPILE_TEST
      pwm: keembay: Fix build failure with -Os
      pwm: imx27: Fix overflow for bigger periods
      pwm: Remove unused function pwmchip_add_inversed()

Vijayakannan Ayyathurai (2):
      dt-bindings: pwm: keembay: Add bindings for Intel Keem Bay PWM
      pwm: Add PWM driver for Intel Keem Bay

Yangtao Li (31):
      pwm: sun4i: Convert to devm_platform_ioremap_resource()
      pwm: fsl-ftm: Convert to devm_platform_ioremap_resource()
      pwm: rcar: Convert to devm_platform_ioremap_resource()
      pwm: renesas-tpu: Convert to devm_platform_ioremap_resource()
      pwm: ep93xx: Convert to devm_platform_ioremap_resource()
      pwm: tegra: Convert to devm_platform_ioremap_resource()
      pwm: mediatek: Convert to devm_platform_ioremap_resource()
      pwm: sti: Convert to devm_platform_ioremap_resource()
      pwm: pxa: Convert to devm_platform_ioremap_resource()
      pwm: zx: Convert to devm_platform_ioremap_resource()
      pwm: spear: Convert to devm_platform_ioremap_resource()
      pwm: bcm-kona: Convert to devm_platform_ioremap_resource()
      pwm: lpc32xx: Convert to devm_platform_ioremap_resource()
      pwm: meson: Convert to devm_platform_ioremap_resource()
      pwm: rockchip: Convert to devm_platform_ioremap_resource()
      pwm: bcm-iproc: Convert to devm_platform_ioremap_resource()
      pwm: samsung: Convert to devm_platform_ioremap_resource()
      pwm: tiehrpwm: Convert to devm_platform_ioremap_resource()
      pwm: imx: Convert to devm_platform_ioremap_resource()
      pwm: tiecap: Convert to devm_platform_ioremap_resource()
      pwm: bcm2835: Convert to devm_platform_ioremap_resource()
      pwm: berlin: Convert to devm_platform_ioremap_resource()
      pwm: vt8500: Convert to devm_platform_ioremap_resource()
      pwm: brcmstb: Convert to devm_platform_ioremap_resource()
      pwm: mtk-disp: Convert to devm_platform_ioremap_resource()
      pwm: clps711x: Convert to devm_platform_ioremap_resource()
      pwm: img: Convert to devm_platform_ioremap_resource()
      pwm: lpc18xx-sct: Convert to devm_platform_ioremap_resource()
      pwm: hibvt: Convert to devm_platform_ioremap_resource()
      pwm: sifive: Convert to devm_platform_ioremap_resource()
      pwm: atmel: Convert to devm_platform_ioremap_resource()

 .../devicetree/bindings/pwm/atmel-tcb-pwm.txt      |  16 --
 .../devicetree/bindings/pwm/intel,keembay-pwm.yaml |  47 +++
 .../devicetree/bindings/pwm/intel,lgm-pwm.yaml     |  44 +++
 .../devicetree/bindings/pwm/pwm-mediatek.txt       |   1 +
 .../devicetree/bindings/pwm/pwm-mtk-disp.txt       |   1 +
 .../soc/microchip/atmel,at91rm9200-tcb.yaml        |  34 ++-
 drivers/pwm/Kconfig                                |  71 ++++-
 drivers/pwm/Makefile                               |   3 +
 drivers/pwm/core.c                                 |   2 +-
 drivers/pwm/pwm-ab8500.c                           |   4 +-
 drivers/pwm/pwm-atmel-tcb.c                        | 264 ++++++++++-------
 drivers/pwm/pwm-atmel.c                            |   4 +-
 drivers/pwm/pwm-bcm-iproc.c                        |   4 +-
 drivers/pwm/pwm-bcm-kona.c                         |   4 +-
 drivers/pwm/pwm-bcm2835.c                          |  73 ++---
 drivers/pwm/pwm-berlin.c                           |   4 +-
 drivers/pwm/pwm-brcmstb.c                          |   4 +-
 drivers/pwm/pwm-clps711x.c                         |   4 +-
 drivers/pwm/pwm-crc.c                              |   2 +-
 drivers/pwm/pwm-dwc.c                              | 319 +++++++++++++++++++++
 drivers/pwm/pwm-ep93xx.c                           |   4 +-
 drivers/pwm/pwm-fsl-ftm.c                          |   4 +-
 drivers/pwm/pwm-hibvt.c                            |   7 +-
 drivers/pwm/pwm-img.c                              |   4 +-
 drivers/pwm/pwm-imx-tpm.c                          |  10 +-
 drivers/pwm/pwm-imx1.c                             |  25 +-
 drivers/pwm/pwm-imx27.c                            |  28 +-
 drivers/pwm/pwm-intel-lgm.c                        | 244 ++++++++++++++++
 drivers/pwm/pwm-iqs620a.c                          |   2 +-
 drivers/pwm/pwm-keembay.c                          | 245 ++++++++++++++++
 drivers/pwm/pwm-lp3943.c                           |   1 +
 drivers/pwm/pwm-lpc18xx-sct.c                      |   4 +-
 drivers/pwm/pwm-lpc32xx.c                          |   4 +-
 drivers/pwm/pwm-lpss-platform.c                    |  39 ++-
 drivers/pwm/pwm-lpss.c                             |   7 +-
 drivers/pwm/pwm-mediatek.c                         |  23 +-
 drivers/pwm/pwm-meson.c                            |   4 +-
 drivers/pwm/pwm-mtk-disp.c                         |   4 +-
 drivers/pwm/pwm-pxa.c                              |   4 +-
 drivers/pwm/pwm-rcar.c                             |   6 +-
 drivers/pwm/pwm-renesas-tpu.c                      |   4 +-
 drivers/pwm/pwm-rockchip.c                         |   4 +-
 drivers/pwm/pwm-samsung.c                          |   4 +-
 drivers/pwm/pwm-sifive.c                           |   4 +-
 drivers/pwm/pwm-sl28cpld.c                         |   4 +-
 drivers/pwm/pwm-spear.c                            |   4 +-
 drivers/pwm/pwm-sti.c                              |  54 ++--
 drivers/pwm/pwm-sun4i.c                            |  10 +-
 drivers/pwm/pwm-tegra.c                            |   4 +-
 drivers/pwm/pwm-tiecap.c                           |   4 +-
 drivers/pwm/pwm-tiehrpwm.c                         |  16 +-
 drivers/pwm/pwm-vt8500.c                           |   4 +-
 drivers/pwm/pwm-zx.c                               |   5 +-
 include/linux/pwm.h                                |   5 -
 54 files changed, 1307 insertions(+), 393 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/intel,keembay-pwm.yaml
 create mode 100644 Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
 create mode 100644 drivers/pwm/pwm-dwc.c
 create mode 100644 drivers/pwm/pwm-intel-lgm.c
 create mode 100644 drivers/pwm/pwm-keembay.c
