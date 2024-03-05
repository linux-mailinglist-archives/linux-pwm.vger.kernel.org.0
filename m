Return-Path: <linux-pwm+bounces-1716-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C24872423
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Mar 2024 17:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF9CC1F240F6
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Mar 2024 16:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF6112DD9E;
	Tue,  5 Mar 2024 16:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oTY/fz9e";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/SJm838O";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oTY/fz9e";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/SJm838O"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB20128830;
	Tue,  5 Mar 2024 16:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709655875; cv=none; b=C+Kz/Cx/DkaJ1R2/BDjxx+JlgSnIefL8UFSxJTnt1ys1jt8Bd/CVTitKh1/FoAA8uxXETWPCMgdwJx0EkZvZysvW3ZOizzc1KskVHcvrtqGPo1NyYMfdv6Cm8QwM8BuJx05yi9iQ9uRCTAVnCsxkERvudNJCt0otRFQMKKF2Nu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709655875; c=relaxed/simple;
	bh=rPQHnvCIjtbT2t1iS++6XEJwoeTIM5tFBM8oP1+Bg5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A9HDPhBtEoGJITmaYbaD9G1uI3MM7b2GN9jtu3OyyE/Q6Y4XkF2tNBTVvv/FxscSjKPd+CZJh3aOnbj7KzVKgjg8DkfcSZFP3pwbhmCR+jXq6Ulebw+sGTw1o3CfGqg5LxK3SeFcLHYtj1p111yWDWEaicz44JN01VcpxGoXHgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oTY/fz9e; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/SJm838O; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oTY/fz9e; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/SJm838O; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2B08F767E8;
	Tue,  5 Mar 2024 16:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709655870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g3TI3Wjm7l0an5zPuyKBUbJnlqiR4+jPAB6G/7j4aKk=;
	b=oTY/fz9eslkgFxUo1fF81Y3IiyvDX9zY+1sT7JtfaZ8lbbEE7z88CUQLoMlyu9dz5W/+xt
	51TUpsZSZUewhK2WaB6LvoD0uYLGIqxy19n9R+upYL064beIpDBlopYvzXLSraWRcRb4m6
	P/Po0b7e9T4XxnwoXX/lakp+i7GgkF0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709655870;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g3TI3Wjm7l0an5zPuyKBUbJnlqiR4+jPAB6G/7j4aKk=;
	b=/SJm838OqN0uATF8b/CluZAUbApRBPZASRJqe2lFK4Gunt+sdIoUvt4BTuuADL9efyflv+
	cQhTRo0pH+X/HRCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709655870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g3TI3Wjm7l0an5zPuyKBUbJnlqiR4+jPAB6G/7j4aKk=;
	b=oTY/fz9eslkgFxUo1fF81Y3IiyvDX9zY+1sT7JtfaZ8lbbEE7z88CUQLoMlyu9dz5W/+xt
	51TUpsZSZUewhK2WaB6LvoD0uYLGIqxy19n9R+upYL064beIpDBlopYvzXLSraWRcRb4m6
	P/Po0b7e9T4XxnwoXX/lakp+i7GgkF0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709655870;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g3TI3Wjm7l0an5zPuyKBUbJnlqiR4+jPAB6G/7j4aKk=;
	b=/SJm838OqN0uATF8b/CluZAUbApRBPZASRJqe2lFK4Gunt+sdIoUvt4BTuuADL9efyflv+
	cQhTRo0pH+X/HRCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CD43F13A5D;
	Tue,  5 Mar 2024 16:24:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id CnnMMD1H52WwYwAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Tue, 05 Mar 2024 16:24:29 +0000
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
Subject: [PATCH v4 00/10] backlight: Replace struct fb_info in interfaces
Date: Tue,  5 Mar 2024 17:22:33 +0100
Message-ID: <20240305162425.23845-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="oTY/fz9e";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/SJm838O"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.01 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[kernel.org,linaro.org,gmail.com,gmx.de,protonic.nl,redhat.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -6.01
X-Rspamd-Queue-Id: 2B08F767E8
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

v4:
	* fix fb_bl_device() declaration and export
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
 drivers/video/fbdev/core/fb_backlight.c  |  6 +++++
 drivers/video/fbdev/sh_mobile_lcdcfb.c   |  7 ------
 drivers/video/fbdev/ssd1307fb.c          | 31 +++++++++---------------
 include/linux/backlight.h                | 16 ++++++------
 include/linux/fb.h                       |  9 +++++++
 include/linux/pwm_backlight.h            |  1 -
 16 files changed, 71 insertions(+), 97 deletions(-)

-- 
2.44.0


