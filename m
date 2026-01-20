Return-Path: <linux-pwm+bounces-7972-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHyBKmjHb2mgMQAAu9opvQ
	(envelope-from <linux-pwm+bounces-7972-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 19:20:24 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3344B49564
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 19:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1679A6CC24C
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 18:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC4344CAF0;
	Tue, 20 Jan 2026 18:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ep6vB2aS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D6F44B69F
	for <linux-pwm@vger.kernel.org>; Tue, 20 Jan 2026 18:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768932137; cv=none; b=TeVXRIOxobYsB908haGitPMI4mIDDTzzPQC8f5k4dK+XnMJuGMxMyDmvM6WmDeInuovBFeatqbUpfMGSYLIQ3I97RIgmxApgt0J0evxAFZI0+15urIYD7FcW22EYi/qvMeRDFCZtqaysJH1+hMNCYn7osk1ukbOqtk2UNhWMNZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768932137; c=relaxed/simple;
	bh=1feF74p1hZuJuzZ/zjxof/doJAtUR/T5sZ3KS8Yscfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPQ3LcLV8wfSFbUuc/BbuLGGZQioyIldy3CDKSEX3sU5LfR9lIm6FBnT6bVpAnJQ+2OilAXA5Moe2O3IKpgBqbyGPnyB9TFgZ7pvTjxjQK3G8diWfSqWfCXoBVxZ3rU/eNyEi7iVxFltvDrLL0deLEZ0839CKOERZ8sfk27F810=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ep6vB2aS; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42fb6ce71c7so4986577f8f.1
        for <linux-pwm@vger.kernel.org>; Tue, 20 Jan 2026 10:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768932131; x=1769536931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JbQTjruPv+79bC7NXUKMnpFpvOUvYwvd8LHHgIF12mQ=;
        b=Ep6vB2aSYaZy/IZdbrgU+uaRbpqvP/9b42BsiXEBt99zuGXKP5n/1P9tTrxG7rPg/X
         nJPi8tWZK/mmHHxaa8Sagbk/BmdNTSYCTDD1ceOgpufgMfnWYOfjnFovOAycqDzq9TQK
         MHxrz+DsvEA7kVF3eYjS9ZrP/90+XKJGlVEnS1SDL4+C4xg9hnH9FY/hu10wzqqO5gMT
         bAuhFmoV4n9G28CctrANHpoXVUHiokIeFzVe52POVPI09vFczq+4zoTSVqko1uU94xYr
         FZAwuaL5cSAXdiSrnOCtOL4RTKmXXOr0493Ph86n+JgUxSUQduCWPWilKbb0n10KidPB
         F0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768932131; x=1769536931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbQTjruPv+79bC7NXUKMnpFpvOUvYwvd8LHHgIF12mQ=;
        b=djrE4hxv0UesCu9pTEiaqZ3gpBfeohA/wZfsXyjevSlTJi/H6zyp+I2SKvlN9alD/k
         ARVYalNblhFJRakCtwTmoQ/S7QUEb8LUW6tRhgkzW+ZR8PMsaVHShEkijnwAXK6RgpPi
         sNY+hGC9xWIPcCEQ4rH6NeiYMFBvV3y7OzOlJbrPMjHJkx7QW5r2KZXPzQ07stFzqFEj
         5A+XP+DJLgM57IcN5nOC1GJjETTJcBugCaxJAmokcZLfRGDuwl2BfdqC14cTO5znOn9d
         ubB6jDQh6q0gRjPn5E+NmxwHb/OK2lhxh/M/UuDsNEvmp9DJtq1Gv8w/tuCb20bDxpsS
         Rb+A==
X-Forwarded-Encrypted: i=1; AJvYcCX5kowPO5btlEPaoATPzKJFfTkxAS/BToGx0HC8p/BzLPAnL1i+yukFaPg56o09z9Z/Al5YaX8obhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YySdbGfolBOy97smfz4XCYwzloqn4NoTN2oGoz007j/3NQVBaej
	pc5wDZR+FHbIPvV2Z67/CnEDQr2d8k/rTvD6ssGuSsRMcw6x5XYxlrgtn9z8pdmcYvM=
X-Gm-Gg: AZuq6aIRR8AOj2zza4D7RuefaXYHakLdvnjS+gAuovo+66nZ36cJVJMSiZrjnB4+Cmm
	L638/AiQoJg4CsThfoQf5gB76torcYm66nhk7ZkO/Bp9XIz8RLFBYkRUqZsA88Sj4eopN+7JF1p
	8RVB9fYIu9cQHUUowFhdlszhEfA6xR/9ZKmbNp1lEDGb7anVHVfrf1AEAOxPds3fcd6MMPFF2JT
	5zo5S8yRvbaUUbKahOGp6qvjmf6rPKuWjQqXwczdjou+VpQJFM3xNZqqJnPuvy+2IOfErXuXew/
	Pu0T2sVWno2R1rsEUmyKfxE2oQ2S6zQS7U+0AJWpF1NRliENVuXdWfkDb7pZmqj7O3TV73QBgZr
	DIPa91nZ1J2aO16xFI7eENPTFdr54bZML6YRB0eX3qJ6nTGVlLD4SyTwu1pv8UrUxtJGGVY6yrE
	Law6QkF00C3CJl3/z+AFE2jjN0C3AyTGizdvu8LTfBlczfGGHkI3g+ZeD1Swajlh8hBg4XznT/T
	zo=
X-Received: by 2002:a05:6000:bce:b0:435:8aa0:a30c with SMTP id ffacd0b85a97d-4358aa0a34dmr5194709f8f.48.1768932130909;
        Tue, 20 Jan 2026 10:02:10 -0800 (PST)
Received: from localhost (p200300f65f20eb0448044bf769fbb982.dip0.t-ipconnect.de. [2003:f6:5f20:eb04:4804:4bf7:69fb:b982])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43596291e0asm2105352f8f.15.2026.01.20.10.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 10:02:10 -0800 (PST)
Date: Tue, 20 Jan 2026 19:02:08 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michal Wilczynski <m.wilczynski@samsung.com>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 14/27] rust: pwm: add __rust_helper to helpers
Message-ID: <ejdtzcvxpz5iih7o5ppgpdo6npdjut6utofacdgrwkdntvurhs@vgiuagsrzo6b>
References: <20260105-define-rust-helper-v2-0-51da5f454a67@google.com>
 <20260105-define-rust-helper-v2-14-51da5f454a67@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b724s7lxgfngeqjj"
