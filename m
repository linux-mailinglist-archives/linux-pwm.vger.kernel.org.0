Return-Path: <linux-pwm+bounces-6255-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B1BAD0451
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Jun 2025 16:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E1E57A4F59
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Jun 2025 14:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AB11D6193;
	Fri,  6 Jun 2025 14:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ji+tBwGY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0831CEACB
	for <linux-pwm@vger.kernel.org>; Fri,  6 Jun 2025 14:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749221836; cv=none; b=Z199GBTwy73jCAACB28Mo7ndwO//UtkkSZBiqacxtPp6PvJ1EnCKMKWYRIXF2vRe4zLVBtKOkV3PY7b1oZlDp+Eb4wSh2b8cmf75J+awiUJ9tJOQTiPlDnGl4h1QiFK9xWXuy7/e9tEnfEKUZwHpD6VvoZZYRZnD4jkW/8Sba7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749221836; c=relaxed/simple;
	bh=ia7pnAGyVV1EpMWakQwBtxjI3bEZOeCvt8bf0l4HQIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3BfIZ7KBqJq0dBZy7XSfLvLWz1Ib1wdEPgMarwjzQKqnk56YMt507lgXug6esxAHhk2n5ZFt+xuRB0y5B8t4bebF1waTPQIwdZz+bkFovT6Q2GYLelJvhd4xzdM/nK5qJo33eQy5x921l3OUI5ZBIuBzauaoCBC1G7tYGp/eoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ji+tBwGY; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-450cf214200so19897255e9.1
        for <linux-pwm@vger.kernel.org>; Fri, 06 Jun 2025 07:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749221832; x=1749826632; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ybeh6r8IJ9MMaBfEPZurC85ycYwc4zI6taH+XBEB7iM=;
        b=Ji+tBwGYkavoDMO2lvr8lzuKAde/GcNvyhsdvCc7YKkXSjig9iG67tFKvktaWtZBn2
         T7mCDqAZ6U/+1BKCqd9rDB9bOIxlFWSfOVifoMs4oZpfxLjy7FG+BYVr66OIG0Szrg7W
         a4vB934BQzNaw5DZeH86zO8SPDoPSJK7lUrdpDMtzn0stPutv2tFFN5GuMaePUTRX3vG
         qYFbWgUbtJSyvOqF99X5tvsOpwCO2Y3dKtSh27EgxILr7LROSDFiVhCIany08F0uKbfL
         No1jRCDMM/YVZrQz78c/Kso8fbr3t9WjvZe79kTIdyAbQqppe06i70kCYc7r4lIIXNN6
         z2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749221832; x=1749826632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ybeh6r8IJ9MMaBfEPZurC85ycYwc4zI6taH+XBEB7iM=;
        b=v0LkCIsvNTh7YxsilbEmjHp2BZ5Mx8NvwWIrQHs3PcOv/VdjCZHKunVsk6+01M2oEU
         oRB3isufbbs8wrbI869kwCfXFl7ARqoBa30ntnLzDZ1noLWEX2mBWIECDNee3yGlxNuD
         2rWW4XIyerrBdLL8D/4h2F2nKpj34E+olImdVZWkGlLMVikYTEB0zx1soT6VRnfDmhHO
         5sle2U5vNXugPEoQz6FMNYTYXpEg0DS7WJ3/UMak0cxzXEkKMLzh5dE8DjzxfQ2Xf7Hf
         eDRQHGkh4Lqx+ry5658oJrHBmLcBVTzeNW9TrO20uVwFeXl+tPddvm+Fa5SGbSBgtLcJ
         h8Cg==
X-Forwarded-Encrypted: i=1; AJvYcCX7JY2PvmVDu09MmQ8tOaJSctZw+m7gWEhKzbQGNNudXyBGfBK7PIxAyz/U/TOqmb9WyaE3IR+C5qs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOQUA1d6d+JHn0YN4Clla/ksujfT/Qna5csOboVlXtq+WsfWFU
	0VBa158Ogqekfv9fn5hiQD2xXi8Nfhzh766aSyv/4hxi+xmBVBt4RQm53d5pUcdCZew=
