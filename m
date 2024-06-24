Return-Path: <linux-pwm+bounces-2599-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FA5915212
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Jun 2024 17:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FE06B25AA6
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Jun 2024 15:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4A219D09D;
	Mon, 24 Jun 2024 15:20:48 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93061D696;
	Mon, 24 Jun 2024 15:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242448; cv=none; b=Pi7HUFtwraIHrdFEZVIrHNUWn7zd5v58XMvsNNjKBw47lGHzLgkAGKYxBTmcmrIZGKfPUbzBRm7vdESJXC8d0vEN5qFM1CifwdSWZ8dYONGmS0Hw7PrT6xtfRVOHM/0OxgzA+ijFMXepp4VgZI1O0to1XXsY5Wd9eG//MiPP6sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242448; c=relaxed/simple;
	bh=YUvGDAeLO17SZ7HyyPx9pAY6WHG1VlF4ckgD1dIOfzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sc7wURFq0QK0mFx9VKeEhKeKrX/x4Qo2V/joNKhSN4LVe7EcJnJIa3fiYV0GlCoPaCWrrZvQn4DpTzSNVJ0ZdeiUvYpl50aLTTfftp5sqGN9EsxaGvG1SZ7YEVLgV88ZC882guwPHAAfV/1B1W2rcgNOpKHAopNQZeE1EWp/Iis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4136E1F839;
	Mon, 24 Jun 2024 15:20:45 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B496413ACD;
	Mon, 24 Jun 2024 15:20:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UEHkKsyOeWbqGgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 24 Jun 2024 15:20:44 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: lee@kernel.org,
	daniel.thompson@linaro.org,
	sam@ravnborg.org,
	jingoohan1@gmail.com,
	deller@gmx.de,
	linus.walleij@linaro.org,
	f.suligoi@asem.it,
	ukleinek@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 12/17] backlight: mp3309c: Use backlight power constants
Date: Mon, 24 Jun 2024 17:20:07 +0200
Message-ID: <20240624152033.25016-13-tzimmermann@suse.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240624152033.25016-1-tzimmermann@suse.de>
References: <20240624152033.25016-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 4136E1F839
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

Replace FB_BLANK_ constants with their counterparts from the
backlight subsystem. The values are identical, so there's no
change in functionality.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/backlight/mp3309c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/mp3309c.c b/drivers/video/backlight/mp3309c.c
index a28036c964af..88bc296968e9 100644
--- a/drivers/video/backlight/mp3309c.c
+++ b/drivers/video/backlight/mp3309c.c
@@ -358,7 +358,7 @@ static int mp3309c_probe(struct i2c_client *client)
 	props.max_brightness = pdata->max_brightness;
 	props.scale = BACKLIGHT_SCALE_LINEAR;
 	props.type = BACKLIGHT_RAW;
-	props.power = FB_BLANK_UNBLANK;
+	props.power = BACKLIGHT_POWER_ON;
 	chip->bl = devm_backlight_device_register(dev, "mp3309c", dev, chip,
 						  &mp3309c_bl_ops, &props);
 	if (IS_ERR(chip->bl))
@@ -388,7 +388,7 @@ static void mp3309c_remove(struct i2c_client *client)
 	struct mp3309c_chip *chip = i2c_get_clientdata(client);
 	struct backlight_device *bl = chip->bl;
 
-	bl->props.power = FB_BLANK_POWERDOWN;
+	bl->props.power = BACKLIGHT_POWER_OFF;
 	bl->props.brightness = 0;
 	backlight_update_status(chip->bl);
 }
-- 
2.45.2


