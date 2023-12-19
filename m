Return-Path: <linux-pwm+bounces-576-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A959E818C3E
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Dec 2023 17:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7326B20DF8
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Dec 2023 16:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D3F179;
	Tue, 19 Dec 2023 16:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="Ud803sgk";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="ReHiDNTR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313B4171D8;
	Tue, 19 Dec 2023 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1703003448; bh=fOWuvxGGsnWIrUNGcwxEGN7UpLks/52oxfAvQTJwFQE=;
	h=From:To:Cc:Subject:Date:From;
	b=Ud803sgkFLxmpbS0P5igkXKJiTKaVYTMbOzUGOE4Wg/ylYpoQzD6UAMx5z3XUGA9/
	 iy4WjMOgLW/JKe/u45Q5aXUSch834oK6i7faKmn384NbOcVLXqYDWjfC8KpN+34hr+
	 +J+dI5wgik1qFtWY2Uz5JTr2bEkSNLSlyYmZuUS2IZaXK8MYkOLb6faEGnSlLGj6qw
	 X9ZmY4BJz0WEC8l8CTLFYCqoUTnfstdGzLCrQGEm/t2DlCDxdXztJSNiB2+QUvZVzS
	 FHfiMDTC0wV8LpPdvFki5Z+UHfqRzrcEhJ36dZWsJlRhukLr57qrjTslOTNHuVrCzb
	 URtD+Ars2xvsQ==
Received: by gofer.mess.org (Postfix, from userid 501)
	id C4B891009FE; Tue, 19 Dec 2023 16:30:48 +0000 (GMT)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1703003446; bh=fOWuvxGGsnWIrUNGcwxEGN7UpLks/52oxfAvQTJwFQE=;
	h=From:To:Cc:Subject:Date:From;
	b=ReHiDNTRtvQEIa091mcj1QrwngGSl5CbIW2j9Ye+Ac5s+4TN03ONR2GWFs2ZSAFQ/
	 nx9L86MBHDAoSWZ7PjldQXEwVIyNtD2JE5eipptuMXMSstRF93yX5/fZ+3E/kyoimR
	 h8//MBZ5e/K1I5kJYH+knMEyr0Uo/rwBQwsnmxgiTQHRXhSt2/Dh4/WoEn+aKo0/sN
	 PHboelYE3c6xmNC5a2XYct9G4rAnM2I/txSbRbHIcOX8aTQ6WS3c8aUzwYJxiq8dH3
	 t7kFw+WqkoNocUGnbqJjPVJg2dbYeBL7I/l84IhGsooAqkV1PBCccKOCSa6Mn+XBbX
	 XYrLbfuIdpBKg==
Received: from localhost.localdomain (bigcore.local [IPv6:2a02:8011:d000:212:ca7f:54ff:fe51:14d6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gofer.mess.org (Postfix) with ESMTPSA id E0CF91000CC;
	Tue, 19 Dec 2023 16:30:46 +0000 (GMT)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Sean Young <sean@mess.org>
Subject: [PATCH v10 0/6] Improve pwm-ir-tx precision
Date: Tue, 19 Dec 2023 16:30:23 +0000
Message-ID: <cover.1703003288.git.sean@mess.org>
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

v10:
 - Uwe Kleine-König review comments/fixes

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
 drivers/pwm/pwm-bcm2835.c                     | 34 ++++++--
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
 24 files changed, 255 insertions(+), 93 deletions(-)

-- 
2.43.0


