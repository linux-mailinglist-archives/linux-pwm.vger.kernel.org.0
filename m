Return-Path: <linux-pwm+bounces-2601-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3C1915210
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Jun 2024 17:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 958531F219DF
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Jun 2024 15:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C07519D884;
	Mon, 24 Jun 2024 15:20:49 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C10319B3FB;
	Mon, 24 Jun 2024 15:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242449; cv=none; b=YMfgnscT3PebMwxKgx8QUTjKKjHkrGcm2OXB4wstS0lxpiGmQRPtkq5VPDcHFiC9u0nmlcLXFnkciIlTYIqxPwuRawVfWT1T6kNb2MLJfs9aeM6TFs9q698sDZVCWlOerXB0XINuzTuBEEJeYRcO29y+kKLU0eGCzfxipxSxEpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242449; c=relaxed/simple;
	bh=gh1YEf13/sjqp8a2Uc6Gz3W9p6vq+lLG4VJHiifBeFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RvmGF4law13urdztymnwZJb7N+IBzWoruToWsy82vAm+awwTpLTwdkZccSfnBh9MjSiolDkJEl/z+47Irac1f3AQSrYgENO49a6/vting0zyTZAaiY7GW67OiWhLhwupUByNdzGqzE1FvVdaE49Zb1C3ukrAutgQ3BqXs4o4yAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ED60021ABE;
	Mon, 24 Jun 2024 15:20:45 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B1C213ACD;
	Mon, 24 Jun 2024 15:20:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2OicJM2OeWbqGgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 24 Jun 2024 15:20:45 +0000
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
Subject: [PATCH v2 14/17] backlight: pcf50633-backlight: Use backlight power constants
Date: Mon, 24 Jun 2024 17:20:09 +0200
Message-ID: <20240624152033.25016-15-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: ED60021ABE
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
 drivers/video/backlight/pcf50633-backlight.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/video/backlight/pcf50633-backlight.c b/drivers/video/backlight/pcf50633-backlight.c
index 540dd3380c81..157be2f366df 100644
--- a/drivers/video/backlight/pcf50633-backlight.c
+++ b/drivers/video/backlight/pcf50633-backlight.c
@@ -10,7 +10,6 @@
 #include <linux/platform_device.h>
 
 #include <linux/backlight.h>
-#include <linux/fb.h>
 
 #include <linux/mfd/pcf50633/core.h>
 #include <linux/mfd/pcf50633/backlight.h>
@@ -53,7 +52,7 @@ static int pcf50633_bl_update_status(struct backlight_device *bl)
 
 
 	if (bl->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK) ||
-		bl->props.power != FB_BLANK_UNBLANK)
+		bl->props.power != BACKLIGHT_POWER_ON)
 		new_brightness = 0;
 	else if (bl->props.brightness < pcf_bl->brightness_limit)
 		new_brightness = bl->props.brightness;
@@ -106,7 +105,7 @@ static int pcf50633_bl_probe(struct platform_device *pdev)
 	memset(&bl_props, 0, sizeof(bl_props));
 	bl_props.type = BACKLIGHT_RAW;
 	bl_props.max_brightness = 0x3f;
-	bl_props.power = FB_BLANK_UNBLANK;
+	bl_props.power = BACKLIGHT_POWER_ON;
 
 	if (pdata) {
 		bl_props.brightness = pdata->default_brightness;
-- 
2.45.2


