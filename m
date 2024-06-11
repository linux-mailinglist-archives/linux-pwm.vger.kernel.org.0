Return-Path: <linux-pwm+bounces-2429-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E3B903C67
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Jun 2024 14:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB8F22820FE
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Jun 2024 12:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9814017C9F3;
	Tue, 11 Jun 2024 12:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="r2QkMReT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PfSmakso";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="r2QkMReT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PfSmakso"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDB317C7D7;
	Tue, 11 Jun 2024 12:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718110412; cv=none; b=ChZJ/AU4SqxVU9LPqfvsniy2tH8kbaOTBcpUmzak2W0AKuxL4NRip8IGUR6WgYKmjqnC4+rjagZiEqCaT006DYX8BByb/XldXFmcx9N7ZbJ5zmLbTLspU04MBlON7l7mKOVGOIgEoqPHsxi/vVkUsZkeBZnYYDu+BEffiiLQSYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718110412; c=relaxed/simple;
	bh=mrKsI7V1VLDXXNYXGRYo3wy7OR288KJNg+BnOCQFsVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u51nSmjJjFvwYAvC9wRmrzst4o420MCjeqhPcc8KO0uuCWqyM/suZAV8JisdRw7iNfsDnwOUE+JPZqZ6KZK1vNXroLWpvU6BzCMNXOZSh9ujI8+QpOsQTer/8IdSZQus8P/5WwgiYJlqIDGlWEpXpcf4Duty9smmHZDSUqLmRTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=r2QkMReT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PfSmakso; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=r2QkMReT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PfSmakso; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4F5AE219D0;
	Tue, 11 Jun 2024 12:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718110409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HEjWtkTb/PFeRAxD/W2sHmuGdmWUrqrevxaycEPb138=;
	b=r2QkMReTANHU/i76oAvxi6CivFgLO6xiQG8c26ZjkO4xH1Lb83VshrSCKIjTAXfmxuBDlS
	ZGxlo3xlZtzCkYas4rDes6jnYdTGowzqfBvmkRkSjGmNN7kgepjCxi+f+0P477CZZOWrcA
	ESo9PbwsrWA59ml9Y6Uvnfe6PWl8E7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718110409;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HEjWtkTb/PFeRAxD/W2sHmuGdmWUrqrevxaycEPb138=;
	b=PfSmaksoM4NVGIZa+YKdWWDcJppY4SHgzJmRihWdpn4BqEjt5+sbSFkvcqtsfEpd8q7eNz
	C9Xy5hGIkIjV2SDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718110409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HEjWtkTb/PFeRAxD/W2sHmuGdmWUrqrevxaycEPb138=;
	b=r2QkMReTANHU/i76oAvxi6CivFgLO6xiQG8c26ZjkO4xH1Lb83VshrSCKIjTAXfmxuBDlS
	ZGxlo3xlZtzCkYas4rDes6jnYdTGowzqfBvmkRkSjGmNN7kgepjCxi+f+0P477CZZOWrcA
	ESo9PbwsrWA59ml9Y6Uvnfe6PWl8E7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718110409;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HEjWtkTb/PFeRAxD/W2sHmuGdmWUrqrevxaycEPb138=;
	b=PfSmaksoM4NVGIZa+YKdWWDcJppY4SHgzJmRihWdpn4BqEjt5+sbSFkvcqtsfEpd8q7eNz
	C9Xy5hGIkIjV2SDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 08DEB13AAB;
	Tue, 11 Jun 2024 12:53:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aCT/AMlIaGbxMgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 11 Jun 2024 12:53:29 +0000
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
Subject: [PATCH 17/17] backlight: sky81452-backlight: Use backlight power constants
Date: Tue, 11 Jun 2024 14:42:12 +0200
Message-ID: <20240611125321.6927-18-tzimmermann@suse.de>
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
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 

Replace FB_BLANK_ constants with their counterparts from the
backlight subsystem. The values are identical, so there's no
change in functionality.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/backlight/sky81452-backlight.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/sky81452-backlight.c b/drivers/video/backlight/sky81452-backlight.c
index 19f9f84a9fd6e..d76ac7c5cd990 100644
--- a/drivers/video/backlight/sky81452-backlight.c
+++ b/drivers/video/backlight/sky81452-backlight.c
@@ -315,7 +315,7 @@ static void sky81452_bl_remove(struct platform_device *pdev)
 
 	sysfs_remove_group(&bd->dev.kobj, &sky81452_bl_attr_group);
 
-	bd->props.power = FB_BLANK_UNBLANK;
+	bd->props.power = BL_CORE_UNBLANK;
 	bd->props.brightness = 0;
 	backlight_update_status(bd);
 
-- 
2.45.2


