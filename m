Return-Path: <linux-pwm+bounces-1696-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 801A087071E
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Mar 2024 17:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 357DF1F23231
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Mar 2024 16:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328EC4DA09;
	Mon,  4 Mar 2024 16:32:31 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C1B4CE11;
	Mon,  4 Mar 2024 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709569951; cv=none; b=Vrbpy1n7h7qZSeFaxMzQhoK5lfvEUjm8mh64PYwmi2s4yb66vfVNh1AtZfcRHH4UeBjssWmtZrh/VW/EuslZEoM/sZoFFg+IlXm5SiMtnxdszOXdviNAAlTT0COplwk94BBLGbGFCnWrY2cSarIIGlzujDFjHWYANAecG+kSh7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709569951; c=relaxed/simple;
	bh=uOwFMt+83EsKNNhkY2N+wi4oavD08Okoo2gbXz7O1jY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FWS+GV4xCkRD2eukjVj5n4sFFVtZOFy0+XsuLWJE5MHBWVe1g1jbg2J8TfxZhQwkmzJRvfN/7JQBICVtrr6VblusSJ+AAGhLbU/SIeqSJKjNSwCFO/xnWBTXule5cnSgtf9Skbcpk9r06RSMbae6L2J3Ks5fX8izcxe8uuvKeOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 26DD31FF5D;
	Mon,  4 Mar 2024 16:32:27 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BE682139C6;
	Mon,  4 Mar 2024 16:32:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id GKU4LZr35WVLAQAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Mon, 04 Mar 2024 16:32:26 +0000
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
Subject: [PATCH v3 08/10] fbdev/ssd1307fb: Init backlight before registering framebuffer
Date: Mon,  4 Mar 2024 17:29:53 +0100
Message-ID: <20240304163220.19144-9-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: 26DD31FF5D
X-Spam-Flag: NO

For drivers that support backlight, LCD and fbdev devices, fbdev has
to be initialized last. See documentation for struct fbinfo.bl_dev.

The backlight name's index number comes from register_framebuffer(),
which now happens after initializing the backlight device. So like
in all other backlight drivers, we now give the backlight device a
generic name without the fbdev index.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
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
2.44.0


