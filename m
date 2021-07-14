Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0254F3C7F79
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Jul 2021 09:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238214AbhGNHoV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Jul 2021 03:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238139AbhGNHoV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Jul 2021 03:44:21 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C1FC06175F;
        Wed, 14 Jul 2021 00:41:29 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l6so973904wmq.0;
        Wed, 14 Jul 2021 00:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HaPuVlFN93lFNEwDlqhYSbss+sw9P7bEYo9pp9pFNBY=;
        b=gpnWT3y8tV1w32BBPQhcFuhxi09k8qADlLloU8h5+tdIBgUgIjm+xIrrQ9sXdK89fC
         gtNJoJ/bAZPHxBMtRnlyr/TlCT6rfnRx8bu4tIs0xoZS32g/Pa2PW4IByyUB2uPNktlo
         d+BcQ1MPyPa3jllQ1Tjv8d6yFbaIjQmL+R5V68NQmZj2NXfHQc5pyRjAfUHmVdcPbQm5
         kBDDMIZ1OunkW8XBYvhzj0MtGU5wCKVx0Orz3DZH0E/M2d3urNQjcri7yR2pZiiSuyx+
         qTNOxzRyU4lLXkpVoQpjtSiN2ToQUN40mEu1fxdbg5332StcnywgLF4vzgIE5qM7trMD
         8AKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HaPuVlFN93lFNEwDlqhYSbss+sw9P7bEYo9pp9pFNBY=;
        b=fXzlvynHKxgz/QmSYhSiAt3TR9cfeOFAHB/QFHGtReOyQ3RoM+kIcTEK7HGYJriQkr
         sDKj5TpTfeC/Vq4jR7/dtlKqLR0y0ijDUXNeEGfrtl9WP3cmZjQ0qhJIsrRCcILOeaxu
         gSiMgQ6rJv8pUa9JHiApP2vMr6Cf97tYASwsPATgRM1L6n3vZ/kKGzTnXfDeeMhUY3Cy
         4ZUMNAjZO+viHZTOBaHllKepuWSQU3nWtwB5ysaAPBfOw8mPecVzMc6N96zzoRdRSfwA
         IqXOtvKdBpPllYachztgs9VnlBqwXgPwilYOh87d+lPQ/zsC9irhvj3KpM8eIG0lntaB
         piaQ==
X-Gm-Message-State: AOAM532U/lnqCinpj/ZhFuipppkYKxDwIj7Ajq0UehEPDfAYuzBpF27J
        NHk9LHQ3O1eKHCM6PZSLvYM=
X-Google-Smtp-Source: ABdhPJyUT5jMW/owtA/QgMEvgs+6KvHjgyA1PLfmkdMXeI7lpLNXKeK1ovn3oejwGVdR29Uia3XS8Q==
X-Received: by 2002:a05:600c:4ecc:: with SMTP id g12mr2604039wmq.118.1626248487936;
        Wed, 14 Jul 2021 00:41:27 -0700 (PDT)
Received: from localhost (p200300e41f023e00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f02:3e00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id l15sm1510464wrv.87.2021.07.14.00.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 00:41:26 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Fixes for v5.14-rc2
Date:   Wed, 14 Jul 2021 09:43:26 +0200
Message-Id: <20210714074326.89692-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Linus,

The following changes since commit bebedf2bb4a9e0cb4ffa72cbc960728051b338a4:

  pwm: Remove redundant assignment to pointer pwm (2021-07-07 21:43:32 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.14-rc2

for you to fetch changes up to f4a8e31ed84ec646c158824f423cb22d1f362bbf:

  pwm: ep93xx: Ensure configuring period and duty_cycle isn't wrongly skipped (2021-07-08 16:09:30 +0200)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Fixes for v5.14-rc2

This contains a couple of fixes from Uwe that I missed for v5.14-rc1.

----------------------------------------------------------------
Uwe Kleine-König (5):
      pwm: sprd: Ensure configuring period and duty_cycle isn't wrongly skipped
      pwm: spear: Ensure configuring period and duty_cycle isn't wrongly skipped
      pwm: tiecap: Ensure configuring period and duty_cycle isn't wrongly skipped
      pwm: berlin: Ensure configuring period and duty_cycle isn't wrongly skipped
      pwm: ep93xx: Ensure configuring period and duty_cycle isn't wrongly skipped

 drivers/pwm/pwm-berlin.c |  9 ++---
 drivers/pwm/pwm-ep93xx.c | 85 +++++++++++++++++++++++-------------------------
 drivers/pwm/pwm-spear.c  |  9 ++---
 drivers/pwm/pwm-sprd.c   | 11 +++----
 drivers/pwm/pwm-tiecap.c | 15 ++++-----
 5 files changed, 56 insertions(+), 73 deletions(-)
