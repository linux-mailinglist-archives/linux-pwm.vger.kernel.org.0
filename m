Return-Path: <linux-pwm+bounces-1587-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 813EB85D425
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Feb 2024 10:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 107C01F2743F
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Feb 2024 09:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28943EA8A;
	Wed, 21 Feb 2024 09:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="umQsCj5l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MwvHq6uj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="umQsCj5l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MwvHq6uj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2867C3E476;
	Wed, 21 Feb 2024 09:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708508614; cv=none; b=UrtWnriEH3S3s64CdO1lVKE0gBnQ5pSPVWzu1TD8NUdy42vTWW3rvxydYm/0gVbaSqXhlMcA6crRmK2O+42UYOAIHyPwD9mayrsv1L+7hnaRpOSFis5xmnI7BMFBehVKlZDN6YARzNy1XbwJh45WUlAmnqMoQqclkZTOR5NWv0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708508614; c=relaxed/simple;
	bh=ULiONwxGySw2NOJ67ycr/w1ptbYUqSXogsN0uAmnYjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNGiRMCZT/dLy004hcrgzxgm7n1aYcaibm++/hFiReNMiTEy1g1++rlhLiCZdxE0cwzmwVKrTJs1f6nEPDv50sT0EH8loiPwztk8I7JnT1p69o2VKE2O/Dcpeuxep6QuHeKsOyxi2d7ZKMrAZskX+wbuUkYZJ5coknvqCE3IiB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=umQsCj5l; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MwvHq6uj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=umQsCj5l; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MwvHq6uj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C91C222127;
	Wed, 21 Feb 2024 09:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708508610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hlRgnNrze55CLjOfXEge3l50s+drMdqYBnjoZMl9n8U=;
	b=umQsCj5lRaWfW0cKhFk9Tca+b+MaveuOgowpQka0NSseZdlAH37DSsuv8V0B3I+Bbp65hZ
	ZxKiqvgfLeCjMPmI3Ikt5XtCscVJmt4x57hudXm/hUcFX/6QV0Al+FKpkzPAArffhhNRwM
	wf3Ovt2s/5LJ4HEVaMb/8URkLBYPaig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708508610;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hlRgnNrze55CLjOfXEge3l50s+drMdqYBnjoZMl9n8U=;
	b=MwvHq6ujnI3dahhcn0n60BwuovJyTgTbnQjlBCwpY4rUXUyFB5rSHAUlglowMxQWhdHhPt
	gkkqJJktlxD3IoBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708508610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hlRgnNrze55CLjOfXEge3l50s+drMdqYBnjoZMl9n8U=;
	b=umQsCj5lRaWfW0cKhFk9Tca+b+MaveuOgowpQka0NSseZdlAH37DSsuv8V0B3I+Bbp65hZ
	ZxKiqvgfLeCjMPmI3Ikt5XtCscVJmt4x57hudXm/hUcFX/6QV0Al+FKpkzPAArffhhNRwM
	wf3Ovt2s/5LJ4HEVaMb/8URkLBYPaig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708508610;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hlRgnNrze55CLjOfXEge3l50s+drMdqYBnjoZMl9n8U=;
	b=MwvHq6ujnI3dahhcn0n60BwuovJyTgTbnQjlBCwpY4rUXUyFB5rSHAUlglowMxQWhdHhPt
	gkkqJJktlxD3IoBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 692C413A25;
	Wed, 21 Feb 2024 09:43:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id EFQkGMLF1WUpCwAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Wed, 21 Feb 2024 09:43:30 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: lee@kernel.org,
	daniel.thompson@linaro.org,
	jingoohan1@gmail.com,
	deller@gmx.de,
	andy@kernel.org,
	robin@protonic.nl,
	javierm@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 09/10] fbdev/ssd1307fb: Remove struct backlight_ops.check_fb
Date: Wed, 21 Feb 2024 10:41:36 +0100
Message-ID: <20240221094324.27436-10-tzimmermann@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240221094324.27436-1-tzimmermann@suse.de>
References: <20240221094324.27436-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.21 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLbrmj4aennmrpd7btm9n9zy3k)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FREEMAIL_TO(0.00)[kernel.org,linaro.org,gmail.com,gmx.de,protonic.nl,redhat.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.11)[88.30%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.21

The driver sets struct fb_info.bl_dev to the correct backlight
device. Thus rely on the backlight core code to match backlight
and framebuffer devices, and remove the extra check_fb function
from struct backlight_ops.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/video/fbdev/ssd1307fb.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 0d1590c61eb06..3f30af3c059e0 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -530,17 +530,10 @@ static int ssd1307fb_get_brightness(struct backlight_device *bdev)
 	return par->contrast;
 }
 
-static int ssd1307fb_check_fb(struct backlight_device *bdev,
-				   struct fb_info *info)
-{
-	return (info->bl_dev == bdev);
-}
-
 static const struct backlight_ops ssd1307fb_bl_ops = {
 	.options	= BL_CORE_SUSPENDRESUME,
 	.update_status	= ssd1307fb_update_bl,
 	.get_brightness	= ssd1307fb_get_brightness,
-	.check_fb	= ssd1307fb_check_fb,
 };
 
 static struct ssd1307fb_deviceinfo ssd1307fb_ssd1305_deviceinfo = {
-- 
2.43.0


