Return-Path: <linux-pwm+bounces-1586-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7677E85D424
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Feb 2024 10:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3072728591D
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Feb 2024 09:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4913EA7B;
	Wed, 21 Feb 2024 09:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Vg3LEfB2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="798d/gMQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Vg3LEfB2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="798d/gMQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C243D995;
	Wed, 21 Feb 2024 09:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708508614; cv=none; b=WEPs4H8xfH9CPNcbyhEwWe+we29kEzR5yoTPIotUKGKTzefrN2571C6UiYkJvOyISwgJNyM7EyIwo+0/KYhymhvmwKFRCpMXEr6Vfuxsl3H4xYbZdI1BmfQIAojFi2xULgXk4dmQltzcvpRFM/tpzcXmI9q3xWomAjVeZZxMzWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708508614; c=relaxed/simple;
	bh=pYORUPjgZxymnXgGDfpgr1hnPbabxhGJFr2Ri2emk+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ruQHvIs4afxS4IPZD8jxct65D35bulvBEC7/KUFPYwuoBJTekWaECTIgbRsCihzkUb85Rg81X5v2tEsZHnVm0PHal5GZZyUGdx4Zp8d4KJOVnuPIBLo6SHwAjADBH8N5/7cuxuStvzfdESfkvWktnQLOZvA42JUPQCJ/f6cOEbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Vg3LEfB2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=798d/gMQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Vg3LEfB2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=798d/gMQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5138B1FB4F;
	Wed, 21 Feb 2024 09:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708508608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PtixQVizv1gFoo8SvQU9nQzVSWG+j9t0ClPmcGl6r30=;
	b=Vg3LEfB2SM9vQPy5SBDpBgBa49OM5RS9m8enUUt0zqXTU8SX0bFFR4U7UmMHuFThO4nZpO
	seVR2Udleqj/mJoHYH2p2wPbMWe0o/2885SmDaGwiXDMxLU+zLtPcGKtWe3v0+XeB844N0
	5suGiPy0y/TOKcAskSylnJjxE4byZ18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708508608;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PtixQVizv1gFoo8SvQU9nQzVSWG+j9t0ClPmcGl6r30=;
	b=798d/gMQ2O7fG9jQLjXoGsPMSF06B+q29MMkRw3s2kJpL2WdflbNCnlr1pGPGQiXjGPWez
	QK4SjX7zRIQDfyCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708508608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PtixQVizv1gFoo8SvQU9nQzVSWG+j9t0ClPmcGl6r30=;
	b=Vg3LEfB2SM9vQPy5SBDpBgBa49OM5RS9m8enUUt0zqXTU8SX0bFFR4U7UmMHuFThO4nZpO
	seVR2Udleqj/mJoHYH2p2wPbMWe0o/2885SmDaGwiXDMxLU+zLtPcGKtWe3v0+XeB844N0
	5suGiPy0y/TOKcAskSylnJjxE4byZ18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708508608;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PtixQVizv1gFoo8SvQU9nQzVSWG+j9t0ClPmcGl6r30=;
	b=798d/gMQ2O7fG9jQLjXoGsPMSF06B+q29MMkRw3s2kJpL2WdflbNCnlr1pGPGQiXjGPWez
	QK4SjX7zRIQDfyCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DF2F613A6D;
	Wed, 21 Feb 2024 09:43:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id IOD3NL/F1WUpCwAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Wed, 21 Feb 2024 09:43:27 +0000
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
	Thomas Zimmermann <tzimmermann@suse.de>,
	=?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons@linux-vserver.org>
Subject: [PATCH v2 03/10] hid/hid-picolcd: Fix initialization order
Date: Wed, 21 Feb 2024 10:41:30 +0100
Message-ID: <20240221094324.27436-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240221094324.27436-1-tzimmermann@suse.de>
References: <20240221094324.27436-1-tzimmermann@suse.de>
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
X-Spamd-Result: default: False [-3.19 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
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
	 BAYES_HAM(-0.09)[64.52%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.19

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
2.43.0


