Return-Path: <linux-pwm+bounces-1579-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD5E85D410
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Feb 2024 10:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76A4EB26489
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Feb 2024 09:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6233D56B;
	Wed, 21 Feb 2024 09:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Kr8a3vn/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="V8x1NxXV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Kr8a3vn/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="V8x1NxXV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0CB3D96E;
	Wed, 21 Feb 2024 09:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708508610; cv=none; b=pM+m9kHMDHEk84LpRaThuCM73Uvjf+L3WGCYt7wudu9uoloy5mLZNDtVwXByVSlpMsm3dWLKvAu+h2pFBwA9qf+aeQmEK0vXqogO4TzVG1LDdhVipgDkPPjjs28bUS9m3oJr215fW2fbORwoVhOb9fw973E/emrBREy2Fgb2kDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708508610; c=relaxed/simple;
	bh=Hvzcr5RBJPdm+8z4BoHnhC0rtE9jV4DKIhvTdjLqvbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m9RwZbirxSjWRLj2Elwd15ssEetu4yKp5PEizXE5br4JFKaVX2F/k6nPxv/jey6IPavemh6GCbhXwRTo2JB7mQWgLzAn30gdoOLOHwolFqKsT42muASkjSB5VzYsfKUeYMMN/HfcRI2ULeJX4RRFOFufN+4MGGXEA8lbaHx1h0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Kr8a3vn/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=V8x1NxXV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Kr8a3vn/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=V8x1NxXV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0EA491FB4C;
	Wed, 21 Feb 2024 09:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708508607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YstQ3CddJjC34bDAs5WZSxsfNpobKm7CJ8F64ZqVt7U=;
	b=Kr8a3vn/Yr2bpRRVeuUJJcVYPqSGJ0E0ujh5Pi1/CI+A61nbcivbsBkEtRNR31sdwdtcqu
	Y1UpFBHZqoCOqaMrEJUZZ6SG19cSLaKnDOaTGB7eUE8HBCtvWg/vUwt0jtnVvyCsjm4kk4
	CGIxsVtNCktPF4KJLaULRiLIYrT+mak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708508607;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YstQ3CddJjC34bDAs5WZSxsfNpobKm7CJ8F64ZqVt7U=;
	b=V8x1NxXVQL/OeLaaacwPMEkJERfrtSlQJNu8MVx7nE1X5QSrHBnjHJZ4WRjflFXah+OHuq
	4Seorot3aydM91AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708508607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YstQ3CddJjC34bDAs5WZSxsfNpobKm7CJ8F64ZqVt7U=;
	b=Kr8a3vn/Yr2bpRRVeuUJJcVYPqSGJ0E0ujh5Pi1/CI+A61nbcivbsBkEtRNR31sdwdtcqu
	Y1UpFBHZqoCOqaMrEJUZZ6SG19cSLaKnDOaTGB7eUE8HBCtvWg/vUwt0jtnVvyCsjm4kk4
	CGIxsVtNCktPF4KJLaULRiLIYrT+mak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708508607;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YstQ3CddJjC34bDAs5WZSxsfNpobKm7CJ8F64ZqVt7U=;
	b=V8x1NxXVQL/OeLaaacwPMEkJERfrtSlQJNu8MVx7nE1X5QSrHBnjHJZ4WRjflFXah+OHuq
	4Seorot3aydM91AQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A384813A25;
	Wed, 21 Feb 2024 09:43:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id DyRyJr7F1WUpCwAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Wed, 21 Feb 2024 09:43:26 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: lee@kernel.org,
	daniel.thompson@linaro.org,
	jingoohan1@gmail.com,
	deller@gmx.de,
	andy@kernel.org,
	robin@protonic.nl,
	javierm@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 00/10] backlight: Replace struct fb_info in interfaces
Date: Wed, 21 Feb 2024 10:41:27 +0100
Message-ID: <20240221094324.27436-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.43.0
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
X-Spam-Level: 
X-Spam-Score: -0.83
X-Spamd-Result: default: False [-0.83 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[kernel.org,linaro.org,gmail.com,gmx.de,protonic.nl,redhat.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.53)[80.54%]
X-Spam-Flag: NO

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
 drivers/video/backlight/backlight.c      |  9 +++++--
 drivers/video/backlight/bd6107.c         | 12 ++++-----
 drivers/video/backlight/gpio_backlight.c | 12 ++++-----
 drivers/video/backlight/lv5207lp.c       | 12 ++++-----
 drivers/video/backlight/pwm_bl.c         | 12 ---------
 drivers/video/fbdev/sh_mobile_lcdcfb.c   |  7 ------
 drivers/video/fbdev/ssd1307fb.c          | 31 +++++++++---------------
 include/linux/backlight.h                | 16 ++++++------
 include/linux/pwm_backlight.h            |  1 -
 14 files changed, 57 insertions(+), 97 deletions(-)

-- 
2.43.0