Content-Disposition: inline
In-Reply-To: <20260105-define-rust-helper-v2-14-51da5f454a67@google.com>
X-Spamd-Result: default: False [-3.06 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7972-lists,linux-pwm=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[linux-pwm];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,samsung.com:email,baylibre-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 3344B49564
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--b724s7lxgfngeqjj
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 14/27] rust: pwm: add __rust_helper to helpers
MIME-Version: 1.0

Hello,

On Mon, Jan 05, 2026 at 12:42:27PM +0000, Alice Ryhl wrote:
> This is needed to inline these helpers into Rust code.
>=20
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> Cc: Michal Wilczynski <m.wilczynski@samsung.com>
> Cc: linux-pwm@vger.kernel.org

Applied this patch to
	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for=
-next
as merge window material.

Best regards
Uwe

--b724s7lxgfngeqjj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlvwx4ACgkQj4D7WH0S
/k7S9Af8Df5IfayQwO2CKCypBfDYh3ig8BbcsVXk1PrCDqs4gsZ/tsbSTUwWoYgI
Id+1r1kUyJ7ssv7Jsh4IBW6Yu46TKFKVUtzDVKveNKFlL+aYn9zdipnYr8xH53u5
ibLNg7n6CnI7hP2oYb1+nnZpCWdOBufQXm9zapjIMkTXl0bMrndlHyVZI+gz+bWD
f8fhMKfKiHPp9Oq5wBMO3tAhAqt6EO1XJnVyM9EoJG8gx5cX8E4oclQun92XzR0h
eR/RdRi7aMeX3WOolRzH8EWeb1ZSFyfOPltbocl3wAvQw4Ojc4Sx14xTXr6IH+Y/
1I56LvvHrlkqyRoflNIHFXAy0fO0Nw==
=a+NJ
-----END PGP SIGNATURE-----

--b724s7lxgfngeqjj--

