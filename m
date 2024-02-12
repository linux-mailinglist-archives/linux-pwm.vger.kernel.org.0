Return-Path: <linux-pwm+bounces-1284-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AFC8518EC
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Feb 2024 17:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B11A1C20A6C
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Feb 2024 16:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ACD3D3B4;
	Mon, 12 Feb 2024 16:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HJb6k7Jd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DqB73Qrs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HJb6k7Jd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DqB73Qrs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B093D0D2;
	Mon, 12 Feb 2024 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707755213; cv=none; b=F2zD4ibOU4YRVum10Q6IBbJGDRW3rH5TuDCjpJTkLEs0s07/fdAtSFOEWTWRMKZL6YWdT+7P1YfVeRbHT4T9JtUUF4eVkwRLeb+FdL8XOwsJvubwjHaWddqOINQueBpqC7GudR85AKF2jugK1NCsMpMfvJi68gOGzikHb7aacEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707755213; c=relaxed/simple;
	bh=H+UuV4jrWI69sWyQx+P8r3Xj+qldFT1G7UMwDg90HNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eWutqiJmDgK194ArbYkyFgVj9UVGnPSS41N+HME756GpSZdrkS1MR7xfmH5DInBk26vgNlpWszzaisb+3xRb2vjf0/ufAWW0wnpXQTtUxDWOJSCtH/j9mdjxLEiTuRHoMfB380PrtKQ3MWFXveiojt+q7jZu0Aybdj8L3LCX19k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HJb6k7Jd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DqB73Qrs; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HJb6k7Jd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DqB73Qrs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C31E52209C;
	Mon, 12 Feb 2024 16:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707755209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YVY8JDGCUpRWMipTF/sWYOAMXRX+W5q/EN06D8H6f8k=;
	b=HJb6k7JdeXftaiQusrGFpL6C5hSn6ZiU81yJor8JdGz8qkNW0ryDg6vcDdbh9vfWc0LF3m
	bdJmLXeLj4oVg7E7q9Uo9A1E/g6pgx9Sob0cAzDRUyC8A/14KF1fdLkxoGhbEYGndxvrBx
	IIyMHKG/RNIFFMiU8KK79nv3lGI6jwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707755209;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YVY8JDGCUpRWMipTF/sWYOAMXRX+W5q/EN06D8H6f8k=;
	b=DqB73QrsRkvZqS4kA1tXsJgGHHg+yKmHl6lkSjw097Px+ifmJt1x11nxgp5Fefsl8HqGb4
	1kPCkMXrOKCAahDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707755209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YVY8JDGCUpRWMipTF/sWYOAMXRX+W5q/EN06D8H6f8k=;
	b=HJb6k7JdeXftaiQusrGFpL6C5hSn6ZiU81yJor8JdGz8qkNW0ryDg6vcDdbh9vfWc0LF3m
	bdJmLXeLj4oVg7E7q9Uo9A1E/g6pgx9Sob0cAzDRUyC8A/14KF1fdLkxoGhbEYGndxvrBx
	IIyMHKG/RNIFFMiU8KK79nv3lGI6jwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707755209;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YVY8JDGCUpRWMipTF/sWYOAMXRX+W5q/EN06D8H6f8k=;
	b=DqB73QrsRkvZqS4kA1tXsJgGHHg+yKmHl6lkSjw097Px+ifmJt1x11nxgp5Fefsl8HqGb4
	1kPCkMXrOKCAahDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 79C6E13A0E;
	Mon, 12 Feb 2024 16:26:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 4LqOHMlGymXmXgAAn2gu4w
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
	Robin van der Gracht <robin@protonic.nl>
Subject: [PATCH 02/10] auxdisplay/ht16k33: Remove struct backlight_ops.check_fb
Date: Mon, 12 Feb 2024 17:16:35 +0100
Message-ID: <20240212162645.5661-3-tzimmermann@suse.de>
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
X-Spamd-Result: default: False [-2.10 / 50.00];
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
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[kernel.org,linaro.org,gmail.com,gmx.de,redhat.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[99.99%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.10

The driver sets struct fb_info.bl_dev to the correct backlight
device. Thus rely on the backlight core code to match backlight
and framebuffer devices, and remove the extra check_fb function
from struct backlight_ops.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Robin van der Gracht <robin@protonic.nl>
---
 drivers/auxdisplay/ht16k33.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
index a90430b7d07ba..0a858db32486b 100644
--- a/drivers/auxdisplay/ht16k33.c
+++ b/drivers/auxdisplay/ht16k33.c
@@ -325,16 +325,8 @@ static int ht16k33_bl_update_status(struct backlight_device *bl)
 	return ht16k33_brightness_set(priv, brightness);
 }
 
-static int ht16k33_bl_check_fb(struct backlight_device *bl, struct fb_info *fi)
-{
-	struct ht16k33_priv *priv = bl_get_data(bl);
-
-	return (fi == NULL) || (fi->par == priv);
-}
-
 static const struct backlight_ops ht16k33_bl_ops = {
 	.update_status	= ht16k33_bl_update_status,
-	.check_fb	= ht16k33_bl_check_fb,
 };
 
 /*
-- 
2.43.0


