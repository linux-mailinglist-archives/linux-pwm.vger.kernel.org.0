Return-Path: <linux-pwm+bounces-2389-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F9A901A8F
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Jun 2024 07:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C280B1C22BCD
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Jun 2024 05:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AEC1803A;
	Mon, 10 Jun 2024 05:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ktgyr2ZZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F4B4AEE5
	for <linux-pwm@vger.kernel.org>; Mon, 10 Jun 2024 05:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717998821; cv=none; b=KKonF/onLG/J1POyvOGsp6eq04yQ4Q3EU8LPISlvW124dWhNb0Qh6dzDJg0E0Ke6MWIdAmu/EXFJ8mONAqj4c04sgI2kbN1UQ5UJltxT92VDLe0jdUpMvqtxWu+kfifSn9OfBpTQb5cvZo2tb1hvGUT7Q7jl9KdbxBAmgnLzq2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717998821; c=relaxed/simple;
	bh=rUKWtYHraZrMXYSCFmYbWtBSzxS4f3FPYen46DHiIlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kB6DuLzSMfYeWkLA+jHiV0Z5b08cS6vTaKLu3qXhYI+7sLYbAnRdeUkyygB6vHic4NAll9jkrjK30bRuhKeREDPX0YDGF/4f0iAklOYsChXdfSuRKbXnkh+O10cbdUAHuTYIZSd0eKG5Dl3eSkiExRfmZqY4uCuwQb5VM1Smqr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ktgyr2ZZ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57a4d7ba501so5099574a12.2
        for <linux-pwm@vger.kernel.org>; Sun, 09 Jun 2024 22:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717998816; x=1718603616; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nveD5QVwsPxKXb89Jt+nHFvKedVwXNgcMUK/mtqTUZ4=;
        b=Ktgyr2ZZpw9lkoojKUWKLLWot1Qpm7DlSizmKWobwZ1mZ/wV4W8im59CkJAJHkdYv6
         hjs0hHXjF4fUoLCWPqKTKmQMy3oYgf5eVRLNbBr9AAxTH2zkJddxrayZm4FumLFi/8W5
         Hb2MK8h/TEYfM+j9ol9iMWM9d7mFxjjmtc2mvcyj2I2jBk2uIhNEsI0w845NypdWxhqc
         WbpodGTd6ecQ6t1P7NS2oDweVJMKsU3AT1uK02xbVZi/6fNjSj83ivDGjs/sPntv3jtU
         4ilA6xYXaitg91yHLxG0OMyoLnJSAtptA9xvdOfmWHzLG0yj/Xwq4j6BNFvZEIsBzSVX
         1ybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717998816; x=1718603616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nveD5QVwsPxKXb89Jt+nHFvKedVwXNgcMUK/mtqTUZ4=;
        b=ob6BfzSc/llPjEAC5eO1VJWVK79TK50mEtm3cJ5dE2gXcgaxjYXm9lDKFhoIh5l6mZ
         IbhK/dlmdtKfbDUb/fYTp/SivrG8neC+W6L3RWkaAiGNgKy0SIQWqp25VDkCLta1hYJB
         1tv73pI8nzbm16jrtrNsWtBf6GCDAjsIE69Rlj7lHXICOcxui8uExSIY5pGloQgBRoDX
         IbcnSjKOk+9zlR8WaRa8AQUIz+B3Jnkpnoc+59s9veS2zQtsXWHkTwQjEqRHmv+/SLg3
         0yUy7Uewi21F/rFDq/dhcqasSqj9hmg/ArJ356B8elaVMX2QVArVarsTUUasKzlQ7EMT
         1q7A==
X-Forwarded-Encrypted: i=1; AJvYcCWFZSaWyzW8/gN5OgnNcK1E3DvYUEI3iymcMl6gvg+0jXOmKG/FnpFDcg8Y5jBLBF45SgTsCJtSR5k1HIRgDBlapQtEXQIrJbId
X-Gm-Message-State: AOJu0YyNLu28sdihWhJRpnwJo6tN3PvpzZ7bEUGDaEX45KE5O6X3cJjR
	SChCQsxw/cyhF4P6SFm+NViCJh3fUNoHPA5lf1OgM/uAxyHMHonwp5cxn1+MO1M=
X-Google-Smtp-Source: AGHT+IGKWaofCbzaeJ8PKDw9g9lx54jjRGNbuTdIbQeM1t5M32qK+oQhnwU8rBZwu6qz61ojjBDTYg==
X-Received: by 2002:a17:906:71b:b0:a6f:1e97:b177 with SMTP id a640c23a62f3a-a6f1e97b24fmr93056166b.64.1717998815904;
        Sun, 09 Jun 2024 22:53:35 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:28d2:2417:3aa2:932])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c805cc3a4sm593844766b.69.2024.06.09.22.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 22:53:35 -0700 (PDT)
Date: Mon, 10 Jun 2024 07:53:33 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Trevor Gamblin <tgamblin@baylibre.com>, 
	Michael Hennerich <michael.hennerich@analog.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH 2/2] pwm: axi-pwmgen: Make use of regmap_clear_bits()
Message-ID: <no6gyqovcjrzcior5lym6qtb7ya4abgcspe2mebpvfc2bl3f4i@h3x64l7pomhf>
References: <20240606164047.534741-4-u.kleine-koenig@baylibre.com>
 <20240606164047.534741-6-u.kleine-koenig@baylibre.com>
 <3755faec8dc7048da880ef6b924ed2e5a224bfef.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ba52wjcuwfduil2v"
Content-Disposition: inline
In-Reply-To: <3755faec8dc7048da880ef6b924ed2e5a224bfef.camel@gmail.com>


--ba52wjcuwfduil2v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Nuno,

On Fri, Jun 07, 2024 at 08:40:32AM +0200, Nuno S=E1 wrote:
> On Thu, 2024-06-06 at 18:40 +0200, Uwe Kleine-K=F6nig wrote:
> > Instead of using regmap_update_bits() and passing val=3D0, better use
> > regmap_clear_bits().
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> > ---
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>

Thanks for looking at the patch. When I apply it (using b4) I get
however:

NOTE: some trailers ignored due to from/email mismatches:
    ! Trailer: Reviewed-by: Nuno Sa <nuno.sa@analog.com>
     Msg From: Nuno S=E1 <noname.nuno@gmail.com>

I'll add it anyhow, but it would be great if you fixed your workflow to
have the sender match the address in the tag.

Best regards
Uwe


--ba52wjcuwfduil2v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZmlNkACgkQj4D7WH0S
/k5v1Qf/ZWOKkRry+WUr4g3Yy/+TjWum2HU0rZMGOq57/l9MLDlpIcy8ns8cE7GY
dHyIa6Dj0K8R1jCHXGzkC4qu3MqkZParXl4Vt520XcXLZIuNkIdQD875pqgUDMqK
lLvQ/09BWiv8F9oywkV6c6P10yCKbyG+JngPanT9sGJpFSXJnH0SF6Ie5r84Sf8w
/sMPILOkSYwEn1Tikqh5XMUxlu/LQypQBofEK8ha9ESJDQKVFETvLGVYzdWyamZ+
NS7M8Gq00U99EG3pjhhQmsgntJO3MXIEoKXlvK2TQJqaRBVVb9OqIFsSKBiAhHpU
DyYvgzlUqUPAInRWKDoH6NXkQb0hcg==
=v0Lt
-----END PGP SIGNATURE-----

--ba52wjcuwfduil2v--

