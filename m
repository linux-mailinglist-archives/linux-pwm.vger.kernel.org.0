Return-Path: <linux-pwm+bounces-2595-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB0C915206
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Jun 2024 17:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB05D1F2363B
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Jun 2024 15:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8506219D08B;
	Mon, 24 Jun 2024 15:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OomKApW1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GBY3ZMKh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OomKApW1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GBY3ZMKh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFFE1D696;
	Mon, 24 Jun 2024 15:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242446; cv=none; b=KMw7+7LxqJi3s8m7XzMVR8UonzkTDH4mT5W8RsXk6RIydI880K/+tR9T4ggJRxHKCFhYp4ZSXzieJdFRQPH79bGtSDnuhIBOdOUdn7AeSFQ/UPotMg1v21u4JzgRnGXbsOyfOBrspPexbMg4MKPQWTevxb2MFt8z5Y+ShvEHkH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242446; c=relaxed/simple;
	bh=FtyoM9uZSy7hivVHRLXLK99sI7DiS9n8c12A7kCROtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pVi+wBXSpisv1qGGWz7Gi69MGJSv/8tD/hT9M22YaUzSDQsflIIV2S2QUiiXivigBG5wlsl80ap9apjCuNcwAbCNB0F0JpW7CxH0hir3fgxROM3K0g7oNaZqEfzyaOdvKxxcCd0bCwXxU8M0QvxH3VAMBFQGPHFZfogd+WQfCws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OomKApW1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GBY3ZMKh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OomKApW1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GBY3ZMKh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BED891F833;
	Mon, 24 Jun 2024 15:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719242439; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FWQ9rEI80QCBFf/qKWxScFU6ulM0RLJFEWtPXOxovD0=;
	b=OomKApW1JPIngJ6sn9C9lnB9m2MLzbchXlQVV0Oqb4HEwZZaPi22ldl7LycX53bsJahMPF
	xWGi9RWtnzcSBSP2ujzs2E25u9wEm5J46p5Cf2/4Mjnswk9FmcmTClfTkSaWVF6BTAogkp
	rXA00YKUTRGBx5cwKtIpeOBEhVomecg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719242439;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FWQ9rEI80QCBFf/qKWxScFU6ulM0RLJFEWtPXOxovD0=;
	b=GBY3ZMKhEttjiesYWZ5thJoNMSuzn7iU12EIdtO8GcGuVadN299UJeTYX7oYPE6akTjTrY
	BAcHtBwL5Kf+LuCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719242439; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FWQ9rEI80QCBFf/qKWxScFU6ulM0RLJFEWtPXOxovD0=;
	b=OomKApW1JPIngJ6sn9C9lnB9m2MLzbchXlQVV0Oqb4HEwZZaPi22ldl7LycX53bsJahMPF
	xWGi9RWtnzcSBSP2ujzs2E25u9wEm5J46p5Cf2/4Mjnswk9FmcmTClfTkSaWVF6BTAogkp
	rXA00YKUTRGBx5cwKtIpeOBEhVomecg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719242439;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FWQ9rEI80QCBFf/qKWxScFU6ulM0RLJFEWtPXOxovD0=;
	b=GBY3ZMKhEttjiesYWZ5thJoNMSuzn7iU12EIdtO8GcGuVadN299UJeTYX7oYPE6akTjTrY
	BAcHtBwL5Kf+LuCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D97213AA4;
	Mon, 24 Jun 2024 15:20:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WJfBDceOeWbqGgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 24 Jun 2024 15:20:39 +0000
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
Subject: [PATCH v2 05/17] backlight: gpio-backlight: Use backlight power constants
Date: Mon, 24 Jun 2024 17:20:00 +0200
Message-ID: <20240624152033.25016-6-tzimmermann@suse.de>
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
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linaro.org,ravnborg.org,gmail.com,gmx.de,asem.it];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	R_RATELIMIT(0.00)[to_ip_from(RLbaz54pzrc9psah3tsaj8ddaq)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de]

Replace FB_BLANK_ constants with their counterparts from the
backlight subsystem. The values are identical, so there's no
change in functionality.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/backlight/gpio_backlight.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index 4476c317ce29..728a546904b0 100644
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
+		bl->props.power = def_value ? BACKLIGHT_POWER_ON
+					    : BACKLIGHT_POWER_OFF;
 	else if (gpiod_get_value_cansleep(gbl->gpiod) == 0)
-		bl->props.power = FB_BLANK_POWERDOWN;
+		bl->props.power = BACKLIGHT_POWER_OFF;
 	else
-		bl->props.power = FB_BLANK_UNBLANK;
+		bl->props.power = BACKLIGHT_POWER_ON;
 
 	bl->props.brightness = 1;
 
-- 
2.45.2


