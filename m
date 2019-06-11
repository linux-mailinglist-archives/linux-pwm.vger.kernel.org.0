Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 219ED3C37E
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Jun 2019 07:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391272AbfFKFpK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Jun 2019 01:45:10 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37641 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390492AbfFKFpK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Jun 2019 01:45:10 -0400
Received: by mail-pf1-f194.google.com with SMTP id 19so5845283pfa.4
        for <linux-pwm@vger.kernel.org>; Mon, 10 Jun 2019 22:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=AC7Q5AeoR3PoVwY63Fs/Bbr4OkIe7mdwRdwoih2xQXM=;
        b=d1SfvDdSO5LW24x4Uqc4ksCtu++Q8Xe8tw9gXshryTCJiPoZz0s2ehJGCuxbtZc+Vc
         r6bsQsx2OSum0krPWyUeMBF08aV5qMqV7CH5WYpZGKgU3egCYZ2nlkeWIuUEDScBt/xi
         yRikO4Lzu99FnXADtjH0CcY+k0YvtqIljAmC/BkxMNHA3BKUWQXAvueoRX+3vZPDl60X
         rwkil8iODmJ5O7viS3hwpEJKtVaxMzrCV6V3jfWxa21L+giD5wlK4eFdU0k9VV3/7xhl
         LpxWSib2rl0GSWmdXAxh+5cchiGRFjAGBkjBjoas/JZJ4e0WeGeaWRM2msuax0+vpcw4
         un3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AC7Q5AeoR3PoVwY63Fs/Bbr4OkIe7mdwRdwoih2xQXM=;
        b=TlxX6XOTD3OpB1SAAHrjAIONNoz4I6M81lts6rkW84ypnnz0u69Snae2RExbX3YtCK
         dhtYtprwsKA/G5e9aXDdiuG8W2nzdX8yx/jygO2U8miHGLhYNmFKV3Kt4CSasipLbFYn
         JQUleCLz+f2hfgJNV/wPLRXSzYxfCRWeD+LNJFu/A4X1ZCcFMX3Ojf9tLGGIp11kir7j
         7tOafFSBGHUu3ObzwBSQLjNbLudhM2eAZH0ID335m/fHcenNy/M0DNmKjP+nzqaX7KyE
         bOxOXIK0/D049b7Lr2KW7ubChFkWFe+zI4Hzs7o9NaO1boqomctliJzSrDI9HPrinkBz
         lGlQ==
X-Gm-Message-State: APjAAAUJ8LT2lsjLgT3NkjXtvgGxxwgrbeN8JOIbhRvTPGyamyLKFFAj
        B1+FoXEJoyQiYXBQ4vcCx+DpaA==
X-Google-Smtp-Source: APXvYqwBOvCQnw3NQjALS8zfnVm+kEy+W4gCD/woV1b1tFEZz2+HFTLQGa7knvwNAaCponAWXJ7SvQ==
X-Received: by 2002:a63:8049:: with SMTP id j70mr16231374pgd.63.1560231909490;
        Mon, 10 Jun 2019 22:45:09 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id d35sm11609228pgm.31.2019.06.10.22.45.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Jun 2019 22:45:08 -0700 (PDT)
From:   Yash Shah <yash.shah@sifive.com>
To:     thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, palmer@sifive.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        sachin.ghadi@sifive.com, Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v13 0/2] PWM support for HiFive Unleashed
Date:   Tue, 11 Jun 2019 11:14:42 +0530
Message-Id: <1560231884-15694-1-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This patch series adds a PWM driver and DT documentation
for HiFive Unleashed board. The patches are mostly based on
Wesley's patch.

This patchset is based on Linux v5.2-rc1 and tested on HiFive Unleashed
board with additional board related patches needed for testing can be
found at dev/yashs/pwm_v13 branch of:
https://github.com/yashshah7/riscv-linux.git

v13
- Rebased onto Mainline v5.2-rc1
- Correct the order of pwmchip_remove() after clk_disable() in .remove()

v12
- Rebased onto Mainline v5.1

v11
- Change naming convention for pwm_device and pwm_sifive_ddata pointers
- Assign of_pwm_xlate_with_flag() to of_xlate func ptr since this driver
  use three pwm-cells (Issue reported by Andreas Schwab <schwab@suse.de>
- Other minor fixes

v10
- Use DIV_ROUND_CLOSEST_ULL instead of div_u64_round
- Change 'num' defination to u64 bit (in pwm_sifive_apply).
- Remove the usage of pwm_get_state()

v9
- Use appropriate bitfield macros
- Add approx_period in pwm_sifive_ddata struct and related changes
- Correct the eqn for calculation of frac (in pwm_sifive_apply)
- Other minor fixes

v8
- Typo corrections
- Remove active_user and related code
- Do not clear PWM_SIFIVE_PWMCFG_EN_ALWAYS
- Other minor fixes

v7
- Modify description of compatible property in DT documentation
- Use mutex locks at appropriate places
- Fix all bad line breaks
- Allow enabling/disabling PWM only when the user is the only active user
- Remove Deglitch logic
- Other minor fixes

v6
- Remove the global property 'sifive,period-ns'
- Implement free and request callbacks to maintain user counts.
- Add user_count member to struct pwm_sifive_ddata
- Allow period change only if user_count is one
- Add pwm_sifive_enable function to enable/disable PWM
- Change calculation logic of frac (in pwm_sifive_apply)
- Remove state correction
- Remove pwm_sifive_xlate function
- Clock to be enabled only when PWM is enabled
- Other minor fixes

v5
- Correct the order of compatible string properties
- PWM state correction to be done always
- Other minor fixes based upon feedback on v4

v4
- Rename macros with appropriate names
- Remove unused macros
- Rename struct sifive_pwm_device to struct pwm_sifive_ddata
- Rename function prefix as per driver name
- Other minor fixes based upon feedback on v3

v3
- Add a link to the reference manaul
- Use appropriate apis for division operation
- Add check for polarity
- Enable clk before calling clk_get_rate
- Other minor fixes based upon feedback on v2

V2 changed from V1:
- Remove inclusion of dt-bindings/pwm/pwm.h
- Remove artificial alignments
- Replace ioread32/iowrite32 with readl/writel
- Remove camelcase
- Change dev_info to dev_dbg for unnecessary log
- Correct typo in driver name
- Remove use of of_match_ptr macro
- Update the DT compatible strings and Add reference to a common
  versioning document

Yash Shah (2):
  pwm: sifive: Add DT documentation for SiFive PWM Controller
  pwm: sifive: Add a driver for SiFive SoC PWM

 .../devicetree/bindings/pwm/pwm-sifive.txt         |  33 ++
 drivers/pwm/Kconfig                                |  11 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-sifive.c                           | 339 +++++++++++++++++++++
 4 files changed, 384 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt
 create mode 100644 drivers/pwm/pwm-sifive.c

-- 
1.9.1

