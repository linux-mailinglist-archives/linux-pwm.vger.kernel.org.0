Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C073256D0
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Feb 2021 20:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbhBYTg6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 25 Feb 2021 14:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbhBYTfO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 25 Feb 2021 14:35:14 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9933C061756;
        Thu, 25 Feb 2021 11:34:33 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id n4so4399737wmq.3;
        Thu, 25 Feb 2021 11:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lVZp14Mcd8FycajwzlQP/vuilnLXZoOgy0eCNqGJ0m4=;
        b=J2OOoVb9u1EcBPPokPsurVn8KByV44J0ZX04iFk+WG9o0jK/+46MmhfxeokcEoOFq5
         1SsNH8pYoGUiLpKHMQP86m42LwO3m5cqVkkTTMtEH3h9j3A1hDP2wjXxmGMw+VreIScx
         QHIRtyPM302s6uvGDjg52bNin/2w++v8bV/rEK5Ehru6aC5aTw5w9nE4GLiDjD9mSTLM
         FRitHNTceFI9JT2yIT7UAxteMmM1HyEkLXVIfxmdGGDaSrC9mT1wGsZorSOAW3XrPvNP
         9ltDTJmirJrfXXpsJwMHWPa1JR27q6NA6dU+Lls+h/fvEYnxLLG7M/Az4+OEuvkLnH/Y
         iL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lVZp14Mcd8FycajwzlQP/vuilnLXZoOgy0eCNqGJ0m4=;
        b=qddflWq0/qRthxARGhzrgrJo1uwulMw3wWhHXQX0P30n8DMBqkU7bAEByw+54f8/Lv
         QyJuf8gwps61wVys5qYlauulXL/r3tersKdEPpYvCZbwUvXsDqe/xDngO574tJgLjmxN
         r/qccxITXfI1dDfgOBUtJYGKTPo3lITe6TFdptG3z2F7fNyNMWFmRU10P6flazL5LM6j
         ifWNUeTVX+wgTn/6H7b8Vo4kMmTb8S0fqoPtBeBTN9zxi0vHTotg/KdY9S5loNRT9bvo
         Ovj9TDPcaQH7+KlSP9+hD9ji5jAy+PmjDdNJb2p0hGZnZ8/yBGyNSf8TbmqD76g6T7Mh
         JBzA==
X-Gm-Message-State: AOAM532wTABxdZ7GZMJUkRMw2TbSdLE6LndI7hTPIc6mZC8JCZMK7JhA
        0H3ktz9oayP6GNfeohFH798=
X-Google-Smtp-Source: ABdhPJwi5c4JQV8ntU927+jDX4oN5q5lZTAZXC2Q5YRE4TxwY/2Geq592o1YkHgyFLECtmTfocsLmA==
X-Received: by 2002:a05:600c:4f94:: with SMTP id n20mr4670107wmq.78.1614281672529;
        Thu, 25 Feb 2021 11:34:32 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id k15sm8417005wmj.6.2021.02.25.11.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 11:34:31 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Changes for v5.12-rc1
Date:   Thu, 25 Feb 2021 20:34:26 +0100
Message-Id: <20210225193426.3679817-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Linus,

The following changes since commit 6eefb79d6f5bc4086bd02c76f1072dd4a8d9d9f6:

  pwm: sun4i: Remove erroneous else branch (2020-12-17 14:23:49 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.12-rc1

for you to fetch changes up to 9a9dd7e473517b68412fd2da3da8a4aeb4ecb38a:

  pwm: lpc18xx-sct: remove unneeded semicolon (2021-02-22 15:20:43 +0100)

As I was generating the pull request I noticed that I forgot to fast-
forward this to v5.11-rc1 after the last merge window. However, I did
not think a last-minute rebase was appropriate. I did go back and ran
my test builds on a rebase on top of v5.11-rc1 and everything checked
out, so I think this is safe to merge. Also, linux-next would have
caught any problems related to this. I'll make sure to properly roll
forward the branch next time.

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v5.12-rc1

The ZTE ZX platform is being removed, so the PWM driver is no longer
needed and removed as well. Other than that this contains a small set of
fixes and cleanups across a couple of drivers.

----------------------------------------------------------------
Arnd Bergmann (1):
      pwm: Remove ZTE ZX driver

Jeff LaBundy (1):
      pwm: iqs620a: Correct a stale state variable

Simon South (5):
      pwm: rockchip: Enable APB clock during register access while probing
      pwm: rockchip: rockchip_pwm_probe(): Remove superfluous clk_unprepare()
      pwm: rockchip: Replace "bus clk" with "PWM clk"
      pwm: rockchip: Eliminate potential race condition when probing
      pwm: rockchip: Enable clock before calling clk_get_rate()

Uwe Kleine-König (1):
      pwm: iqs620a: Fix overflow and optimize calculations

Yang Li (1):
      pwm: lpc18xx-sct: remove unneeded semicolon

 Documentation/devicetree/bindings/pwm/pwm-zx.txt |  22 --
 drivers/pwm/Kconfig                              |  10 -
 drivers/pwm/Makefile                             |   1 -
 drivers/pwm/pwm-iqs620a.c                        |  94 ++++----
 drivers/pwm/pwm-lpc18xx-sct.c                    |   2 +-
 drivers/pwm/pwm-rockchip.c                       |  32 ++-
 drivers/pwm/pwm-zx.c                             | 278 -----------------------
 7 files changed, 65 insertions(+), 374 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-zx.txt
 delete mode 100644 drivers/pwm/pwm-zx.c
