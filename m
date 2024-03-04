Return-Path: <linux-pwm+bounces-1701-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B20870731
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Mar 2024 17:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E324280BF1
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Mar 2024 16:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2F84EB2E;
	Mon,  4 Mar 2024 16:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oRKXJq3D";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HtHq3Jle";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oRKXJq3D";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HtHq3Jle"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE331482EF;
	Mon,  4 Mar 2024 16:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709569954; cv=none; b=VNSc0irlBtd5JEL/MSCsPmK6vrph0mYd+1ajQ6PtO9pjc76ZjafVvb9l3ZtcJJoaL84f9YQJY+8B5lTE7udEHXX94xXgFY4i7AghZ9fhltWvaR639OW1rPHgI2/WVXeQjpxpEeUa1hfJ6XpqXwOzYPPo2+QafSv2E9tNq9AVMPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709569954; c=relaxed/simple;
	bh=vKr5mElKlCE9ez3QEO/1NXFNqefBHLhR/ArilKitksI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uhwPaAIC3pNlYy51EtNhfviujtZRNHtlyDJg4LJ8iM6RJ6Gu+xWXeXpIiCfpzHml5r8jXK3P+bhxToaUtpnvMJI3YuXmZrVhZ335pjGzYGfE9kQhvdekbyPEuIcXoIew+hqZUhHGkLARooxUAh3xluE/6VbBhjBK9BeHf6oXff8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oRKXJq3D; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HtHq3Jle; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oRKXJq3D; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HtHq3Jle; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A4D4A1FF58;
	Mon,  4 Mar 2024 16:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709569945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qfhcy/hEHxfuNqfhSlDlbxTKM4p4+a+utzcPfxG9fCY=;
	b=oRKXJq3D6SeCDo95QBbZMtFYNf0zjjHXlJXQuNaGuYmHkx+Vuwf8snb32q6iUQzc8oBiVz
	GSdt1PAiiLfvkuBgTlphq+1QuGHwTpELkVfbEDTjXEQyq3CabwwK3UbDMZ4xK2LqTm0pe8
	e11L3jftSMYN1MVdhklyklzH0KlqwdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709569945;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qfhcy/hEHxfuNqfhSlDlbxTKM4p4+a+utzcPfxG9fCY=;
	b=HtHq3JlezzWvMluJirEqqL6v+IAdQFULN15vNhwzk8eNZ1xXnUMJh4TSuXCDPH7ACFQO9z
	7uEjr4Q9wB+MSlAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709569945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qfhcy/hEHxfuNqfhSlDlbxTKM4p4+a+utzcPfxG9fCY=;
	b=oRKXJq3D6SeCDo95QBbZMtFYNf0zjjHXlJXQuNaGuYmHkx+Vuwf8snb32q6iUQzc8oBiVz
	GSdt1PAiiLfvkuBgTlphq+1QuGHwTpELkVfbEDTjXEQyq3CabwwK3UbDMZ4xK2LqTm0pe8
	e11L3jftSMYN1MVdhklyklzH0KlqwdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709569945;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qfhcy/hEHxfuNqfhSlDlbxTKM4p4+a+utzcPfxG9fCY=;
	b=HtHq3JlezzWvMluJirEqqL6v+IAdQFULN15vNhwzk8eNZ1xXnUMJh4TSuXCDPH7ACFQO9z
	7uEjr4Q9wB+MSlAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4DAE2139C6;
	Mon,  4 Mar 2024 16:32:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id YAGmEZn35WVLAQAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Mon, 04 Mar 2024 16:32:25 +0000
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
	Thomas Zimmermann <tzimmermann@suse.de>,
	=?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons@linux-vserver.org>
Subject: [PATCH v3 04/10] hid/hid-picolcd: Remove struct backlight_ops.check_fb
Date: Mon,  4 Mar 2024 17:29:49 +0100
Message-ID: <20240304163220.19144-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304163220.19144-1-tzimmermann@suse.de>
References: <20240304163220.19144-1-tzimmermann@suse.de>
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
X-Spamd-Result: default: False [-6.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLbrmj4aennmrpd7btm9n9zy3k)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[kernel.org,linaro.org,gmail.com,gmx.de,protonic.nl,redhat.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -6.10

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
2.44.0


