Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3CA37481C
	for <lists+linux-pwm@lfdr.de>; Wed,  5 May 2021 20:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbhEESkN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 5 May 2021 14:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbhEESkN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 5 May 2021 14:40:13 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC9AC061574;
        Wed,  5 May 2021 11:39:16 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id u21so4362633ejo.13;
        Wed, 05 May 2021 11:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e2AGj2xhZnTw8GALBpMadxr6OfPLDfLfB5W643s1mpg=;
        b=ktFAA9W2XAiEfPdc+F5uqwgAEIweBWy/YTst3Rt/B0wk3yqqBFfcOJnbBqjJwYdDj0
         9RDz3WvID2oiJAwMBM7qCCIOYtybVGWPgdhA8lEhW+krGLPDustmW5K8gTuGQot9hHGS
         Jf/o7Ql5S6WFi5TovRbdFUfLpavZQAbrpVGKxV7W+H3eVj7q4eOJVb+vHZF9Bpp1kbHq
         ZAh7xVcj5lNOQqf7Yg7wGvMgq88gdd1IwDmeD5fdGqxxwOvJapsNvWNytSQTdgvr9f2V
         MJjSiOAZEnZBkqipvug5sLU+1954T/2da1K91rUP7XPFVWRPJZDSrPUNj7p7oLm0Is6F
         55/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e2AGj2xhZnTw8GALBpMadxr6OfPLDfLfB5W643s1mpg=;
        b=db/HA4/0tkUU/Jl1rvSMrTv35dxiGXVnTduCOlLZaQW9JGmNFzNOevlILGgpbQPmWb
         dewXc7bYNZ8/iSf5NxbF3t/VvwONd3nQxsvQ0O277Cftst14dTaEDACUSLoCwMJk7K+y
         QKD94XGwHFvulK6XUcD5AVFh3WSE06KlaX12SdtZ/W004Zzvj+Em3YvRuOfOQsBH6htE
         5m4x5QDxDkov7hpEf2qEz2L5h086tC1dZYqwBznrvxj0uoVcsKhS76LCdpIlYtrS3sOs
         u8YJUbsAmCnt7t7+Lodt3FYMqCA2V1YcLSey3Xxu3/cXDXpbCdHnYr2xEiKfv3HUKtku
         aaBA==
X-Gm-Message-State: AOAM530dYRkoSrAtGiOWKkgOMGDc6Absa9gdXQba1Xz2Ze5psrxtRmnl
        ruHVGSTbKPaCovYBXXYJYJ+tD9Cx4zT/3w==
X-Google-Smtp-Source: ABdhPJytchI4YYgTjt5Fu201TVtvt+GpodCQcPDOCmRv163sdIUQhvcR1o3AD8gFp7Jonje1KJX0BQ==
X-Received: by 2002:a17:907:2104:: with SMTP id qn4mr197809ejb.82.1620239954831;
        Wed, 05 May 2021 11:39:14 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id n2sm16806918edi.32.2021.05.05.11.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 11:39:13 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Changes for v5.13-rc1
Date:   Wed,  5 May 2021 20:40:15 +0200
Message-Id: <20210505184015.1250649-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Linus,

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.13-rc1

for you to fetch changes up to a6efb35019d00f483a0e5f188747723371d659fe:

  pwm: Reword docs about pwm_apply_state() (2021-04-26 08:49:48 +0200)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v5.13-rc1

This set of changes adds support for the PWM controller found on Toshiba
Visconti SoCs and converts a couple of drivers to the atomic API.

There's also a bunch of cleanups and minor fixes across the board.

----------------------------------------------------------------
Clemens Gruber (3):
      pwm: pca9685: Switch to atomic API
      pwm: pca9685: Support hardware readout
      pwm: pca9685: Improve runtime PM behavior

Fabio Estevam (1):
      pwm: imx-tpm: Use a single line for error message

Jiapeng Chong (1):
      pwm: mediatek: Remove unused function

Johan Jonker (4):
      dt-bindings: pwm: Convert pwm-rockchip.txt to YAML
      dt-bindings: pwm: rockchip: Add more compatible strings
      ARM: dts: rockchip: Remove clock-names from PWM nodes
      arm64: dts: rockchip: Remove clock-names from PWM nodes

Nobuhiro Iwamatsu (2):
      dt-bindings: pwm: Add bindings for Toshiba Visconti PWM Controller
      pwm: visconti: Add Toshiba Visconti SoC PWM support

