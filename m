Return-Path: <linux-pwm+bounces-225-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB357FD1D7
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Nov 2023 10:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EFF52824F1
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Nov 2023 09:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AD112B93;
	Wed, 29 Nov 2023 09:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="CjBoUbnt";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="sOENhCXg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336DB85;
	Wed, 29 Nov 2023 01:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1701249228; bh=7Q4m/lQIMeFPiVfunijCevWKOXgawRKLjJhhiXwsycw=;
	h=From:To:Cc:Subject:Date:From;
	b=CjBoUbntoSwDpahmK5DuDBlJBMoJXJjjmYLjMLt9bkKFy4eQVi0roAp6IS/C4F3R2
	 oYNnP3iGP/F0kA0b0YGWBZvsDgO5bUjz6m5W5EqBDameFADumRGGDilIhV3aTg6jfv
	 q0stWT0ngbmfFKEifpNLhLBaa3BOLVKxF+R8dWUD36cBmfIV7RyzAcKN1VQ1DaH+2L
	 gzWuaHQnyT/lbVvSTu31+16S1NwO9nvwCT0Yxr9ExsKRl3tx24VfpZ8OaMw7EMLOJ9
	 TF+MxuSS85M5s8gnhWSGfGi+VP3wgPXITv+KmQwy15UTQIr7Bll3C9TrR81ZlnhjLt
	 9W9pR1i5/YZnQ==
Received: by gofer.mess.org (Postfix, from userid 501)
	id EA270100102; Wed, 29 Nov 2023 09:13:48 +0000 (GMT)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1701249227; bh=7Q4m/lQIMeFPiVfunijCevWKOXgawRKLjJhhiXwsycw=;
	h=From:To:Cc:Subject:Date:From;
	b=sOENhCXg98CAKLZY3EKL+ET+fTcnlpnppYmvDcylQwT65XWUTtbANVwD7iwad1r2w
	 u1I1hAnKY1DH5Pr/OEq9UzmnIBOkrD6DbUDut4vsVXztK6YY29TeztGonsJGZBB2nA
	 VQsN3n8YnBiiLNXHlUY+seaSSjG5li6IJKotlrFS0IxsaINOPEXw+kBNMQRRyLgsie
	 sACqrRZFPDTCO905Q/pM8/vM6qTHY2vkwdT+vNKNJnq/s9DDVPzL4ff90upMziWixx
	 XBL8IBxLHxlaZhnVm8vO6R9qq40watr0M9rdQVf5h8vTaNJR5SYPgrePY8kONyu+yC
	 m5jqSaVnl4LRQ==
Received: from localhost.localdomain (bigcore-99.local [IPv6:2a02:8011:d000:212:ca7f:54ff:fe51:14d6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gofer.mess.org (Postfix) with ESMTPSA id 3EFBD100064;
	Wed, 29 Nov 2023 09:13:47 +0000 (GMT)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Sean Young <sean@mess.org>
Subject: [PATCH v6 0/4] Improve pwm-ir-tx precision
Date: Wed, 29 Nov 2023 09:13:33 +0000
Message-ID: <cover.1701248996.git.sean@mess.org>
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
  pwm: rename pwm_apply_state() to pwm_apply_might_sleep()
  pwm: make it possible to apply pwm changes in atomic context
  pwm: bcm2835: allow pwm driver to be used in atomic context
  media: pwm-ir-tx: trigger edges from hrtimer interrupt context

 Documentation/driver-api/pwm.rst              | 17 +++-
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
 drivers/pwm/core.c                            | 75 +++++++++++++----
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
 23 files changed, 248 insertions(+), 92 deletions(-)

-- 
2.43.0


