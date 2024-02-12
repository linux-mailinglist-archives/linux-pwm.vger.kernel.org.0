Return-Path: <linux-pwm+bounces-1288-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC778518FF
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Feb 2024 17:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2BEB1F21D71
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Feb 2024 16:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207EF3D568;
	Mon, 12 Feb 2024 16:26:55 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2943D3BC;
	Mon, 12 Feb 2024 16:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707755215; cv=none; b=Eb940tryRRzdmdQ2wtBfF8laBjEDSH9apOa9yH0+VBywN/AM920rfQiQ5ifqcN5dNVejLIXsSe7AgF3flCgWTxFCboVOuPaZ9s4HIuanwG+SXZ2nOJGvGsqDJjpbs2jvQh+QWf/Gk5hpQbFp+mDzJCg7xrz6A4t8cCVfhpvh0ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707755215; c=relaxed/simple;
	bh=Ip1iT85HlJAH6A07JsI3qif8Wgw5KeoLW86H2X4k/ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sjAZZmaEpR+a41xTvnWN/HXvxzPDP4ZIOzEAcjrAr33F5D7th8Kc5DfE4+YT0oRx/bURukx24jtd1o5IPUlRZtCVzaxBZewAzFcYKLAdj9Bu51FIfuuzs/3nFsTaHVWUZb16rCuigaaNZ9vX1tlZ9jVCDCf5cxoKehrqEmt0wzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D888D2211E;
	Mon, 12 Feb 2024 16:26:51 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9647913A3D;
	Mon, 12 Feb 2024 16:26:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id QHSCI8tGymXmXgAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Mon, 12 Feb 2024 16:26:51 +0000
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
Subject: [PATCH 09/10] fbdev/ssd1307fb: Remove struct backlight_ops.check_fb
Date: Mon, 12 Feb 2024 17:16:42 +0100
Message-ID: <20240212162645.5661-10-tzimmermann@suse.de>
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
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: D888D2211E
X-Spam-Flag: NO

The driver sets struct fb_info.bl_dev to the correct backlight
device. Thus rely on the backlight core code to match backlight
and framebuffer devices, and remove the extra check_fb function
from struct backlight_ops.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
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


