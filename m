Return-Path: <linux-pwm+bounces-1589-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5530D85D42A
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Feb 2024 10:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C35CC1F274A7
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Feb 2024 09:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765363EA98;
	Wed, 21 Feb 2024 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Pa/61KEn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pZCukhie";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Pa/61KEn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pZCukhie"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3523D996;
	Wed, 21 Feb 2024 09:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708508615; cv=none; b=FOyjR7aZbSOJNs2JBKWMMt7KrM7EJYoc2hTVlR5M70ixuMqwUB6qC2a6UgMNNqO9cRXQbi6EWvsrNXkoivuX5VRmMmKdtR+vJdA1KoZFzr785G9HCUSf02j4lm3xgb7+ijd1zyVUVgWjKc+NI9C8eu7uf1W5QVqw937Y5MQp9bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708508615; c=relaxed/simple;
	bh=dm6dUWs5eYK7iDD0KXEIKym4BzOLgtmh5PvRibkkMSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gfIyRIPr5kCcUyxU1Z7dHwmgp2DBLXWr71kDunSxAVnOhcVvuiAY9T2CHucliz8OZ25qHGjxgfZ0LblUB9zY/hIt7TOZ4ZJXAAqAinhLn3/Sxb9L66JZhy+B3rJjRItsBGDmy4xESc9nvzTLq18PNqybcC8a/y7nq8rVDfsa8Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Pa/61KEn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pZCukhie; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Pa/61KEn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pZCukhie; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BA1782212A;
	Wed, 21 Feb 2024 09:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708508608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2vbH6fXbw5kSaZe8A6x1Pisz/54U5gjhrI6eNLro4oQ=;
	b=Pa/61KEnUsNnytdLB8GtCF/LdojJ8cxpXJ3Z8dySP0iUXfys7ORmXoeGfQxfpN8Wt1YL/M
	5qSEHYaK2KVjhoY9UktzMc40m3tV8P4XNDOpDOiBxoAhE+vRsm1ILcG9l5NAWOkChRBEIW
	EMoScmgkEGQrqfXdCl+ZMp3DUosRHLI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708508608;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2vbH6fXbw5kSaZe8A6x1Pisz/54U5gjhrI6eNLro4oQ=;
	b=pZCukhiepzqX7o8ZwERsMLn7dqMUJW1wOQO4dzmZS8SH6y8zuH3JGxQk+aj9UwLgow89ox
	cJR4WxQgE2VqssBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708508608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2vbH6fXbw5kSaZe8A6x1Pisz/54U5gjhrI6eNLro4oQ=;
	b=Pa/61KEnUsNnytdLB8GtCF/LdojJ8cxpXJ3Z8dySP0iUXfys7ORmXoeGfQxfpN8Wt1YL/M
	5qSEHYaK2KVjhoY9UktzMc40m3tV8P4XNDOpDOiBxoAhE+vRsm1ILcG9l5NAWOkChRBEIW
	EMoScmgkEGQrqfXdCl+ZMp3DUosRHLI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708508608;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2vbH6fXbw5kSaZe8A6x1Pisz/54U5gjhrI6eNLro4oQ=;
	b=pZCukhiepzqX7o8ZwERsMLn7dqMUJW1wOQO4dzmZS8SH6y8zuH3JGxQk+aj9UwLgow89ox
	cJR4WxQgE2VqssBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 576AE13A25;
	Wed, 21 Feb 2024 09:43:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id aGPBE8DF1WUpCwAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Wed, 21 Feb 2024 09:43:28 +0000
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
	Thomas Zimmermann <tzimmermann@suse.de>,
	=?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons@linux-vserver.org>
Subject: [PATCH v2 04/10] hid/hid-picolcd: Remove struct backlight_ops.check_fb
Date: Wed, 21 Feb 2024 10:41:31 +0100
Message-ID: <20240221094324.27436-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240221094324.27436-1-tzimmermann@suse.de>
References: <20240221094324.27436-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RLbrmj4aennmrpd7btm9n9zy3k)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FREEMAIL_TO(0.00)[kernel.org,linaro.org,gmail.com,gmx.de,protonic.nl,redhat.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

Update the driver to initialize struct fb_info.bl_dev to its backlight
device, if any. Thus rely on the backlight core code to match backlight
and framebuffer devices, and remove the extra check_fb function from
struct backlight_ops.

v2:
	* protect against CONFIG_FB_BACKLIGHT (Javier, kernel test robot)
	* reword commit message (Daniel)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: "Bruno Prémont" <bonbons@linux-vserver.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/hid/hid-picolcd_backlight.c | 7 -------
 drivers/hid/hid-picolcd_fb.c        | 6 ++++++
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-picolcd_backlight.c b/drivers/hid/hid-picolcd_backlight.c
index 5bd2a8c4bbd66..08d16917eb60b 100644
--- a/drivers/hid/hid-picolcd_backlight.c
+++ b/drivers/hid/hid-picolcd_backlight.c
@@ -9,7 +9,6 @@
 
 #include <linux/hid.h>
 
-#include <linux/fb.h>
 #include <linux/backlight.h>
 
 #include "hid-picolcd.h"
@@ -39,15 +38,9 @@ static int picolcd_set_brightness(struct backlight_device *bdev)
 	return 0;
 }
 
-static int picolcd_check_bl_fb(struct backlight_device *bdev, struct fb_info *fb)
-{
-	return fb && fb == picolcd_fbinfo((struct picolcd_data *)bl_get_data(bdev));
-}
-
 static const struct backlight_ops picolcd_blops = {
 	.update_status  = picolcd_set_brightness,
 	.get_brightness = picolcd_get_brightness,
-	.check_fb       = picolcd_check_bl_fb,
 };
 
 int picolcd_init_backlight(struct picolcd_data *data, struct hid_report *report)
diff --git a/drivers/hid/hid-picolcd_fb.c b/drivers/hid/hid-picolcd_fb.c
index d7dddd99d325e..750206f5fc674 100644
--- a/drivers/hid/hid-picolcd_fb.c
+++ b/drivers/hid/hid-picolcd_fb.c
@@ -493,6 +493,12 @@ int picolcd_init_framebuffer(struct picolcd_data *data)
 	info->fix = picolcdfb_fix;
 	info->fix.smem_len   = PICOLCDFB_SIZE*8;
 
+#ifdef CONFIG_FB_BACKLIGHT
+#ifdef CONFIG_HID_PICOLCD_BACKLIGHT
+	info->bl_dev = data->backlight;
+#endif
+#endif
+
 	fbdata = info->par;
 	spin_lock_init(&fbdata->lock);
 	fbdata->picolcd = data;
-- 
2.43.0


