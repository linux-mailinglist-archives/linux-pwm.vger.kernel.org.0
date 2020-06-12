Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237741F78F4
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jun 2020 15:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgFLNu5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 12 Jun 2020 09:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgFLNu4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 12 Jun 2020 09:50:56 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFA1C03E96F;
        Fri, 12 Jun 2020 06:50:56 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c3so9786892wru.12;
        Fri, 12 Jun 2020 06:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=psNTl7b3xz3hbJPsvAGnz66wfWri0qx+KAw09sdE0Xk=;
        b=TFBggTfwRjqnOuEKjxpDDkhy2wbHaO8tEw971I5tUTibRIOJtRCCVxY6m4zCFdvq4V
         licSW1m+gS6w13OdxcdcLT8em5KDKj5zE5XEY67zbhBUzAN375j6a4iSyCScDBKYrCgw
         hZwm+97fF0JaQlf9Df/uWZrV82IS6YTJ1PhOMgjl6zQlCbQi0XkSlZs0d6S8IccoPx0h
         LgG0gs1lzX+6N8siz+/eSOSh4nQ0fXnuyczJJ7G3hdc5xrke7ssYZ1g4sEP7T0ww/2Qd
         uFPb/klEza8/E/f5fZVhQYYVRPZhNdW5K25hKgOLGN01wlgpBaF5I3YgDhbDuR8jSeYB
         n34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=psNTl7b3xz3hbJPsvAGnz66wfWri0qx+KAw09sdE0Xk=;
        b=fjnsJUnnmmT+RkmiN5cUx2NuQSVMnfTCHhv2t1KgfMo1O6czBIlLXRLs2tQ0n2YmRO
         jouN5/VJgrR1UTuEY/HoLQ6tX6nOUwl0emg1fAfxxlyW0IaPU5+IFDA5OeljVQ3MC/cx
         w3VYX6+rKuyADpiKA6gA4HoVQX6jKQb+r48pZPJ3Yfhsuw2cDX2YobWrptRi9qKFAMnW
         p4lPcYM/s397y8s9ih4YryDtV3YldijcIzel5ej0X3BECgzQm2f37W0Suctpc1cuSH2a
         OTqI0l9Xu4aSTQbc1YfnqhtfTnCkpFi7569rKdlHSJ3lwprYxM4h0rhBnr33N3cmg7gr
         4ApQ==
X-Gm-Message-State: AOAM532ogi1YerXJKs3yIfYruzH/cuWQGmsb2/CG7qKFjotPvUc5RqDi
        ahkw35PMhjs1hGnJ0bUGWpA=
X-Google-Smtp-Source: ABdhPJzF0H2UhUM06r7ogNE4ze5O3T+jwsB+vZ9LcFaG7UcyVHIyQEqcnsknnU+9YRA9Py4WHSwiZw==
X-Received: by 2002:a5d:52c6:: with SMTP id r6mr14770656wrv.74.1591969855000;
        Fri, 12 Jun 2020 06:50:55 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id t8sm10020795wro.56.2020.06.12.06.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 06:50:53 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Changes for v5.8-rc1
Date:   Fri, 12 Jun 2020 15:50:49 +0200
Message-Id: <20200612135049.2341678-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Linus,

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.8-rc1

for you to fetch changes up to f5641d053d46a9a18fe13f2ecb4a7b4a66d9cdf7:

  pwm: Add missing "CONFIG_" prefix (2020-06-04 19:09:28 +0200)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v5.8-rc1

Nothing too exciting for this cycle. A couple of fixes across the board,
and Lee volunteered to help with patch review.

----------------------------------------------------------------
Christophe JAILLET (1):
      pwm: Add missing '\n' in log messages

Hans de Goede (1):
      pwm: lpss: Fix get_state runtime-pm reference handling

Jeff LaBundy (1):
      pwm: Add support for Azoteq IQS620A PWM generator

Kees Cook (1):
      pwm: Add missing "CONFIG_" prefix

Navid Emamdoost (1):
      pwm: img: Call pm_runtime_put() in pm_runtime_get_sync() failed case

Paul Cercueil (4):
      pwm: jz4740: Drop dependency on MACH_INGENIC
      pwm: jz4740: Enhance precision in calculation of duty cycle
      pwm: jz4740: Make PWM start with the active part
      pwm: jz4740: Add support for the JZ4725B

Peter Vasil (1):
      pwm: sun4i: Support direct clock output on Allwinner A64

Rasmus Villemoes (1):
      pwm: rockchip: Simplify rockchip_pwm_get_state()

Sandipan Patra (1):
      pwm: tegra: Support dynamic clock frequency configuration

Thierry Reding (1):
      MAINTAINERS: Add Lee Jones as reviewer for the PWM subsystem

Uwe Kleine-König (1):
      pwm: imx27: Fix rounding behavior

Yoshihiro Shimoda (1):
      dt-bindings: pwm: rcar: add r8a77961 support

 .../devicetree/bindings/pwm/renesas,pwm-rcar.yaml  |   1 +
 MAINTAINERS                                        |   1 +
 drivers/pwm/Kconfig                                |  12 +-
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/core.c                                 |   4 +-
 drivers/pwm/pwm-img.c                              |   8 +-
 drivers/pwm/pwm-imx27.c                            |  20 +-
 drivers/pwm/pwm-iqs620a.c                          | 270 +++++++++++++++++++++
 drivers/pwm/pwm-jz4740.c                           |  55 +++--
 drivers/pwm/pwm-lpss.c                             |  15 +-
 drivers/pwm/pwm-rockchip.c                         |   7 +-
 drivers/pwm/pwm-sun4i.c                            |   9 +
 drivers/pwm/pwm-tegra.c                            |  80 +++++-
 13 files changed, 438 insertions(+), 45 deletions(-)
 create mode 100644 drivers/pwm/pwm-iqs620a.c
