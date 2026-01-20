Return-Path: <linux-pwm+bounces-7977-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGWBALDVb2mgMQAAu9opvQ
	(envelope-from <linux-pwm+bounces-7977-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 20:21:20 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 629334A30A
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 20:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 313FA96FF30
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 18:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40374418D2;
	Tue, 20 Jan 2026 18:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0xMSADJE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BC4436361
	for <linux-pwm@vger.kernel.org>; Tue, 20 Jan 2026 18:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768933475; cv=none; b=f4barii9NSoumu9awXUmERq8MxINzI5kt6buFD5qeijJR4hAgwUXawv7OQR2EEIPBXNJoU8n95RuLCvRp3MyMTLcqrp8Tj/SSKPkCdGo78JIU8pLBTi5ArAUDizRivD3pfZLPXI1OoDaAicPKHnsJpDLWId3qcOXbkdtR+AJvDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768933475; c=relaxed/simple;
	bh=Y/hbkF63DHzS8v7oINnsZdqK81IfExep0UtNbytNrFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8e1grsEKGIfYj99kt5WiNYHbLERu5AcJ07A0DEpzX1uAokVEfqcCr8VOYESa/bWQ84/+a1PS159VCMUNMD7v1l3f/kamCM21WSwJ8nSIeAU64De2UMNaeAALGMt3SL2MHK7AU+MhLLQYrJ5PPpkOoG1YnA3KPtP8NuYruph5RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0xMSADJE; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47ee301a06aso53858965e9.0
        for <linux-pwm@vger.kernel.org>; Tue, 20 Jan 2026 10:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768933471; x=1769538271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kAfH4J2MMujA9aR++g3pNjBmasACHAT+NgH7tqn+Aww=;
        b=0xMSADJE8NbkA/NOV6+DqcZT+gfEiqo1h17BrKyf2hODTIU5DuMKkAVDzWY1RRf2Y4
         AiP9pecKxLw5i3tcvNBEVFdXn8rGYu5NG76gek6ReQnZrG3M1/kjlqKNCTQ0PmWo/fw7
         85GHetzSPRn3oqpuTEoXnZMqQjnb1aDGuO0XAnyRiqLwkuyIkaX3SGboTW1GZNuLm28h
         iNMwdyUDf5BqZdSWEEjR5Ew7FWsgW9ApwVvyQ4wCH8cbqNARz3oGCMRMflQYilbtYQVq
         BmnmM7voZnKi3hxHHiVWWndwY317YNJRy8YTrmx6MUvI/m8Ii7b76uLLgHUqWg0Inzoq
         GMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768933471; x=1769538271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kAfH4J2MMujA9aR++g3pNjBmasACHAT+NgH7tqn+Aww=;
        b=otaPNBNjQTkYq7eljT4DhYI+Pkgjt5ulkHrdo0d1jw3fgV7fr0eKVTc4cjI27jct/h
         ktbLkQHD8UmVtv4aqA7bCX3oSD+MrKa5wMiXu/Q6u8YTTz82RJShLEePOrsrVi4TPovX
         4ABCeKk8LbtV/TZg4iMbcw007mQuaXDT4sU2dnpOe9lYVFtixKqJAy5mHtMOt+YuU5/C
         DK9CjoIkepenFletkdRuoEcTCBtUhy9N+y+vD/4R2lAKfGAQGf7gEZEdh6H2QI2hTNCA
         iAa07rgv5UXV3Y/uqU+YJ5DsEg+SjkY67klH3TNNJlCd4AT1LlXUpDuNJ503elvuI2gd
         Jdww==
X-Gm-Message-State: AOJu0YzYSWW1YWGt+i3wnj24JJS1J7ja4FJHx9QfTu9k3WOmv1zKvzWG
	pNp+3sHG8PT5vFow7OCfV3UPVKqvZRWzMgZQ0b3Y+a5nDfc2IZ3nIp3sSGaTllonRo4=
X-Gm-Gg: AY/fxX7yNA9Hxzhsby46RRgK3c69hGPmHVbepr3y31jBMz7fjCZNWseHmNu9hK1k6su
	KZday42zrw7Gp7nEm8g+yJRf/h2J3rTESlAu/T7ZZTN+J2m6ayXzJ4aXBefZd5s2G2OliG66jZG
	dakT/f7bo5HqeLHQvjqLXF/eV+OB6BMbI0+iBs53q72hlih033MOFgv9dq65wvUUDuvKi0EaVcj
	vXkxEyKUw2Lt6HwWudfkseOMJ1dUBfPV+wZN5ZcqXUTAKCffp0AgHYc7aWryDjrpXddRRuKCh1q
	N4qmGWledS41FjNIPLet8FZ3vGgKzlZcdj7v4o5WajlRjtgbSzqo5tJ6/q7XmNZwAkXWec9iRSF
	xy4rQ8iwJ58GX+tiKHljH+dZgc482KJiuQyIEc8rFV1p2qof+JrjuydRudIoBhEIAgnqeXLd+Kc
	syz/siNUPepo7N/+6mbxaU98gkO4XqXHwyKGxdd2lnUuen1daIgtTdhHtlizO/Y2iAdIO9eOQST
	MY=
X-Received: by 2002:a05:600c:198e:b0:477:9976:9e1a with SMTP id 5b1f17b1804b1-4801eaadc94mr185200225e9.6.1768933471540;
        Tue, 20 Jan 2026 10:24:31 -0800 (PST)
Received: from localhost (p200300f65f20eb0448044bf769fbb982.dip0.t-ipconnect.de. [2003:f6:5f20:eb04:4804:4bf7:69fb:b982])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43569921da2sm30827776f8f.1.2026.01.20.10.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 10:24:30 -0800 (PST)
Date: Tue, 20 Jan 2026 19:24:29 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michal Wilczynski <m.wilczynski@samsung.com>, Richard Genoud <richard.genoud@bootlin.com>
Subject: Re: [GIT PULL] pwm: Two fixes and a maintainer update
Message-ID: <3u2dfdn56wqqxcn2bcrl3s7x5gbwpbx5cmvszwhgv3ioluqcct@fel5x6sqomnw>
References: <ahytfwrx6d7nvddjviqt6wyit6f7flh5vmiuuzdet44unjdbwp@cktsraaj56au>
 <CAHk-=wga8Qu0-OSE9VZbviq9GuqwhPhLUXeAt-S7_9+fMCLkKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zsp4dyfbktt6kfba"
Content-Disposition: inline
In-Reply-To: <CAHk-=wga8Qu0-OSE9VZbviq9GuqwhPhLUXeAt-S7_9+fMCLkKg@mail.gmail.com>
X-Spamd-Result: default: False [-3.06 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-7977-lists,linux-pwm=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-pwm];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,baylibre.com:email,baylibre-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 629334A30A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--zsp4dyfbktt6kfba
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [GIT PULL] pwm: Two fixes and a maintainer update
MIME-Version: 1.0

Hello Linus,

On Tue, Jan 20, 2026 at 10:11:27AM -0800, Linus Torvalds wrote:
> On Tue, 20 Jan 2026 at 01:32, Uwe Kleine-K=F6nig
> <u.kleine-koenig@baylibre.com> wrote:
> >
> >    You might argue that this is an ABI change [..]
>=20
> [...]
>=20
> This one looks entirely benign, but I wanted to point out that if it
> breaks some program - however unlikely that is - it just needs to be
> reverted, and it doesn't matter what the change is called.

Thanks for your feedback, that matches what I think. I just thought it a
good idea to motivate the change well, given it's that late in the
development cycle and I didn't want you to yell at me for trying to hide
something :-D

Best regards
Uwe

--zsp4dyfbktt6kfba
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlvyFsACgkQj4D7WH0S
/k4EFwf/eE7DLn1jNTM7x55LP3HdUu0PNiMSzi8r58cKADzGMGdVH+kdZyVHP2oA
8m7UrgQ5ycAt7JWHeU06Z1bIs3ZGt/1GAqhMxfj+Vw9EjXgg8/P7Z9QbGLX7jUbn
wUCvl90kXHwODv/tb+dEqplLceueBBb3FMQP5KuiCipeHeBzARYybhD+0DOs7DLV
IIfDgxsXY3TMkRJQa/h0Cxy5FKxBQqurF2KlCAobi+ii7OJDWG0DSdYWfB/mDDqm
8EakjuZIHpyf+8tYw2p8gIBhkPadiZ1uVEvuoeT56QQy3Cvgmq10DjUD1Q/xTUqK
1Dfg8vsG8ZBT8glpkgnaobj21HxX4Q==
=CUNZ
-----END PGP SIGNATURE-----

--zsp4dyfbktt6kfba--

