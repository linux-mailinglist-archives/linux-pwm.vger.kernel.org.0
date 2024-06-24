Return-Path: <linux-pwm+bounces-2593-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F19915200
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Jun 2024 17:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F9C71C21F99
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Jun 2024 15:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D5D19D086;
	Mon, 24 Jun 2024 15:20:45 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0341DFC7;
	Mon, 24 Jun 2024 15:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242445; cv=none; b=C4VR+yrAsOVsdedPe+D4lE/k4kf+LSMjhxjRU75efORJLtHJb1RqQmqgIrY2nZNkDB8ooxrvDfVcGsYwDYWRD38uGjI4wPvjB5k7W/eMivJbbEjr7CcnQOHoA4n/AtuEmNu6RaZKI1TF8z1yw8iZKTsjLUj7rc9QSRWovgk45SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242445; c=relaxed/simple;
	bh=KUiWBRIByr2eyeU3NNlByF3JQZlc1mPlmjeKcIWTzpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SRz6dxpuJkKvUBbXZp4ilXM/JTBVDwWMU/hxHOfNYLeW+83xSUFymOcc1vq1nSUbqCfX3d1W3pTK1iGgSUQFcYM4H5v73fQlkyiMDg2nYxRNCBoVBkHuxJtvNumeY6hKOIN0+e7BxL3jzQN/MFX5o7lIWMQf8GVD+o8RoinL9Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 781A71F839;
	Mon, 24 Jun 2024 15:20:41 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6A9613AA4;
	Mon, 24 Jun 2024 15:20:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KGdYJ8iOeWbqGgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 24 Jun 2024 15:20:40 +0000
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
Subject: [PATCH v2 07/17] backlight: journada_bl: Use backlight power constants
Date: Mon, 24 Jun 2024 17:20:02 +0200
Message-ID: <20240624152033.25016-8-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: 781A71F839
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
 drivers/video/backlight/jornada720_bl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/backlight/jornada720_bl.c b/drivers/video/backlight/jornada720_bl.c
index 066d0dc98f60..e28d2c071798 100644
--- a/drivers/video/backlight/jornada720_bl.c
+++ b/drivers/video/backlight/jornada720_bl.c
@@ -7,7 +7,6 @@
 
 #include <linux/backlight.h>
 #include <linux/device.h>
-#include <linux/fb.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -121,7 +120,7 @@ static int jornada_bl_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	bd->props.power = FB_BLANK_UNBLANK;
+	bd->props.power = BACKLIGHT_POWER_ON;
 	bd->props.brightness = BL_DEF_BRIGHT;
 	/*
 	 * note. make sure max brightness is set otherwise
-- 
2.45.2


