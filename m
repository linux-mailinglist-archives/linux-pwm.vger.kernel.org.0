Return-Path: <linux-pwm+bounces-1718-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD17872425
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Mar 2024 17:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 126FF28797B
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Mar 2024 16:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F136312DDAF;
	Tue,  5 Mar 2024 16:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QNlmEcIz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="C4D0Naq6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QNlmEcIz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="C4D0Naq6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC905129A69;
	Tue,  5 Mar 2024 16:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709655878; cv=none; b=FJAMcILnubQiC4zbPiDM+dzKxWyPWrVRjwQSbN7cIgIhwgs5UXfP8mPYWWGiD+ExEF8xvIeG5hEcMz/5th8nVGpx0cKsOuZpHJJio39pXYS5VM/8FYcEyBPGxvmJGbQ8S0eNs7U/8nEFZHUcOomWqpXSYT8yRU5lQ2/TBOHiUxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709655878; c=relaxed/simple;
	bh=2bPOPNIHmcZTgpWYlyNa1KiHEaRnhgkL5SGpobPm8Vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T452whrtplPuqiMIqG5nDWRwfzloAMAwehf/P7DebjgabaOZ1uVZO9fxb++jjWQsDiAWxc35GLyzJGoUSsG6zk20nckuvcMEVJGIqUqsMDGDPjSJz5j2vf/0zEaTRVdLBeWj1IRazzBJ5Em5JVQuyKjsOUOKRci+rs87kCG8Q4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QNlmEcIz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=C4D0Naq6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QNlmEcIz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=C4D0Naq6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 071C16B969;
	Tue,  5 Mar 2024 16:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709655872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W0DH+ovuFKZKkAPGVkfdyjheKXnKjpTcQmUhHMaVdfE=;
	b=QNlmEcIzyyOHrDKttcS56wXbIuhagQkSKbCIHwwidg9J6YTZKwkPkunxSehm1tNdUiBzwv
	Xw0/3NysoR9abWA9IH/a800WPWo6GSPZTc8yHd2ZdDdRX4oky1EM4eaP9h2Xfp3itfNe7B
	a8ZcgtZ0YEgT+oMlJ7NuXK4BqrcCRik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709655872;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W0DH+ovuFKZKkAPGVkfdyjheKXnKjpTcQmUhHMaVdfE=;
	b=C4D0Naq6/Y6ug+HRRSC9g8OdPSn+urMMgWhotX6TYc5O2b+WSwSa44viPiokVWPjz0zXkq
	FFDFAEydDWLyxMAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709655872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W0DH+ovuFKZKkAPGVkfdyjheKXnKjpTcQmUhHMaVdfE=;
	b=QNlmEcIzyyOHrDKttcS56wXbIuhagQkSKbCIHwwidg9J6YTZKwkPkunxSehm1tNdUiBzwv
	Xw0/3NysoR9abWA9IH/a800WPWo6GSPZTc8yHd2ZdDdRX4oky1EM4eaP9h2Xfp3itfNe7B
	a8ZcgtZ0YEgT+oMlJ7NuXK4BqrcCRik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709655872;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W0DH+ovuFKZKkAPGVkfdyjheKXnKjpTcQmUhHMaVdfE=;
	b=C4D0Naq6/Y6ug+HRRSC9g8OdPSn+urMMgWhotX6TYc5O2b+WSwSa44viPiokVWPjz0zXkq
	FFDFAEydDWLyxMAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F4FA13A8A;
	Tue,  5 Mar 2024 16:24:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id oBCEJT9H52WwYwAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Tue, 05 Mar 2024 16:24:31 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: lee@kernel.org,
	andy@kernel.org,
	daniel.thompson@linaro.org,
	jingoohan1@gmail.com,
	deller@gmx.de,
	robin@protonic.nl,
	javierm@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v4 05/10] backlight/aat2870-backlight: Remove struct backlight.check_fb
Date: Tue,  5 Mar 2024 17:22:38 +0100
Message-ID: <20240305162425.23845-6-tzimmermann@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240305162425.23845-1-tzimmermann@suse.de>
References: <20240305162425.23845-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QNlmEcIz;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=C4D0Naq6
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.80 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLmbat3p9xsccqh5oowmzmthut)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[kernel.org,linaro.org,gmail.com,gmx.de,protonic.nl,redhat.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-1.79)[93.72%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -0.80
X-Rspamd-Queue-Id: 071C16B969
X-Spam-Flag: NO

The driver's implementation of check_fb always returns true, which
is the default if no implementation has been set. So remove the code
from the driver.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
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
2.44.0


