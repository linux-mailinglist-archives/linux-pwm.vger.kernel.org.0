Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDBD3FD8A3
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Nov 2019 10:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfKOJVK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 15 Nov 2019 04:21:10 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:27990 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726196AbfKOJVK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 15 Nov 2019 04:21:10 -0500
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 15 Nov 2019 01:21:09 -0800
IronPort-SDR: bTBONXy8IgvXHhxDd1u8k/0j6HRKEPo/egG7tsgY/mVNkixUorsJ9CYjAs28tE9ULm5TDQ4QGj
 IBol9hI9RlIMyvfnjV04COxoBY67uVUIVPdSBGsFjG1Nzym/s+DQU187dp68jySPCjL2IZnnlp
 x0v4/YcjI2rWnTL3fdaSxA41gtA0YuqLCvYYr4cMH302fYmlltjtTs4ALQBN10O9WAziKinrzP
 wBJHD2Rfco+r+tIKyvlgfIE089U6J+C9Boi4qzOjGcy5MYYXEy+W5eL+3XY6SHd1K2tfXkrw+7
 AkgeJdB+jLXDBuqPhs/IMC8b
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg03-sd.qualcomm.com with ESMTP; 15 Nov 2019 01:21:09 -0800
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id 39E8521F5; Fri, 15 Nov 2019 01:21:09 -0800 (PST)
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>, kernel-team@android.com,
        Mark Salyzyn <salyzyn@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Guru Das Srinagesh <gurus@codeaurora.org>
Subject: [PATCH v2 0/1] Convert period and duty cycle to u64
Date:   Fri, 15 Nov 2019 01:21:02 -0800
Message-Id: <cover.1573809232.git.gurus@codeaurora.org>
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

Guru Das Srinagesh (1):
  pwm: Convert period and duty cycle to u64

 drivers/clk/clk-pwm.c                      |  2 +-
 drivers/gpu/drm/i915/display/intel_panel.c |  2 +-
 drivers/hwmon/pwm-fan.c                    |  2 +-
 drivers/media/rc/ir-rx51.c                 |  3 ++-
 drivers/pwm/core.c                         |  4 ++--
 drivers/pwm/pwm-clps711x.c                 |  2 +-
 drivers/pwm/pwm-imx27.c                    |  5 ++---
 drivers/pwm/pwm-sti.c                      |  4 ++--
 drivers/pwm/pwm-sun4i.c                    |  2 +-
 drivers/pwm/sysfs.c                        | 10 +++++-----
 drivers/video/backlight/pwm_bl.c           |  3 ++-
 include/linux/pwm.h                        | 16 ++++++++--------
 12 files changed, 28 insertions(+), 27 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

