Return-Path: <linux-pwm+bounces-2413-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F71903C45
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Jun 2024 14:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC9D81F23B1F
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Jun 2024 12:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A964017C236;
	Tue, 11 Jun 2024 12:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YEWOKj7Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="o5IKrxjf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mhf+MmSw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KukXRqvS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D943D17C216;
	Tue, 11 Jun 2024 12:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718110407; cv=none; b=BmD8pRYg61EmoTqa5UzaFLzPCyz8w/OjdbVAs9syp1fjmXPEHdy2q205xuhmGCS1fOH0ZQWUozC+seOWdDS1O3VzhiYIX/6i17A/2yRPElvweuiGbWyoNFKmuvwasW14648if/BRaA8R4FH0OqM9nBgTWmjm3K6F5s5JyYjFZqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718110407; c=relaxed/simple;
	bh=7/ZPqCg2oypznzAk4bB3/au5AjkxMVCIcYfits/UUyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k0sSW/xoEO0Zgajs7dqtuDIJGOPCeAgt1k5sgoZVzO5qwXnA4tz2cH4XutdWCtgYgBWY8TuLdgI7eo02LtsdH3tOi/Pw1kLYyzmORGYJtGDqGbbrzEGQmFSJdJ/hpASQSf79lluin/PU7Qoyop1DREkeuJk2cEsceU3tDidDiJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YEWOKj7Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=o5IKrxjf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mhf+MmSw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KukXRqvS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 08293219AB;
	Tue, 11 Jun 2024 12:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718110403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0OJ/GmOeQSU/IZhTKn9PtsP3VM7GWYfDZ3snD6F8rcQ=;
	b=YEWOKj7QCAypbX9KgVarmr2rpiLMjKK9er9utpS8/9eOLsGftVG2YdPVgrfWQSGu1j0Y+k
	vGEO1AuUeUUHLtZ3cqv3vEK8tZ2dUVNe67hc2dZ4aPdFDmTTyiDNAvnOn4M8rPuVXNqasf
	8K35Iii3OP8KRPdxAj+bTxQDEp3L5tM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718110403;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0OJ/GmOeQSU/IZhTKn9PtsP3VM7GWYfDZ3snD6F8rcQ=;
	b=o5IKrxjfuZdL+t1Dgn8NeALCupja+o83kq7O58+6RQv0Vm2DYliZpWQdQciRkqHzLVOhn6
	eb9vqdecn72s6QCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718110404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0OJ/GmOeQSU/IZhTKn9PtsP3VM7GWYfDZ3snD6F8rcQ=;
	b=mhf+MmSwbvA1MjLAIWluuMlGTTih/VVI+Lww3XDbPNHtl+JmSiTAIAMqQlbJirGF3cpQ6F
	kCGXS4+XU4kdH4SQ9JINppdxc7C3EGJSbZXE3zpUteGoibjs4sSIlJLSEQVLTdeXI/mbTI
	YCMmob+a8O0s0GFXKT9WUnTAg+t2pXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718110404;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0OJ/GmOeQSU/IZhTKn9PtsP3VM7GWYfDZ3snD6F8rcQ=;
	b=KukXRqvSRpzmi0UyQDdoML0HhDD4HgwDFjUCON1axpIt+ABVob80UVm1LydF91tDQ+WkVk
	12X1KgiZCU58wQDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4317137DF;
	Tue, 11 Jun 2024 12:53:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r0q6KsNIaGbxMgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 11 Jun 2024 12:53:23 +0000
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
Subject: [PATCH 00/17] backlight: Introduce power-state constants
Date: Tue, 11 Jun 2024 14:41:55 +0200
Message-ID: <20240611125321.6927-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[kernel.org,linaro.org,gmail.com,gmx.de,asem.it];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de]

The backlight code currently uses fbdev's FB_BLANK_ constants to
represent power states UNBLANK and POWERDOWN. Introduce dedicated
backlight constants to remove this dependency on fbdev.

Patch 1 introduces BL_CORE_UNBLANK and BL_CORE_POWERDOWN, which
replace similarly named constants from fbdev. There's also
BL_CORE_NORMAL, which is required by a few drivers that appear
to use incorrect or uncommon blanking semantics.

The rest of the patchset converts backlight drivers. The new
constants' values are identical to the old ones, so the driver
conversion can be done one-by-one.

There are many more backlight drivers in other subsystems. These
can later be converted when the new constants have been merged.
Once merged, several include statements for <linux/fb.h> can be
removed (specifically under drivers/platform/x86/).

This patchset is part of a larger effort to implement the backlight
code without depending on fbdev and ultimatively remove fbdev
dependencies from the kernel.

Thomas Zimmermann (17):
  backlight: Add BL_CORE_ constants for power states
  backlight: aat2870-backlight: Use blacklight power constants
  backlight: ams369fb06: Use backlight power constants
  backlight: corgi-lcd: Use backlight power constants
  backlight: gpio-backlight: Use backlight power constants
  backlight: ipaq-micro-backlight: Use backlight power constants
  backlight: journada_bl: Use backlight power constants
  backlight: kb3886-bl: Use backlight power constants
  backlight: ktd253-backlight: Use backlight power constants
  backlight: led-backlight: Use backlight power constants
  backlight: lm3533-backlight: Use backlight power constants
  backlight: mp3309c: Use backlight power constants
  backlight: pandora-backlight: Use backlight power constants
  backlight: pcf50633-backlight: Use backlight power constants
  backlight: pwm-backlight: Use backlight power constants
  backlight: rave-sp-backlight: Use backlight power constants
  backlight: sky81452-backlight: Use backlight power constants

 .../ABI/stable/sysfs-class-backlight          |  7 +++---
 drivers/video/backlight/aat2870_bl.c          |  4 ++--
 drivers/video/backlight/ams369fg06.c          | 23 +++++++++----------
 drivers/video/backlight/corgi_lcd.c           |  4 ++--
 drivers/video/backlight/gpio_backlight.c      |  9 ++++----
 drivers/video/backlight/ipaq_micro_bl.c       |  3 +--
 drivers/video/backlight/jornada720_bl.c       |  3 +--
 drivers/video/backlight/kb3886_bl.c           |  4 ++--
 drivers/video/backlight/ktd253-backlight.c    |  5 ++--
 drivers/video/backlight/led_bl.c              |  4 ++--
 drivers/video/backlight/lm3533_bl.c           |  3 +--
 drivers/video/backlight/mp3309c.c             |  4 ++--
 drivers/video/backlight/pandora_bl.c          |  3 +--
 drivers/video/backlight/pcf50633-backlight.c  |  5 ++--
 drivers/video/backlight/pwm_bl.c              |  4 ++--
 drivers/video/backlight/rave-sp-backlight.c   |  2 +-
 drivers/video/backlight/sky81452-backlight.c  |  2 +-
 include/linux/backlight.h                     | 16 ++++++++-----
 18 files changed, 51 insertions(+), 54 deletions(-)


base-commit: 2bea08bd31298d60d416b2a6ed346bb53dd28037
-- 
2.45.2


