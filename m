Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22842961E0
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Oct 2020 17:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368726AbgJVPtI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 22 Oct 2020 11:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S368724AbgJVPtI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 22 Oct 2020 11:49:08 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B187EC0613CE;
        Thu, 22 Oct 2020 08:49:07 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id e22so2999912ejr.4;
        Thu, 22 Oct 2020 08:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uw1PkLLaqjDA3D1LrQql9HZhn0ykM5t9eiDbj0Ozf5s=;
        b=uwCXBd1dhXCe5gst/SzOkTHtb9XS3uate5r4meUw/CX8NlWwCmusg66qPlIv7MJLWy
         E9BpqczD8wJE00HWLMchk1lp7AX9P60C3a1z2WrECEhMDcVJePfkGRXoakZswv/19k6U
         srO6tuuq7uEdskdhuAYqC/ZbP1ZhuM98NXoUoOsN4bkNAGyQSxWfy3y6xgWnd7PdwQp6
         CNGokkb4MEthX5URrL3BgFee8KH9wScFY3ZAcHiEvP3DSJ4UNbhKoVkF+wboftEJ05gk
         EPmpuc5Cu9EJR7J0qVl/RTAGx1u2nsaG6iqJil76kHuI8HD48nw62WHcdRIF+FBRDeWb
         Ffxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uw1PkLLaqjDA3D1LrQql9HZhn0ykM5t9eiDbj0Ozf5s=;
        b=HBInIZ+uT+mt+6nbFNJdobui4G0Py6ZlujSciI9MBaSHzjaNzJuxAQbcLMEIK+SNTV
         QnRvaxWtqJ9mQ2OPyjohBJYCh/HFeN5qhfyVlfJ8orpp10KqcJp6rq1kP5N+oLlqXeiX
         Qkce3Lj40x9tE4JqvS4IFtQr1M5ii9e1Ge7PvZoIJ8Fg81o1TY8w7x4VRuFf9DtqMGbO
         9Jp9RgHnvaM1KW2/Kxa4lCS2cWvn0KzT0AE05XPQdjAo9Q1TL8fYHU7+tS0RZNMv+PLp
         jCpPK4hf03/n4gb87nGwCVbvQuQfj79j24BKEDtwFRRKv69+8oidFHB0oipc+JsvUcA+
         rtPg==
X-Gm-Message-State: AOAM532RNu6f3OOYu9xi8w6nUZ+Py20lOVb8uIYrVoj5JlVOtqMFxOix
        swju8cGK8+/oySCwoMNCbollYhGb2Uo=
X-Google-Smtp-Source: ABdhPJzutdogq5U2OoT78Ti5Kfdn0Jhn9txUlkqzajInUC0Qq15WRw/icu2uEGOihR/GDKh7Hbchmw==
X-Received: by 2002:a17:906:383:: with SMTP id b3mr2746485eja.351.1603381746362;
        Thu, 22 Oct 2020 08:49:06 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id j11sm1093256ejk.63.2020.10.22.08.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 08:49:05 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Changes for v5.10-rc1
Date:   Thu, 22 Oct 2020 17:49:03 +0200
Message-Id: <20201022154903.21929-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Linus,

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.10-rc1

for you to fetch changes up to 3b1954cd57bf7648417c593d60eac1ec661ad514:

  dt-bindings: pwm: renesas,pwm-rcar: Add r8a7742 support (2020-10-09 13:30:15 +0200)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v5.10-rc1

This release cycle's updates are mostly cleanup and some minor fixes.

----------------------------------------------------------------
David Jander (3):
      pwm: pca9685: Make comments more consistent
      pwm: pca9685: Use BIT() macro instead of shift
      pwm: pca9685: Disable unused alternative addresses

Hauke Mehrtens (1):
      pwm: img: Fix null pointer access in probe

Jarkko Nikula (1):
      pwm: Allow store 64-bit duty cycle from sysfs interface

Krzysztof Kozlowski (6):
      pwm: bcm2835: Simplify with dev_err_probe()
      pwm: jz4740: Simplify with dev_err_probe()
      pwm: rockchip: Simplify with dev_err_probe()
      pwm: sifive: Simplify with dev_err_probe()
      pwm: sprd: Simplify with dev_err_probe()
      pwm: sun4i: Simplify with dev_err_probe()

Lad Prabhakar (2):
      dt-bindings: pwm: renesas,tpu-pwm: Document r8a7742 support
      dt-bindings: pwm: renesas,pwm-rcar: Add r8a7742 support

Liu Shixin (1):
      pwm: Convert to use DEFINE_SEQ_ATTRIBUTE macro

Marian-Cristian Rotariu (1):
      dt-bindings: pwm: renesas,pwm-rcar: Add r8a774e1 support

Simon South (1):
      pwm: rockchip: Keep enabled PWMs running while probing

 .../devicetree/bindings/pwm/renesas,pwm-rcar.yaml  |  2 +
 .../devicetree/bindings/pwm/renesas,tpu-pwm.yaml   |  1 +
 drivers/pwm/core.c                                 | 17 ++------
 drivers/pwm/pwm-bcm2835.c                          | 10 ++---
 drivers/pwm/pwm-img.c                              |  3 +-
 drivers/pwm/pwm-jz4740.c                           |  9 ++---
 drivers/pwm/pwm-pca9685.c                          | 45 +++++++++++++---------
 drivers/pwm/pwm-rockchip.c                         | 15 ++++----
 drivers/pwm/pwm-sifive.c                           |  8 ++--
 drivers/pwm/pwm-sprd.c                             |  7 +---
 drivers/pwm/pwm-sun4i.c                            | 36 ++++++-----------
 drivers/pwm/sysfs.c                                |  4 +-
 12 files changed, 67 insertions(+), 90 deletions(-)
