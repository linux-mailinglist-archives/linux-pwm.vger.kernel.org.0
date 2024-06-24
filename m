Return-Path: <linux-pwm+bounces-2606-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF39915257
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Jun 2024 17:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12114B26125
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Jun 2024 15:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBFF13C3CD;
	Mon, 24 Jun 2024 15:28:28 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152FD1E869;
	Mon, 24 Jun 2024 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242908; cv=none; b=Ih7j+6WSoJHugWCYLAvm7RXpAYIUN1lbJe6Ag0/GXLn29yv5txGI4Xzb9LcJBfQ7nooup2xDvJfRjrOZZ5BjGAUADvyfx0cOs+Ru19UHoRhYdaomVMqttP9W4E4hB10UWa3yJeEDdDAUKXjtczo24vafA+BZ30YxuB8huQo40EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242908; c=relaxed/simple;
	bh=xim++fTPPdH8x1hxhpoXVrYMHpzUNh7/T3DAmaiafag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ynsi6odZCUtYw7LgxWkWlcYVB5TH+f8mAsI7WdmeeFN6LKzwTM4u4Yg5RrskXSgzyQDNT1AS5Lvhxil6QdbC0gIX0Fbc0KyJB5Pb3h2vVUGuZV3r6KYI883iVrNJHVYVkxdK6WR9iPwRhhYWHtjdK1YHnaLtfAytXJwfWAmQi5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 990DA21A62;
	Mon, 24 Jun 2024 15:20:38 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4744E13ACD;
	Mon, 24 Jun 2024 15:20:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uLgVEMaOeWbqGgAAD6G6ig
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
Subject: [PATCH v2 03/17] backlight: ams369fb06: Use backlight power constants
Date: Mon, 24 Jun 2024 17:19:58 +0200
Message-ID: <20240624152033.25016-4-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: 990DA21A62
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
 drivers/video/backlight/ams369fg06.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/video/backlight/ams369fg06.c b/drivers/video/backlight/ams369fg06.c
index 57ec205d2bd2..f8442689ac43 100644
--- a/drivers/video/backlight/ams369fg06.c
+++ b/drivers/video/backlight/ams369fg06.c
@@ -10,7 +10,6 @@
 
 #include <linux/backlight.h>
 #include <linux/delay.h>
-#include <linux/fb.h>
 #include <linux/lcd.h>
 #include <linux/module.h>
 #include <linux/spi/spi.h>
@@ -300,7 +299,7 @@ static int ams369fg06_ldi_disable(struct ams369fg06 *lcd)
 
 static int ams369fg06_power_is_on(int power)
 {
-	return power <= FB_BLANK_NORMAL;
+	return power <= BACKLIGHT_POWER_REDUCED;
 }
 
 static int ams369fg06_power_on(struct ams369fg06 *lcd)
@@ -396,8 +395,8 @@ static int ams369fg06_set_power(struct lcd_device *ld, int power)
 {
 	struct ams369fg06 *lcd = lcd_get_data(ld);
 
-	if (power != FB_BLANK_UNBLANK && power != FB_BLANK_POWERDOWN &&
-		power != FB_BLANK_NORMAL) {
+	if (power != BACKLIGHT_POWER_ON && power != BACKLIGHT_POWER_OFF &&
+		power != BACKLIGHT_POWER_REDUCED) {
 		dev_err(lcd->dev, "power value should be 0, 1 or 4.\n");
 		return -EINVAL;
 	}
@@ -492,11 +491,11 @@ static int ams369fg06_probe(struct spi_device *spi)
 		 * current lcd status is powerdown and then
 		 * it enables lcd panel.
 		 */
-		lcd->power = FB_BLANK_POWERDOWN;
+		lcd->power = BACKLIGHT_POWER_OFF;
 
-		ams369fg06_power(lcd, FB_BLANK_UNBLANK);
+		ams369fg06_power(lcd, BACKLIGHT_POWER_ON);
 	} else {
-		lcd->power = FB_BLANK_UNBLANK;
+		lcd->power = BACKLIGHT_POWER_ON;
 	}
 
 	spi_set_drvdata(spi, lcd);
@@ -510,7 +509,7 @@ static void ams369fg06_remove(struct spi_device *spi)
 {
 	struct ams369fg06 *lcd = spi_get_drvdata(spi);
 
-	ams369fg06_power(lcd, FB_BLANK_POWERDOWN);
+	ams369fg06_power(lcd, BACKLIGHT_POWER_OFF);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -524,16 +523,16 @@ static int ams369fg06_suspend(struct device *dev)
 	 * when lcd panel is suspend, lcd panel becomes off
 	 * regardless of status.
 	 */
-	return ams369fg06_power(lcd, FB_BLANK_POWERDOWN);
+	return ams369fg06_power(lcd, BACKLIGHT_POWER_OFF);
 }
 
 static int ams369fg06_resume(struct device *dev)
 {
 	struct ams369fg06 *lcd = dev_get_drvdata(dev);
 
-	lcd->power = FB_BLANK_POWERDOWN;
+	lcd->power = BACKLIGHT_POWER_OFF;
 
-	return ams369fg06_power(lcd, FB_BLANK_UNBLANK);
+	return ams369fg06_power(lcd, BACKLIGHT_POWER_ON);
 }
 #endif
 
@@ -544,7 +543,7 @@ static void ams369fg06_shutdown(struct spi_device *spi)
 {
 	struct ams369fg06 *lcd = spi_get_drvdata(spi);
 
-	ams369fg06_power(lcd, FB_BLANK_POWERDOWN);
+	ams369fg06_power(lcd, BACKLIGHT_POWER_OFF);
 }
 
 static struct spi_driver ams369fg06_driver = {
-- 
2.45.2


