Return-Path: <linux-pwm+bounces-2417-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9B3903C4C
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Jun 2024 14:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC76A282E31
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Jun 2024 12:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF77117C7AC;
	Tue, 11 Jun 2024 12:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GSRUM8Fo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vujDglSB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GSRUM8Fo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vujDglSB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F80A1E86F;
	Tue, 11 Jun 2024 12:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718110408; cv=none; b=b61B82ABfISh7RQ4u6dXx22ETmwPmbzhRy4DKGcpGzNe+IgS61OTuZA604zQReCm7YJkCl2Pyk1mdXPMPMyr3flLLdALApttzK+9auZsNJygO0RACXxMzsPonRgPgM6YgHG1SS3llwqH7udmwwubRqIsyFWyoQeJJe05S+QC9eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718110408; c=relaxed/simple;
	bh=H/Db/RGg2JteBdFDur+fY8/zfuqlaQVbsdZvDodj5gE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RuaX0ZfcI28lVUEvdON84cJtu4mj5TuJ7ukrrNvyZ5SzbYIpjYtl0i7OBndE17pSR2rRAQcmxPzXct3Yiwxp90DSxtxK1QrpH1rBhEikEJ60bjxjmrH4ylWIxIYpSCLLwb9gCyjhsC4IK4aQqOED3cMACzDR//et2FWYPuRQhs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GSRUM8Fo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vujDglSB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GSRUM8Fo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vujDglSB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 47ACA21A85;
	Tue, 11 Jun 2024 12:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718110405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AY62X9S0/yPV0+VskPf5UGNtp3wqnp143wsfQN22Z0g=;
	b=GSRUM8FoYO3aa71sI+m64V2rV353ggIKeu3FXda7eGUbC9fJ+gkByhuppb6urcPejQApLy
	QLrwqJUNb0K+UHs/omB5vCT68MgLiMR+DnOVvadVxIGc6essYPdNNJd0Q6WT5SgMI7hZ0L
	3O/vU/CeprERS4ZPIkeV5ujGO2ukJHU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718110405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AY62X9S0/yPV0+VskPf5UGNtp3wqnp143wsfQN22Z0g=;
	b=vujDglSBJ577DjlTUSznJJrRhsc/Fv9vy9u39BAKmcPb9ybhvIUpmzmgzn03CMb6sirP20
	4FIZbkTvJJhF7OBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718110405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AY62X9S0/yPV0+VskPf5UGNtp3wqnp143wsfQN22Z0g=;
	b=GSRUM8FoYO3aa71sI+m64V2rV353ggIKeu3FXda7eGUbC9fJ+gkByhuppb6urcPejQApLy
	QLrwqJUNb0K+UHs/omB5vCT68MgLiMR+DnOVvadVxIGc6essYPdNNJd0Q6WT5SgMI7hZ0L
	3O/vU/CeprERS4ZPIkeV5ujGO2ukJHU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718110405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AY62X9S0/yPV0+VskPf5UGNtp3wqnp143wsfQN22Z0g=;
	b=vujDglSBJ577DjlTUSznJJrRhsc/Fv9vy9u39BAKmcPb9ybhvIUpmzmgzn03CMb6sirP20
	4FIZbkTvJJhF7OBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 021DB137DF;
	Tue, 11 Jun 2024 12:53:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qEvvOsRIaGbxMgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 11 Jun 2024 12:53:24 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: lee@kernel.org,
	daniel.thompson@linaro.org,
	jingoohan1@gmail.com,
	deller@gmx.de,
	linus.walleij@linaro.org,
	f.suligoi@asem.it,
	ukleinek@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 04/17] backlight: corgi-lcd: Use backlight power constants
Date: Tue, 11 Jun 2024 14:41:59 +0200
Message-ID: <20240611125321.6927-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240611125321.6927-1-tzimmermann@suse.de>
References: <20240611125321.6927-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linaro.org,gmail.com,gmx.de,asem.it];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	R_RATELIMIT(0.00)[to_ip_from(RLbaz54pzrc9psah3tsaj8ddaq)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de]

Replace FB_BLANK_ constants with their counterparts from the
backlight subsystem. The values are identical, so there's no
change in functionality.

Only change the driver's backlight device, but leave the LCD
device as-is.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/backlight/corgi_lcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/corgi_lcd.c b/drivers/video/backlight/corgi_lcd.c
index aad1680c9075d..b29ee8579b57e 100644
--- a/drivers/video/backlight/corgi_lcd.c
+++ b/drivers/video/backlight/corgi_lcd.c
@@ -526,7 +526,7 @@ static int corgi_lcd_probe(struct spi_device *spi)
 		return PTR_ERR(lcd->bl_dev);
 
 	lcd->bl_dev->props.brightness = pdata->default_intensity;
-	lcd->bl_dev->props.power = FB_BLANK_UNBLANK;
+	lcd->bl_dev->props.power = BL_CORE_UNBLANK;
 
 	ret = setup_gpio_backlight(lcd, pdata);
 	if (ret)
@@ -547,7 +547,7 @@ static void corgi_lcd_remove(struct spi_device *spi)
 {
 	struct corgi_lcd *lcd = spi_get_drvdata(spi);
 
-	lcd->bl_dev->props.power = FB_BLANK_UNBLANK;
+	lcd->bl_dev->props.power = BL_CORE_UNBLANK;
 	lcd->bl_dev->props.brightness = 0;
 	backlight_update_status(lcd->bl_dev);
 	corgi_lcd_set_power(lcd->lcd_dev, FB_BLANK_POWERDOWN);
-- 
2.45.2


