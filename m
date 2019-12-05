Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D241D113B93
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Dec 2019 07:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbfLEGKv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 5 Dec 2019 01:10:51 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40445 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfLEGKv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 5 Dec 2019 01:10:51 -0500
Received: by mail-wm1-f67.google.com with SMTP id t14so2261460wmi.5;
        Wed, 04 Dec 2019 22:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ArLi67MutEfJm1xYk1UV39NkETu8w3LGxgZUr4uMUhM=;
        b=qPVow2Hk4o5+1WIh/HU4A9dCAFKXssaxFnoREXVgfUNekkba6Xp6ZKKXTJfa7FqxiE
         rNSNKrMGQERENYIfxVKffRhoBrS9s38aEA5Qgv40ZFBLXI1Vr6npC7a2yyOyK+UBau9H
         7eG2IyAD2RIf18w9lax1HQfN8F/LhFVI3q1G+bySK0ebfH3mPCTDeHgJ0xkNa1fvk1qd
         TQ1+bHp1zBEIrT7oM+ZLS7XoEbix4k2YfjcUpj8xmiOBtGjeKCa4g4PsP6KXXVgQTvXF
         dz/ip/GEI6QzCy2w7iPG+e0kuazsRSkG5KTRmcwJgEOW80lZCnoK5yC+/1OJWwlDoSnw
         R+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ArLi67MutEfJm1xYk1UV39NkETu8w3LGxgZUr4uMUhM=;
        b=gb2BOIy3IGGoMZHx8Zd6lTDR7+Hak+socuDwi3qmi1zkmjY9ISE3ZyPWjLijn2X0jA
         1t6/B2I16mQoiY7Al/6qfHstpNPeLPQHMpdfo2D7p82UM+0su0CX+cNBfEehm83Hzr3A
         KTUWZG/83cSrwYGYl8AV+0/WCwfBgT8hXfP4fq5BpIirPwjicPxjD/eNgqtMj0rtKOSP
         Eshimm5xlIZcDHfHCfygLH2/dgJf9VHCuTuGFbFqgUNLYiRZWKO1MhxW13Rh03R2wUqm
         SsgXXElwtKEOnL0fGXS/fdxcFP5HdyOHWBs8CSFbPD4FRuY967Dd9FhH2/aosO5QbYVP
         +LCA==
X-Gm-Message-State: APjAAAWe/BCF1cAS+aAIgO6emoeJ8/0uH7TrNgZDhMP/XjV7VDFOT0ew
        Ov9/c+HQ9JYnWuYJq881tTk=
X-Google-Smtp-Source: APXvYqyaq4P8aZhdb+VYjY2oEPts6nfj2eJx99tS+iwSemPDHGSF/vEPXx8w+j2MAIM5a62SPtVpog==
X-Received: by 2002:a1c:f404:: with SMTP id z4mr3069874wma.12.1575526248274;
        Wed, 04 Dec 2019 22:10:48 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id e18sm12477940wrw.70.2019.12.04.22.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 22:10:47 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Changes for v5.5-rc1
Date:   Thu,  5 Dec 2019 07:10:44 +0100
Message-Id: <20191205061044.1006766-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Linus,

The following changes since commit 40a6b9a00930fd6b59aa2eb6135abc2efe5440c3:

  Revert "pwm: Let pwm_get_state() return the last implemented state" (2019-10-21 16:48:52 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.5-rc1

for you to fetch changes up to f5ff2628867b9c7cb4abb6c6a5a7eea079dad4b6:

  pwm: imx27: Unconditionally write state to hardware (2019-10-21 16:58:09 +0200)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v5.5-rc1

Various changes and minor fixes across a couple of drivers.

----------------------------------------------------------------
Colin Ian King (1):
      pwm: sun4i: Drop redundant assignment to variable pval

Fabrice Gasnier (3):
      dt-bindings: pwm-stm32: Document pinctrl sleep state
      pwm: stm32: Split breakinput apply routine to ease PM support
      pwm: stm32: Add power management support

Ondrej Jirman (1):
      pwm: sun4i: Fix incorrect calculation of duty_cycle/period

Rasmus Villemoes (1):
      pwm: Update comment on struct pwm_ops::apply

Thierry Reding (8):
      dt-bindings: pwm: mediatek: Remove gratuitous compatible string for MT7629
      pwm: stm32: Validate breakinput data from DT
      pwm: stm32: Remove clutter from ternary operator
      pwm: stm32: Pass breakinput instead of its values
      pwm: Read initial hardware state at request time
      pwm: cros-ec: Cache duty cycle value
      pwm: imx27: Cache duty cycle register value
      pwm: imx27: Unconditionally write state to hardware

 .../devicetree/bindings/pwm/pwm-mediatek.txt       |   2 +-
 .../devicetree/bindings/pwm/pwm-stm32.txt          |   8 +-
 drivers/pwm/core.c                                 |   6 +-
 drivers/pwm/pwm-cros-ec.c                          |  58 ++++++++-
 drivers/pwm/pwm-imx27.c                            | 137 ++++++++++++---------
 drivers/pwm/pwm-stm32.c                            | 112 ++++++++++++-----
 drivers/pwm/pwm-sun4i.c                            |   5 +-
 include/linux/mfd/stm32-timers.h                   |  12 +-
 include/linux/pwm.h                                |   5 +-
 9 files changed, 228 insertions(+), 117 deletions(-)
