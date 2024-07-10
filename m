Return-Path: <linux-pwm+bounces-2752-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0283192D58B
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Jul 2024 17:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7D11288E05
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Jul 2024 15:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C637118EFE0;
	Wed, 10 Jul 2024 15:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2txdI4YA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3B536AF8
	for <linux-pwm@vger.kernel.org>; Wed, 10 Jul 2024 15:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627095; cv=none; b=oFA+cHrWmKhf74Ow6e2CBN6SQtkCX7BzvWBJpj35C3iBzFqPGXfXTodgJ/7Y6IcMG4AnxGB8HsdMTZhL3FEv3bdC4J9cjCNzoO9MPXDUKibo9XPfTfwCykOXRRFV7bEXotrabFvi7tLZ3R1Tph/lQhmCzkDGZCN7PVb3v3i1NFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627095; c=relaxed/simple;
	bh=VHpziX1DOdez7ql/kyo0p1uqprtai0+ZnlJi+ofjK/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7AjEkgzrBJhHXmjBzjKP/uFLJTmNMVl9QqmEVGnRUgNG0quBa5Q2fztISAKsQeto/tm2A55vCwAsFaZ7fezmOq3106itLREn3fAIViUdHr7jO8yz7DDl4NrNc8QeYCJM66VgHrzjNzY+UvnKGjsNSYGnGOcPief7MAH7GHwOPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2txdI4YA; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ec61eeed8eso77698241fa.0
        for <linux-pwm@vger.kernel.org>; Wed, 10 Jul 2024 08:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720627091; x=1721231891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VHpziX1DOdez7ql/kyo0p1uqprtai0+ZnlJi+ofjK/c=;
        b=2txdI4YAsGuDVw31pLZevt12eGo9lVaDa0rXIBtsE+ZF4WmuZNIRAdjdtyqYWFFKRs
         /litNOio7B5voi0EfsSMAqUn2A5TR8H0wkU3fX2cwrgZ5fr/8awtuPbXEUfxEvm+cJOC
         puXZpbK8pQzZaS3OxURjtC9VoZOpNMsOUP6l0vROinxp5jjSi9JblGs6GZTMOIqC5CDA
         +l3IEx4q+4R9/Rk7w7TRocsIfuT3AxQekzttJyMiZTA8+ri7tVAVPe/cXlwgeukZjFNo
         ez44Y6JQl9vbyql3X5bwpuvM2+OWJAhXmSkaGt4zb7M0iPn1y8l46EwK4wTlDEV0Lyak
         1FOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720627091; x=1721231891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHpziX1DOdez7ql/kyo0p1uqprtai0+ZnlJi+ofjK/c=;
        b=qCax4WQeQXbs+Yyk8ENJYTMlnvVOqIJwX5v1WPgsaM5UxS1iD3QvlN5oxMD7qf5H6f
         vckl/3NaLfJUm9Xu3tncRRVDHMzOmQNSUhpn0rxChMVaVYi1gMYn1JpUheOFVQym6pEz
         5ynIei52H9BDqcboaiVRrpghAv4n0SGE2quj8EBq9xobOQVjZtnu96lb8tubB39LSKV7
         2XDWttiTXDzMfM5/SzASUPIGzRem6N+jsFQpM8UsBp0Zf+tykkEbkWJgFpLFVzfa7H3b
         7lqOOFOMPcONSy25Urr7aTTWuDHSTxAjxJk46kMO5sC/iH5JVL7g5/OmQbVme5ps5mPr
         AWgw==
X-Forwarded-Encrypted: i=1; AJvYcCVvezQHAGPrOyqILc75PoUhnsSak5ve3Jqu3sEbYGnoi/o+OAZUGjHRH2BE3nCab/5rcxCUhYPEwi2QB1jov1b74xgLUnc+eeVC
X-Gm-Message-State: AOJu0Yz6uexdGf3f1KhuiFaObyrldnhLLKOWZptuHNxYKw1zNTM/SnmF
	6wBYUPwrUcYnGR+0hRUvp9kuowtfviaWQ/hjsJ18RSVFdnwlqW5jZUqPMLwDmSg=
X-Google-Smtp-Source: AGHT+IGd80Hxjs0hQY5YKzq9z8S045nzPp8FA0PQTSOixgCa2AK5SzQnJmBMqH6bFfIGmdju+q9i/w==
X-Received: by 2002:a05:651c:d4:b0:2ee:93ba:8b0a with SMTP id 38308e7fff4ca-2eeb310356amr39939171fa.29.1720627090803;
        Wed, 10 Jul 2024 08:58:10 -0700 (PDT)
Received: from localhost (p200300f65f164800ca5d02fee8f4878b.dip0.t-ipconnect.de. [2003:f6:5f16:4800:ca5d:2fe:e8f4:878b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfab199sm5662308f8f.106.2024.07.10.08.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 08:58:10 -0700 (PDT)
Date: Wed, 10 Jul 2024 17:58:09 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pwm: atmel-tcb: Make private data variable naming
 consistent
Message-ID: <6zy2pdg6odfkki4i452bx4jnmwyx7oc24vgmaymjcsmn4jhy6v@43yju34qv62m>
References: <20240709092221.47025-2-u.kleine-koenig@baylibre.com>
 <db038b7e-8864-43db-a4e0-5992ca01cdec@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="crbkx5luv62ukg4z"
Content-Disposition: inline
In-Reply-To: <db038b7e-8864-43db-a4e0-5992ca01cdec@microchip.com>


--crbkx5luv62ukg4z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 03:20:00PM +0200, Nicolas Ferre wrote:
> On 09/07/2024 at 11:22, Uwe Kleine-K=F6nig wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the content is safe
> >=20
> > Currently the variables of type struct atmel_tcb_pwm_device
> > are named "tcbpwm", and variables of type atmel_tcb_pwm_chip are either
> > named "tcbpwm" (too!) or "tcbpwmc". Rename the chips with device name to
> > "tcbpwmc" to get a consistent naming.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
>=20
> Makes sense: thanks Uwe:
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks, I applied the patch with your ack to my pwm/for-next branch.

Best regards
Uwe

--crbkx5luv62ukg4z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaOr44ACgkQj4D7WH0S
/k4vjQf/ds5tx7TNva/30ksXIstjizhUpn9/Q6GfoD0uQT8R7P3+9P61N9jcyjGx
OVRsfS88o/kDEH2ascx03ChhWtVu4NJ0A2ayhwTuGrR+VrbmTCehWT+Gk9WI+k1W
6Bs3PMveKHgbFMSFoYnZ01HgJNWibjZeUZX+m8jK3zgx8m86ljafSwL9UJC/MBj8
4qGVtQhXOEpEAxxTvapNuKI/lqs/nR5b3pUAd22i3kBzLyYpdlJ5aGVA3q+lJbSj
R0OLOQ4M8SXf8JKAhumFttwhOl/JJJjNfMPEewWNCIVtQEjxcgflY3/bAv8oMf+w
boKCeFbfhR7W18r+ciEulXMqv7NNaA==
=+eex
-----END PGP SIGNATURE-----

--crbkx5luv62ukg4z--

