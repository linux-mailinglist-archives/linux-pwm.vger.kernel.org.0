Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7C83FE6C2
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Nov 2019 22:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfKOVDF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 15 Nov 2019 16:03:05 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:56931 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726567AbfKOVDE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 15 Nov 2019 16:03:04 -0500
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 15 Nov 2019 13:02:37 -0800
IronPort-SDR: GZO1xmP+vwE6tRS0wMvCmVAmH8iiCxZNUgMWWzAO5aQAYwTpobVIkyciYCtGGLzbgyZS8DfjGo
 N6+ceEUObPr34rBEPsWRRrSLc7eveuV2o=
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP; 15 Nov 2019 13:02:37 -0800
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id 4626F47B8; Fri, 15 Nov 2019 13:02:37 -0800 (PST)
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>, kernel-team@android.com,
        Mark Salyzyn <salyzyn@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Guru Das Srinagesh <gurus@codeaurora.org>
Subject: [PATCH v3 0/1] Convert period and duty cycle to u64
Date:   Fri, 15 Nov 2019 13:02:31 -0800
Message-Id: <cover.1573851299.git.gurus@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Reworked the change pushed upstream earlier [1] so as to not add an extension
to an obsolete API. With this change, pwm_ops->apply() can be used to set
pwm_state parameters as usual.

[1] https://lore.kernel.org/lkml/20190916140048.GB7488@ulmo/

Changes from v1:
  - Fixed compilation errors seen when compiling for different archs.

Changes from v2:
  - Fixed %u -> %llu in a dev_dbg in pwm-stm32-lp.c, thanks to kbuild test robot
  - Added a couple of fixes to pwm-imx-tpm.c and pwm-sifive.c

Guru Das Srinagesh (1):
  pwm: Convert period and duty cycle to u64

 drivers/clk/clk-pwm.c                      |  2 +-
 drivers/gpu/drm/i915/display/intel_panel.c |  2 +-
 drivers/hwmon/pwm-fan.c                    |  2 +-
 drivers/media/rc/ir-rx51.c                 |  3 ++-
 drivers/pwm/core.c                         |  4 ++--
 drivers/pwm/pwm-clps711x.c                 |  2 +-
 drivers/pwm/pwm-imx-tpm.c                  |  2 +-
 drivers/pwm/pwm-imx27.c                    |  5 ++---
 drivers/pwm/pwm-sifive.c                   |  2 +-
 drivers/pwm/pwm-sti.c                      |  4 ++--
 drivers/pwm/pwm-stm32-lp.c                 |  2 +-
 drivers/pwm/pwm-sun4i.c                    |  2 +-
 drivers/pwm/sysfs.c                        | 10 +++++-----
 drivers/video/backlight/pwm_bl.c           |  3 ++-
 include/linux/pwm.h                        | 16 ++++++++--------
 15 files changed, 31 insertions(+), 30 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

