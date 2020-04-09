Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7E011A2F8E
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Apr 2020 08:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgDIGxJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Apr 2020 02:53:09 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:47343 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726627AbgDIGw5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Apr 2020 02:52:57 -0400
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 08 Apr 2020 23:52:55 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg01-sd.qualcomm.com with ESMTP; 08 Apr 2020 23:52:53 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id E4C474C4D; Wed,  8 Apr 2020 23:52:53 -0700 (PDT)
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Guru Das Srinagesh <gurus@codeaurora.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        Arnd Bergmann <arnd@arndb.de>,
        Atish Patra <atish.patra@wdc.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Fabio Estevam <festevam@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joe Perches <joe@perches.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Fontana <rfontana@redhat.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v12 00/11] Convert PWM period and duty cycle to u64
Date:   Wed,  8 Apr 2020 23:52:29 -0700
Message-Id: <cover.1586414867.git.gurus@codeaurora.org>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Because period and duty cycle are defined in the PWM framework structs as ints
with units of nanoseconds, the maximum time duration that can be set is limited
to ~2.147 seconds. Consequently, applications desiring to set greater time
periods via the PWM framework are not be able to do so - like, for instance,
causing an LED to blink at an interval of 5 seconds.

Redefining the period and duty cycle struct members in the core PWM framework
structs as u64 values will enable larger time durations to be set and solve
this problem. Such a change to the framework mandates that drivers using these
struct members (and corresponding helper functions) also be modified correctly
in order to prevent compilation errors.

This patch series introduces the changes to all the drivers first, followed by
the framework change at the very end so that when the latter is applied, all
the drivers are in good shape and there are no compilation errors.

Changes from v11:
  - Rebased to tip of for-next.
  - Collected "Acked-by:" for v7 (unchanged) of pwm: sifive: [4]
  - Squished stm32-lp.c change with final patch in series
  - sun4i: Used nsecs_to_jiffies()
  - imx27: Added overflow handling logic
  - clps711x: Corrected the if condition for skipping the division
  - clk: pwm: Reverted to v8 version, added check to prevent division-by-zero

Changes from v10:
  - Carefully added back all the "Reviewed-by: " and "Acked-by: " tags received
    so far that had gotten missed in v9. No other changes.

Changes from v9:
  - Gathered the received "Reviewed-by: " tag
  - Added back the clk-pwm.c patch because kbuild test robot complained [3]
    and addressed received review comments.
  - clps711x: Addressed review comments.

Changes from v8:
  - Gathered all received "Acked-by: " and "Reviewed-by: " tags
  - Dropped patch to clk-pwm.c for reasons mentiond in [2]
  - Expanded audience of unreviewed patches

Changes from v7:
  - Changed commit messages of all patches to be brief and to the point.
  - Added explanation of change in cover letter.
  - Dropped change to pwm-sti.c as upon review it was unnecessary as struct
    pwm_capture is not being modified in the PWM core.

Changes from v6:
  - Split out the driver changes out into separate patches, one patch per file
    for ease of reviewing.

Changes from v5:
  - Dropped the conversion of struct pwm_capture to u64 for reasons mentioned
    in https://www.spinics.net/lists/linux-pwm/msg11541.html

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

Changes from v3:
  - Rebased to current tip of for-next.

Changes from v2:
  - Fixed %u -> %llu in a dev_dbg in pwm-stm32-lp.c, thanks to kbuild test robot
  - Added a couple of fixes to pwm-imx-tpm.c and pwm-sifive.c

Changes from v1:
  - Fixed compilation errors seen when compiling for different archs.

v1:
  - Reworked the change pushed upstream earlier [1] so as to not add an
    extension to an obsolete API. With this change, pwm_ops->apply() can be
    used to set pwm_state parameters as usual.

[1] https://lore.kernel.org/lkml/20190916140048.GB7488@ulmo/
[2] https://lore.kernel.org/lkml/20200312190859.GA19605@codeaurora.org/
[3] https://www.spinics.net/lists/linux-pwm/msg11906.html
[4] https://www.spinics.net/lists/linux-pwm/msg11986.html

Cc: Alexander Shiyan <shc_work@mail.ru>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Atish Patra <atish.patra@wdc.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Joe Perches <joe@perches.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Richard Fontana <rfontana@redhat.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "Ville Syrjälä" <ville.syrjala@linux.intel.com>
Cc: Yash Shah <yash.shah@sifive.com>

Guru Das Srinagesh (11):
  drm/i915: Use 64-bit division macro
  hwmon: pwm-fan: Use 64-bit division macro
  ir-rx51: Use 64-bit division macro
  pwm: clps711x: Cast period to u32 before use as divisor
  pwm: pwm-imx-tpm: Use 64-bit division macro
  pwm: imx27: Use 64-bit division macro and function
  pwm: sifive: Use 64-bit division macro
  pwm: sun4i: Use nsecs_to_jiffies to avoid a division
  backlight: pwm_bl: Use 64-bit division function
  clk: pwm: Use 64-bit division function
  pwm: core: Convert period and duty cycle to u64

 drivers/clk/clk-pwm.c                      |  7 +++-
 drivers/gpu/drm/i915/display/intel_panel.c |  2 +-
 drivers/hwmon/pwm-fan.c                    |  2 +-
 drivers/media/rc/ir-rx51.c                 |  3 +-
 drivers/pwm/core.c                         | 14 ++++----
 drivers/pwm/pwm-clps711x.c                 |  5 ++-
 drivers/pwm/pwm-imx-tpm.c                  |  2 +-
 drivers/pwm/pwm-imx27.c                    | 53 +++++++++++++++++++++++++-----
 drivers/pwm/pwm-sifive.c                   |  2 +-
 drivers/pwm/pwm-stm32-lp.c                 |  2 +-
 drivers/pwm/pwm-sun4i.c                    |  2 +-
 drivers/pwm/sysfs.c                        |  8 ++---
 drivers/video/backlight/pwm_bl.c           |  3 +-
 include/linux/pwm.h                        | 12 +++----
 14 files changed, 82 insertions(+), 35 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

