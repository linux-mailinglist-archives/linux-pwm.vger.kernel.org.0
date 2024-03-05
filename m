Return-Path: <linux-pwm+bounces-1725-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5767887243E
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Mar 2024 17:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B3581C23A01
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Mar 2024 16:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD86D12DDBA;
	Tue,  5 Mar 2024 16:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KKaAQYgN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bYeOyE+Y";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KKaAQYgN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bYeOyE+Y"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A268128830;
	Tue,  5 Mar 2024 16:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709655895; cv=none; b=WXwEJg/WPz0dmM06K2FBqjy5VGoeGBDmBsoVP8NoZTN14jphCDIVFzXih+8R6Pmv2bHD2EBuGIIC/iGM7TkcPYtbACD1nGIRo1JKtGSRAD3BY1p45VxtH73dO1gNelqQ9ipAV+JQa6DxRaUvi3IeED0i4MRZC9RXmNzVXXubvAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709655895; c=relaxed/simple;
	bh=uOwFMt+83EsKNNhkY2N+wi4oavD08Okoo2gbXz7O1jY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KiaZA8sqVT5o+YqhVYCpHg37Ymv/RZDpVNMgDNygFyUSm6gtDMzba77uYdXcAmmdhdH7hlVVndoD+UdT/fdze0U2nG6NUuhI0GCxLrT+lWnKR+Da8M7S1ut4h2hu/nhxiz2U81pIQgRNTCO0HXN0g+dMdJ/upIARotyHdlTJmkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KKaAQYgN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bYeOyE+Y; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KKaAQYgN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bYeOyE+Y; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1402F6B96C;
	Tue,  5 Mar 2024 16:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709655873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tiW8oMxRirFfgXm1wCsY/SJh6175DL+59YAwCG6IkK4=;
	b=KKaAQYgNert5uKY+9h5Cn0u97seXJ0D67DcxnT9vQ5lou/tg3kdRw6qoLlOrmZtEtrueoK
	e0+vmcR6vRoUg4gNsOth4gCnOIjFStqBsUyV4tRpK5MqZKKI8VTFhBzhjKcljmUe8pI/3M
	VWXXl/z2me4sQOB4Io0Rbml3eEBVWt8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709655873;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tiW8oMxRirFfgXm1wCsY/SJh6175DL+59YAwCG6IkK4=;
	b=bYeOyE+YUoawS1yySKcNQ5AbZwa5rxaZ7F2e5Ggt8UZ3LV9+9FCcgsX+9XRf6bsQz2iHBf
	fsV9ImWBO1cGN+BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709655873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tiW8oMxRirFfgXm1wCsY/SJh6175DL+59YAwCG6IkK4=;
	b=KKaAQYgNert5uKY+9h5Cn0u97seXJ0D67DcxnT9vQ5lou/tg3kdRw6qoLlOrmZtEtrueoK
	e0+vmcR6vRoUg4gNsOth4gCnOIjFStqBsUyV4tRpK5MqZKKI8VTFhBzhjKcljmUe8pI/3M
	VWXXl/z2me4sQOB4Io0Rbml3eEBVWt8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709655873;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tiW8oMxRirFfgXm1wCsY/SJh6175DL+59YAwCG6IkK4=;
	b=bYeOyE+YUoawS1yySKcNQ5AbZwa5rxaZ7F2e5Ggt8UZ3LV9+9FCcgsX+9XRf6bsQz2iHBf
	fsV9ImWBO1cGN+BA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B7D9A13A5D;
	Tue,  5 Mar 2024 16:24:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 6O+hK0BH52WwYwAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Tue, 05 Mar 2024 16:24:32 +0000
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
Subject: [PATCH v4 08/10] fbdev/ssd1307fb: Init backlight before registering framebuffer
Date: Tue,  5 Mar 2024 17:22:41 +0100
Message-ID: <20240305162425.23845-9-tzimmermann@suse.de>
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
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KKaAQYgN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bYeOyE+Y
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.99 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLmbat3p9xsccqh5oowmzmthut)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[kernel.org,linaro.org,gmail.com,gmx.de,protonic.nl,redhat.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[21.65%];
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
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 0.99
X-Rspamd-Queue-Id: 1402F6B96C
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


