Return-Path: <linux-pwm+bounces-2424-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEC7903C5B
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Jun 2024 14:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F66A28214D
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Jun 2024 12:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C23817C7DD;
	Tue, 11 Jun 2024 12:53:31 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F2617C7B1;
	Tue, 11 Jun 2024 12:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718110411; cv=none; b=jLvK2qIb4vfgPl2Ecxn2ZNY/djYTMQ5TBDjqPL/Ai3XTSmOnr7xHsbZG4+sRF1PJDFMZIiA84c9n5+ca/9W4BRNceZILf04FVc/XSyWrqJRiz47ayGmqsz6PYkQ6Ggx7ZsmO1KIrz+WdBqnBsiHB66AGeOh6nJN8ELJBdYjwoJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718110411; c=relaxed/simple;
	bh=eO9qWMtUDGE24m8mWS3b/KjHu88Qrbs9BVBC0VzpOsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TAyt24mvEN8BmERCHaOmCE9MExirSRiwaipBli8YxcIQgHLB/f+U1vr5t02gWhPAYmT0twObaOzY4d2quv2FXTD40QKXmjzwm00NeusUcTMZ++foqFVNCMxDDVyxixRgcXZYYIHiZGeef06Lj7pteo5chFLHSW151qkEokjg/cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1F57D20702;
	Tue, 11 Jun 2024 12:53:28 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4DC913AAB;
	Tue, 11 Jun 2024 12:53:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6GulLsdIaGbxMgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 11 Jun 2024 12:53:27 +0000
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
Subject: [PATCH 13/17] backlight: pandora-backlight: Use backlight power constants
Date: Tue, 11 Jun 2024 14:42:08 +0200
Message-ID: <20240611125321.6927-14-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: 1F57D20702
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
 drivers/video/backlight/pandora_bl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/backlight/pandora_bl.c b/drivers/video/backlight/pandora_bl.c
index 51faa889e01f4..11b280f39a0c1 100644
--- a/drivers/video/backlight/pandora_bl.c
+++ b/drivers/video/backlight/pandora_bl.c
@@ -11,7 +11,6 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
-#include <linux/fb.h>
 #include <linux/backlight.h>
 #include <linux/mfd/twl.h>
 #include <linux/err.h>
@@ -43,7 +42,7 @@ static int pandora_backlight_update_status(struct backlight_device *bl)
 	struct pandora_private *priv = bl_get_data(bl);
 	u8 r;
 
-	if (bl->props.power != FB_BLANK_UNBLANK)
+	if (bl->props.power != BL_CORE_UNBLANK)
 		brightness = 0;
 	if (bl->props.state & BL_CORE_FBBLANK)
 		brightness = 0;
-- 
2.45.2


