Return-Path: <linux-pwm+bounces-522-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED32380E62F
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Dec 2023 09:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C4271F21966
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Dec 2023 08:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5FE15AFD;
	Tue, 12 Dec 2023 08:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="GZer0AYH";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="nXL1kVc4"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3967BD5;
	Tue, 12 Dec 2023 00:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1702370062; bh=r/agY9fwYBs7EbxmjAFiRJMjqpQR4WzbKjehXHKlVZs=;
	h=From:To:Cc:Subject:Date:From;
	b=GZer0AYHsYx3VF9C27OSlzHrB3TUjOjJy4ZVPy0Tt2ugAFlYIQnySMqV6Aa+lKSId
	 BDE8r+Mh619seEZWYvte78bP5HgY2Yrab/ncCCvcV4njP0r66nuCfn6GOiy18jECi0
	 hVEb1wsk15i6adG56pFdTbVGCvMSfM00iIEWAz9Rgp6Q9wt2Gg21wG+nriShEmQrM3
	 ezBlPCkpF9SBJXXIp4mqDE9XGLBbmMweSCSWZojGhZriQtODnxrLV+H3wV6OLyQdio
	 SqL41RKcdU+LjrV9LPwE+Xy/nJ5FgAn8LcV6XIY8EHx68jsenm1Y1RthqfpbxBofHi
	 s2qCCwOciZJwQ==
Received: by gofer.mess.org (Postfix, from userid 501)
	id 27CF01009FE; Tue, 12 Dec 2023 08:34:22 +0000 (GMT)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1702370060; bh=r/agY9fwYBs7EbxmjAFiRJMjqpQR4WzbKjehXHKlVZs=;
	h=From:To:Cc:Subject:Date:From;
	b=nXL1kVc4rU+mOxZ1VDsMcddM1lfAbSFMlGwNXydl6cgVVPTdQcHx1CsrV6jOvMLkf
	 MmeNUYQ3DU09lFwXQ1oh3fXhlpgmuoTxmMkuv9R8mIW0plVPS0/MJqw+/UtsmZpC9H
	 AO7yF15VMqL/VFNsCwSnX8xWB3s3E78gzDoa3AfDqWtbeoqV73NDrbjNaQxWSfck+8
	 1qknbLESHFm2uBbURvj4XICzYMgR6wGU9INe03M//MnSHb78NcBOQguFwgySXil0ID
	 fQrq6I1nnAPF6AdpN6d5wbma8p0sF9OL55jjgaZTmQuniH28ax/TIs2JMpvG85nyyp
	 wmb34B/JufiTA==
Received: from localhost.localdomain (bigcore-58.local [IPv6:2a02:8011:d000:212:ca7f:54ff:fe51:14d6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gofer.mess.org (Postfix) with ESMTPSA id 0D93610006D;
	Tue, 12 Dec 2023 08:34:20 +0000 (GMT)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Sean Young <sean@mess.org>
Subject: [PATCH v8 0/6] Improve pwm-ir-tx precision
Date: Tue, 12 Dec 2023 08:33:59 +0000
Message-ID: <cover.1702369869.git.sean@mess.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The pwm-ir-tx driver has to turn the pwm signal on and off, and suffers
from delays as this is done in process context. Make this work in atomic
context.

changes:

v8:
 - Uwe Kleine-König review comments
 - Minor cleanups

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

Sean Young (6):
  pwm: Rename pwm_apply_state() to pwm_apply_might_sleep()
  pwm: Replace ENOTSUPP with EOPNOTSUPP
  pwm: renesas: Remove unused include
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
 drivers/media/rc/pwm-ir-tx.c                  | 87 +++++++++++++++++--
 drivers/platform/x86/lenovo-yogabook.c        |  2 +-
 drivers/pwm/core.c                            | 77 ++++++++++++----
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
 include/linux/pwm.h                           | 57 ++++++++----
 24 files changed, 253 insertions(+), 95 deletions(-)

-- 
2.43.0


