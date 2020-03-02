Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7DA176404
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Mar 2020 20:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbgCBTe0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 2 Mar 2020 14:34:26 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:36504 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727234AbgCBTe0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 2 Mar 2020 14:34:26 -0500
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 02 Mar 2020 11:34:25 -0800
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg02-sd.qualcomm.com with ESMTP; 02 Mar 2020 11:34:25 -0800
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id 7BEE74B04; Mon,  2 Mar 2020 11:34:25 -0800 (PST)
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Guru Das Srinagesh <gurus@codeaurora.org>
Subject: [RESEND v6 0/2] Convert period and duty cycle to u64
Date:   Mon,  2 Mar 2020 11:34:21 -0800
Message-Id: <cover.1583177501.git.gurus@codeaurora.org>
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

Changes from v3:
  - Rebased to current tip of for-next.

Changes from v4:
  - Split the patch into two: one for changes to the drivers, and the actual
    switch to u64 for ease of reverting should the need arise.
  - Re-examined the patch and made the following corrections:
      * intel_panel.c:
	DIV64_U64_ROUND_UP -> DIV_ROUND_UP_ULL (as only the numerator would be
	64-bit in this case).
      * pwm-sti.c:
	do_div -> div_u64 (do_div is optimized only for x86 architectures, and
	div_u64's comment block suggests to use this as much as possible).

Changes from v5:
  - Dropped the conversion of struct pwm_capture to u64 for reasons mentioned
    in https://www.spinics.net/lists/linux-pwm/msg11541.html


Guru Das Srinagesh (2):
  pwm: Convert drivers to use 64-bit period and duty cycle
  pwm: core: Convert period and duty cycle to u64

 drivers/clk/clk-pwm.c                      |  2 +-
 drivers/gpu/drm/i915/display/intel_panel.c |  2 +-
 drivers/hwmon/pwm-fan.c                    |  2 +-
 drivers/media/rc/ir-rx51.c                 |  3 ++-
 drivers/pwm/core.c                         |  4 ++--
 drivers/pwm/pwm-clps711x.c                 |  2 +-
 drivers/pwm/pwm-imx-tpm.c                  |  2 +-
 drivers/pwm/pwm-imx27.c                    |  5 ++---
 drivers/pwm/pwm-sifive.c                   |  2 +-
 drivers/pwm/pwm-sti.c                      |  5 +++--
 drivers/pwm/pwm-stm32-lp.c                 |  2 +-
 drivers/pwm/pwm-sun4i.c                    |  2 +-
 drivers/pwm/sysfs.c                        |  8 ++++----
 drivers/video/backlight/pwm_bl.c           |  3 ++-
 include/linux/pwm.h                        | 12 ++++++------
 15 files changed, 29 insertions(+), 27 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