Uwe Kleine-König (24):
      pwm: bcm2835: Improve period and duty cycle calculation
      pwm: ab8500: Implement .apply instead of .config, .enable and .disable
      pwm: Always allocate PWM chip base ID dynamically
      pwm: Return -EINVAL for old-style drivers without .set_polarity callback
      pwm: atmel-tcb: Implement .apply callback
      pwm: atmel-tcb: Only free resources after pwm_chip_remove() returned
      pwm: sprd: Refuse requests with unsupported polarity
      pwm: cros-ec: Refuse requests with unsupported polarity
      pwm: bcm-kona: Use pwmchip_add() instead of pwmchip_add_with_polarity()
      pwm: atmel-hlcdc: Use pwmchip_add() instead of pwmchip_add_with_polarity()
      pwm: Drop function pwmchip_add_with_polarity()
      pwm: Clarify which state pwm_get_state() returns
      pwm: atmel: Free resources only after pwmchip_remove()
      pwm: bcm-iproc: Free resources only after pwmchip_remove()
      pwm: bcm2835: Free resources only after pwmchip_remove()
      pwm: bcm-kona: Don't modify HW state in .remove callback
      pwm: lpc18xx-sct: Free resources only after pwmchip_remove()
      pwm: lpc3200: Don't modify HW state in .remove callback
      pwm: sti: Don't modify HW state in .remove callback
      pwm: sti: Free resources only after pwmchip_remove()
      pwm: lpss: Don't modify HW state in .remove callback
      pwm: atmel: Fix duty cycle calculation in .get_state()
      pwm: atmel: Improve duty cycle calculation in .apply()
      pwm: Reword docs about pwm_apply_state()

 .../devicetree/bindings/pwm/pwm-rockchip.txt       |  27 --
 .../devicetree/bindings/pwm/pwm-rockchip.yaml      | 100 +++++++
 .../bindings/pwm/toshiba,pwm-visconti.yaml         |  43 +++
 Documentation/driver-api/pwm.rst                   |   6 +-
 arch/arm/boot/dts/rk3036.dtsi                      |   4 -
 arch/arm/boot/dts/rk3288.dtsi                      |   4 -
 arch/arm64/boot/dts/rockchip/rk3368.dtsi           |   4 -
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |   4 -
 drivers/pwm/Kconfig                                |   9 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/core.c                                 |  48 +---
 drivers/pwm/pwm-ab8500.c                           |  54 ++--
 drivers/pwm/pwm-atmel-hlcdc.c                      |   3 +-
 drivers/pwm/pwm-atmel-tcb.c                        |  42 ++-
 drivers/pwm/pwm-atmel.c                            |  30 +-
 drivers/pwm/pwm-bcm-iproc.c                        |   5 +-
 drivers/pwm/pwm-bcm-kona.c                         |   8 +-
 drivers/pwm/pwm-bcm2835.c                          |  40 ++-
 drivers/pwm/pwm-berlin.c                           |   1 -
 drivers/pwm/pwm-brcmstb.c                          |   1 -
 drivers/pwm/pwm-clps711x.c                         |   1 -
 drivers/pwm/pwm-crc.c                              |   1 -
 drivers/pwm/pwm-cros-ec.c                          |   4 +-
 drivers/pwm/pwm-dwc.c                              |   1 -
 drivers/pwm/pwm-ep93xx.c                           |   1 -
 drivers/pwm/pwm-fsl-ftm.c                          |   1 -
 drivers/pwm/pwm-hibvt.c                            |   1 -
 drivers/pwm/pwm-img.c                              |   1 -
 drivers/pwm/pwm-imx-tpm.c                          |   5 +-
 drivers/pwm/pwm-imx1.c                             |   1 -
 drivers/pwm/pwm-imx27.c                            |   1 -
 drivers/pwm/pwm-intel-lgm.c                        |   1 -
 drivers/pwm/pwm-iqs620a.c                          |   1 -
 drivers/pwm/pwm-jz4740.c                           |   1 -
 drivers/pwm/pwm-keembay.c                          |   1 -
 drivers/pwm/pwm-lp3943.c                           |   1 -
 drivers/pwm/pwm-lpc18xx-sct.c                      |   5 +-
 drivers/pwm/pwm-lpc32xx.c                          |   5 -
 drivers/pwm/pwm-lpss.c                             |   7 -
 drivers/pwm/pwm-mediatek.c                         |   7 -
 drivers/pwm/pwm-meson.c                            |   1 -
 drivers/pwm/pwm-mtk-disp.c                         |   1 -
 drivers/pwm/pwm-mxs.c                              |   1 -
 drivers/pwm/pwm-omap-dmtimer.c                     |   1 -
 drivers/pwm/pwm-pca9685.c                          | 303 +++++++++------------
 drivers/pwm/pwm-pxa.c                              |   1 -
 drivers/pwm/pwm-rcar.c                             |   1 -
 drivers/pwm/pwm-renesas-tpu.c                      |   1 -
 drivers/pwm/pwm-rockchip.c                         |   1 -
 drivers/pwm/pwm-samsung.c                          |   1 -
 drivers/pwm/pwm-sifive.c                           |   1 -
 drivers/pwm/pwm-sl28cpld.c                         |   1 -
 drivers/pwm/pwm-spear.c                            |   1 -
 drivers/pwm/pwm-sprd.c                             |   4 +-
 drivers/pwm/pwm-sti.c                              |   7 +-
 drivers/pwm/pwm-stm32-lp.c                         |   1 -
 drivers/pwm/pwm-stm32.c                            |   1 -
 drivers/pwm/pwm-stmpe.c                            |   1 -
 drivers/pwm/pwm-sun4i.c                            |   1 -
 drivers/pwm/pwm-tegra.c                            |   1 -
 drivers/pwm/pwm-tiecap.c                           |   1 -
 drivers/pwm/pwm-tiehrpwm.c                         |   1 -
 drivers/pwm/pwm-twl-led.c                          |   1 -
 drivers/pwm/pwm-twl.c                              |   1 -
 drivers/pwm/pwm-visconti.c                         | 190 +++++++++++++
 drivers/pwm/pwm-vt8500.c                           |   1 -
 include/linux/pwm.h                                |   7 +-
 67 files changed, 619 insertions(+), 395 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
 create mode 100644 Documentation/devicetree/bindings/pwm/toshiba,pwm-visconti.yaml
 create mode 100644 drivers/pwm/pwm-visconti.c