X-Gm-Gg: ASbGnct0DAcJMAYCGkK5kWkI38xLdyVH/ueaNkD/Hg8kzzvxtoZi+sXxNKDXYtzWoRR
	zzfLYvo2cW370dx85eWMToP5jLnPHiZRzpJN62JICN99ud+TqgK/IUcUppqaHVPcb5lOHFnNduM
	xJrvwHUyCCGWD+fLC09rMTu5nsnwWVOc/hEpD4R8Ia8/OFRrJVE16uAl3mT9xkNbcfVyWxrqmBy
	RMvVr9eALtpTh6nO7IvYKP71UA8Y3S22gRTTG7Iix8hz0ItT9uH1Qlnu6YDofAxMG/67tJkuTrH
	YoYoyVu9qh1NJGeSSpNrzm4NrCfVxAoZSYoi3ufXRYVZuU9vYTXYr4wvul7DXrnogk/1clJJ2jH
	ruoXXlagOh9UL4FzVRo0iv4fzbbMd
X-Google-Smtp-Source: AGHT+IEtcBbSWQ+OKjv58Suw5c1swP9aEvffhR8eHp0ff4ePqLrLdMPX0D2MvWAAWZPqN7jMkQVkmg==
X-Received: by 2002:a05:600c:458a:b0:450:cabd:b4a9 with SMTP id 5b1f17b1804b1-452014ea1ebmr35514085e9.29.1749221832308;
        Fri, 06 Jun 2025 07:57:12 -0700 (PDT)
