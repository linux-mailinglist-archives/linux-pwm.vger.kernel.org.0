Return-Path: <linux-pwm+bounces-2605-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2945915254
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Jun 2024 17:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 676DAB25AAB
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Jun 2024 15:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9829019CCF7;
	Mon, 24 Jun 2024 15:28:28 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153E519B59E;
	Mon, 24 Jun 2024 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242908; cv=none; b=MRvHKlORF/mLSAj8UWGV8UdWPKFO6x42ZNKveAL8auL+hxLfrpLrPZaY7UqnSprTX3xMAftQT8NfiFEzNxSKF+5jX+tQLVxSH32EcQT8JCrBzTlHiTjJZw6HI2X8BifY/ErWnfNkdhRlLrBHcrm0QADRfYSp66F/EoS5l9W/1Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242908; c=relaxed/simple;
	bh=7QwTSjiqQ5ECvzlz5NkSK3mo+StEdnjNQ4vgKGsIwFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TeY6Y7W7pO9QYRgYZMAIxYl6sRYcTuawI6GDIGoayFLnYkuC6aq8kBheyY4zXqXVxog/GdZ2yF+pJts3bWKQoY8UE6T+4fkFQU8awaiBhn487hm65qWrZ+I+lQfppGKw3quvkI3RfjRAqEzdRhw58APYMPEnZJCfDe0FSbKZBOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 296C721AA2;
	Mon, 24 Jun 2024 15:20:39 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A06F113AA4;
	Mon, 24 Jun 2024 15:20:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QBfEJcaOeWbqGgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 24 Jun 2024 15:20:38 +0000
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
Subject: [PATCH v2 04/17] backlight: corgi-lcd: Use backlight power constants
Date: Mon, 24 Jun 2024 17:19:59 +0200
Message-ID: <20240624152033.25016-5-tzimmermann@suse.de>
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
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: 296C721AA2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

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
index aad1680c9075..e4fcfbe38dc6 100644
--- a/drivers/video/backlight/corgi_lcd.c
+++ b/drivers/video/backlight/corgi_lcd.c
@@ -526,7 +526,7 @@ static int corgi_lcd_probe(struct spi_device *spi)
 		return PTR_ERR(lcd->bl_dev);
 
 	lcd->bl_dev->props.brightness = pdata->default_intensity;
-	lcd->bl_dev->props.power = FB_BLANK_UNBLANK;
+	lcd->bl_dev->props.power = BACKLIGHT_POWER_ON;
 
 	ret = setup_gpio_backlight(lcd, pdata);
 	if (ret)
@@ -547,7 +547,7 @@ static void corgi_lcd_remove(struct spi_device *spi)
 {
 	struct corgi_lcd *lcd = spi_get_drvdata(spi);
 
-	lcd->bl_dev->props.power = FB_BLANK_UNBLANK;
+	lcd->bl_dev->props.power = BACKLIGHT_POWER_ON;
 	lcd->bl_dev->props.brightness = 0;
 	backlight_update_status(lcd->bl_dev);
 	corgi_lcd_set_power(lcd->lcd_dev, FB_BLANK_POWERDOWN);
-- 
2.45.2


