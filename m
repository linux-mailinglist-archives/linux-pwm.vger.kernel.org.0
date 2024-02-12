Return-Path: <linux-pwm+bounces-1285-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B623D8518F0
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Feb 2024 17:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF3228137F
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Feb 2024 16:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3540F3D3BF;
	Mon, 12 Feb 2024 16:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qj3iQ9qd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="d5YaXlb9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qj3iQ9qd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="d5YaXlb9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B713D0DD;
	Mon, 12 Feb 2024 16:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707755214; cv=none; b=W14RkahAyzsde6Pg/ff2hUslU3GZ14ztzUCljMj39uk1vbIvVQY++uPepxyfH9276qMj1an2ygWeQEbRGy4Uuef77dP4LB8ovDKNd2vZ6bB5rJ9oguY/NKov/sUiT0QuAxRp+2iGnTI61qUrDDqrfvZ5PbdT24uEKkYENVe2gzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707755214; c=relaxed/simple;
	bh=uw2CvIalkaV8QLettoE/ekU1CX5amrAUkxPZxJ8MkiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=beTB/myJUUAjW6Hpf3uABIJYEQzUBdtQu1f/6cyBelH7KdFAf5VztaEmtN5IgvyJgx1blmLRYGQSGJK/fCUGi65V+GhD/pWPcDlLPg6oMP+vJhr0dbP3rx6L9m32uf1BMBk/WYSjzcMcGxTJctNv+oiAdEf8dB+d1SHXth5wArE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qj3iQ9qd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=d5YaXlb9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qj3iQ9qd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=d5YaXlb9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B60A6220EB;
	Mon, 12 Feb 2024 16:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707755210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XeEbhE7gJBfpRZnf7wbtBQJjMg65ulylVLZqUtDUC6Y=;
	b=qj3iQ9qdLUI66aBQIuJXD+7eRASXi9qTxCnorDFis5wqqDXUpqnmme/MN5QSeobcjwvHwO
	gE2455wmv/X4t2hoeBMHWc6H2KEhglXbEusHJ0zROm4KgITYbgbk7D9cMVEB7kWV0zz79b
	czYLPYN36Z/AYUyeI3ubUovf7FhMzJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707755210;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XeEbhE7gJBfpRZnf7wbtBQJjMg65ulylVLZqUtDUC6Y=;
	b=d5YaXlb97upgeiOX1sJOvLimqwCQfs6eX62681Ug74ks0tuql+Mhig5w2mDBiJ5QJfieLa
	MqUqcEZn5V/ZmUBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707755210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XeEbhE7gJBfpRZnf7wbtBQJjMg65ulylVLZqUtDUC6Y=;
	b=qj3iQ9qdLUI66aBQIuJXD+7eRASXi9qTxCnorDFis5wqqDXUpqnmme/MN5QSeobcjwvHwO
	gE2455wmv/X4t2hoeBMHWc6H2KEhglXbEusHJ0zROm4KgITYbgbk7D9cMVEB7kWV0zz79b
	czYLPYN36Z/AYUyeI3ubUovf7FhMzJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707755210;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XeEbhE7gJBfpRZnf7wbtBQJjMg65ulylVLZqUtDUC6Y=;
	b=d5YaXlb97upgeiOX1sJOvLimqwCQfs6eX62681Ug74ks0tuql+Mhig5w2mDBiJ5QJfieLa
	MqUqcEZn5V/ZmUBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A5A313A3D;
	Mon, 12 Feb 2024 16:26:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id UOSjGMpGymXmXgAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Mon, 12 Feb 2024 16:26:50 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: lee@kernel.org,
	daniel.thompson@linaro.org,
	jingoohan1@gmail.com,
	deller@gmx.de,
	javierm@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 05/10] backlight/aat2870-backlight: Remove struct backlight.check_fb
Date: Mon, 12 Feb 2024 17:16:38 +0100
Message-ID: <20240212162645.5661-6-tzimmermann@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212162645.5661-1-tzimmermann@suse.de>
References: <20240212162645.5661-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.30
X-Spamd-Result: default: False [-0.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RLbrmj4aennmrpd7btm9n9zy3k)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[kernel.org,linaro.org,gmail.com,gmx.de,redhat.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[41.17%]
X-Spam-Flag: NO

The driver's implementation of check_fb always returns true, which
is the default if no implementation has been set. So remove the code
from the driver.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/backlight/aat2870_bl.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/video/backlight/aat2870_bl.c b/drivers/video/backlight/aat2870_bl.c
index 81fde3abb92c4..b4c3354a1a8a6 100644
--- a/drivers/video/backlight/aat2870_bl.c
+++ b/drivers/video/backlight/aat2870_bl.c
@@ -12,7 +12,6 @@
 #include <linux/platform_device.h>
 #include <linux/mutex.h>
 #include <linux/delay.h>
-#include <linux/fb.h>
 #include <linux/backlight.h>
 #include <linux/mfd/aat2870.h>
 
@@ -90,15 +89,9 @@ static int aat2870_bl_update_status(struct backlight_device *bd)
 	return 0;
 }
 
-static int aat2870_bl_check_fb(struct backlight_device *bd, struct fb_info *fi)
-{
-	return 1;
-}
-
 static const struct backlight_ops aat2870_bl_ops = {
 	.options = BL_CORE_SUSPENDRESUME,
 	.update_status = aat2870_bl_update_status,
-	.check_fb = aat2870_bl_check_fb,
 };
 
 static int aat2870_bl_probe(struct platform_device *pdev)
-- 
2.43.0


