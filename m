Return-Path: <linux-pwm+bounces-1692-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4842870713
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Mar 2024 17:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7F111C20B63
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Mar 2024 16:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA624D5A5;
	Mon,  4 Mar 2024 16:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FON9Hzor";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4YvKJRIw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FON9Hzor";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4YvKJRIw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3A3482F3;
	Mon,  4 Mar 2024 16:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709569950; cv=none; b=F7+fDFpyPLg7LXn8mUN4ctLTc/e8AWzc2Zc0eYkhvorY2OTEeqXfjc0NNhaxp9PrAVAZwAv8iXMDjD0P+LAfmyNzO8WK1O1qSnYwABNvs9ieWNUvb2vEzMKmOsOpR0yFT671KAfR6Nx1NXFO3XVLYcjtdxHs14uOBxRTHLZnVtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709569950; c=relaxed/simple;
	bh=cwcfVoEuJYCD7YFcV/k8yX7XLPBTaFPBt5teq1u8jp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OoarxbOYhHmNrzQ9crD/LepgMIorHoslyv7ztacVr7qhq8dNgua10Tm+VHlPxzMHJOLCmZSkrA0+8wuhiw4sBGYgySJELGOmMocTuyVz5niV3R/2ixfJSdoYm6sT2t0/KiHzp7LdiLBUzUjtQM0aHQXYqRGk9rxjiiOvNtz4l88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FON9Hzor; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4YvKJRIw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FON9Hzor; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4YvKJRIw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 278A01FE24;
	Mon,  4 Mar 2024 16:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709569944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dRnMrLF+OEWl73CjxNgaSUmbiASWREFcyTi8/I+dH/0=;
	b=FON9HzorjogV9BnGtNplI5qa/c9Wz5dREnvYZg0bcpwHFTnM3xz2gxtUfIHbAy4kSPlL1f
	OVl3EMJRK4c6Yztgf3iir0b1M4xI1/n7WBge4Cw30+Lf6abiaROe8m55G2s2/jL1Ige0jC
	jTKQLNH8LHrFN+CBVkJ10JKyPPxPlto=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709569944;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dRnMrLF+OEWl73CjxNgaSUmbiASWREFcyTi8/I+dH/0=;
	b=4YvKJRIwJsqhqj/YEOcxSwTNZhkKe5FaJelzYMkZsnVmfSovuy/pjtBbM/bOLKHOADC3px
	e+b7hgYb0GBdjADQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709569944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dRnMrLF+OEWl73CjxNgaSUmbiASWREFcyTi8/I+dH/0=;
	b=FON9HzorjogV9BnGtNplI5qa/c9Wz5dREnvYZg0bcpwHFTnM3xz2gxtUfIHbAy4kSPlL1f
	OVl3EMJRK4c6Yztgf3iir0b1M4xI1/n7WBge4Cw30+Lf6abiaROe8m55G2s2/jL1Ige0jC
	jTKQLNH8LHrFN+CBVkJ10JKyPPxPlto=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709569944;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dRnMrLF+OEWl73CjxNgaSUmbiASWREFcyTi8/I+dH/0=;
	b=4YvKJRIwJsqhqj/YEOcxSwTNZhkKe5FaJelzYMkZsnVmfSovuy/pjtBbM/bOLKHOADC3px
	e+b7hgYb0GBdjADQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CA965139C6;
	Mon,  4 Mar 2024 16:32:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 3gUvMJf35WVLAQAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Mon, 04 Mar 2024 16:32:23 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: lee@kernel.org,
	andy@kernel.org,
	daniel.thompson@linaro.org,
	jingoohan1@gmail.com,
	deller@gmx.de,
	robin@protonic.nl,
	javierm@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 00/10] backlight: Replace struct fb_info in interfaces
Date: Mon,  4 Mar 2024 17:29:45 +0100
Message-ID: <20240304163220.19144-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[kernel.org,linaro.org,gmail.com,gmx.de,protonic.nl,redhat.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.10

Backlight drivers implement struct backlight_ops.check_fb, which
uses struct fb_info in its interface. Replace the callback with one
that does not use fb_info.

In DRM, we have several drivers that implement backlight support. By
including <linux/backlight.h> these drivers depend on <linux/fb.h>.
At the same time, fbdev is deprecated for new drivers and likely to
be replaced on many systems.

This patchset is part of a larger effort to implement the backlight
code without depending on fbdev.

Patch 1 makes the backlight core match backlight and framebuffer
devices via struct fb_info.bl_dev. Patches 2 to 9 then go through
drivers and remove unnecessary implementations of check_fb. Finally,
patch 10 replaces the check_fb hook with controls_device, which
uses the framebuffer's Linux device instead of the framebuffer.

v3:
	* hide CONFIG_FB_BACKLIGHT behind fb_bl_device() (Lee)
	* if-else cleanups (Andy)
	* fix commit message of patch 2 (Andy)
v2:
	* fix hid-picolcd for CONFIG_FB_BACKLIGHT=n
	* fixes to commit messages

Thomas Zimmermann (10):
  backlight: Match backlight device against struct fb_info.bl_dev
  auxdisplay/ht16k33: Remove struct backlight_ops.check_fb
  hid/hid-picolcd: Fix initialization order
  hid/hid-picolcd: Remove struct backlight_ops.check_fb
  backlight/aat2870-backlight: Remove struct backlight.check_fb
  backlight/pwm-backlight: Remove struct backlight_ops.check_fb
  fbdev/sh_mobile_lcdc_fb: Remove struct backlight_ops.check_fb
  fbdev/ssd1307fb: Init backlight before registering framebuffer
  fbdev/ssd1307fb: Remove struct backlight_ops.check_fb
  backlight: Add controls_device callback to struct backlight_ops

 drivers/auxdisplay/ht16k33.c             |  8 ------
 drivers/hid/hid-picolcd_backlight.c      |  7 ------
 drivers/hid/hid-picolcd_core.c           | 14 +++++------
 drivers/hid/hid-picolcd_fb.c             |  6 +++++
 drivers/video/backlight/aat2870_bl.c     |  7 ------
 drivers/video/backlight/backlight.c      |  8 ++++--
 drivers/video/backlight/bd6107.c         | 12 ++++-----
 drivers/video/backlight/gpio_backlight.c | 12 ++++-----
 drivers/video/backlight/lv5207lp.c       | 12 ++++-----
 drivers/video/backlight/pwm_bl.c         | 12 ---------
 drivers/video/fbdev/core/fb_backlight.c  |  5 ++++
 drivers/video/fbdev/sh_mobile_lcdcfb.c   |  7 ------
 drivers/video/fbdev/ssd1307fb.c          | 31 +++++++++---------------
 include/linux/backlight.h                | 16 ++++++------
 include/linux/fb.h                       |  9 +++++++
 include/linux/pwm_backlight.h            |  1 -
 16 files changed, 70 insertions(+), 97 deletions(-)

-- 
2.44.0


