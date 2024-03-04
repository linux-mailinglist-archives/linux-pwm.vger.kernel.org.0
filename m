Return-Path: <linux-pwm+bounces-1691-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5940F870719
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Mar 2024 17:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CF1EB2306A
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Mar 2024 16:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83BB4CE1C;
	Mon,  4 Mar 2024 16:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="M7QF9IZd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="q6UmkMeP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yK1s5VZA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="W6HctuyR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D695E3FE5B;
	Mon,  4 Mar 2024 16:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709569949; cv=none; b=kV8RQrWQCocd9QBHfUD3T3gOKmMhrQw2snAxMA4vZGsM1pGPWY0yxN6epI5piut7fX2Svo6I0qCbw/6o+pLSiVbGhv02o44jZaSpd2J308v6xUfY8a56tCKxEEjCX3Mz7LUe+vclNx5O8+/MdqIR9qAVYIVwd38BEVb8WWjhG9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709569949; c=relaxed/simple;
	bh=MVnT1GcB9mZoAtZdM+8qrT/edK7G7vR5qVyJTuLE/Gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qGO82+4aZC6V0G2A5KLF6arurvnvq/4agl4O/Djz36G0aMkfNshI3v5rHwK5R27YcC99kZu568jZH8ogbelxKDTLFJtl9q+C4LNFdxVYK+VhQGAriVb7l7KvEDbOpi1YYf9ajGA5t9VabXoZnhaghevMlJGe8/tuy6gQlFe3cVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=M7QF9IZd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=q6UmkMeP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yK1s5VZA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=W6HctuyR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DFA64336BB;
	Mon,  4 Mar 2024 16:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709569945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lQ3sK+9yV9Ua9Fkbkvpx8TNNPEaeONOzmEHQ+4kI0JQ=;
	b=M7QF9IZdXpT9ejRtElLd6FHvYCzPM4VPzDiJ7awB4oPCdoMjJKM2fPwkcxCW4PUjBfNhO4
	NqgsprhtUg3TnI38uk3upApyj3hRMueeZ0NQSAH3muc+qMIVvl6RavST6vwshJBGeJZ+9p
	PysyKBNDNG6i6/tbKsQatlP/+M9bXGY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709569945;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lQ3sK+9yV9Ua9Fkbkvpx8TNNPEaeONOzmEHQ+4kI0JQ=;
	b=q6UmkMeP/UzKh+xk09ibc/Je7FzybKuwmbdk8kFlQknE/bZLeO8FRSDtYD7aoK9znJcdR3
	h5B8hh4eXQcfNUDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709569944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lQ3sK+9yV9Ua9Fkbkvpx8TNNPEaeONOzmEHQ+4kI0JQ=;
	b=yK1s5VZA/oN38PTRiaWR+bOANmOK8XHYE6Ux1ppC7otzGVz6zePnyP4NgsHQVXtfV7XXop
	gMvvn6zC3rxqW9I7xLmYheA3T3xgbczITW7lu63TYw12PViRr20yBS28DHfGXm6UPuaygK
	TpGhGvxj1XTaXpxeticlmycyMpmJsLs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709569944;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lQ3sK+9yV9Ua9Fkbkvpx8TNNPEaeONOzmEHQ+4kI0JQ=;
	b=W6HctuyRQS+A6NFQ95zgsKaZEOr2M7fCntKwsYh5izj0DzjBFfzHIRXDZ1/M6DNLeiYNc2
	Ahkp16Lh8B77BZAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E659139C6;
	Mon,  4 Mar 2024 16:32:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 8BFpIZj35WVLAQAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Mon, 04 Mar 2024 16:32:24 +0000
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
Subject: [PATCH v3 02/10] auxdisplay/ht16k33: Remove struct backlight_ops.check_fb
Date: Mon,  4 Mar 2024 17:29:47 +0100
Message-ID: <20240304163220.19144-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304163220.19144-1-tzimmermann@suse.de>
References: <20240304163220.19144-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.20 / 50.00];
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
	 RCPT_COUNT_TWELVE(0.00)[12];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[kernel.org,linaro.org,gmail.com,gmx.de,protonic.nl,redhat.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.70)[83.41%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.20

The driver sets struct fb_info.bl_dev to the correct backlight
device. Thus rely on the backlight core code to match backlight
and framebuffer devices, and remove the extra check_fb() function
from struct backlight_ops.

v3:
	* use 'check_fb()' in commit message (Andy)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Robin van der Gracht <robin@protonic.nl>
Acked-by: Robin van der Gracht <robin@protonic.nl>
Acked-by: Andy Shevchenko <andy@kernel.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
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
2.44.0


