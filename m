Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7BE21532C7
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2020 15:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgBEOZP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 5 Feb 2020 09:25:15 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38649 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbgBEOZP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 5 Feb 2020 09:25:15 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so2971662wrh.5;
        Wed, 05 Feb 2020 06:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qhXaXnj7gj/UHklOFLVC+u57GTsIaZTNIrcJnG9KwhE=;
        b=fdGw10ukTIsbS2IUVXIBEXDsk9f1aqfr64xNDeQWjMSCOeqW7Dnd8t0aiFkXZM6/Er
         Xe7xgLe4QfDWWneBciDvkyQWsNC+khv4RYeT7nGoTptdMg/55rxqqoVEfPrG0bNdWUlp
         iN4SSMlEaESmaY8C7gxXiS7cIc/VcnqQuOAQrIdvMgGJKRMvmxPRQTGIDhRwy+sBo2gM
         QwRioT3VjASh7CUqlUdkRD68+lkTslQWU6my8Siu0GAWicZ5CPasCBkS6JgYa9wHtkGj
         S8FWa5Q/OI9mOE8NzeNbDogcHvqeKQ5thc80jYEF2QiYK/3JThwzaJtvko2Xts1HXRr0
         sq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qhXaXnj7gj/UHklOFLVC+u57GTsIaZTNIrcJnG9KwhE=;
        b=cWN4P0UKOHIjJ4M5LFSJymkztjOL4nqm2NLVKiGiQuIe3qCd02A4tDJ6v+MxQcGIrK
         xpeswsBV4fBilx6s7w9qrN4csZq3w8X7x6xBBUS28hiKWXbX3HQL2UHNtu2I+9HANJne
         veHf+UY6l/WaoP9TQjEKJO7vgYEjqZHCDefBiPhHrMqm2qOSMPvaq73X08XSvn9pOWcR
         8S0QH6kPvqs/9j2cty6ctfHUZFg+SLULNkMZT9cVcdAK6E+FlFF5t8F3xDk8c0Hl3OJX
         xrX5qQomqsgTFsihID2ysCTCoEyScWS0ovMOqXWGqOMerVK84yNn/+gF53DSJjUm1DNK
         gBzQ==
X-Gm-Message-State: APjAAAUci8USNyhyqBTfIatxetuQMtFvled3k+SKq1jPzDHn4slf9ajs
        Bn9fzAygqyMJv672GIxQjbc=
X-Google-Smtp-Source: APXvYqx6w55XElDxgPBTYbaClZFgVcTjDyhPQxSHuYzRC0KycfMhsXQ7RV3nUG6/jMgm6hWBAntEAg==
X-Received: by 2002:adf:f8c4:: with SMTP id f4mr27352188wrq.243.1580912713282;
        Wed, 05 Feb 2020 06:25:13 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id e18sm33846336wrw.70.2020.02.05.06.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 06:25:12 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Changes for v5.6-rc1
Date:   Wed,  5 Feb 2020 15:25:11 +0100
Message-Id: <20200205142511.2172050-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Linus,

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.6-rc1

for you to fetch changes up to 9871abffc81048e20f02e15d6aa4558a44ad53ea:

  pwm: Remove set but not set variable 'pwm' (2020-01-20 15:40:49 +0100)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v5.6-rc1

This set of changes are mostly cleanups and minor improvements with some
new chip support for some drivers.

----------------------------------------------------------------
Anson Huang (1):
      pwm: imx27: Eliminate error message for defer probe

Clément Péron (3):
      pwm: sun4i: Prefer "mod" clock to unnamed
      pwm: sun4i: Always calculate params when applying new parameters
      pwm: sun4i: Move pwm_calculate() out of spin_lock()

Fabrice Gasnier (1):
      pwm: stm32: Remove automatic output enable

Florian Fainelli (1):
      pwm: bcm2835: Allow building for ARCH_BRCMSTB

Gustavo A. R. Silva (1):
      pwm: sun4i: Fix inconsistent IS_ERR and PTR_ERR

Jernej Skrabec (4):
      pwm: sun4i: Add an optional probe for reset line
      pwm: sun4i: Add an optional probe for bus clock
      pwm: sun4i: Add support to output source clock directly
      pwm: sun4i: Add support for H6 PWM

Krzysztof Kozlowski (1):
      pwm: Fix minor Kconfig whitespace issues

Rasmus Villemoes (5):
      pwm: mxs: Implement ->apply()
      pwm: mxs: Remove legacy methods
      pwm: mxs: Add support for inverse polarity
      dt-bindings: pwm: mxs-pwm: Increase #pwm-cells
      pwm: mxs: Avoid a division in mxs_pwm_apply()

Thierry Reding (5):
      pwm: Read initial hardware state at request time
      pwm: cros-ec: Cache duty cycle value
      pwm: imx27: Cache duty cycle register value
      pwm: imx27: Unconditionally write state to hardware
      pwm: sun4i: Initialize variables before use

Uwe Kleine-König (14):
      pwm: atmel: Add a hint where to find hardware documentation
      pwm: atmel: Use a constant for maximum prescale value
      pwm: atmel: Replace loop in prescale calculation by ad-hoc calculation
      pwm: atmel: Document known weaknesses of both hardware and software
      pwm: atmel: Use register accessors for channels
      pwm: atmel: Implement .get_state()
      pwm: rcar: Drop useless call to pwm_get_state()
      pwm: rcar: Document inability to set duty_cycle = 0
      pwm: Implement tracing for .get_state() and .apply_state()
      pwm: omap-dmtimer: Remove PWM chip in .remove before making it unfunctional
      pwm: omap-dmtimer: Simplify error handling
      pwm: omap-dmtimer: put_device() after of_find_device_by_node()
      pwm: omap-dmtimer: Allow compiling with COMPILE_TEST
      pwm: sun4i: Narrow scope of local variable

yu kuai (1):
      pwm: Remove set but not set variable 'pwm'

 Documentation/devicetree/bindings/pwm/mxs-pwm.txt |   4 +-
 drivers/pwm/Kconfig                               |   9 +-
 drivers/pwm/core.c                                |  13 +-
 drivers/pwm/pwm-atmel.c                           |  87 ++++++++--
 drivers/pwm/pwm-cros-ec.c                         |  58 ++++++-
 drivers/pwm/pwm-imx27.c                           | 147 +++++++++-------
 drivers/pwm/pwm-mxs.c                             | 101 ++++++-----
 drivers/pwm/pwm-omap-dmtimer.c                    |  54 ++++--
 drivers/pwm/pwm-pca9685.c                         |   4 -
 drivers/pwm/pwm-rcar.c                            |   5 +-
 drivers/pwm/pwm-stm32.c                           |   4 +-
 drivers/pwm/pwm-sun4i.c                           | 194 ++++++++++++++++++----
 include/trace/events/pwm.h                        |  58 +++++++
 13 files changed, 539 insertions(+), 199 deletions(-)
 create mode 100644 include/trace/events/pwm.h
