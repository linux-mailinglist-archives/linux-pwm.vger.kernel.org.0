Return-Path: <linux-pwm+bounces-2430-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D83903C6C
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Jun 2024 14:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E319AB2377F
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Jun 2024 12:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C5F17C7D7;
	Tue, 11 Jun 2024 12:53:33 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FBE17C7B5;
	Tue, 11 Jun 2024 12:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718110413; cv=none; b=iLjX777swtXzQO6wE9GadwQ5kcqt3Ap6oKBnsYlemjO9668nFT88/ijw/IjsEsIja99UkNEjH8v8kmPBorqrt4IcJFcRIqD4l9ZOYV1nkDE1q1q+VIFdHbDGxYsqEg9JIV87qqvs82COO3eXomkiiD776naM2FOIikhlF0eqxqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718110413; c=relaxed/simple;
	bh=4DCuf+bAHycGTk7N5uCsYAL49McdNd2p4i3N0F0iLi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SW6hoEGyEDaPbuRBIWHNvrWsYqpygK6b86Lg4TvU6ZKLQ8Xb70gpDw8Ap1LqXG/Kx0in9OjC0ehyjgWmv8Vf0H1r4wE6EWC0FSPjNdyKcGXK4XUml0aUEOkLW/JjV1WhaIsKuYs8XS4xOWGZBkmNMot3+k+Ez+YVsRyi1OK6K0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 600BC20703;
	Tue, 11 Jun 2024 12:53:28 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A504137DF;
	Tue, 11 Jun 2024 12:53:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8IxBBchIaGbxMgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 11 Jun 2024 12:53:28 +0000
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
Subject: [PATCH 14/17] backlight: pcf50633-backlight: Use backlight power constants
Date: Tue, 11 Jun 2024 14:42:09 +0200
Message-ID: <20240611125321.6927-15-tzimmermann@suse.de>
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
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 600BC20703
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Action: no action

Replace FB_BLANK_ constants with their counterparts from the
backlight subsystem. The values are identical, so there's no
change in functionality.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/backlight/pcf50633-backlight.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/video/backlight/pcf50633-backlight.c b/drivers/video/backlight/pcf50633-backlight.c
index 540dd3380c81d..f75cd5e98f2be 100644
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
+		bl->props.power != BL_CORE_UNBLANK)
 		new_brightness = 0;
 	else if (bl->props.brightness < pcf_bl->brightness_limit)
 		new_brightness = bl->props.brightness;
@@ -106,7 +105,7 @@ static int pcf50633_bl_probe(struct platform_device *pdev)
 	memset(&bl_props, 0, sizeof(bl_props));
 	bl_props.type = BACKLIGHT_RAW;
 	bl_props.max_brightness = 0x3f;
-	bl_props.power = FB_BLANK_UNBLANK;
+	bl_props.power = BL_CORE_UNBLANK;
 
 	if (pdata) {
 		bl_props.brightness = pdata->default_brightness;
-- 
2.45.2


