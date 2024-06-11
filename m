Return-Path: <linux-pwm+bounces-2420-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C53A903C54
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Jun 2024 14:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0153A1F23496
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Jun 2024 12:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBE317C7C6;
	Tue, 11 Jun 2024 12:53:30 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1E01E86F;
	Tue, 11 Jun 2024 12:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718110410; cv=none; b=k0wfEr6OAUBTT8Baq+6IW/FuskpZcc48yDT2GzaHfE/OhS+M9zNgwTDZSIVXXpp+Fueail4OpBjDqNbXqYr3v4XKP1lrqshECxbo1KXGG4ooYxSCyGnx+oGq7PMKwZ9pNkuh/e+AIhZ+4AJrKB1RYIHcEC1lp3KNeC5cP6mqBBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718110410; c=relaxed/simple;
	bh=sE/s44Pvv2FVAxLRC5+M5i+C8Gdr6Ou4a5uKWjEeq4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UuTed2x1Z6UO0HAA6zEBlil6jw3bQ8ogYv9sr4+8c8wsDu5Io/9ANJuvWLuiN35eCkFQPh6OQBP7Gd63cQA6tM+QLjOKXBbeT5ofT9LDzmWaBQYFHIAUK9CTVLYwW3rz4mR24Nr7rMM7U3VbhGoaQ43S0B8u+wtSY/rCPyE4KZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DFBFC21C5B;
	Tue, 11 Jun 2024 12:53:25 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A835137DF;
	Tue, 11 Jun 2024 12:53:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kMB7JMVIaGbxMgAAD6G6ig
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
Subject: [PATCH 06/17] backlight: ipaq-micro-backlight: Use backlight power constants
Date: Tue, 11 Jun 2024 14:42:01 +0200
Message-ID: <20240611125321.6927-7-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: DFBFC21C5B
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
 drivers/video/backlight/ipaq_micro_bl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/backlight/ipaq_micro_bl.c b/drivers/video/backlight/ipaq_micro_bl.c
index f595b8c8cbb24..d3be6d2d7493a 100644
--- a/drivers/video/backlight/ipaq_micro_bl.c
+++ b/drivers/video/backlight/ipaq_micro_bl.c
@@ -7,7 +7,6 @@
 
 #include <linux/backlight.h>
 #include <linux/err.h>
-#include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/mfd/ipaq-micro.h>
 #include <linux/module.h>
@@ -42,7 +41,7 @@ static const struct backlight_ops micro_bl_ops = {
 static const struct backlight_properties micro_bl_props = {
 	.type = BACKLIGHT_RAW,
 	.max_brightness = 255,
-	.power = FB_BLANK_UNBLANK,
+	.power = BL_CORE_UNBLANK,
 	.brightness = 64,
 };
 
-- 
2.45.2


