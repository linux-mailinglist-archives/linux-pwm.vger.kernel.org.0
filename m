Return-Path: <linux-pwm+bounces-1286-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A72BB8518F6
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Feb 2024 17:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16EF61F21C1A
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Feb 2024 16:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD503D555;
	Mon, 12 Feb 2024 16:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PT/8qR1c";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="N/iDH5bx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PT/8qR1c";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="N/iDH5bx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49363D397;
	Mon, 12 Feb 2024 16:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707755214; cv=none; b=Q5LAHYdAdSQRDOPFiKVNag3ZzgmzCg3rFu5HavEFH/TbYhC6q9+MRjY1zOygwdMKUcoYD5hsX3RFG7vVKwqvyPzVqCcUQfF/4OJskaqwew5/dbYZ1rGh6E225DyVsSccw+QLTwDnBHgEL0m14H6HRQFNeniyJAcRtsxyX2lpveU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707755214; c=relaxed/simple;
	bh=9EBL+tejszEFDi/LE68caUJLPpBCHgUe8WI/NDk/gqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RtC4zI9bb3mTpLFp8rDrT8LodcjEz5asYv7DNMvLB2YeFtXfPRcHwcxumJat8mh3S0Tu4tFPcy7ydbx76aSqNrjv/aYRHRptpkBmWpK3ICxWcyEU0WvWHL2/apIxZoSjgcLAjXPZDh0VmY3gxbSalb2TVntvQAv8W+0Z1RHyPvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PT/8qR1c; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=N/iDH5bx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PT/8qR1c; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=N/iDH5bx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 03E6C2211C;
	Mon, 12 Feb 2024 16:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707755211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GPjtN8qJEIMbX0lL0lVoNRNOYWns1/I1H1N1TQ8+8wA=;
	b=PT/8qR1ciEy9FGuMdR2l1p6nB0oYT/jR7cd5ZYHgiN7WWeA1OEsPk/wL0i/EG3zFwM97tZ
	4RGCqRmMFNJ92os34EMI3g7Hza8FvuNHh+LEwpXIrtWiZClm7cTC4mzDcP8ZdUAbJQWIvj
	/C9vdl7qgOWC7b3WKf4gfPPKQaJ25gE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707755211;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GPjtN8qJEIMbX0lL0lVoNRNOYWns1/I1H1N1TQ8+8wA=;
	b=N/iDH5bx1m7ndjFlxxfx7rFUfgqVVXPLsTYS9M3zB4TrmAUZpJMDT2ZPEl+lorGsYRXRgg
	fll5FETod5m6SvCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707755211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GPjtN8qJEIMbX0lL0lVoNRNOYWns1/I1H1N1TQ8+8wA=;
	b=PT/8qR1ciEy9FGuMdR2l1p6nB0oYT/jR7cd5ZYHgiN7WWeA1OEsPk/wL0i/EG3zFwM97tZ
	4RGCqRmMFNJ92os34EMI3g7Hza8FvuNHh+LEwpXIrtWiZClm7cTC4mzDcP8ZdUAbJQWIvj
	/C9vdl7qgOWC7b3WKf4gfPPKQaJ25gE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707755211;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GPjtN8qJEIMbX0lL0lVoNRNOYWns1/I1H1N1TQ8+8wA=;
	b=N/iDH5bx1m7ndjFlxxfx7rFUfgqVVXPLsTYS9M3zB4TrmAUZpJMDT2ZPEl+lorGsYRXRgg
	fll5FETod5m6SvCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B0C7713A0E;
	Mon, 12 Feb 2024 16:26:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id qBT2KcpGymXmXgAAn2gu4w
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
	Thomas Zimmermann <tzimmermann@suse.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 06/10] backlight/pwm-backlight: Remove struct backlight_ops.check_fb
Date: Mon, 12 Feb 2024 17:16:39 +0100
Message-ID: <20240212162645.5661-7-tzimmermann@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212162645.5661-1-tzimmermann@suse.de>
References: <20240212162645.5661-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLbrmj4aennmrpd7btm9n9zy3k)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[kernel.org,linaro.org,gmail.com,gmx.de,redhat.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[20.96%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.10

The internal check_fb callback from struct pwm_bl_data is never
implemented. thus the driver's implementation of check_fb always
returns true, which is the backlight core's default if no
implementation has been set. So remove the code from the driver.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
---
 drivers/video/backlight/pwm_bl.c | 12 ------------
 include/linux/pwm_backlight.h    |  1 -
 2 files changed, 13 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index ffcebf6aa76a9..61d30bc98eea5 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -11,7 +11,6 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/fb.h>
 #include <linux/backlight.h>
 #include <linux/err.h>
 #include <linux/pwm.h>
@@ -34,7 +33,6 @@ struct pwm_bl_data {
 					  int brightness);
 	void			(*notify_after)(struct device *,
 					int brightness);
-	int			(*check_fb)(struct device *, struct fb_info *);
 	void			(*exit)(struct device *);
 };
 
@@ -129,17 +127,8 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
 	return 0;
 }
 
-static int pwm_backlight_check_fb(struct backlight_device *bl,
-				  struct fb_info *info)
-{
-	struct pwm_bl_data *pb = bl_get_data(bl);
-
-	return !pb->check_fb || pb->check_fb(pb->dev, info);
-}
-
 static const struct backlight_ops pwm_backlight_ops = {
 	.update_status	= pwm_backlight_update_status,
-	.check_fb	= pwm_backlight_check_fb,
 };
 
 #ifdef CONFIG_OF
@@ -482,7 +471,6 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 
 	pb->notify = data->notify;
 	pb->notify_after = data->notify_after;
-	pb->check_fb = data->check_fb;
 	pb->exit = data->exit;
 	pb->dev = &pdev->dev;
 	pb->enabled = false;
diff --git a/include/linux/pwm_backlight.h b/include/linux/pwm_backlight.h
index cdd2ac366bc72..0bf80e98d5b40 100644
--- a/include/linux/pwm_backlight.h
+++ b/include/linux/pwm_backlight.h
@@ -19,7 +19,6 @@ struct platform_pwm_backlight_data {
 	int (*notify)(struct device *dev, int brightness);
 	void (*notify_after)(struct device *dev, int brightness);
 	void (*exit)(struct device *dev);
-	int (*check_fb)(struct device *dev, struct fb_info *info);
 };
 
 #endif
-- 
2.43.0


