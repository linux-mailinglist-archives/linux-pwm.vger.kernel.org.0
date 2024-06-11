Return-Path: <linux-pwm+bounces-2415-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E856F903C48
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Jun 2024 14:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8BFC1C21F97
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Jun 2024 12:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12CA17C7A8;
	Tue, 11 Jun 2024 12:53:27 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3707417C21F;
	Tue, 11 Jun 2024 12:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718110407; cv=none; b=osDLnfzQQGzMvR5jlL1l4+5cbQAo+5cyFkvwh2CcReQigRnVGwt15LKnKzDvCivElGHzq1dp5o//RY4y/T6YxA88HFwTuPsCqWHRm0gCV6xZRQAeROk0Lu2ZOchRGVevsq9yj5fZjQLNNbK4JjDC3i+FEDtOAu315E0nC7NEIyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718110407; c=relaxed/simple;
	bh=eT6RfcYax/sVicVqLrrK/Bwi39O6tDy5hSrkRdPCkJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A78MPLYrhOTu3u6HZv4WI4LoBq8v/ZidfKSH5PQN330a8p3l6p+S0rctxZ0aML0NrAUY4zQY3qYeRcxyj1731KJsVaEN/8zEwYR4OJbGrEaMKstSDrSrvuoGGWdJH5e6TrXH6431INfcAxvd0eJkD0HEGjsD9wvDH/nRwr8AFns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5675D219B1;
	Tue, 11 Jun 2024 12:53:24 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0DF6D13AAB;
	Tue, 11 Jun 2024 12:53:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8BY9AsRIaGbxMgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 11 Jun 2024 12:53:24 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: lee@kernel.org,
	daniel.thompson@linaro.org,
	jingoohan1@gmail.com,
	deller@gmx.de,
	linus.walleij@linaro.org,
	f.suligoi@asem.it,
	ukleinek@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 01/17] backlight: Add BL_CORE_ constants for power states
Date: Tue, 11 Jun 2024 14:41:56 +0200
Message-ID: <20240611125321.6927-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240611125321.6927-1-tzimmermann@suse.de>
References: <20240611125321.6927-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5675D219B1
X-Spam-Flag: NO
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Score: -4.00

Duplicate FB_BLANK_ constants as BL_CORE_ constants in the backlight
header file. Allows backlight drivers to avoid including the fbdev
header file and removes a compile-time dependency between the two
subsystems.

The new BL_CORE constants have the same values as their FB_BLANK_
counterparts. Hence UAPI and internal semantics do not change. The
backlight drivers can be converted one by one.

Backlight code or drivers do not use FB_BLANK_VSYNC_SUSPEND and
FB_BLANK_HSYNC_SUSPEND, so no new constants for these are being
added.

The semantics of FB_BLANK_NORMAL appear inconsistent. In fbdev,
NORMAL means display off with sync enabled. In backlight code,
this translates to turn the backlight off, but some drivers
interpret it as backlight on. So we keep the current code as is,
but mark BL_CORE_NORMAL as deprecated. Drivers should be fixed
and the constant removed. This affects ams369fg06 and a few DRM
panel drivers.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 Documentation/ABI/stable/sysfs-class-backlight |  7 ++++---
 include/linux/backlight.h                      | 16 ++++++++++------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-class-backlight b/Documentation/ABI/stable/sysfs-class-backlight
index 023fb52645f8b..6102d6bebdf9a 100644
--- a/Documentation/ABI/stable/sysfs-class-backlight
+++ b/Documentation/ABI/stable/sysfs-class-backlight
@@ -3,10 +3,11 @@ Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	Richard Purdie <rpurdie@rpsys.net>
 Description:
-		Control BACKLIGHT power, values are FB_BLANK_* from fb.h
+		Control BACKLIGHT power, values are compatible with
+		FB_BLANK_* from fb.h
 
-		 - FB_BLANK_UNBLANK (0)   : power on.
-		 - FB_BLANK_POWERDOWN (4) : power off
+		 - 0 (FB_BLANK_UNBLANK)   : power on.
+		 - 4 (FB_BLANK_POWERDOWN) : power off
 Users:		HAL
 
 What:		/sys/class/backlight/<backlight>/brightness
diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index 19a1c0e22629d..e0cfd89ffadd2 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -210,14 +210,18 @@ struct backlight_properties {
 	 * When the power property is updated update_status() is called.
 	 *
 	 * The possible values are: (0: full on, 1 to 3: power saving
-	 * modes; 4: full off), see FB_BLANK_XXX.
+	 * modes; 4: full off), see BL_CORE_XXX constants.
 	 *
 	 * When the backlight device is enabled @power is set
-	 * to FB_BLANK_UNBLANK. When the backlight device is disabled
-	 * @power is set to FB_BLANK_POWERDOWN.
+	 * to BL_CORE_UNBLANK. When the backlight device is disabled
+	 * @power is set to BL_CORE_POWERDOWN.
 	 */
 	int power;
 
+#define BL_CORE_UNBLANK		(0)
+#define BL_CORE_NORMAL		(1) // deprecated; don't use in new code
+#define BL_CORE_POWERDOWN	(4)
+
 	/**
 	 * @type: The type of backlight supported.
 	 *
@@ -346,7 +350,7 @@ static inline int backlight_enable(struct backlight_device *bd)
 	if (!bd)
 		return 0;
 
-	bd->props.power = FB_BLANK_UNBLANK;
+	bd->props.power = BL_CORE_UNBLANK;
 	bd->props.state &= ~BL_CORE_FBBLANK;
 
 	return backlight_update_status(bd);
@@ -361,7 +365,7 @@ static inline int backlight_disable(struct backlight_device *bd)
 	if (!bd)
 		return 0;
 
-	bd->props.power = FB_BLANK_POWERDOWN;
+	bd->props.power = BL_CORE_POWERDOWN;
 	bd->props.state |= BL_CORE_FBBLANK;
 
 	return backlight_update_status(bd);
@@ -380,7 +384,7 @@ static inline int backlight_disable(struct backlight_device *bd)
  */
 static inline bool backlight_is_blank(const struct backlight_device *bd)
 {
-	return bd->props.power != FB_BLANK_UNBLANK ||
+	return bd->props.power != BL_CORE_UNBLANK ||
 	       bd->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK);
 }
 
-- 
2.45.2


