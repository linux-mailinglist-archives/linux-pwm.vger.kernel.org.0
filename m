Return-Path: <linux-pwm+bounces-1292-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F23FB85190F
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Feb 2024 17:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65AB01F21D58
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Feb 2024 16:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5103D969;
	Mon, 12 Feb 2024 16:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ITSm5xUY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zD8fuXtl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ITSm5xUY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zD8fuXtl"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C681F3D0D4;
	Mon, 12 Feb 2024 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707755217; cv=none; b=pyieL2q/xCL9GVkZZkW2JI/LJhr/CHunypyXsl1wVCuV4++CqIgeKbJj+871RPTme2u4Zx5kT7tI5SnBbEIcaD4uJjTZ+4TZEmRFbfNTqyp7fHJvKKW5+Egh3PexZ1AmdYV+ZDkg8w7hLDMxtVGay0QuFydn4uSa8jwQ3icYlF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707755217; c=relaxed/simple;
	bh=AieS5dJ5Nfhit1dWCXPmx6XhOYR0e/KtOWgCbU60kEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nih5p8m6cnqmhZNSX3ZNuqhOFRt4Y9NmmmGVnR83Aiim7rk4oHYcfdxoWSeJrQ6ty4FiUmzQhmSkvlkj5m8Ie7VyyBZ84GW4u8AFIE6Xrx1//hf2pau2tmS+HT/vFqpX5PTX09h0SsGW7NSCb8MfX3zvvBbXQQL2IHRE77RxC4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ITSm5xUY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zD8fuXtl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ITSm5xUY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zD8fuXtl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 257B11FD55;
	Mon, 12 Feb 2024 16:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707755210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yxISTntkPhzhHroXWtNxLJRq1PFjq8ruleuT4zEM1tw=;
	b=ITSm5xUY60pFGthZdkuMpzG5iuG9pjDxrMpg0Oqpl1rdFOw52C3F/S4jA9LRKU7FE3dRkU
	FBWAco82UysTguAgGX1VV5GAIzFCzYPEHExRlnERWP3dVQWYCfiuh5FqYlTNDEzDGJBjaZ
	8sd6KJNWo4F/Uo/FaxwSY5LlM35gUjM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707755210;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yxISTntkPhzhHroXWtNxLJRq1PFjq8ruleuT4zEM1tw=;
	b=zD8fuXtlXGiU5oPXqFrnw0qskYZMmRFGdwsq0uk497BVCJ31Xaiz/kKHmXg3mnEG0Bjr4K
	ZAMFdd5gqmdGi9BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707755210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yxISTntkPhzhHroXWtNxLJRq1PFjq8ruleuT4zEM1tw=;
	b=ITSm5xUY60pFGthZdkuMpzG5iuG9pjDxrMpg0Oqpl1rdFOw52C3F/S4jA9LRKU7FE3dRkU
	FBWAco82UysTguAgGX1VV5GAIzFCzYPEHExRlnERWP3dVQWYCfiuh5FqYlTNDEzDGJBjaZ
	8sd6KJNWo4F/Uo/FaxwSY5LlM35gUjM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707755210;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yxISTntkPhzhHroXWtNxLJRq1PFjq8ruleuT4zEM1tw=;
	b=zD8fuXtlXGiU5oPXqFrnw0qskYZMmRFGdwsq0uk497BVCJ31Xaiz/kKHmXg3mnEG0Bjr4K
	ZAMFdd5gqmdGi9BQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C856B13A3D;
	Mon, 12 Feb 2024 16:26:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id mPWmL8lGymXmXgAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Mon, 12 Feb 2024 16:26:49 +0000
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
	=?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons@linux-vserver.org>
Subject: [PATCH 03/10] hid/hid-picolcd: Fix initialization order
Date: Mon, 12 Feb 2024 17:16:36 +0100
Message-ID: <20240212162645.5661-4-tzimmermann@suse.de>
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
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.42
X-Spamd-Result: default: False [-4.42 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RLbrmj4aennmrpd7btm9n9zy3k)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[kernel.org,linaro.org,gmail.com,gmx.de,redhat.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.12)[67.14%]
X-Spam-Flag: NO

For drivers that support backlight, LCD and fbdev devices, fbdev has
to be initialized last. See documentation for struct fbinfo.bl_dev.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: "Bruno Prémont" <bonbons@linux-vserver.org>
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
2.43.0


