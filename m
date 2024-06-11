Return-Path: <linux-pwm+bounces-2422-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 711BC903C58
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Jun 2024 14:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68EA61C23189
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Jun 2024 12:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0064A17C7D1;
	Tue, 11 Jun 2024 12:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vFwq3qP1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zxGM+tmb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vFwq3qP1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zxGM+tmb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5549017C226;
	Tue, 11 Jun 2024 12:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718110410; cv=none; b=C4dDOrqhke044clYkggv7hBgo3nnuIFV9eMOLPg220lTMqMBrR/HBqylLO64pWJmc2kGOBBGOrjyO5PsYuv59MD9WB3RqavsU7l0Darh/Gpg0z07TqdQ3FdvbTjVctN1ggnF/hNacnSDp4KEuiZlLp6m+WiakjsaVQTZZZ0SzSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718110410; c=relaxed/simple;
	bh=EPd7RcN6oCM6UHIlK/4KsW7QcSGXxaE8b7vwc8TY3XI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FstSBRq74cWY3Dx68bCYEJkMAudzocw41hnV+0EnWxonBIpLdespp/Ly78LebWWdbk97uB+pBIt/ZsLJP+OKOxewBgSQgUjVOo/mTozrqKiBNokoOI3QsQIJPujcyXjxVIInod3wqTvYmcZ/jxP9Zc4cqsC8oCDJ5ReIoThdnHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vFwq3qP1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zxGM+tmb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vFwq3qP1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zxGM+tmb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 38C5421C8D;
	Tue, 11 Jun 2024 12:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718110406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NP7evCnXqcwa5ThIT89JaYCIIBxddzoHvzRUuSZe7JE=;
	b=vFwq3qP19yJ2BkqDpjY0YJaHkmPO4EXfI51W9LujRD+nm4YSfueXqq5qvZ9MKyJw+JPA/U
	14Lbi0a/b8V/kR1gs9gaDJSwL+1Cnd7AYFfBQpLS7Y796LCCSTEVQ9X7fltmMPg6cOEZS5
	aYjHxeZVuF716MatFm0nR8Qa7t+Rq+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718110406;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NP7evCnXqcwa5ThIT89JaYCIIBxddzoHvzRUuSZe7JE=;
	b=zxGM+tmb0H75geg83+tpaCT9JGN67gS6KdY05oCg3Q0PQB3BxXIjWUbBAlOFUYUL7aEydx
	uOe6xRxwar1DKdDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718110406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NP7evCnXqcwa5ThIT89JaYCIIBxddzoHvzRUuSZe7JE=;
	b=vFwq3qP19yJ2BkqDpjY0YJaHkmPO4EXfI51W9LujRD+nm4YSfueXqq5qvZ9MKyJw+JPA/U
	14Lbi0a/b8V/kR1gs9gaDJSwL+1Cnd7AYFfBQpLS7Y796LCCSTEVQ9X7fltmMPg6cOEZS5
	aYjHxeZVuF716MatFm0nR8Qa7t+Rq+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718110406;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NP7evCnXqcwa5ThIT89JaYCIIBxddzoHvzRUuSZe7JE=;
	b=zxGM+tmb0H75geg83+tpaCT9JGN67gS6KdY05oCg3Q0PQB3BxXIjWUbBAlOFUYUL7aEydx
	uOe6xRxwar1DKdDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E59B813AAB;
	Tue, 11 Jun 2024 12:53:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4P3MNsVIaGbxMgAAD6G6ig
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
Subject: [PATCH 07/17] backlight: journada_bl: Use backlight power constants
Date: Tue, 11 Jun 2024 14:42:02 +0200
Message-ID: <20240611125321.6927-8-tzimmermann@suse.de>
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
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linaro.org,gmail.com,gmx.de,asem.it];
	RCPT_COUNT_SEVEN(0.00)[11];
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
 drivers/video/backlight/jornada720_bl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/backlight/jornada720_bl.c b/drivers/video/backlight/jornada720_bl.c
index 066d0dc98f607..d296799ba9d14 100644
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
+	bd->props.power = BL_CORE_UNBLANK;
 	bd->props.brightness = BL_DEF_BRIGHT;
 	/*
 	 * note. make sure max brightness is set otherwise
-- 
2.45.2


