Return-Path: <linux-pwm+bounces-1715-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96110872420
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Mar 2024 17:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B97BC1C24EA7
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Mar 2024 16:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5808612DD95;
	Tue,  5 Mar 2024 16:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="A1aTRjM6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cs4HrCOo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="A1aTRjM6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cs4HrCOo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC08128833;
	Tue,  5 Mar 2024 16:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709655874; cv=none; b=iBcDOXWefdzsCn4a4oyRuB/6Q8LrPV7LGVtGrQFd6gaVI6FghpromWrtRg/rOBZH/fojT5k/RefaHHKvwYRdmc8d4yJnZFQEwRIb8xPlH5XBa3FOo+6Gc2VTLuNxa5k69aKDu6sluqHukIVcnPGSX6Zb3W+r7YKC1V9IUM6c/V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709655874; c=relaxed/simple;
	bh=Geet9zHtyoPfTclnIQiLdAfHmUz9X7lYZLWxnwQbYsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jbx1AanOfwmZisuddBfhI+YX+z/GMndXUoaKT/7CyzhQV/n/fQd5/++OgG2pHrNlICuWZg5/CQrIjg7sGhWnWwRQgrFzRVsKXgsNnTZNH4PefPhMPWuNusQGVW1tjdf0fp7SPRSOQdfVJIw0ioGsfeUAbeAEOZU6qE+6SypgwHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=A1aTRjM6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cs4HrCOo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=A1aTRjM6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cs4HrCOo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7ECC27680E;
	Tue,  5 Mar 2024 16:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709655870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L1WjLxpZIYQCrdPUjEkYkZ3IQ5J3+0S0X90f17cfdNU=;
	b=A1aTRjM6zrVM0wP4zt9JNiRgoYiULaP03xT/PO7ZC0cI9wzoKi4kLQubat3TKUifXfthsO
	DKIIaWODH60X9TUqrsS8LBdMI/0DDrCKi8HoUNtZzmbFpjeVhqDTxhqjo6B5P9vUneyUgr
	pTSBhM1pX4uNocpu5NeMRo3kIy1q6PI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709655870;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L1WjLxpZIYQCrdPUjEkYkZ3IQ5J3+0S0X90f17cfdNU=;
	b=cs4HrCOon5Aqb92yiPbOx+SP7CX60sOxRs0g7A1YZ+dUC5IMQtcwIkhGBY7yU/1s73GOYh
	v+OyDMXva4xcJRAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709655870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L1WjLxpZIYQCrdPUjEkYkZ3IQ5J3+0S0X90f17cfdNU=;
	b=A1aTRjM6zrVM0wP4zt9JNiRgoYiULaP03xT/PO7ZC0cI9wzoKi4kLQubat3TKUifXfthsO
	DKIIaWODH60X9TUqrsS8LBdMI/0DDrCKi8HoUNtZzmbFpjeVhqDTxhqjo6B5P9vUneyUgr
	pTSBhM1pX4uNocpu5NeMRo3kIy1q6PI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709655870;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L1WjLxpZIYQCrdPUjEkYkZ3IQ5J3+0S0X90f17cfdNU=;
	b=cs4HrCOon5Aqb92yiPbOx+SP7CX60sOxRs0g7A1YZ+dUC5IMQtcwIkhGBY7yU/1s73GOYh
	v+OyDMXva4xcJRAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 304B313A8A;
	Tue,  5 Mar 2024 16:24:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id cPaECj5H52WwYwAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Tue, 05 Mar 2024 16:24:30 +0000
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
Subject: [PATCH v4 01/10] backlight: Match backlight device against struct fb_info.bl_dev
Date: Tue,  5 Mar 2024 17:22:34 +0100
Message-ID: <20240305162425.23845-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240305162425.23845-1-tzimmermann@suse.de>
References: <20240305162425.23845-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=A1aTRjM6;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cs4HrCOo
X-Spamd-Result: default: False [-0.81 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
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
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.81
X-Rspamd-Queue-Id: 7ECC27680E
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

Framebuffer drivers for devices with dedicated backlight are supposed
to set struct fb_info.bl_dev to the backlight's respective device. Use
the value to match backlight and framebuffer in the backlight core code.

The code first tests against struct backlight_ops.check_ops. If this
test succeeds, it performs the test against fbdev. So backlight drivers
can override the later test as before.

Fbdev's backlight support depends on CONFIG_FB_BACKLIGHT. To avoid
ifdef in the code, the new helper fb_bl_device() returns the backlight
device, or NULL if the config option has been disabled. The test in
the backlight code will then do nothing.

v4:
	* declare empty fb_bl_device() as static inline
	* export fb_bl_device()
v3:
	* hide ifdef in fb_bl_device() (Lee)
	* no if-else blocks (Andy)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/video/backlight/backlight.c     | 8 ++++++--
 drivers/video/fbdev/core/fb_backlight.c | 6 ++++++
 include/linux/fb.h                      | 9 +++++++++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 86e1cdc8e3697..4f7973c6fcc79 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -98,7 +98,9 @@ static int fb_notifier_callback(struct notifier_block *self,
 {
 	struct backlight_device *bd;
 	struct fb_event *evdata = data;
-	int node = evdata->info->node;
+	struct fb_info *info = evdata->info;
+	struct backlight_device *fb_bd = fb_bl_device(info);
+	int node = info->node;
 	int fb_blank = 0;
 
 	/* If we aren't interested in this event, skip it immediately ... */
@@ -110,7 +112,9 @@ static int fb_notifier_callback(struct notifier_block *self,
 
 	if (!bd->ops)
 		goto out;
-	if (bd->ops->check_fb && !bd->ops->check_fb(bd, evdata->info))
+	if (bd->ops->check_fb && !bd->ops->check_fb(bd, info))
+		goto out;
+	if (fb_bd && fb_bd != bd)
 		goto out;
 
 	fb_blank = *(int *)evdata->data;
diff --git a/drivers/video/fbdev/core/fb_backlight.c b/drivers/video/fbdev/core/fb_backlight.c
index e2d3b3adc870f..6fdaa9f81be90 100644
--- a/drivers/video/fbdev/core/fb_backlight.c
+++ b/drivers/video/fbdev/core/fb_backlight.c
@@ -30,4 +30,10 @@ void fb_bl_default_curve(struct fb_info *fb_info, u8 off, u8 min, u8 max)
 	mutex_unlock(&fb_info->bl_curve_mutex);
 }
 EXPORT_SYMBOL_GPL(fb_bl_default_curve);
+
+struct backlight_device *fb_bl_device(struct fb_info *info)
+{
+	return info->bl_dev;
+}
+EXPORT_SYMBOL(fb_bl_device);
 #endif
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 708e6a177b1be..15e91c04758c8 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -732,6 +732,15 @@ extern struct fb_info *framebuffer_alloc(size_t size, struct device *dev);
 extern void framebuffer_release(struct fb_info *info);
 extern void fb_bl_default_curve(struct fb_info *fb_info, u8 off, u8 min, u8 max);
 
+#if IS_ENABLED(CONFIG_FB_BACKLIGHT)
+struct backlight_device *fb_bl_device(struct fb_info *info);
+#else
+static inline struct backlight_device *fb_bl_device(struct fb_info *info)
+{
+	return NULL;
+}
+#endif
+
 /* fbmon.c */
 #define FB_MAXTIMINGS		0
 #define FB_VSYNCTIMINGS		1
-- 
2.44.0


