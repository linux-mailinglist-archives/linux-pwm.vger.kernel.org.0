Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D8A44E497
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Nov 2021 11:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbhKLKeV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 12 Nov 2021 05:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234917AbhKLKeU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 12 Nov 2021 05:34:20 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D312C061766;
        Fri, 12 Nov 2021 02:31:30 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id c4so14622326wrd.9;
        Fri, 12 Nov 2021 02:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GRId0R89X51NxidyOU+NSWQUAWm4NbnKVuU1z19yzt4=;
        b=ZU/2z553bDzH+m3p+tYs90x6L9v3GNYm9JQIFO0yg0pkYU4ffz9BEs6VPoXegk3AkR
         a7LjF5CGE++BwkfXdX0anqyZTg2Axkgana/DquGmQhgnZxm0uKMkzYHAcfUkAJW3Zpe4
         he3mXF5rlzAymg/Ty2oiLYq1To40h3SiuaCEFlIKGgdDmwj82BfhoyCALDu8bg9UtWIo
         3uA9Iv9fQi5GYBERTqFo/f751lunx12xFD9rlsHVT5rVrhLvatvGuPYuArs08+AkcZNm
         ccbnP/c5MDFqUBDPPe5i0yBEcpzIapK774BtUKNDtQQJwNekdJKTYUZl54oEZzO/AMjn
         tnKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GRId0R89X51NxidyOU+NSWQUAWm4NbnKVuU1z19yzt4=;
        b=ZrQiojW5NQ4rbYm4jE53z5HOdkr3SR5AoLvQ98ziwDsE6iVVHsakVe+oFKcikBFlhD
         9+bcQEv10HASoA1WzYY8BoZekw7VfXFfC/hfmNr9wufCigL92z+4Yz4fN5BsXwEYB4Pd
         TD3kluMKLBNf0WL9HGo4LM1Mm4m8bX0mdzL5TcdMdNgjmW9Yfuy11zi+sRjhDUKC+8W4
         /yLdZZX4v3gXcSsC6K5pjnaX9QZaApsvHgmz3+gsCa6WicVbMBLL1w5+xS3nrd/zDaQZ
         EutuxfPkCNECEjZB5fplsg5lTOtcW5mH9zxVybA3wS98jU79EJidL/zsUSG0kSYHzBOZ
         kV0Q==
X-Gm-Message-State: AOAM531joMQ8jJfs8qtL8DKOQfnH+d1dnnlCku6TMioSwS7GLIHxn5ZP
        Bu648b/IomZpOWCWqo+p+Kw=
X-Google-Smtp-Source: ABdhPJxDqxg4v9yVykQ4C/B8MDUNjaPAb/R3xkxgNtav3U0DAlCgmaIQ/I5iXvNLWebmGepi6Pqz+g==
X-Received: by 2002:a05:6000:1787:: with SMTP id e7mr16958321wrg.433.1636713088636;
        Fri, 12 Nov 2021 02:31:28 -0800 (PST)
Received: from localhost ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id l4sm5163329wrv.94.2021.11.12.02.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 02:31:27 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Changes for v5.16-rc1
Date:   Fri, 12 Nov 2021 11:31:22 +0100
Message-Id: <20211112103122.3664089-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Linus,

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.16-rc1

for you to fetch changes up to e9d866d5a6296c701e5b46a94c0bbd6e2c0e357e:

  pwm: vt8500: Rename pwm_busy_wait() to make it obviously driver-specific (2021-11-05 11:57:13 +0100)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v5.16-rc1

This set is mostly small fixes and cleanups, so more of a janitorial
update for this cycle.

----------------------------------------------------------------
Duc Nguyen (1):
      dt-bindings: pwm: tpu: Add R-Car V3U device tree bindings

Krzysztof Kozlowski (1):
      pwm: samsung: Describe driver in Kconfig

Mårten Lindahl (1):
      pwm: pwm-samsung: Trigger manual update when disabling PWM

Uwe Kleine-König (4):
      pwm: atmel: Drop unused header
      pwm: Add might_sleep() annotations for !CONFIG_PWM API functions
      pwm: Make it explicit that pwm_apply_state() might sleep
      pwm: vt8500: Rename pwm_busy_wait() to make it obviously driver-specific

Wolfram Sang (1):
      dt-bindings: pwm: tpu: Add R-Car M3-W+ device tree bindings

zhaoxiao (1):
      pwm: visconti: Simplify using devm_pwmchip_add()

 .../devicetree/bindings/pwm/renesas,tpu-pwm.yaml   |  2 ++
 drivers/pwm/Kconfig                                |  4 ++-
 drivers/pwm/core.c                                 |  9 +++++++
 drivers/pwm/pwm-atmel.c                            |  1 -
 drivers/pwm/pwm-samsung.c                          | 30 ++++++++++++++++------
 drivers/pwm/pwm-visconti.c                         | 14 +---------
 drivers/pwm/pwm-vt8500.c                           | 16 ++++++------
 include/linux/pwm.h                                | 13 ++++++++++
 8 files changed, 58 insertions(+), 31 deletions(-)
