Return-Path: <linux-pwm+bounces-2596-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D9291520B
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Jun 2024 17:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25771B25A73
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Jun 2024 15:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DB219D08F;
	Mon, 24 Jun 2024 15:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="r0xVBbBf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tStuB+gL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="r0xVBbBf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tStuB+gL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538FA1DFC7;
	Mon, 24 Jun 2024 15:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242447; cv=none; b=DYVZxnAJghBTM41cdYRP48OeMU80nujgM/Y4szw7YxK0QBV9OBx5b1rvEk06fkbacIJfugPtKcL+QI3+wFg5VLp3sLAaZcTLNs/K0xkd6ynPdhvmH1R1xKlUldhSPcliDRNSPfG5zewLLIWZK4fiCRMmwQVpu2gqecDyU8TdNDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242447; c=relaxed/simple;
	bh=sZHQaMysikkIVe1w8/j2eI1Monakw17/mcUE8WiLOBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D483vvil//ONkptAzcF/ztU975+lGeuWEzeQ+hjlH/lM5E1s7BMaPXnC1yETgpmhsiK+fbcTHFExXPMAoVdObxQk7hbu1gUSOl16TOtCmUCiYTVSx/uSI0NP1m5VEB1Hdz2JAthnkAQKfT2rWoH5hoQZMgKJ8uKvdznPAd/2J9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=r0xVBbBf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tStuB+gL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=r0xVBbBf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tStuB+gL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 82D232198F;
	Mon, 24 Jun 2024 15:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719242443; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eW33RKsOzPElPDu8ypGq45XLJtPeU8TrSkFM1are/1Y=;
	b=r0xVBbBfKrnXGNpMcO9pbVdEhGWB5+JTj2xR0EfIhymzAvvRJn3dvf92d/vnu9dEfCz2q0
	ZHhv0PDJLNPoImuAwUzmxc8SpXlOorfM6kGkKpOgNx2JwlhgV9nC+mcNfKmJF/KI7Gzcff
	RYu4mhazKEcDarr28xfadX85EzdKv+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719242443;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eW33RKsOzPElPDu8ypGq45XLJtPeU8TrSkFM1are/1Y=;
	b=tStuB+gLXnfR6q02wrI0GEZJv9jewWctg1ETr0MyheXJ8T9Rj3eJXLjpuR02lUROjOvJQm
	RLnXiLsxRf20baDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719242443; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eW33RKsOzPElPDu8ypGq45XLJtPeU8TrSkFM1are/1Y=;
	b=r0xVBbBfKrnXGNpMcO9pbVdEhGWB5+JTj2xR0EfIhymzAvvRJn3dvf92d/vnu9dEfCz2q0
	ZHhv0PDJLNPoImuAwUzmxc8SpXlOorfM6kGkKpOgNx2JwlhgV9nC+mcNfKmJF/KI7Gzcff
	RYu4mhazKEcDarr28xfadX85EzdKv+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719242443;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eW33RKsOzPElPDu8ypGq45XLJtPeU8TrSkFM1are/1Y=;
	b=tStuB+gLXnfR6q02wrI0GEZJv9jewWctg1ETr0MyheXJ8T9Rj3eJXLjpuR02lUROjOvJQm
	RLnXiLsxRf20baDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C0A6313AA4;
	Mon, 24 Jun 2024 15:20:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WHzBLcqOeWbqGgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 24 Jun 2024 15:20:42 +0000
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
Subject: [PATCH v2 09/17] backlight: ktd253-backlight: Use backlight power constants
Date: Mon, 24 Jun 2024 17:20:04 +0200
Message-ID: <20240624152033.25016-10-tzimmermann@suse.de>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
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
 drivers/video/backlight/ktd253-backlight.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/video/backlight/ktd253-backlight.c b/drivers/video/backlight/ktd253-backlight.c
index d7d43454f64a..327b4ee75254 100644
--- a/drivers/video/backlight/ktd253-backlight.c
+++ b/drivers/video/backlight/ktd253-backlight.c
@@ -7,7 +7,6 @@
 #include <linux/backlight.h>
 #include <linux/delay.h>
 #include <linux/err.h>
-#include <linux/fb.h>
 #include <linux/gpio/consumer.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -190,10 +189,10 @@ static int ktd253_backlight_probe(struct platform_device *pdev)
 	/* When we just enable the GPIO line we set max brightness */
 	if (brightness) {
 		bl->props.brightness = brightness;
-		bl->props.power = FB_BLANK_UNBLANK;
+		bl->props.power = BACKLIGHT_POWER_ON;
 	} else {
 		bl->props.brightness = 0;
-		bl->props.power = FB_BLANK_POWERDOWN;
+		bl->props.power = BACKLIGHT_POWER_OFF;
 	}
 
 	ktd253->bl = bl;
-- 
2.45.2


