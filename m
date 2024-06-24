Return-Path: <linux-pwm+bounces-2607-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D22F8915250
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Jun 2024 17:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89BC028613D
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Jun 2024 15:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05DF19B59E;
	Mon, 24 Jun 2024 15:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sZi0uDeC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="smhwEg7Y";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sZi0uDeC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="smhwEg7Y"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1534E13D538;
	Mon, 24 Jun 2024 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242908; cv=none; b=lmMNgbqErRG8A6PLbcQgMy03bhx74O4vVktNZLmbNcjWYcjRtNAge48x+MR2Cp6BbEbL0ftRAyqFTw/A2uncDEPAyMbfTgXKC/gVDq6H2sj+CHbQAkDoecqbWH9F35+sITQr+CrTcSqHgf/KF1Qj/e8CmjR+p149Wkc2d/JLPpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242908; c=relaxed/simple;
	bh=QTOnCRTOCXMCLNHSdZI8/pCh9h8Jrr5G08sXG0eKGyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nm+cmbBWpBMwZwuytqOKdE5WaUl/gYKvmgWikDjwNPgnnlUgiBm4QXTQdZ+DohNFE04HX6OKkwJ+LUaFGCGNCZXum4iIKFhsx9GTJz9RLcKH6TzPJCU1eQGAUJqMwnmvarxpBsu9LTRtl5mDg/wPlNPCAaz1PIrsyYo38II3Nck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sZi0uDeC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=smhwEg7Y; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sZi0uDeC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=smhwEg7Y; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4038021A9D;
	Mon, 24 Jun 2024 15:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719242438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mqREaBwcoZ+coU5cHhkCtUFqc6BawunkmVoO2ASgRkY=;
	b=sZi0uDeCKki6gUkIcChC6U1fsbwal0asXBN/t5mxgdiqTNEiLxG9YkiVyh4GeeOxdfzslg
	ax6IimIndkUkPMsLbMMZDBDQ9Zcw8SVviNpGIEMhMCKiHJfr4QWwVBaaP4ylU9Dug8ePnz
	QXpr6vCHJv1gBDWs+69pNh9yTqro9oo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719242438;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mqREaBwcoZ+coU5cHhkCtUFqc6BawunkmVoO2ASgRkY=;
	b=smhwEg7YbHZM5lH6PvltLQKNGRwQUefyE0z+jkC17oIcneusfTmHDjLmglJlaQuqwUW8+B
	xqGdw2/Nr7ryiMCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719242438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mqREaBwcoZ+coU5cHhkCtUFqc6BawunkmVoO2ASgRkY=;
	b=sZi0uDeCKki6gUkIcChC6U1fsbwal0asXBN/t5mxgdiqTNEiLxG9YkiVyh4GeeOxdfzslg
	ax6IimIndkUkPMsLbMMZDBDQ9Zcw8SVviNpGIEMhMCKiHJfr4QWwVBaaP4ylU9Dug8ePnz
	QXpr6vCHJv1gBDWs+69pNh9yTqro9oo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719242438;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mqREaBwcoZ+coU5cHhkCtUFqc6BawunkmVoO2ASgRkY=;
	b=smhwEg7YbHZM5lH6PvltLQKNGRwQUefyE0z+jkC17oIcneusfTmHDjLmglJlaQuqwUW8+B
	xqGdw2/Nr7ryiMCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E68D513AA4;
	Mon, 24 Jun 2024 15:20:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wIP9NsWOeWbqGgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 24 Jun 2024 15:20:37 +0000
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
Subject: [PATCH v2 02/17] backlight: aat2870-backlight: Use blacklight power constants
Date: Mon, 24 Jun 2024 17:19:57 +0200
Message-ID: <20240624152033.25016-3-tzimmermann@suse.de>
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[kernel.org,linaro.org,ravnborg.org,gmail.com,gmx.de,asem.it];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de]

Replace FB_BLANK_ constants with their counterparts from the
backlight subsystem. The values are identical, so there's no
change in functionality.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/backlight/aat2870_bl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/aat2870_bl.c b/drivers/video/backlight/aat2870_bl.c
index b4c3354a1a8a..68d327ee4b2e 100644
--- a/drivers/video/backlight/aat2870_bl.c
+++ b/drivers/video/backlight/aat2870_bl.c
@@ -156,7 +156,7 @@ static int aat2870_bl_probe(struct platform_device *pdev)
 		bd->props.max_brightness = 255;
 
 	aat2870_bl->brightness = 0;
-	bd->props.power = FB_BLANK_UNBLANK;
+	bd->props.power = BACKLIGHT_POWER_ON;
 	bd->props.brightness = bd->props.max_brightness;
 
 	ret = aat2870_bl_update_status(bd);
@@ -176,7 +176,7 @@ static void aat2870_bl_remove(struct platform_device *pdev)
 	struct aat2870_bl_driver_data *aat2870_bl = platform_get_drvdata(pdev);
 	struct backlight_device *bd = aat2870_bl->bd;
 
-	bd->props.power = FB_BLANK_POWERDOWN;
+	bd->props.power = BACKLIGHT_POWER_OFF;
 	bd->props.brightness = 0;
 	backlight_update_status(bd);
 }
-- 
2.45.2


