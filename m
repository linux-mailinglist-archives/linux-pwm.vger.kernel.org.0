Return-Path: <linux-pwm+bounces-1826-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2946788FC9B
	for <lists+linux-pwm@lfdr.de>; Thu, 28 Mar 2024 11:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C6F4B25534
	for <lists+linux-pwm@lfdr.de>; Thu, 28 Mar 2024 10:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08717C09F;
	Thu, 28 Mar 2024 10:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnuMpnRg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725EE7B3EB;
	Thu, 28 Mar 2024 10:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711620686; cv=none; b=BL3okYDl+2GsjDb+qCDH8IsCubvEqaHA7yX7iRIx5asqVcjf3rE1vlVCT7OXUbZd+aZrIy5E6JgPBL4ONwIDmDY7Um0/4RwgGDyVahTmlsA4FgL8NKVNFKsg/tMN1UcadVS6SuzXu7Qyw1Xbvh61enAXV2Rsvv1pc7HOLzWmQ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711620686; c=relaxed/simple;
	bh=/iYJllScuVN6X9EML6q5PXNHY8zPt1H2IRj7tnZN5Eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pB7sp0+kO3pSGivJOuRWvt3ZjqfI4kX1JxX8YMgQtuC/y14LvBmHmtLWLhA7sL6MC8WeaZycsOHbg5hSa3hVKgMj2Q22YPMVQMeyT8pX0QoT7yJT/D8Dv8t/b+MqYjaUfMO9AA5tP9b/WVRTRnzJqAYnUPKnpgBFnmsmhfT2U/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnuMpnRg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205E1C433C7;
	Thu, 28 Mar 2024 10:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711620685;
	bh=/iYJllScuVN6X9EML6q5PXNHY8zPt1H2IRj7tnZN5Eg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZnuMpnRgXxbyxxVjxbv6mntmLR20Py4SnOpS2JcomdOHGP9F6hYdITusD2bexeDz3
	 MwFi7L/pK6aQoOWMRifhNVe/Yi48dxiBYvJe0SJyq1ya1L6R4t1+N6s5d5tx+I+/2P
	 crAHyaqUi+/3HoOs+4FDzRMDJ8NKUPKpx/HgLWBSalu3NjXcYzY8JpzvDeOmdpJiKI
	 US+5Czvt2RJH5UPYJIRVMWZIYbS0ptRkZ88CUARpjh+bTun5qYRaWEjGNBG+7UHO1e
	 qlQpILAtKBaxWhR+y+7+xZ63Q9oH9kaNCrQLBC5xZTSL4BdPGWg7vcz7HlqPyU6A7K
	 ZuuwglAW4DGRg==
Date: Thu, 28 Mar 2024 10:11:20 +0000
From: Lee Jones <lee@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: andy@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com,
	deller@gmx.de, robin@protonic.nl, javierm@redhat.com,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [GIT PULL] Immutable branch between MFD, Auxdisplay, HID and FB due
 for the v6.9 merge window
Message-ID: <20240328101120.GX13211@google.com>
References: <20240305162425.23845-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240305162425.23845-1-tzimmermann@suse.de>

Enjoy!

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git ib-backlight-auxdisplay-hid-fb-v6.9

for you to fetch changes up to 0a4be7263749945a3882f7a0e2e5b1c45c31064e:

  backlight: Add controls_device callback to struct backlight_ops (2024-03-28 10:09:06 +0000)

----------------------------------------------------------------
Immutable branch between MFD, Auxdisplay, HID and FB due for the v6.9 merge window

----------------------------------------------------------------
Thomas Zimmermann (10):
      backlight: Match backlight device against struct fb_info.bl_dev
      auxdisplay: ht16k33: Remove struct backlight_ops.check_fb
      hid: hid-picolcd: Fix initialization order
      hid: hid-picolcd: Remove struct backlight_ops.check_fb
      backlight: aat2870-backlight: Remove struct backlight.check_fb
      backlight: pwm-backlight: Remove struct backlight_ops.check_fb
      fbdev: sh_mobile_lcdc_fb: Remove struct backlight_ops.check_fb
      fbdev: ssd1307fb: Init backlight before registering framebuffer
      fbdev: ssd1307fb: Remove struct backlight_ops.check_fb
      backlight: Add controls_device callback to struct backlight_ops

 drivers/auxdisplay/ht16k33.c             |  8 --------
 drivers/hid/hid-picolcd_backlight.c      |  7 -------
 drivers/hid/hid-picolcd_core.c           | 14 +++++++-------
 drivers/hid/hid-picolcd_fb.c             |  6 ++++++
 drivers/video/backlight/aat2870_bl.c     |  7 -------
 drivers/video/backlight/backlight.c      |  8 ++++++--
 drivers/video/backlight/bd6107.c         | 12 ++++++------
 drivers/video/backlight/gpio_backlight.c | 12 ++++++------
 drivers/video/backlight/lv5207lp.c       | 12 ++++++------
 drivers/video/backlight/pwm_bl.c         | 12 ------------
 drivers/video/fbdev/core/fb_backlight.c  |  6 ++++++
 drivers/video/fbdev/sh_mobile_lcdcfb.c   |  7 -------
 drivers/video/fbdev/ssd1307fb.c          | 31 +++++++++++--------------------
 include/linux/backlight.h                | 16 ++++++++--------
 include/linux/fb.h                       |  9 +++++++++
 include/linux/pwm_backlight.h            |  1 -
 16 files changed, 71 insertions(+), 97 deletions(-)

-- 
Lee Jones [李琼斯]

