Return-Path: <linux-pwm+bounces-1289-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6992B851905
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Feb 2024 17:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EEBD1C2036D
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Feb 2024 16:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCCE3D56D;
	Mon, 12 Feb 2024 16:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pv3s66Yr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1Tgt2qGL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pv3s66Yr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1Tgt2qGL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739623D3B9;
	Mon, 12 Feb 2024 16:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707755215; cv=none; b=lqbKbUcrj+QFiRhdE8dtRL1Xv7XMGpDULFx4LzHqOj+PSqroifFXG/4FguLuVBuS9nXhAsqjOjQXAz9nRtYHpd3F3Gx/P/V1Ht+fcAS1pGmi1UnJkKnklnwJTWpJZuddAvGOMffLb2vEqtqyHrELRavLEWCso+K+95I2zvTfUC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707755215; c=relaxed/simple;
	bh=Wwjg7fv2dKQUrCsLPtqwBOl/vpsRnAhDYuD9iAqk5iY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZyUi+r1jOqKPj2OWCgAwm6cN3O7sPNiNtYttNmsTa3+j2N8vLAng/gw8Kjzg2T6I+Jq1dJnXD3/eVjhET4fErD6xsqMdEmjY0z0IEx/aNsh5P3zEcmVJiQGqyP33Hx1+v/P06A9MtwKbTnMdUNH4/MkRUs0Xq8ODvU5tciulJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pv3s66Yr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1Tgt2qGL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pv3s66Yr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1Tgt2qGL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8FC601FD58;
	Mon, 12 Feb 2024 16:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707755211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5nsHrbgFef9XhUX0pSiNccQNsgEN0ZGZB6ATRSeNPxc=;
	b=pv3s66Yrq2GDn9Y5ayb1q8vTJSdxrruVJOPPyJIz0VtfdSrED47bk6Z0ezvngwEXYZhWMD
	gpkvqZbjWdve67m1ipY7ymhXF5VOOSQosJyzmQPJ1tZcAyK5mO73FyHqIrx/luFzarPrJb
	eLpBCCHEsG7QXifBanJywqojZaFyM3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707755211;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5nsHrbgFef9XhUX0pSiNccQNsgEN0ZGZB6ATRSeNPxc=;
	b=1Tgt2qGLJhvPYGeEIbVnftd3+RoRWW0r4rkVRJiPeyRYvzl6FGRpgZxfPvJ19ghsUV8yfI
	vViPOOAfM4UvAfCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707755211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5nsHrbgFef9XhUX0pSiNccQNsgEN0ZGZB6ATRSeNPxc=;
	b=pv3s66Yrq2GDn9Y5ayb1q8vTJSdxrruVJOPPyJIz0VtfdSrED47bk6Z0ezvngwEXYZhWMD
	gpkvqZbjWdve67m1ipY7ymhXF5VOOSQosJyzmQPJ1tZcAyK5mO73FyHqIrx/luFzarPrJb
	eLpBCCHEsG7QXifBanJywqojZaFyM3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707755211;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5nsHrbgFef9XhUX0pSiNccQNsgEN0ZGZB6ATRSeNPxc=;
	b=1Tgt2qGLJhvPYGeEIbVnftd3+RoRWW0r4rkVRJiPeyRYvzl6FGRpgZxfPvJ19ghsUV8yfI
	vViPOOAfM4UvAfCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5126F13A0E;
	Mon, 12 Feb 2024 16:26:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id WBWPEstGymXmXgAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Mon, 12 Feb 2024 16:26:51 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: lee@kernel.org,
	daniel.thompson@linaro.org,
	jingoohan1@gmail.com,
	deller@gmx.de,
	javierm@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 08/10] fbdev/ssd1307fb: Init backlight before registering framebuffer
Date: Mon, 12 Feb 2024 17:16:41 +0100
Message-ID: <20240212162645.5661-9-tzimmermann@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212162645.5661-1-tzimmermann@suse.de>
References: <20240212162645.5661-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLbrmj4aennmrpd7btm9n9zy3k)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[kernel.org,linaro.org,gmail.com,gmx.de,redhat.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.90

For drivers that support backlight, LCD and fbdev devices, fbdev has
to be initialized last. See documentation for struct fbinfo.bl_dev.

The backlight name's index number comes from register_framebuffer(),
which now happens after initializing the backlight device. So like
in all other backlight drivers, we now give the backlight device a
generic name without the fbdev index.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/ssd1307fb.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 1a4f90ea7d5a8..0d1590c61eb06 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -594,7 +594,6 @@ static int ssd1307fb_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct backlight_device *bl;
-	char bl_name[12];
 	struct fb_info *info;
 	struct fb_deferred_io *ssd1307fb_defio;
 	u32 vmem_size;
@@ -733,31 +732,30 @@ static int ssd1307fb_probe(struct i2c_client *client)
 	if (ret)
 		goto regulator_enable_error;
 
-	ret = register_framebuffer(info);
-	if (ret) {
-		dev_err(dev, "Couldn't register the framebuffer\n");
-		goto panel_init_error;
-	}
-
-	snprintf(bl_name, sizeof(bl_name), "ssd1307fb%d", info->node);
-	bl = backlight_device_register(bl_name, dev, par, &ssd1307fb_bl_ops,
+	bl = backlight_device_register("ssd1307fb-bl", dev, par, &ssd1307fb_bl_ops,
 				       NULL);
 	if (IS_ERR(bl)) {
 		ret = PTR_ERR(bl);
 		dev_err(dev, "unable to register backlight device: %d\n", ret);
-		goto bl_init_error;
+		goto panel_init_error;
+	}
+	info->bl_dev = bl;
+
+	ret = register_framebuffer(info);
+	if (ret) {
+		dev_err(dev, "Couldn't register the framebuffer\n");
+		goto fb_init_error;
 	}
 
 	bl->props.brightness = par->contrast;
 	bl->props.max_brightness = MAX_CONTRAST;
-	info->bl_dev = bl;
 
 	dev_info(dev, "fb%d: %s framebuffer device registered, using %d bytes of video memory\n", info->node, info->fix.id, vmem_size);
 
 	return 0;
 
-bl_init_error:
-	unregister_framebuffer(info);
+fb_init_error:
+	backlight_device_unregister(bl);
 panel_init_error:
 	pwm_disable(par->pwm);
 	pwm_put(par->pwm);
-- 
2.43.0


