Return-Path: <linux-pwm+bounces-2416-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C21903C4A
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Jun 2024 14:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 363D8280FEA
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Jun 2024 12:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6439917C21F;
	Tue, 11 Jun 2024 12:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qTk3dJsQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iZ4LlMQS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ximfnlrK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ik/eD9XJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82BC17623D;
	Tue, 11 Jun 2024 12:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718110408; cv=none; b=JSdU4H2Q/EUiEinA8FTYlpGUR4HsBTKZySwMATt7z5qWhXPthvcfe/1ljJk9dz1IlEelWYMytzaFaXoYXJbruyYFK8E991xy5KjBENXj2M2i79cK67DUdKdZ+O+Ng+s2amEzs9OqMqlNU56TKKaToHRRGqqfkDg8gwKf0tyF0RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718110408; c=relaxed/simple;
	bh=m8s5/cLUp6GFb69JYrnI7HHerRHvfI8xKjuxP4oy6fM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eCeo2JEgD5MgK9VPPXXV/ga3F0JYXmSX8fg35C1Uom3NooTZIbhv1HIVsVNOi+uMSjryHA861/RaPPQLLnGOtragz/NWux4Npi6/8E9Fe9Gt0mPCOLmGInmysY3FE2XJw7v3S+GY+7jcOeMyitJ8egJYr+Hsxcn6iaKH9OMeosE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qTk3dJsQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iZ4LlMQS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ximfnlrK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ik/eD9XJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0851921A1C;
	Tue, 11 Jun 2024 12:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718110405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=54g5oiLjrdPEsJB5vfcZDMXSu+oeWoXzVXVz42MmGWQ=;
	b=qTk3dJsQRDv5TUh5/j1lybKlvdzv+vKLez1Fqbl7ak2jDbtrQpylP0Z0JddDPBTS676WhB
	OvbE3zmzj10w0M8yqe2ivYDFZ5oodadSJKCImkdbqpty6gUA/f/3iI/rmNtnlBB7ZfhHuY
	pckp7D3KDz+BJbQ+jXHox0iiQgZS3+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718110405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=54g5oiLjrdPEsJB5vfcZDMXSu+oeWoXzVXVz42MmGWQ=;
	b=iZ4LlMQSHD+5bv7mAI7QW2qJ2eEhPNXdXJs0pNMmL4KynKFrDkgbK0t1FS4W3tWUZYVLiU
	DDcoBhmxinnLgTBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718110404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=54g5oiLjrdPEsJB5vfcZDMXSu+oeWoXzVXVz42MmGWQ=;
	b=ximfnlrK8Ha6/GxYe7jjLV7TievNGrqe8feVBJ2tvrc4OVNi2y/kyDH9cWqDkhlRfyK0bH
	6xDgQddOQJd0gen7V6ymqGQEMC+/DPhtD6bpHmp8z1FuRN5uuoxOYoxsCV8WvoliAgso6l
	hS3DZM/lAMZXmjSqpbAhBNso8z7np4s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718110404;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=54g5oiLjrdPEsJB5vfcZDMXSu+oeWoXzVXVz42MmGWQ=;
	b=Ik/eD9XJJt0YmT81QzF+qZoSoJk6I6WqWWReGIVBG8Arh5DPjNcgH1S01tZBSl018DCuS6
	0dMcLOlrk5+4ZkCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA28C13AAB;
	Tue, 11 Jun 2024 12:53:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yBxhKMRIaGbxMgAAD6G6ig
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
Subject: [PATCH 03/17] backlight: ams369fb06: Use backlight power constants
Date: Tue, 11 Jun 2024 14:41:58 +0200
Message-ID: <20240611125321.6927-4-tzimmermann@suse.de>
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
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[kernel.org,linaro.org,gmail.com,gmx.de,asem.it];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de]
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 

Replace FB_BLANK_ constants with their counterparts from the
backlight subsystem. The values are identical, so there's no
change in functionality.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/backlight/ams369fg06.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/video/backlight/ams369fg06.c b/drivers/video/backlight/ams369fg06.c
index 57ec205d2bd2a..2e97ff9314af4 100644
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
+	return power <= BL_CORE_NORMAL;
 }
 
 static int ams369fg06_power_on(struct ams369fg06 *lcd)
@@ -396,8 +395,8 @@ static int ams369fg06_set_power(struct lcd_device *ld, int power)
 {
 	struct ams369fg06 *lcd = lcd_get_data(ld);
 
-	if (power != FB_BLANK_UNBLANK && power != FB_BLANK_POWERDOWN &&
-		power != FB_BLANK_NORMAL) {
+	if (power != BL_CORE_UNBLANK && power != BL_CORE_POWERDOWN &&
+		power != BL_CORE_NORMAL) {
 		dev_err(lcd->dev, "power value should be 0, 1 or 4.\n");
 		return -EINVAL;
 	}
@@ -492,11 +491,11 @@ static int ams369fg06_probe(struct spi_device *spi)
 		 * current lcd status is powerdown and then
 		 * it enables lcd panel.
 		 */
-		lcd->power = FB_BLANK_POWERDOWN;
+		lcd->power = BL_CORE_POWERDOWN;
 
-		ams369fg06_power(lcd, FB_BLANK_UNBLANK);
+		ams369fg06_power(lcd, BL_CORE_UNBLANK);
 	} else {
-		lcd->power = FB_BLANK_UNBLANK;
+		lcd->power = BL_CORE_UNBLANK;
 	}
 
 	spi_set_drvdata(spi, lcd);
@@ -510,7 +509,7 @@ static void ams369fg06_remove(struct spi_device *spi)
 {
 	struct ams369fg06 *lcd = spi_get_drvdata(spi);
 
-	ams369fg06_power(lcd, FB_BLANK_POWERDOWN);
+	ams369fg06_power(lcd, BL_CORE_POWERDOWN);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -524,16 +523,16 @@ static int ams369fg06_suspend(struct device *dev)
 	 * when lcd panel is suspend, lcd panel becomes off
 	 * regardless of status.
 	 */
-	return ams369fg06_power(lcd, FB_BLANK_POWERDOWN);
+	return ams369fg06_power(lcd, BL_CORE_POWERDOWN);
 }
 
 static int ams369fg06_resume(struct device *dev)
 {
 	struct ams369fg06 *lcd = dev_get_drvdata(dev);
 
-	lcd->power = FB_BLANK_POWERDOWN;
+	lcd->power = BL_CORE_POWERDOWN;
 
-	return ams369fg06_power(lcd, FB_BLANK_UNBLANK);
+	return ams369fg06_power(lcd, BL_CORE_UNBLANK);
 }
 #endif
 
@@ -544,7 +543,7 @@ static void ams369fg06_shutdown(struct spi_device *spi)
 {
 	struct ams369fg06 *lcd = spi_get_drvdata(spi);
 
-	ams369fg06_power(lcd, FB_BLANK_POWERDOWN);
+	ams369fg06_power(lcd, BL_CORE_POWERDOWN);
 }
 
 static struct spi_driver ams369fg06_driver = {
-- 
2.45.2


