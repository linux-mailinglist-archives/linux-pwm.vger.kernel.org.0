Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0719405C2D
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Sep 2021 19:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241827AbhIIRfj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Sep 2021 13:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242053AbhIIRfg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Sep 2021 13:35:36 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB59C061574;
        Thu,  9 Sep 2021 10:34:26 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v10so3696433wrd.4;
        Thu, 09 Sep 2021 10:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8KLun7Ei+AEx9Vr5QQ/kMvRq0vvOfJOr5R+Gkw8p2Xc=;
        b=NH3wiBIt1oeM7w7zRzQdTqXaZsvgnyhiF0yawGMNafy6xHr5GslmvsHdEywkf6mQnX
         BrLuFDsWpOrX/vaUMnTbBAlCoXNO/H47VkwSzTDTs24OUfC6Sek5AiqlS+WvjwIaXDbS
         jTmBJL2OcfjiaGTwLdE9E0R7s3tCKsFATpDjydN46/uFM/wP620J7N3nDBG2GTka+AFY
         mBE0+4q9bQes7RA9WWVBg8QWp/o5u09H9jH6qRqiHenvfX+UNlO/mUqUlp3ZLYRzwdKY
         5UvK1d62XROS7QiX/sgZi5sW1XuPMyJt9uttLPcR1hcKCxSRP8r0Q550RRS15i4C6IgR
         k23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8KLun7Ei+AEx9Vr5QQ/kMvRq0vvOfJOr5R+Gkw8p2Xc=;
        b=ORaiaDKAhoc/FJ3S0CfcYLIRpO+1bhE7cAdTKE7ZoWhKv4m72Hv5LXJCXt+10cJss+
         GoZ7/XhfTAHSCYfyioCuH8izrkXc++SoFh59fTRGMWNDjPXwB3N/hNKG119CZNdpIIY9
         3RIjgWLjoEWo282JCGYWZUmW7UtYHLpaY/P7A8rr5NhF8pTAnx77JqYhhTVC3EQf55bT
         qSaUvSuBNq8ZUUQm+N2OLOt/NqnJLnKLMqNJyNfeIlJGIPgeSBSt/PyHG/II3Bj9xPL0
         4tNfFBkZuztHZpxjT8Vv4UMMYsbuRbsFs/KzuD/XIN2QAvHSsf8cRu3t33QNyDKvROPx
         aNjQ==
X-Gm-Message-State: AOAM532QEtzsg3IgOQTWhzpHef+OIg7b5KhKKAx8rGB+zhvt3ZRo8Slv
        ALzFGp/lDDftuk5zGF4c2YnqtZ43mQc=
X-Google-Smtp-Source: ABdhPJzEijmbnKeGcQ5049hWwwmLcVwXqgP65w8g6NW08SoxEfFjN8r/OF/H1lSmCRdYIVDjEyE/hw==
X-Received: by 2002:adf:dd10:: with SMTP id a16mr5142993wrm.281.1631208865084;
        Thu, 09 Sep 2021 10:34:25 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id s15sm2287670wrb.22.2021.09.09.10.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 10:34:24 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Changes for v5.15-rc1
Date:   Thu,  9 Sep 2021 19:34:20 +0200
Message-Id: <20210909173420.3551559-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Linus,

