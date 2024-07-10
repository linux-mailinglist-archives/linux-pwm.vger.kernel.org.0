Return-Path: <linux-pwm+bounces-2753-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCCA92D593
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Jul 2024 17:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD4E61C21064
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Jul 2024 15:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28F7194A65;
	Wed, 10 Jul 2024 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="B0VAf0EV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A740F194C6B
	for <linux-pwm@vger.kernel.org>; Wed, 10 Jul 2024 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627135; cv=none; b=MiVw+uBelniw6LR4Rt1rk7Fe5M4JbZHzG/7Eu5HyYrgzIK+824U8uPK/bOfuFraNSU1+fANl5EZu9oIMp2p5lif1XT9Ql5rg3p4NcIrA+HHcHVDb1XJa08XM5DTKUebtkjQ5fjylT+/L8N9Gx+8AHJEanpddL3zeaLmOZ7gDUys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627135; c=relaxed/simple;
	bh=Pyb+j628SaKSwyE9z9dxgxQ6lB5NqTwU2hJGMZjGwgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2eOX5O8u1E+2VWo/dXHfBd7wEwiJvL6HAE0LVbkoZYZxQzk7b+mRu20eNZYSB8XpNtCxig5cOx3haCKLvqPinCmDKxnbTxV1jXQASma3Gn1pOWOb6KxIQeCLSG4fWAKmC1FGFRMD7e0xIcK/1GMvinGLFGmlNB8GjeiKq+p3Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=B0VAf0EV; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4265c2b602aso32303845e9.3
        for <linux-pwm@vger.kernel.org>; Wed, 10 Jul 2024 08:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720627132; x=1721231932; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pyb+j628SaKSwyE9z9dxgxQ6lB5NqTwU2hJGMZjGwgc=;
        b=B0VAf0EVfxDiabHdDslqEvvAHbtZEftbI70aw+B3vL0/alLpZuCq4D3OfMgmBAubRX
         2kSw80cHyzMgCeW191tIHb1I5vV8JlCih5fstlqIJlUZN4MXnvxPmbgE3pyRUtPoBaMh
         FKLzMBxqa+qAKVFIIQgQ/72DM2NQESvlUkJ1oqv6TirSx3MNoGUnNIKlSQw31uilB8pM
         NWBzmraPl82WXs0ip9fK1Su36GXpYvU4zLuARXEeoeZD+6puDII6rrYLqi9kaX0dp0Q8
         JlXKfT8rq+R7A5dvEkSxhf69fiIAl5K5fXP4ztW0J5W69psXZ3i6h29sbiTSCT+mGW73
         LMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720627132; x=1721231932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pyb+j628SaKSwyE9z9dxgxQ6lB5NqTwU2hJGMZjGwgc=;
        b=KI+R2gMcrD1uMVxzRuaZd/QLFVWLs9lIPHy8qq9NskIsPwNUyMzK3PqlkYL8u38H+u
         s2kNXkoYVFgfHq6Y1+f/vT9OLC06OEOnv0RznmL868CmdfSA4HdB+Nnh1dhbemB+63mk
         D3G4A25U2u2OafYvGyzYFxCMbjowI/vkEoDDge27VYZ3rv0gOES7fjOJWSUdyy3Skx5N
         wYcC33p0q87WOa7+UzozokcIUyhIbBi7iMhZVI+2gBsy33r9iUVrRKE9pCrr9RDfBhsi
         iT0eV2k6bpiholT70AFeBsNvd4IgoYQi36bs2PedkU3kiUC818sQ7HPwWyp3Yeog1Hbp
         xJFA==
X-Forwarded-Encrypted: i=1; AJvYcCVMHncCuVnFkMjS2cC9YgjhvZesFD+hhj1u2bEqG1xaXJldnYuIj/TnuZ9dD5xrj0c9FBrZzGpZdFNYCokWFFj5bf326oIQpTq4
X-Gm-Message-State: AOJu0YxaJCZGl4AVCuweH8vuCfDYdXF96GIMYtUhRjhfZ2w+uPtKXH9W
	UcINKrgVgr7QbdAOSGLwbO1QNZKxo5YfRAfEayrVlgE88XMRIMD+7q88bWnbH6w=
X-Google-Smtp-Source: AGHT+IFoqWpwJIP9NlnojCZazx7iKTgThMg6yacddpViQU+0gojV9wNwsQBWK9DwixPly5lY0CkFmQ==
X-Received: by 2002:adf:f70d:0:b0:366:ef25:de51 with SMTP id ffacd0b85a97d-367cead0fe8mr3898639f8f.49.1720627132043;
        Wed, 10 Jul 2024 08:58:52 -0700 (PDT)
Received: from localhost (p200300f65f164800ca5d02fee8f4878b.dip0.t-ipconnect.de. [2003:f6:5f16:4800:ca5d:2fe:e8f4:878b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde891cesm5705398f8f.62.2024.07.10.08.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 08:58:51 -0700 (PDT)
Date: Wed, 10 Jul 2024 17:58:50 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] pwm: atmel-tcb: Simplify checking the companion
 output
Message-ID: <5i6ixi72a3yha2i7pshdgwrgxd6pldlrahnvukgujnjs7khhbe@ahilb6recev6>
References: <20240709101806.52394-3-u.kleine-koenig@baylibre.com>
 <20240709101806.52394-4-u.kleine-koenig@baylibre.com>
 <6db1de1b-cf0c-4acc-91dd-41dddfa36227@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="knimn3snydpoyrlk"
Content-Disposition: inline
In-Reply-To: <6db1de1b-cf0c-4acc-91dd-41dddfa36227@microchip.com>


--knimn3snydpoyrlk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 04:17:47PM +0200, Nicolas Ferre wrote:
> On 09/07/2024 at 12:18, Uwe Kleine-K=F6nig wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the content is safe
> >=20
> > The two outputs provided by the supported hardware share some settings,
> > so access to the other PWM is required when one of them is configured.
> >=20
> > Instead of an explicit if to deterimine the other PWM just use
> > hwpwm ^ 1. Further atcbpwm is never NULL, so drop the corresponding
> > check.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
>=20
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks, I applied both patches with your Ack to my pwm/for-next branch.

Best regards
Uwe

--knimn3snydpoyrlk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaOr7cACgkQj4D7WH0S
/k4XAwf+Ljhx3uAJhNE4AdsZNPbn78VLa3zvS43jzt2pJJWXpZ53Kd5JyCTDh6Wb
l269U5yfgDO1J0/h9HaLtV3NrKWU9ZCh9i3Z6MkjgNHwNaZ8zfzAS6oDa+/hko96
YyTucZ3bRmEBnBB1odXv8s397afIjgVlrYRR0Y1f0L301zCiv+tu4Y+lx0v+sGQP
3wdBLu0I85fK0AimEcwrgS/7ocjUMceMvlGhTevmQSk2yxcgeRPBkcpT/tR4N/MN
WtiPV4ZmhYIdJhASUHbPGJ1nSdFNFAreup58PMH3NCJ1l7UaLDmIkhsRDW9n3Fq6
g6SwODG33EGnri9He5DHoav78h4IYw==
=IEot
-----END PGP SIGNATURE-----

--knimn3snydpoyrlk--

