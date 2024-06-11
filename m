Return-Path: <linux-pwm+bounces-2426-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 694EB903C60
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Jun 2024 14:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EA231F23496
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Jun 2024 12:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC64517C9E8;
	Tue, 11 Jun 2024 12:53:31 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554E217C7AE;
	Tue, 11 Jun 2024 12:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718110411; cv=none; b=XBQI81lE54MG8W7S30uUwMt32dQKoHgpVQvVvizWbz5/djo2bHl7/iCQa6QhAtQTOxEtY1KHPGLaYHHApXJmE1hJCiNDirXor7kjH71GiMjYRMnqIDPVf/vGsakYz+slJU8mDlNC8FWMERlby7qSceDgG5nCa0+qDYTCS5CgF84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718110411; c=relaxed/simple;
	bh=QAS9BE6ib4OMNc8HGDSCSOzwx+DkxVLmeMp9jnLuQro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MNP6RuXPN9/fWm2wrgu9DzBfbrmgDIigXLxT5qtjNgEYKNL3M913673TdDVSYPmJn14qHse1EgF3AM/t2rGjEpSoz2HOSzu/2ceCFj8OncKjRjhOcrnPizD6xlGz9ADIVvyIeoM6niZHupgJvuCcPrAO/GL4vxECv02cF/YPIt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 94C5B21AA0;
	Tue, 11 Jun 2024 12:53:25 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4EA9813AAB;
	Tue, 11 Jun 2024 12:53:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EJTqEcVIaGbxMgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 11 Jun 2024 12:53:25 +0000
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
Subject: [PATCH 05/17] backlight: gpio-backlight: Use backlight power constants
Date: Tue, 11 Jun 2024 14:42:00 +0200
Message-ID: <20240611125321.6927-6-tzimmermann@suse.de>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 94C5B21AA0
X-Spam-Flag: NO
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Score: -4.00

Replace FB_BLANK_ constants with their counterparts from the
backlight subsystem. The values are identical, so there's no
change in functionality.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/backlight/gpio_backlight.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index 4476c317ce293..8e41f8ebdc51c 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -5,7 +5,6 @@
 
 #include <linux/backlight.h>
 #include <linux/err.h>
-#include <linux/fb.h>
 #include <linux/gpio/consumer.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -81,12 +80,12 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 	/* Set the initial power state */
 	if (!of_node || !of_node->phandle)
 		/* Not booted with device tree or no phandle link to the node */
-		bl->props.power = def_value ? FB_BLANK_UNBLANK
-					    : FB_BLANK_POWERDOWN;
+		bl->props.power = def_value ? BL_CORE_UNBLANK
+					    : BL_CORE_POWERDOWN;
 	else if (gpiod_get_value_cansleep(gbl->gpiod) == 0)
-		bl->props.power = FB_BLANK_POWERDOWN;
+		bl->props.power = BL_CORE_POWERDOWN;
 	else
-		bl->props.power = FB_BLANK_UNBLANK;
+		bl->props.power = BL_CORE_UNBLANK;
 
 	bl->props.brightness = 1;
 
-- 
2.45.2


