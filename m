Return-Path: <linux-pwm+bounces-2428-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4695903C65
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Jun 2024 14:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 539B128273D
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Jun 2024 12:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437AB17C7B8;
	Tue, 11 Jun 2024 12:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Thi1PAzl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ol5yWXRp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PMXu61oh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="37yBh2+e"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B242517C7CD;
	Tue, 11 Jun 2024 12:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718110412; cv=none; b=ad6G0VACExuSQR68vzCeM6KPXi3xzUIPBEK7GZQimbcsTIUbC1bihUErquAifYUJMPxt1++TjXHlInAieIjfwkk2LzeivzNJGUNlmDzei3FDBXEu77SHcWGt7N3N6f4BxMUH12Clgc66pbK+YSlhrjIROBbpzTuLZYdgYSyDnog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718110412; c=relaxed/simple;
	bh=ai3vKWaOLBrolggpEFFIwJxW0l4OqW5nufpxirKBiv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lVxBdHWNZvpyYe0dAis8Fh7TqbOBSlxVFIHTNEnh8QOTKfkEfNQvx0DXGZ+whTbvvbG/iC3cl7ygRV5Kr5xFPodjBNkbeRAhHxsyboVhcMXVuEWCBqH1FY6v/2hCk3G9dvYxsrZqDU9kDOLuz2TXhIYYxdOCmv+VO5PmwbXdVYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Thi1PAzl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ol5yWXRp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PMXu61oh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=37yBh2+e; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 030A2219B1;
	Tue, 11 Jun 2024 12:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718110408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LwpM7WQiWCVd5LwnaxwSFD2RRkoVuyMxr2MCQD78qH8=;
	b=Thi1PAzlHNiZd2qvSSexbpwom0OVzbvp/a1xIyebx59yunHdwlntToYxlkOCD1CYelUjCf
	zqvKrl38u8ZUOzDexcrQioVZADZLD9kBsOScJqGOMH+aQ68nuzim9GBZUo0griRW4ze1xE
	qGA5xs3Ahv8r2rKH2gHClvay6VzVwBk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718110408;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LwpM7WQiWCVd5LwnaxwSFD2RRkoVuyMxr2MCQD78qH8=;
	b=Ol5yWXRpDkxCETToPkPvNQEn2KVgY228TGDDiWpioZq6K/m7vdJ62naB8jj5+9Qydln1XC
	r77Jt2ClkP5xzOBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718110409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LwpM7WQiWCVd5LwnaxwSFD2RRkoVuyMxr2MCQD78qH8=;
	b=PMXu61ohKETb10gjoMfo8dZNh9v+k4WSgzRnDDM2nsIbbTneYmAkAEYB41ueAbyPom3Zfh
	XZavBh3wWJChiMuPvVgw96mcrr9vZgwZRqsw6yoqL7ti3BbX3sIkzcj/WaJuSMoyO2POU1
	jC1sszKAtfAqXtTu1ffBvfP67DDFGTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718110409;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LwpM7WQiWCVd5LwnaxwSFD2RRkoVuyMxr2MCQD78qH8=;
	b=37yBh2+eSJlN9JuzyqOabX66Z6M2KNb5qQS/rd5fxTe2G0KjKy8o+DUtMswqQcVgF9hlKn
	YoMWBPS3k+ax44Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1584137DF;
	Tue, 11 Jun 2024 12:53:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id COH7KchIaGbxMgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 11 Jun 2024 12:53:28 +0000
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
Subject: [PATCH 16/17] backlight: rave-sp-backlight: Use backlight power constants
Date: Tue, 11 Jun 2024 14:42:11 +0200
Message-ID: <20240611125321.6927-17-tzimmermann@suse.de>
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
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linaro.org,gmail.com,gmx.de,asem.it];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	R_RATELIMIT(0.00)[to_ip_from(RLbaz54pzrc9psah3tsaj8ddaq)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de]

Replace FB_BLANK_ constants with their counterparts from the
backlight subsystem. The values are identical, so there's no
change in functionality.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/backlight/rave-sp-backlight.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/rave-sp-backlight.c b/drivers/video/backlight/rave-sp-backlight.c
index 05b5f003a3d1a..7a564a4e46e07 100644
--- a/drivers/video/backlight/rave-sp-backlight.c
+++ b/drivers/video/backlight/rave-sp-backlight.c
@@ -19,7 +19,7 @@ static int rave_sp_backlight_update_status(struct backlight_device *bd)
 {
 	const struct backlight_properties *p = &bd->props;
 	const u8 intensity =
-		(p->power == FB_BLANK_UNBLANK) ? p->brightness : 0;
+		(p->power == BL_CORE_UNBLANK) ? p->brightness : 0;
 	struct rave_sp *sp = dev_get_drvdata(&bd->dev);
 	u8 cmd[] = {
 		[0] = RAVE_SP_CMD_SET_BACKLIGHT,
-- 
2.45.2


