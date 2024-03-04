Return-Path: <linux-pwm+bounces-1697-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE53A870722
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Mar 2024 17:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E02801C21410
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Mar 2024 16:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEA34DA1F;
	Mon,  4 Mar 2024 16:32:31 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE401495F0;
	Mon,  4 Mar 2024 16:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709569951; cv=none; b=ZWI7rcv+nXwC8IunjNrFwEeT51VIrjz+gIYreUKuVRXK6EYKwafoL2QFwCF3GTflWLgYZ4SqUucyrdOW6RlDXb4lHJNsDfJHjN/NI6fZffdGap1kfofCAWIZI655+ez4ew4cYnc1EBw17jjj1Xl7a02Vh0BfWt1H3/ELbImX7SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709569951; c=relaxed/simple;
	bh=a1s9luZvW5cpl3Ufm72oNJSlqXu75z3ENOkW6TQaklE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ovCbtb4LfMeQIiAWGTx+bBPZ6VERkPnSTznSHQXlbX0Hz7/Ta0MyhTXr5pIE7Dhi4oXppfgnYc4DyA+zBsZ6ZvkYKpdNFJDobdNSRTf8qAgXmQZ482HxskA5vlCzuu0KnSxsacQhUo4oAgQ5jPKff/j5Cz1qRQzEBWpuobDQuHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 871301FF57;
	Mon,  4 Mar 2024 16:32:24 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F04713A92;
	Mon,  4 Mar 2024 16:32:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id aOolCpj35WVLAQAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Mon, 04 Mar 2024 16:32:24 +0000
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
Subject: [PATCH v3 01/10] backlight: Match backlight device against struct fb_info.bl_dev
Date: Mon,  4 Mar 2024 17:29:46 +0100
Message-ID: <20240304163220.19144-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304163220.19144-1-tzimmermann@suse.de>
References: <20240304163220.19144-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 871301FF57
X-Spam-Flag: NO

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

v3:
	* hide ifdef in fb_bl_device() (Lee)
	* no if-else blocks (Andy)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/video/backlight/backlight.c     | 8 ++++++--
 drivers/video/fbdev/core/fb_backlight.c | 5 +++++
 include/linux/fb.h                      | 9 +++++++++
 3 files changed, 20 insertions(+), 2 deletions(-)

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
index e2d3b3adc870f..d3470a90042ea 100644
--- a/drivers/video/fbdev/core/fb_backlight.c
+++ b/drivers/video/fbdev/core/fb_backlight.c
@@ -30,4 +30,9 @@ void fb_bl_default_curve(struct fb_info *fb_info, u8 off, u8 min, u8 max)
 	mutex_unlock(&fb_info->bl_curve_mutex);
 }
 EXPORT_SYMBOL_GPL(fb_bl_default_curve);
+
+struct backlight_device *fb_bl_device(struct fb_info *info)
+{
+	return info->bl_dev;
+}
 #endif
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 708e6a177b1be..1dce640308b5e 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -732,6 +732,15 @@ extern struct fb_info *framebuffer_alloc(size_t size, struct device *dev);
 extern void framebuffer_release(struct fb_info *info);
 extern void fb_bl_default_curve(struct fb_info *fb_info, u8 off, u8 min, u8 max);
 
+#if IS_ENABLED(CONFIG_FB_BACKLIGHT)
+struct backlight_device *fb_bl_device(struct fb_info *info);
+#else
+struct backlight_device *fb_bl_device(struct fb_info *info)
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