Received: from localhost (p200300f65f13c80400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f13:c804::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45213754973sm26847055e9.35.2025.06.06.07.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 07:57:11 -0700 (PDT)
Date: Fri, 6 Jun 2025 16:57:10 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Sean Anderson <sean.anderson@seco.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Subject: Re: New default binding for PWM devices? [Was: Re: [PATCH]
 dt-bindings: timer: xlnx,xps-timer: Make PWM in example usable]
Message-ID: <erst43cabswj3cwnszssolgyoh4dsgrlnjjxhb7luk3qkqhyay@6zyoixljvwwg>
References: <20250527171504.346696-2-u.kleine-koenig@baylibre.com>
 <a14be34c-de2a-4bea-9282-1fac7780b9a4@kernel.org>
 <crk42dsypmbyqk7avldghjq32vslmalfmmouwxzgtdci4agfhz@rkbmxj5z22fx>
 <20250606141324.GA1383279-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="53f32hgy6vknjdpf"
Content-Disposition: inline
In-Reply-To: <20250606141324.GA1383279-robh@kernel.org>


--53f32hgy6vknjdpf
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: New default binding for PWM devices? [Was: Re: [PATCH]
 dt-bindings: timer: xlnx,xps-timer: Make PWM in example usable]
MIME-Version: 1.0

Hello Rob,

On Fri, Jun 06, 2025 at 09:13:24AM -0500, Rob Herring wrote:
>    reg:
> >      maxItems: 1
> > =20
> > -  '#pwm-cells': true
> > +  '#pwm-cells':
> > +    const: 3
> > =20
> >    xlnx,count-width:
> >      $ref: /schemas/types.yaml#/definitions/uint32
> > @@ -82,7 +83,7 @@ examples:
> >      };
> > =20
> >      timer@800f0000 {
> > -        #pwm-cells =3D <0>;
> > +        #pwm-cells =3D <3>;
> >          clock-names =3D "s_axi_aclk";
> >          clocks =3D <&zynqmp_clk 71>;
> >          compatible =3D "xlnx,xps-timer-1.00.a";
> >=20
> > There is however one concern that I want to get resolved first to
> > prevent churn:
> >=20
> > In principle I think it's bad that a phandle to a PWM must contain a
> > period and flags specifying the polarity. For some use cases the period
> > might not matter or is implicitly given or more than one period length
> > is relevant.
>=20
> Why can't the period be 0 and no flags set if they aren't needed?

I don't say they cannot, and probably that's the most sane option if
there is no fixed default period and flags and we're sticking to 3
cells.

> > So I wonder if instead of unifying all PWM bindings to #pwm-cells =3D <=
3>
> > I should instead go to something like
> >=20
> > 	mypwm: pwm {
> > 		compatible =3D "...."
> > 		#pwm-cells =3D <1>;
> > 	};
> >=20
> > 	fan {
> > 		compatible =3D "pwm-fan";
> > 		pwms =3D <&mypwm 1>;
> > 		assigned-pwms =3D <&mypwm>;
> > 		assigned-pwm-default-period-lengths-ns =3D <40000>;
> > 		assigned-pwm-default-flags =3D <PWM_POLARITY_INVERTED>;
> > 	};
> >=20
> > (where the single cell specifies the index of the PWM's output).
>=20
> Sigh. You just changed everyone to 3 cells and now you want to change=20
> again?

I did? I admit that I intended to, but before starting to modify the
bindings I thought about if #pwm-cells =3D <3> is really the best way
forward.

> Changing existing users to 3 was borderline churn. Changing again=20
> I won't be receptive to.=20

I'm puzzled about what you mean.

There is 2bb369ab50e107a7de6df060a1ece2f33a6a0b9e but this is hardly
churn? And I prepared switching to 3 cells in
895fe4537cc8586f51abb5c66524efaa42c29883 but didn't touch the bindings
yet.
=20
> > I already suggested that in
> > https://lore.kernel.org/linux-pwm/jmxmxzzfyobuheqe75lj7qcq5rlt625wddb3r=
lhiernunjdodu@tgxghvfef4tl/.
> > When I asked about that in #armlinux Rob said "no. We don't need a 2nd
> > way to set period and flags." Is this still a bad idea if the
> > traditional binding with 3 cells will be deprecated for all PWM
> > devices? If this would be ok then, I'm also open for improvements to
> > the new concept. Maybe something like:
> >=20
> > 	fan {
> > 		compatible =3D "pwm-fan";
> > 		pwms =3D <&mypwm 1>;
> > 		pwm-default-period-lengths-ns =3D <40000>;
> > 		pwm-default-flags =3D <PWM_POLARITY_INVERTED>;
> > 	};
> >=20
> > ?
>=20
> How is this any different than a slight name change?

Compared to the suggestion with assigned-pwms it's mostly just a name
change, but dropping assigned-pwms is a relevant change. Compared to
what we have now (i.e. #pwm-cells =3D <3> for most bindings) the
specification of flags and period is optional which is IMHO a nicer
design pattern.

> What I also said there is that case looked like a property of the fan.=20
> If you want a default fan speed, then you should express that in fan=20
> terms (i.e. RPM or %) and then have a table to go from fan speeds to fan=
=20
> control settings (i.e. PWM duty cycle in this case). Even if you need=20
> something like minimum startup duty cycle, that's still a property of=20
> the fan.

I fully agree and want to fix the #pwm-cells =3D <4> case. In that context
it's also relevant if the change should go to <3> or <1>.

Best regards
Uwe

--53f32hgy6vknjdpf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhDAcMACgkQj4D7WH0S
/k7Zrwf/e3pkjRqHFV7Lk3vsWkmBLVvNzXJD7lFWLaL48eo49cz+xEVS1hg2NH2x
OdS0bPOu1kOSTdJcpWCThTsJUL0IignJx5D+SXMlcSj+VfeEpfTj2ooi7MhnZEK7
hSlIT/VfKcrlOh5SQw+uslH6VDNW7jEWfrimh90vEcqYCJqm56kyalzdI6Gj0XS9
YRmmjvxWu4hU73H2LB04Ha5VAtWSI2E1o/2Bm81jL6dQfqyVQDIjO+fAK90QNGnT
Fv7OM+bluN1LiMZRzy3TLv1wyNTFAZ1Vv93Xb+ZuSPC6SrJB+C082J+vQtXT20f6
8KapgO98QZsotPXAGWN7LPxr3fkCmg==
=fwHN
-----END PGP SIGNATURE-----

--53f32hgy6vknjdpf--

