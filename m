Return-Path: <linux-pwm+bounces-1723-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D016A872438
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Mar 2024 17:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84D78288F7B
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Mar 2024 16:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08E512DDB4;
	Tue,  5 Mar 2024 16:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Xc6NdHWX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IKR6MdEL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Xc6NdHWX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IKR6MdEL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFE21292C8;
	Tue,  5 Mar 2024 16:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709655885; cv=none; b=akdKph2hF34yqzq6QHxNPL0Kh0zhP0tV7sz1GdPSJKq5RVXWA88WHkVLKErvIBij8edW5imkrA6nWNnQfmKatozgMmgW49LVZN501602Gg4iEJQehSnNxI4GSkQThFCd2R3j3BWQsI+yW5w30jn+re0v1+ZjXq8gYtZIba0bzT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709655885; c=relaxed/simple;
	bh=1y+6KrrTlqONyKuX80nFfFCgfKVi7IrUmbZtLouk0g0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KNDqQBMkD0bz7YFuFSeVlNdlJted1S3frvXBryD2eeMfeYEOSgpA4HDAXFV1qYHoZ2aKAxi3452PEt1yQKFBmuRI238ymJhTd4uWYvGidcxBjHZtXbCXT7Ode/7hz1qK7Nn9jsqJM0ZnqKInbRFGWknAsUVPisHh6NDW4quwucA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Xc6NdHWX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IKR6MdEL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Xc6NdHWX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IKR6MdEL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 488D46B966;
	Tue,  5 Mar 2024 16:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709655871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Um9G5Ls9++DRKuAUMV6tbE4vZGmL1TD2IaQItszLy/U=;
	b=Xc6NdHWXFboiE1sOhhZ8J06LeaZKILwYw7GXBolX4GjbntgQKExHlXDPTgfHtzIPQU0UCh
	ziQdvyC8mN8vlbQfx4TTn1gCQ3NvwaJIf5ICnupP117occmBx+jDyWc2/KjyrFF4b15HIL
	2I2dEYRR2REUTaKvY+QGyIAD4vtt6DQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709655871;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Um9G5Ls9++DRKuAUMV6tbE4vZGmL1TD2IaQItszLy/U=;
	b=IKR6MdELZw2THKe8P7dypx1asWkzgSMh53NlsZi+XJ/RpNP74+431lenfbw7dFL/nF5aGF
	vkys1lfiCqgSMOBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709655871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Um9G5Ls9++DRKuAUMV6tbE4vZGmL1TD2IaQItszLy/U=;
	b=Xc6NdHWXFboiE1sOhhZ8J06LeaZKILwYw7GXBolX4GjbntgQKExHlXDPTgfHtzIPQU0UCh
	ziQdvyC8mN8vlbQfx4TTn1gCQ3NvwaJIf5ICnupP117occmBx+jDyWc2/KjyrFF4b15HIL
	2I2dEYRR2REUTaKvY+QGyIAD4vtt6DQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709655871;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Um9G5Ls9++DRKuAUMV6tbE4vZGmL1TD2IaQItszLy/U=;
	b=IKR6MdELZw2THKe8P7dypx1asWkzgSMh53NlsZi+XJ/RpNP74+431lenfbw7dFL/nF5aGF
	vkys1lfiCqgSMOBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DBDA513A8A;
	Tue,  5 Mar 2024 16:24:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id iH5CND5H52WwYwAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Tue, 05 Mar 2024 16:24:30 +0000
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
	Thomas Zimmermann <tzimmermann@suse.de>,
	=?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons@linux-vserver.org>
Subject: [PATCH v4 03/10] hid/hid-picolcd: Fix initialization order
Date: Tue,  5 Mar 2024 17:22:36 +0100
Message-ID: <20240305162425.23845-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240305162425.23845-1-tzimmermann@suse.de>
References: <20240305162425.23845-1-tzimmermann@suse.de>
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
X-Spamd-Result: default: False [0.33 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FREEMAIL_TO(0.00)[kernel.org,linaro.org,gmail.com,gmx.de,protonic.nl,redhat.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.57)[81.29%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.33

For drivers that support backlight, LCD and fbdev devices, fbdev has
to be initialized last. See documentation for struct fbinfo.bl_dev.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: "Bruno Prémont" <bonbons@linux-vserver.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/hid/hid-picolcd_core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-picolcd_core.c b/drivers/hid/hid-picolcd_core.c
index bbda231a7ce30..5ddebe25eb91f 100644
--- a/drivers/hid/hid-picolcd_core.c
+++ b/drivers/hid/hid-picolcd_core.c
@@ -474,11 +474,6 @@ static int picolcd_probe_lcd(struct hid_device *hdev, struct picolcd_data *data)
 	if (error)
 		goto err;
 
-	/* Set up the framebuffer device */
-	error = picolcd_init_framebuffer(data);
-	if (error)
-		goto err;
-
 	/* Setup lcd class device */
 	error = picolcd_init_lcd(data, picolcd_out_report(REPORT_CONTRAST, hdev));
 	if (error)
@@ -489,6 +484,11 @@ static int picolcd_probe_lcd(struct hid_device *hdev, struct picolcd_data *data)
 	if (error)
 		goto err;
 
+	/* Set up the framebuffer device */
+	error = picolcd_init_framebuffer(data);
+	if (error)
+		goto err;
+
 	/* Setup the LED class devices */
 	error = picolcd_init_leds(data, picolcd_out_report(REPORT_LED_STATE, hdev));
 	if (error)
@@ -502,9 +502,9 @@ static int picolcd_probe_lcd(struct hid_device *hdev, struct picolcd_data *data)
 	return 0;
 err:
 	picolcd_exit_leds(data);
+	picolcd_exit_framebuffer(data);
 	picolcd_exit_backlight(data);
 	picolcd_exit_lcd(data);
-	picolcd_exit_framebuffer(data);
 	picolcd_exit_cir(data);
 	picolcd_exit_keys(data);
 	return error;
@@ -623,9 +623,9 @@ static void picolcd_remove(struct hid_device *hdev)
 	/* Cleanup LED */
 	picolcd_exit_leds(data);
 	/* Clean up the framebuffer */
+	picolcd_exit_framebuffer(data);
 	picolcd_exit_backlight(data);
 	picolcd_exit_lcd(data);
-	picolcd_exit_framebuffer(data);
 	/* Cleanup input */
 	picolcd_exit_cir(data);
 	picolcd_exit_keys(data);
-- 
2.44.0


