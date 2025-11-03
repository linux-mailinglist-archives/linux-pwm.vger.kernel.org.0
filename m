Return-Path: <linux-pwm+bounces-7584-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5F6C2D247
	for <lists+linux-pwm@lfdr.de>; Mon, 03 Nov 2025 17:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D76FC3A0896
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Nov 2025 16:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFB7315D45;
	Mon,  3 Nov 2025 16:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G5xPLwXo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Q/kcsV2L";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G5xPLwXo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Q/kcsV2L"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4E9313E13
	for <linux-pwm@vger.kernel.org>; Mon,  3 Nov 2025 16:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762186909; cv=none; b=DpSUsEnEVFh9YSM4NGuaeHWuPdeHQsrS9EtrQ9qgRg7DEBBt+7RFEgQkNkOCYWg/e9c4tkN1X2lDaqt6Lyzz5mGwqNE9MZcTbMipp4bGN1OXqqNb0GlspLV5vDK5hdZ55DCwOz711xYpk7k66azwAFqmF2hCc+9LjidY7GvcRdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762186909; c=relaxed/simple;
	bh=xD0SMtUixDeNu149m/O3Yy5GnNeGU5q/NRy0aSrtG08=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UY3Fz/T4kryfnnwufhnPBkH9NeLTzsM4f48hP/4tuvcTKuz0WLdohwr78zIAA8nTVT+Koj3b/5UNXeHNVfYqG5AsJ5B6pKS8C2a53c59KeKRIBtardCQZXFR+WCEbyMXQjBhIPn28XLEtuDNh3oTYssDZKw+T24N3nBEWigMl/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=G5xPLwXo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Q/kcsV2L; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=G5xPLwXo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Q/kcsV2L; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0C4A91F387;
	Mon,  3 Nov 2025 16:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762186905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=I6huNQkWgnuuMIwCi4NHTgRGdF9sQVm7S8UUv3sZ39Q=;
	b=G5xPLwXox5KV1eQOypx7lmCNKWOKYUVmUeDCtExPUzjIZECOzB/THkjAtRaGz8sm9FF/Wb
	EI7U/dRw62S//kevQcVrqzaBfqgVn1NHvRfT9mGKar5sLpgiTOhiuzEV2irgpAkl8pp5S6
	0CmqO8WYE2ke8wXR2OuV97c88DcxcVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762186905;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=I6huNQkWgnuuMIwCi4NHTgRGdF9sQVm7S8UUv3sZ39Q=;
	b=Q/kcsV2LVppOCG74k9lx3Gy7ffINca9V0rZnPQBowiZtvskhU2qnaEhUmIWh2WAzxsxkLl
	KObqHE1sOt8v/qDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=G5xPLwXo;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="Q/kcsV2L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762186905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=I6huNQkWgnuuMIwCi4NHTgRGdF9sQVm7S8UUv3sZ39Q=;
	b=G5xPLwXox5KV1eQOypx7lmCNKWOKYUVmUeDCtExPUzjIZECOzB/THkjAtRaGz8sm9FF/Wb
	EI7U/dRw62S//kevQcVrqzaBfqgVn1NHvRfT9mGKar5sLpgiTOhiuzEV2irgpAkl8pp5S6
	0CmqO8WYE2ke8wXR2OuV97c88DcxcVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762186905;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=I6huNQkWgnuuMIwCi4NHTgRGdF9sQVm7S8UUv3sZ39Q=;
	b=Q/kcsV2LVppOCG74k9lx3Gy7ffINca9V0rZnPQBowiZtvskhU2qnaEhUmIWh2WAzxsxkLl
	KObqHE1sOt8v/qDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB59D1364F;
	Mon,  3 Nov 2025 16:21:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PpO2L5jWCGn0TgAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Mon, 03 Nov 2025 16:21:44 +0000
Message-ID: <f6c2d892b64057c079662e8bd64060d45c156288.camel@suse.de>
Subject: Re: [PATCH] pwm: argon-fan-hat: Add hardware dependency
From: Jean Delvare <jdelvare@suse.de>
To: Marek Vasut <marek.vasut@mailbox.org>, Uwe
	=?ISO-8859-1?Q?Kleine-K=F6nig?=
	 <ukleinek@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pwm@vger.kernel.org
Date: Mon, 03 Nov 2025 17:21:44 +0100
In-Reply-To: <05b5b096-33cd-45c4-9d9c-286d743c6916@mailbox.org>
References: <20251103164752.533aee39@endymion>
	 <05b5b096-33cd-45c4-9d9c-286d743c6916@mailbox.org>
Autocrypt: addr=jdelvare@suse.de; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 0C4A91F387
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

Hi Marek,

On Mon, 2025-11-03 at 16:55 +0100, Marek Vasut wrote:
> On 11/3/25 4:47 PM, Jean Delvare wrote:
> > The Argon fan hat is designed to be connected to Raspberry Pi 3+
> > systems, so only offer this option when building a kernel which
> > supports this architecture (unless build-testing). Also extend the
> > description to reflect that.
> >=20
> > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > ---
> > =C2=A0 drivers/pwm/Kconfig |=C2=A0=C2=A0=C2=A0 4 +++-
> > =C2=A0 1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > --- linux-6.17.orig/drivers/pwm/Kconfig
> > +++ linux-6.17/drivers/pwm/Kconfig
> > @@ -68,9 +68,11 @@ config PWM_APPLE
> > =C2=A0=20
> > =C2=A0 config PWM_ARGON_FAN_HAT
> > =C2=A0=C2=A0	tristate "Argon40 Fan HAT support"
> > +	depends on ARCH_BCM2835 || COMPILE_TEST
>=20
> NAK, this is wrong.
>=20
> This fan plugs into any arbitrary board with compatible 2x20 connector,=
=20
> not only RPi. That connector is present on all kinds of fruitboards with=
=20
> different non-BCM2835 SoCs.

Yet the company who builds and sells this fan device, markets it as
compatible with Raspberry Pi 3 and Raspberry Pi 4 only:

https://argon40.com/products/argon-fan-hat

Which other "fruitboards" would be supported, and what SoCs are they
using?

Thanks,
--=20
Jean Delvare
SUSE L3 Support

