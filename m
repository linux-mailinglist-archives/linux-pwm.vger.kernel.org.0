Return-Path: <linux-pwm+bounces-2603-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC86915213
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Jun 2024 17:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E723628586F
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Jun 2024 15:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE1A19D886;
	Mon, 24 Jun 2024 15:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uDmhL3nt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F2VI+eWt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uDmhL3nt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F2VI+eWt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAD519AD95;
	Mon, 24 Jun 2024 15:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242449; cv=none; b=qNrUl+FIEj4LMPEnnuhBNuRgXdDgRxLDhKjidCWBIvciYlzU0N4TYNMntZQxNIQogZZ+lBqrToJ+xanonRw/aiW0zAj2nbBfdcmv3TP2YymaODuxFfsMky1Am7LJYW8iswHVyT86r+VrzaB4+HGqz+7LdiV2TyVjgKRpbMuHu+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242449; c=relaxed/simple;
	bh=x8m3JnUH/WbIvXOszDAbQGLjZYLrhHRbVkawjxFmf/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OFO/5pgmbUPmc2f+P4YW1VxZZOaevNytcVkBmYfSkpgJzm9DUW3tKOjQV0f4wv9TrbojGriSCnYHMsy9h6CIiAea0Og6LtIX0xCWHrdmKCNahcQA8cRcPzqQb8rEIX/41IkzveGnhr0wCR+8NITTcqri7E52k+wOe5fhhHVnp6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uDmhL3nt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=F2VI+eWt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uDmhL3nt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=F2VI+eWt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A484B21B1B;
	Mon, 24 Jun 2024 15:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719242446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LNcezCLGx0lTTITreFTkr6GAEb2YAiiqoWZrEhOECZg=;
	b=uDmhL3ntGVWiHlTPMGVtIRZFVfZr5mDJkbZ5P2GP166mtdRgLR794LvAL6raa8l6dP794z
	eEcvG3Rgeth6SnlVtsZU9weSrSuh3vVd8IcfBAyNFTIKQV12RsVHv41omm8pnkDKV8gw8+
	vrvXcqIkH/wfh0H6z3EUBaJFsNYDdlU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719242446;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LNcezCLGx0lTTITreFTkr6GAEb2YAiiqoWZrEhOECZg=;
	b=F2VI+eWtQidQaPcy0PH4tEZV1+BhCU8IV7J9dLmEX1K5ZbaQ65aRl/7MadPRHRcFvXx9W1
	ZFYsYOGC+YnFbWAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719242446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LNcezCLGx0lTTITreFTkr6GAEb2YAiiqoWZrEhOECZg=;
	b=uDmhL3ntGVWiHlTPMGVtIRZFVfZr5mDJkbZ5P2GP166mtdRgLR794LvAL6raa8l6dP794z
	eEcvG3Rgeth6SnlVtsZU9weSrSuh3vVd8IcfBAyNFTIKQV12RsVHv41omm8pnkDKV8gw8+
	vrvXcqIkH/wfh0H6z3EUBaJFsNYDdlU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719242446;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LNcezCLGx0lTTITreFTkr6GAEb2YAiiqoWZrEhOECZg=;
	b=F2VI+eWtQidQaPcy0PH4tEZV1+BhCU8IV7J9dLmEX1K5ZbaQ65aRl/7MadPRHRcFvXx9W1
	ZFYsYOGC+YnFbWAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5649013ACD;
	Mon, 24 Jun 2024 15:20:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WDbCE86OeWbqGgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 24 Jun 2024 15:20:46 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: lee@kernel.org,
	daniel.thompson@linaro.org,
	sam@ravnborg.org,
	jingoohan1@gmail.com,
	deller@gmx.de,
	linus.walleij@linaro.org,
	f.suligoi@asem.it,
	ukleinek@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 16/17] backlight: rave-sp-backlight: Use backlight power constants
Date: Mon, 24 Jun 2024 17:20:11 +0200
Message-ID: <20240624152033.25016-17-tzimmermann@suse.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240624152033.25016-1-tzimmermann@suse.de>
References: <20240624152033.25016-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linaro.org,ravnborg.org,gmail.com,gmx.de,asem.it];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	R_RATELIMIT(0.00)[to_ip_from(RLbaz54pzrc9psah3tsaj8ddaq)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de]
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 

Replace FB_BLANK_ constants with their counterparts from the
backlight subsystem. The values are identical, so there's no
change in functionality.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/backlight/rave-sp-backlight.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/rave-sp-backlight.c b/drivers/video/backlight/rave-sp-backlight.c
index 05b5f003a3d1..e708a060a6e4 100644
--- a/drivers/video/backlight/rave-sp-backlight.c
+++ b/drivers/video/backlight/rave-sp-backlight.c
@@ -19,7 +19,7 @@ static int rave_sp_backlight_update_status(struct backlight_device *bd)
 {
 	const struct backlight_properties *p = &bd->props;
 	const u8 intensity =
-		(p->power == FB_BLANK_UNBLANK) ? p->brightness : 0;
+		(p->power == BACKLIGHT_POWER_ON) ? p->brightness : 0;
 	struct rave_sp *sp = dev_get_drvdata(&bd->dev);
 	u8 cmd[] = {
 		[0] = RAVE_SP_CMD_SET_BACKLIGHT,
-- 
2.45.2


