Return-Path: <linux-pwm+bounces-1283-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7528518EE
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Feb 2024 17:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3099CB210B9
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Feb 2024 16:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA283D3A4;
	Mon, 12 Feb 2024 16:26:52 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3493D0D1;
	Mon, 12 Feb 2024 16:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707755212; cv=none; b=urUyv6+ygc5+I6yjgpXLYYFJiPcTqfIy5KMDhcIt5dGja59wMyICGQeEsCG0HahPaAp8ZFBRxibK1IhS9BpVf3ViZ5gqsKXRkP6CO4KRVoTNCq+0u8iNruSSa3gx87ujiRAZqMed3E0VTQc+tp00M/6nGZ3N4KtNJGfZMrUTShY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707755212; c=relaxed/simple;
	bh=C2WavXORd0CbbT0k9Kv+WFEysZqm+sHXxqvEfYE3OYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eMedevoXUT0gZSedA3LYHHIF9v8T9vbI0wbKAc+z5GQ2x1dkvPOv3aU/gCn+YhTwiiG4ksUOQlqs8You+3sIbRuRul15q/BCkTwjL3DGL+kRKCS6dDPvHDeV47aLksk1BbV+nG3qPpssHN4I4VgZLjgYTtmgRMjHQukkxlyl9zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7508E1FD53;
	Mon, 12 Feb 2024 16:26:49 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 34E6F13A3D;
	Mon, 12 Feb 2024 16:26:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id gDOlC8lGymXmXgAAn2gu4w
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
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 01/10] backlight: Match backlight device against struct fb_info.bl_dev
Date: Mon, 12 Feb 2024 17:16:34 +0100
Message-ID: <20240212162645.5661-2-tzimmermann@suse.de>
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
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 7508E1FD53
X-Spam-Flag: NO

Framebuffer drivers for devices with dedicated backlight are supposed
to set struct fb_info.bl_dev to the backlight's respective device. Use
the value to match backlight and framebuffer in the backlight core code.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/backlight/backlight.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 86e1cdc8e3697..48844a4f28ad3 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -98,7 +98,8 @@ static int fb_notifier_callback(struct notifier_block *self,
 {
 	struct backlight_device *bd;
 	struct fb_event *evdata = data;
-	int node = evdata->info->node;
+	struct fb_info *info = evdata->info;
+	int node = info->node;
 	int fb_blank = 0;
 
 	/* If we aren't interested in this event, skip it immediately ... */
@@ -110,8 +111,12 @@ static int fb_notifier_callback(struct notifier_block *self,
 
 	if (!bd->ops)
 		goto out;
-	if (bd->ops->check_fb && !bd->ops->check_fb(bd, evdata->info))
+	else if (bd->ops->check_fb && !bd->ops->check_fb(bd, info))
 		goto out;
+#if IS_ENABLED(CONFIG_FB_BACKLIGHT)
+	else if (info->bl_dev && info->bl_dev != bd)
+		goto out;
+#endif
 
 	fb_blank = *(int *)evdata->data;
 	if (fb_blank == FB_BLANK_UNBLANK && !bd->fb_bl_on[node]) {
-- 
2.43.0


