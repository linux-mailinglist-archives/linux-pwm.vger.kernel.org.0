Return-Path: <linux-pwm+bounces-2592-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C200915202
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Jun 2024 17:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F6D21C211FA
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Jun 2024 15:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8E1143743;
	Mon, 24 Jun 2024 15:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cOrVLEWU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Znvd7wIn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cOrVLEWU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Znvd7wIn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B07E1428E4;
	Mon, 24 Jun 2024 15:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242444; cv=none; b=kXAhYTkb7tKNTHvMTb6WfsvHI9IjdIIoVWwDgkYkLNRuoD6+DsSrk6vYUk+IQWBkGq3OiH5NvLgU6S+F79AggNYUmOLMAR7E4l9M1xdMxevZr/Y2ehTEVOqbwpFckapnC9+/TPmbTWYKHEAswjzEae4lOpXmJzgMoQv4pthWhEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242444; c=relaxed/simple;
	bh=rAMghXfTZ1U0Rlm4TF9j6crg3l5WeTq+H+RnLi0iav0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Igha+b8WaBro3skL8/EQqThK1rk94DxXVT3nuf4RAkgkLQmg9xgadYUv+5GF/UjXLx6R9JV5/MJMY1xkDjZp/oLwlD2rtTFD5YSh6W5kurWpipcQaZT062YzDpYAMLGvGEXXxsTf5cZwx12UjaxlozCtyPYskKU+H99UEEOz7Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cOrVLEWU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Znvd7wIn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cOrVLEWU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Znvd7wIn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A0CD41F83A;
	Mon, 24 Jun 2024 15:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719242440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0tQArUGUeDj7B2Nt0MW902STX9GUrSoE6NAFt0eeQMg=;
	b=cOrVLEWUdQ7iUFXqBLQGD3Aj+kGUdEj/RHIEo/zSwG5UtEXpwaQDc+sZtgWw/9ju8TqTW4
	k1TAE7uVwxanCSSMNBSPhJF+uxVUCcPsDejkoGdQeVGje0uyuuzLBdv6AEM242hZBaPunL
	xt7wdAxejRBrmj+A2Rfv1S5RLScb/tE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719242440;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0tQArUGUeDj7B2Nt0MW902STX9GUrSoE6NAFt0eeQMg=;
	b=Znvd7wIn0paxtd7VEQr0Y3F3fgL/gnzDJHpZEvq+YTpSCfitvA2Bs7Y8i78IRgwcu0XSRt
	NpJHpIgQFG73IUAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719242440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0tQArUGUeDj7B2Nt0MW902STX9GUrSoE6NAFt0eeQMg=;
	b=cOrVLEWUdQ7iUFXqBLQGD3Aj+kGUdEj/RHIEo/zSwG5UtEXpwaQDc+sZtgWw/9ju8TqTW4
	k1TAE7uVwxanCSSMNBSPhJF+uxVUCcPsDejkoGdQeVGje0uyuuzLBdv6AEM242hZBaPunL
	xt7wdAxejRBrmj+A2Rfv1S5RLScb/tE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719242440;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0tQArUGUeDj7B2Nt0MW902STX9GUrSoE6NAFt0eeQMg=;
	b=Znvd7wIn0paxtd7VEQr0Y3F3fgL/gnzDJHpZEvq+YTpSCfitvA2Bs7Y8i78IRgwcu0XSRt
	NpJHpIgQFG73IUAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2CDA13ACD;
	Mon, 24 Jun 2024 15:20:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yOwsMseOeWbqGgAAD6G6ig
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
Subject: [PATCH v2 06/17] backlight: ipaq-micro-backlight: Use backlight power constants
Date: Mon, 24 Jun 2024 17:20:01 +0200
Message-ID: <20240624152033.25016-7-tzimmermann@suse.de>
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
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 

Replace FB_BLANK_ constants with their counterparts from the
backlight subsystem. The values are identical, so there's no
change in functionality.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/backlight/ipaq_micro_bl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/backlight/ipaq_micro_bl.c b/drivers/video/backlight/ipaq_micro_bl.c
index f595b8c8cbb2..19ff66e444bc 100644
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
+	.power = BACKLIGHT_POWER_ON,
 	.brightness = 64,
 };
 
-- 
2.45.2


