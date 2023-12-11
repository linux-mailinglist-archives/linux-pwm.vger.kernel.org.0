Return-Path: <linux-pwm+bounces-492-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 054F380C2FC
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Dec 2023 09:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A613B1F20F0A
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Dec 2023 08:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6067620B39;
	Mon, 11 Dec 2023 08:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="HmYgoJPd";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="J1n3irC2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF78B6;
	Mon, 11 Dec 2023 00:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1702283108; bh=bdWuptrbipE0PwzncdIauG8w5KPE09xoJ3vuSR6axY0=;
	h=From:To:Cc:Subject:Date:From;
	b=HmYgoJPdUZR+eQiq+jXskVqSs8SEgnD5vPlaUZqRpe+CfdPEjqSRo8sQb23R6INER
	 soc1TozRn7ZkzMtrGmYCpovEoxceVKL1R7qshgRBSaayqFKphLGyyQImJ7UhtNo9PH
	 ZRMCg+OrfWIMrozq3o7n7uSKqvrYb4ghzkq/268lmkJaLJz0jiayXYzs76d9UcHz1V
	 6j6YjdqcOW6wJTSZs90UK9KG0S2+Ta3R7KYMHqkrbyISHiVuJBK1GN/Eu4R6ewt4f8
	 daoubCOItXA2eWHOP3kgBOp3mxde8OAjkrI+WzsJLCQ9pjqRAQHcvoJqKcyFElggKo
	 NDeys5XofIv/Q==
Received: by gofer.mess.org (Postfix, from userid 501)
	id C482E1009FD; Mon, 11 Dec 2023 08:25:08 +0000 (GMT)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1702283107; bh=bdWuptrbipE0PwzncdIauG8w5KPE09xoJ3vuSR6axY0=;
	h=From:To:Cc:Subject:Date:From;
	b=J1n3irC2LDck0qzWEex4TDpUWvnmt3EQc/ykryrZkYIVrX9M51f+wp8zYGwuylz8j
	 1Eaj+GthDLdQ9mWgQyZHYlMyzUzK8uBa7sbD64PYvOjkEXaAsouWy6tOxaJsKIfBEr
	 ucku53U2qfuWuXf6jTCXBOVW8JBR3aF8J0pNvrob4/KdJLlPX24RSZMKZDoX3cTHrG
	 Qkam9XxA060D0H/HTrA7Mo5hjI8JQnqrFFoMraqjopxrAncXSA5GtRkTWYwULOO0X3
	 SpjPIMHnoUbfXgyC0NyhZ+Qzocaz70r0+N9KMse7uF2j6E7aVhOOajdvRs0uNbmB0f
	 +k0qMS3a5Vfuw==
Received: from localhost.localdomain (bigcore.local [IPv6:2a02:8011:d000:212:ca7f:54ff:fe51:14d6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gofer.mess.org (Postfix) with ESMTPSA id 36B7A10005E;
	Mon, 11 Dec 2023 08:25:07 +0000 (GMT)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Sean Young <sean@mess.org>
Subject: [PATCH v7 0/4] Improve pwm-ir-tx precision
Date: Mon, 11 Dec 2023 08:24:51 +0000
Message-ID: <cover.1702282806.git.sean@mess.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pwm-ir-tx driver has to turn the pwm signal on and off, and suffers
from delays as this is done in process context. Make this work in atomic
context.

changes:

v7:
 - Thierry Reding review comments
 - Minor cleanups
 - rebase

v6:
 - Rename pwm_apply_cansleep() to pwm_apply_might_sleep()
 - rebase

v5:
 - Use dev_err_probe() as Uwe suggested
 - rebase

v4:
 - Split out the pwm_apply_state() rename into seperate commit
 - Atomic pwm function is called pwm_apply_atomic() and sleeping
   counterpart pwm_apply_cansleep()
 - Fix commit messages

v3:
 - Renamed pwm_apply_state() to pwm_apply_cansleep()
 - Moved pwm atomic to struct pwm_chip
 - Fixed pwm docs
 - Other minor code review comments

v2:
 - Simplified the pwm ir tx based on Ivaylo Dimitrov suggestions
 - Renamed pwm_can_sleep() to pwm_is_atomic
 - Fix sleeping issue in pwm-bcm2835 (clk_get_rate() can sleep)
 - use non_block_start() in pwm to check atomic-ness

Sean Young (4):
  pwm: Rename pwm_apply_state() to pwm_apply_might_sleep()
  pwm: Make it possible to apply PWM changes in atomic context
  pwm: bcm2835: Allow PWM driver to be used in atomic context
  media: pwm-ir-tx: Trigger edges from hrtimer interrupt context

 Documentation/driver-api/pwm.rst              | 17 +++-
 MAINTAINERS                                   |  2 +-
 .../gpu/drm/i915/display/intel_backlight.c    |  6 +-
 drivers/gpu/drm/solomon/ssd130x.c             |  2 +-
 drivers/hwmon/pwm-fan.c                       |  8 +-
 drivers/input/misc/da7280.c                   |  4 +-
 drivers/input/misc/pwm-beeper.c               |  4 +-
 drivers/input/misc/pwm-vibra.c                |  8 +-
 drivers/leds/leds-pwm.c                       |  2 +-
 drivers/leds/rgb/leds-pwm-multicolor.c        |  4 +-
 drivers/media/rc/pwm-ir-tx.c                  | 83 +++++++++++++++++--
 drivers/platform/x86/lenovo-yogabook.c        |  2 +-
 drivers/pwm/core.c                            | 76 +++++++++++++----
 drivers/pwm/pwm-bcm2835.c                     | 31 ++++---
 drivers/pwm/pwm-renesas-tpu.c                 |  1 -
 drivers/pwm/pwm-twl-led.c                     |  2 +-
 drivers/pwm/pwm-vt8500.c                      |  2 +-
 drivers/pwm/sysfs.c                           | 10 +--
 drivers/regulator/pwm-regulator.c             |  4 +-
 drivers/video/backlight/lm3630a_bl.c          |  2 +-
 drivers/video/backlight/lp855x_bl.c           |  2 +-
 drivers/video/backlight/pwm_bl.c              | 12 +--
 drivers/video/fbdev/ssd1307fb.c               |  2 +-
 include/linux/pwm.h                           | 57 +++++++++----
 24 files changed, 250 insertions(+), 93 deletions(-)

-- 
2.43.0


