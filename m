Return-Path: <linux-pwm+bounces-129-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2D07F408E
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Nov 2023 09:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84B081C208B2
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Nov 2023 08:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F9C2D639;
	Wed, 22 Nov 2023 08:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="hTOVsc/M"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D20CBC;
	Wed, 22 Nov 2023 00:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1700643111; bh=kiIc8Yu0M50g2s8FmrHj8bfB2sq34nsCPUTwyTAmzJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hTOVsc/MRdNCx3tkSQQdWZmTk68YS3fp6fyA3yjI083RGWTYkn5vZsM/qLLgnOZ4o
	 +wUOWqrbd7WxjwcjL5TAW5EbUp+pltUAeXcsTeYN578iL89Y5LJa2FxoDyBRrsOVRh
	 cC3SLjJ2pMc+ZyozFLAUToqw1xHajvFPcw1E+/rWa70aBopNXdb2RqFtwZMcAmyvHo
	 qn9txReR3w9UpkHt4iLiuWkFGMGDRQdA+TjuWLwnKoaQJ+ghpu/CQkPyovaDMwZIIn
	 tL5L/YvdZ5wdwLSeqrJ/ydOkUKUmaNeZkKAgTEaol/C9Jz5MVnmrbIaI0LHWPHzFiv
	 EA6Gn38YWb7XQ==
Received: by gofer.mess.org (Postfix, from userid 1000)
	id ADAEA1000CD; Wed, 22 Nov 2023 08:51:51 +0000 (GMT)
Date: Wed, 22 Nov 2023 08:51:51 +0000
From: Sean Young <sean@mess.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v5 0/4] Improve pwm-ir-tx precision
Message-ID: <ZV3BJ67_JCpTYEMl@gofer.mess.org>
References: <cover.1700323916.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1700323916.git.sean@mess.org>

On Sat, Nov 18, 2023 at 04:16:16PM +0000, Sean Young wrote:
> The pwm-ir-tx driver has to turn the pwm signal on and off, and suffers
> from delays as this is done in process context. Make this work in atomic
> context.

Hi Uwe,

Do you have any comments on this series?

I hope you don't dislike the pwm_apply_atomic()/pwm_apply_cansleep(), I am
not wedded to this name, it's just me reading the room and thinking that
would be the most acceptable to everyone - I may have misread this.

Thank you for any feedback

Sean

> 
> changes:
> 
> v5:
>  - Use dev_err_probe() as Uwe suggested
>  - rebase
> 
> v4:
>  - Split out the pwm_apply_state() rename into seperate commit
>  - Atomic pwm function is called pwm_apply_atomic() and sleeping
>    counterpart pwm_apply_cansleep()
>  - Fix commit messages
> 
> v3:
>  - Renamed pwm_apply_state() to pwm_apply_cansleep()
>  - Moved pwm atomic to struct pwm_chip
>  - Fixed pwm docs
>  - Other minor code review comments
> 
> v2:
>  - Simplified the pwm ir tx based on Ivaylo Dimitrov suggestions
>  - Renamed pwm_can_sleep() to pwm_is_atomic
>  - Fix sleeping issue in pwm-bcm2835 (clk_get_rate() can sleep)
>  - use non_block_start() in pwm to check atomic-ness
> 
> 
> Sean Young (4):
>   pwm: rename pwm_apply_state() to pwm_apply_cansleep()
>   pwm: make it possible to apply pwm changes in atomic context
>   pwm: bcm2835: allow pwm driver to be used in atomic context
>   media: pwm-ir-tx: trigger edges from hrtimer interrupt context
> 
>  Documentation/driver-api/pwm.rst              | 17 +++-
>  .../gpu/drm/i915/display/intel_backlight.c    |  6 +-
>  drivers/gpu/drm/solomon/ssd130x.c             |  2 +-
>  drivers/hwmon/pwm-fan.c                       |  8 +-
>  drivers/input/misc/da7280.c                   |  4 +-
>  drivers/input/misc/pwm-beeper.c               |  4 +-
>  drivers/input/misc/pwm-vibra.c                |  8 +-
>  drivers/leds/leds-pwm.c                       |  2 +-
>  drivers/leds/rgb/leds-pwm-multicolor.c        |  4 +-
>  drivers/media/rc/pwm-ir-tx.c                  | 83 +++++++++++++++++--
>  drivers/platform/x86/lenovo-yogabook.c        |  2 +-
>  drivers/pwm/core.c                            | 75 +++++++++++++----
>  drivers/pwm/pwm-bcm2835.c                     | 31 ++++---
>  drivers/pwm/pwm-renesas-tpu.c                 |  1 -
>  drivers/pwm/pwm-twl-led.c                     |  2 +-
>  drivers/pwm/pwm-vt8500.c                      |  2 +-
>  drivers/pwm/sysfs.c                           | 10 +--
>  drivers/regulator/pwm-regulator.c             |  4 +-
>  drivers/video/backlight/lm3630a_bl.c          |  2 +-
>  drivers/video/backlight/lp855x_bl.c           |  2 +-
>  drivers/video/backlight/pwm_bl.c              | 12 +--
>  drivers/video/fbdev/ssd1307fb.c               |  2 +-
>  include/linux/pwm.h                           | 57 +++++++++----
>  23 files changed, 248 insertions(+), 92 deletions(-)
> 
> -- 
> 2.42.1
> 