The following changes since commit 2734d6c1b1a089fb593ef6a23d4b70903526fe0c:

  Linux 5.14-rc2 (2021-07-18 14:13:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.15-rc1

for you to fetch changes up to 3f2b16734914fa7c53ef7f8a10a63828890dbd37:

  pwm: mtk-disp: Implement atomic API .get_state() (2021-09-02 22:27:46 +0200)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v5.15-rc1

The changes this time around are mostly janitorial in nature. A lot of
this is simplifications of drivers using device-managed functions and
improving compilation coverage.

The Mediatek display PWM driver now supports the atomic API.

Cleanups and minor fixes make up the remainder of this set.

----------------------------------------------------------------
Jitao Shi (4):
      pwm: mtk-disp: Adjust the clocks to avoid them mismatch
      pwm: mtk-disp: Implement atomic API .apply()
      pwm: mtk-disp: Fix overflow in period and duty calculation
      pwm: mtk-disp: Implement atomic API .get_state()

Liang Chen (1):
      dt-bindings: pwm: rockchip: Add description for rk3568

Uwe Kleine-König (49):
      pwm: atmel: Rework tracking updates pending in hardware
      pwm: ab8500: Fix register offset calculation to not depend on probe order
      pwm: lpc32xx: Don't modify HW state in .probe() after the PWM chip was registered
      pwm: mxs: Don't modify HW state in .probe() after the PWM chip was registered
      pwm: img: Don't modify HW state in .remove() callback
      pwm: rockchip: Don't modify HW state in .remove() callback
      pwm: stm32-lp: Don't modify HW state in .remove() callback
      pwm: hibvt: Disable the clock only after the PWM was unregistered
      pwm: rockchip: Unprepare clocks only after the PWM was unregistered
      pwm: tiehrpwm: Unprepare clock only after the PWM was unregistered
      pwm: ntxec: Drop useless assignment to struct pwmchip::base
      pwm: jz4740: Improve compile coverage by allowing to enable on !MIPS
      pwm: keembay: Improve compile coverage by allowing to enable on !ARM64
      pwm: ab8500: Simplify using devm_pwmchip_add()
      pwm: bcm-kona: Simplify using devm_pwmchip_add()
      pwm: ep93xx: Simplify using devm_pwmchip_add()
      pwm: fsl-ftm: Simplify using devm_pwmchip_add()
      pwm: imx27: Simplify using devm_pwmchip_add()
      pwm: intel-lgm: Simplify using devm_pwmchip_add()
      pwm: iqs620a: Simplify using devm_pwmchip_add()
      pwm: jz4740: Simplify using devm_pwmchip_add()
      pwm: keembay: Simplify using devm_pwmchip_add()
      pwm: lp3943: Simplify using devm_pwmchip_add()
      pwm: lpc32xx: Simplify using devm_pwmchip_add()
      pwm: mediatek: Simplify using devm_pwmchip_add()
      pwm: mxs: Simplify using devm_pwmchip_add()
      pwm: ntxec: Simplify using devm_pwmchip_add()
      pwm: pxa: Simplify using devm_pwmchip_add()
      pwm: raspberrypi-poe: Simplify using devm_pwmchip_add()
      pwm: sl28cpld: Simplify using devm_pwmchip_add()
      pwm: stm32-lp: Simplify using devm_pwmchip_add()
      pwm: tiecap: Simplify using devm_pwmchip_add()
      pwm: twl-led: Simplify using devm_pwmchip_add()
      pwm: twl: Simplify using devm_pwmchip_add()
      pwm: atmel-hlcdc: Don't check the return code of pwmchip_remove()
      pwm: atmel-tcb: Don't check the return code of pwmchip_remove()
      pwm: brcmstb: Don't check the return code of pwmchip_remove()
      pwm: cros-ec: Don't check the return code of pwmchip_remove()
      pwm: img: Don't check the return code of pwmchip_remove()
      pwm: imx-tpm: Don't check the return code of pwmchip_remove()
      pwm: mtk-disp: Don't check the return code of pwmchip_remove()
      pwm: omap-dmtimer: Don't check the return code of pwmchip_remove()
      pwm: pca9685: Don't check the return code of pwmchip_remove()
      pwm: rcar: Don't check the return code of pwmchip_remove()
      pwm: renesas-tpu: Don't check the return code of pwmchip_remove()
      pwm: samsung: Don't check the return code of pwmchip_remove()
      pwm: sifive: Don't check the return code of pwmchip_remove()
      pwm: sun4i: Don't check the return code of pwmchip_remove()
      pwm: Make pwmchip_remove() return void

 .../devicetree/bindings/pwm/pwm-rockchip.yaml      |   1 +
 drivers/pwm/Kconfig                                |   5 +-
 drivers/pwm/core.c                                 |   4 +-
 drivers/pwm/pwm-ab8500.c                           |  35 ++---
 drivers/pwm/pwm-atmel-hlcdc.c                      |   5 +-
 drivers/pwm/pwm-atmel-tcb.c                        |   5 +-
 drivers/pwm/pwm-atmel.c                            | 102 +++++++++---
 drivers/pwm/pwm-bcm-kona.c                         |  12 +-
 drivers/pwm/pwm-brcmstb.c                          |   5 +-
 drivers/pwm/pwm-cros-ec.c                          |   4 +-
 drivers/pwm/pwm-ep93xx.c                           |  11 +-
 drivers/pwm/pwm-fsl-ftm.c                          |  10 +-
 drivers/pwm/pwm-hibvt.c                            |   4 +-
 drivers/pwm/pwm-img.c                              |  20 +--
 drivers/pwm/pwm-imx-tpm.c                          |   5 +-
 drivers/pwm/pwm-imx27.c                            |  14 +-
 drivers/pwm/pwm-intel-lgm.c                        |  12 +-
 drivers/pwm/pwm-iqs620a.c                          |  16 +-
 drivers/pwm/pwm-jz4740.c                           |  12 +-
 drivers/pwm/pwm-keembay.c                          |  12 +-
 drivers/pwm/pwm-lp3943.c                           |  12 +-
 drivers/pwm/pwm-lpc32xx.c                          |  22 +--
 drivers/pwm/pwm-mediatek.c                         |  12 +-
 drivers/pwm/pwm-mtk-disp.c                         | 174 ++++++++++++---------
 drivers/pwm/pwm-mxs.c                              |  25 +--
 drivers/pwm/pwm-ntxec.c                            |  14 +-
 drivers/pwm/pwm-omap-dmtimer.c                     |   5 +-
 drivers/pwm/pwm-pca9685.c                          |   5 +-
 drivers/pwm/pwm-pxa.c                              |  13 +-
 drivers/pwm/pwm-raspberrypi-poe.c                  |  12 +-
 drivers/pwm/pwm-rcar.c                             |   5 +-
 drivers/pwm/pwm-renesas-tpu.c                      |   5 +-
 drivers/pwm/pwm-rockchip.c                         |  16 +-
 drivers/pwm/pwm-samsung.c                          |   5 +-
 drivers/pwm/pwm-sifive.c                           |   6 +-
 drivers/pwm/pwm-sl28cpld.c                         |  12 +-
 drivers/pwm/pwm-stm32-lp.c                         |  12 +-
 drivers/pwm/pwm-sun4i.c                            |   5 +-
 drivers/pwm/pwm-tiecap.c                           |   6 +-
 drivers/pwm/pwm-tiehrpwm.c                         |   4 +-
 drivers/pwm/pwm-twl-led.c                          |  17 +-
 drivers/pwm/pwm-twl.c                              |  17 +-
 include/linux/pwm.h                                |   2 +-
 43 files changed, 260 insertions(+), 440 deletions(-)
