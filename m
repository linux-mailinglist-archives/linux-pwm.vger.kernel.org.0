Return-Path: <linux-pwm+bounces-561-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B359881693D
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Dec 2023 10:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4582D2813A8
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Dec 2023 09:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9241119A;
	Mon, 18 Dec 2023 09:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="dqaxpQQ2";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="JtP+FSJX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46AC12B6C;
	Mon, 18 Dec 2023 09:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1702890420; bh=FkCr51kULAa8YJGMPXtjxuQF6A5OKu9CA6R1NbTOiZU=;
	h=From:To:Cc:Subject:Date:From;
	b=dqaxpQQ2MD5u0A5cqhdg7X1HpPU6umNIi3EWzfxrV/rLyQC6mWgr2otapf/CDm9Bv
	 j9kDMhZq8QBuVZLZ/2gWrCx06tJIwKQ5Js+A8lPDMxpGNv3E94M5PU/7uEwwF10ToO
	 fFCb4k9ozbfuXDOUsRjgWOGliI9bm9C3w49iSBgiWlaYr7+G3dorSsshFgHcDP+ebn
	 Gwb6tYC3nvg450udoo4goaF7yRjwcGmjZn8RuxNi2u9h/Op0EEn8aOhYhbC31ngRes
	 RWhiPrsK1zFBecZzneusiwROJEbsgRXAHjluGNWTmLajfh+7Gq4ekuYzUIes/2j9b2
	 zeLqXKUVcB8vw==
Received: by gofer.mess.org (Postfix, from userid 501)
	id 3AA231009FE; Mon, 18 Dec 2023 09:07:00 +0000 (GMT)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1702890418; bh=FkCr51kULAa8YJGMPXtjxuQF6A5OKu9CA6R1NbTOiZU=;
	h=From:To:Cc:Subject:Date:From;
	b=JtP+FSJXa+kj2Y6U63zJphy5+N16GUt1JqAQOjNcfFB9ygWULSAffrKviEh1jPDUM
	 PzqiLGdB+r5f7B0BZW1RQ8pFBR9YznHffbuZUcjKcm4AugbkZDVtGCPrA1VOSVkJ9r
	 dSbLUqmfZKaYuNvepMPUUPoIt5Abe6p2YFpaD/XhbHaORSU3k2iiVhaqcjGoEvav54
	 33kSU13hAf74WJAIpd4tKdYT476/4pzFpR4I8fJCmrOPp324+s04x8mnWFZ6CQEEss
	 5MlZ2CYZyO/TFrQcXZQ+2v3BDfnOvD+Na9wL+lRtD7WwPyoA6M/+vy4hxUdBiW7cFg
	 f26bbUuOfMf5A==
Received: from localhost.localdomain (bigcore-79.local [IPv6:2a02:8011:d000:212:ca7f:54ff:fe51:14d6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gofer.mess.org (Postfix) with ESMTPSA id 588981000CC;
	Mon, 18 Dec 2023 09:06:58 +0000 (GMT)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Sean Young <sean@mess.org>
Subject: [PATCH v9 0/6] Improve pwm-ir-tx precision
Date: Mon, 18 Dec 2023 09:06:41 +0000
Message-ID: <cover.1702890244.git.sean@mess.org>
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

v9:
 - Uwe Kleine-König review comments/fixes

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
 drivers/pwm/core.c                            | 74 ++++++++++++----
 drivers/pwm/pwm-bcm2835.c                     | 40 ++++++---
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
 24 files changed, 260 insertions(+), 94 deletions(-)

-- 
2.43.0


