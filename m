Return-Path: <linux-pwm+bounces-7582-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C3BC2CE96
	for <lists+linux-pwm@lfdr.de>; Mon, 03 Nov 2025 16:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 163701894C3F
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Nov 2025 15:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5E2313E2C;
	Mon,  3 Nov 2025 15:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1eLP6HeM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xI4NNlfh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1eLP6HeM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xI4NNlfh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8500F313E0F
	for <linux-pwm@vger.kernel.org>; Mon,  3 Nov 2025 15:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762184877; cv=none; b=my6JdV05nfJG/hl04pOjvo48pPSsf0Qb42qCgleAJD32CnlI0+I+PYPAnzuKXthvhrZUhm8N8bJiVHNJYXekJ3S5LDv+cpqOfeMXQfvYnnJPOUkvowT0Aj+Rmh+APpbhaVoV0Ml9QK0Kbqr4W9i6JqahXJ0ueLXcFMy24pYgLLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762184877; c=relaxed/simple;
	bh=+zkHS4lM7dpJQQ6PZN67msYCzCZlt6yX9zpReKilIKc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=mY4868xL5GWdsXIVtWsk06cUTcFy5aOjBM+F3p1tVpUs7dpad92yd0/bT1xMtHBj/RjzmhMDSyxseV9qIx0Q/Eh7FxLhiM1CbflJysDW/7NpBjox01hQGHF1dM3kGmyHStvL5IfUbFXNPX/oCato9wTmjVRhPA1Agv/M7XOsxis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1eLP6HeM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xI4NNlfh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1eLP6HeM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xI4NNlfh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8DDE91F387;
	Mon,  3 Nov 2025 15:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762184873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NUEEIx0Y9M9NlVYaim4M1cdrD4C/mx6RD9pkB6v0wdE=;
	b=1eLP6HeMzY1Knf6SCy/5RvjVSo6cEa6GWN/daGET8mIlRoOzS2jCmYJxHl7sdtKzLmXEMT
	fO2X7DMW7ItQh37lwLuJOaOJcGCF7nbNmAQQ4uhQ27ZiaWgc4RBgNKINaeC9weAQpq/zZX
	vXFEUJO9Y7w+C+oYsVhvXR5Q6IBWpgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762184873;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NUEEIx0Y9M9NlVYaim4M1cdrD4C/mx6RD9pkB6v0wdE=;
	b=xI4NNlfhjifH+mGZ310veI7i74wrsKRB3E7cJT104NEcN+fYQ8L6rwtND6x+TTbpJc+UoB
	Ynzishp7K3K4uIAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1eLP6HeM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xI4NNlfh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762184873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NUEEIx0Y9M9NlVYaim4M1cdrD4C/mx6RD9pkB6v0wdE=;
	b=1eLP6HeMzY1Knf6SCy/5RvjVSo6cEa6GWN/daGET8mIlRoOzS2jCmYJxHl7sdtKzLmXEMT
	fO2X7DMW7ItQh37lwLuJOaOJcGCF7nbNmAQQ4uhQ27ZiaWgc4RBgNKINaeC9weAQpq/zZX
	vXFEUJO9Y7w+C+oYsVhvXR5Q6IBWpgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762184873;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NUEEIx0Y9M9NlVYaim4M1cdrD4C/mx6RD9pkB6v0wdE=;
	b=xI4NNlfhjifH+mGZ310veI7i74wrsKRB3E7cJT104NEcN+fYQ8L6rwtND6x+TTbpJc+UoB
	Ynzishp7K3K4uIAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 610CD1364F;
	Mon,  3 Nov 2025 15:47:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id apDAFanOCGkvLQAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Mon, 03 Nov 2025 15:47:53 +0000
Date: Mon, 3 Nov 2025 16:47:52 +0100
From: Jean Delvare <jdelvare@suse.de>
To: "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=" <ukleinek@kernel.org>, Marek
 Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pwm@vger.kernel.org
Subject: [PATCH] pwm: argon-fan-hat: Add hardware dependency
Message-ID: <20251103164752.533aee39@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 8DDE91F387
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.01

The Argon fan hat is designed to be connected to Raspberry Pi 3+
systems, so only offer this option when building a kernel which
supports this architecture (unless build-testing). Also extend the
description to reflect that.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
---
 drivers/pwm/Kconfig |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- linux-6.17.orig/drivers/pwm/Kconfig
+++ linux-6.17/drivers/pwm/Kconfig
@@ -68,9 +68,11 @@ config PWM_APPLE
 
 config PWM_ARGON_FAN_HAT
 	tristate "Argon40 Fan HAT support"
+	depends on ARCH_BCM2835 || COMPILE_TEST
 	depends on I2C && OF
 	help
-	  Generic PWM framework driver for Argon40 Fan HAT.
+	  Generic PWM framework driver for Argon40 Fan HAT, found in
+	  some Raspberry Pi 3+ cases.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-argon-fan-hat.


-- 
Jean Delvare
SUSE L3 Support

