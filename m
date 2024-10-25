Return-Path: <linux-pwm+bounces-3876-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 045709AFFE4
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 12:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88A1B1F2226E
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 10:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F061F1DE2A9;
	Fri, 25 Oct 2024 10:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JCrlD5qS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513DE1D8DF8
	for <linux-pwm@vger.kernel.org>; Fri, 25 Oct 2024 10:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729851587; cv=none; b=KRLimcEY6S3CwPlV/j24Zbq+vAVr4SRyo8sySvh6329BFXNAsB3t+JzEaO3uK4RXDLwVPYRl7tqFMYN/vb7Mga6U8iQUFvppM7A2CT2mNnkcC3Y9eJBNyqJ7koeqpJV86OrHvjFz8GTe9UXFC6RuKijdzQ8joCAR3L8O64VZGqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729851587; c=relaxed/simple;
	bh=h8nUr3ec1U3O/GOCFQCKtGsaSKKfc+vHX1qykT7Eng0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=geGG5YVANQ5PLNjFI3QPDZvB+/cdXkZTwcw6+343PUTLNRe8PTIhxxTVA+/yt8M8I+WcivNO3cx6PO3lnjjV2ZFB4H9/nQEIi+rcGE3YDlQEiShNAcD29iwLsObUm+k3AC19eVa8flh2VGg2pxB3+A5+gWji93wlxEVlqW1NoGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JCrlD5qS; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43155afca99so20017545e9.1
        for <linux-pwm@vger.kernel.org>; Fri, 25 Oct 2024 03:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729851584; x=1730456384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rBpUL2K11YBUFELLMPn7J24EDYIInyskb6BQJNfarC8=;
        b=JCrlD5qSIIIOUKQ7nGMLHug1ChJyybiRsT2R7dhAFKnKcQOZ3dp6A9kwgeG0grcymw
         g2goTw7kPIYiSSJJkQJ2tt5lac+27B/ha3HF2usiBEOPFV+WJJ3cCTPtDjHmbWcHtvhk
         Cxxq45+HmVJLrnT1GGhBhIrz4Vf52rOpMAb4xAj1OUhgloe210nCqE/Thso74GO1Pui6
         88bkNaCIrGEjwfSgLmZrW2ciw+k2V2LzYEqmxG9Rbcce+IrFNbVLmUK6eDWdy3nJstLP
         /yBADciZ+Kxd25y3e2tnVEJt0Pt2pGbAa6cfRkRjyRjTWbH2Uw9o8j/fIZgpGss/V2Ah
         6K6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729851584; x=1730456384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBpUL2K11YBUFELLMPn7J24EDYIInyskb6BQJNfarC8=;
        b=af3p9M25UwrQ2RriXDGuMBtmCXSA/+P1IU7DA5D+ygIFy4u100wtdGrImHaTLyI3pi
         fPDKbf9tNtJ6Khw1zNHKoKjiGUWrvwdw1V4DHRZhX5k5zzq0I9nXyZTNTNvsSgXks/e/
         /1b8u82/hZbh6C3mMVX38r+IvSjdTQL++xpL8RBWu1PGCFc+NIC9JWfMmeS/Af7z5+Ig
         dYFGSpNG/Y4WJ6U/sDdc3PdHcfb3GDM/BwA6sRO++xrVMP7qOWbM1F1JvgH5X5SY2kyY
         Mm8Ltip164uhBEmkMV6uK+qUeAnI7JIEKJFDV/I8CTiF2J1CS+Mq0RUpjPB7Idk9TjkT
         L5Mw==
X-Forwarded-Encrypted: i=1; AJvYcCWToQLWPW9E5kraW24L0GYRS51HIz5TAkZaC1Bjp+zJlC2UPqrl01FkWBdLvlrHOQz5ENu5XTfhOCg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+b6XJFUvfG6eVcZeEllUSdtj821VWliWV4oN1yeMVfpIz+FCN
	/yt7Z/K0BpC4MRgpVDAIY5+fLx6x4hQSexitP293u5OmKcPETPTuivYPXUAk8aI=
X-Google-Smtp-Source: AGHT+IEpRucuYPggIRzYn2XOQ7y/jTfvJj1wJmmqoHqungWwIwNJArQ6uCMDVCocpBpGNsacy/BKpg==
X-Received: by 2002:adf:e602:0:b0:37d:43a8:dee0 with SMTP id ffacd0b85a97d-3803ac7d59bmr3967804f8f.17.1729851582645;
        Fri, 25 Oct 2024 03:19:42 -0700 (PDT)
Received: from localhost (p50915d2d.dip0.t-ipconnect.de. [80.145.93.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b46bffsm1132208f8f.46.2024.10.25.03.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 03:19:42 -0700 (PDT)
Date: Fri, 25 Oct 2024 12:19:40 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Guenter Roeck <linux@roeck-us.net>, 
	"jdelvare@suse.com" <jdelvare@suse.com>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"joel@jms.id.au" <joel@jms.id.au>, "andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>, 
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, 
	BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [PATCH v1 0/2] Enable WDT reload feature
Message-ID: <ugont5utr7rwjfonm34fmafimree434orgqas4lknmbo6aep2s@ugkkuizosqhj>
References: <20241024071548.3370363-1-billy_tsai@aspeedtech.com>
 <nm4ckxv6swajr6hnqlkq5uoo6ncjzlg6yfxroftat6dubiefyi@xbhi4dvqacxm>
 <ea1be8af-0948-46b1-a1f4-fe572861cde4@roeck-us.net>
 <OSQPR06MB72529E67E67D0D07E59AF1C08B4F2@OSQPR06MB7252.apcprd06.prod.outlook.com>
 <6hkiqbgqkpdlr5f27drs7vcee7pb2uahek4zz5pd5ndativk53@42otb625deil>
 <OSQPR06MB72521C20B39B1469B5C6DCBC8B4F2@OSQPR06MB7252.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wivfejt2eayn7ufp"
Content-Disposition: inline
In-Reply-To: <OSQPR06MB72521C20B39B1469B5C6DCBC8B4F2@OSQPR06MB7252.apcprd06.prod.outlook.com>


--wivfejt2eayn7ufp
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 0/2] Enable WDT reload feature
MIME-Version: 1.0

Hello Billy,

On Fri, Oct 25, 2024 at 09:37:53AM +0000, Billy Tsai wrote:
> > > > On 10/24/24 08:40, Uwe Kleine-K=C3=B6nig wrote:
> > > > > On Thu, Oct 24, 2024 at 03:15:46PM +0800, Billy Tsai wrote:
> > > > >> Aspeed PWM controller has the WDT reload feature, which changes =
the duty
> > > > >> cycle to a preprogrammed value after a WDT/EXTRST#.
> > > > >>
> > > > >> Billy Tsai (2):
> > > > >>    hwmon: (aspeed-g6-pwm-tacho): Extend the #pwm-cells to 4
> > > > >>    hwmon: (aspeed-g6-pwm-tacho): Support the WDT reload
> > > > >
> > > > > Huh, I'm not convinced that extending #pwm-cells for that feature=
 is a
> > > > > good idea. Unless I'm missing something none of the other support=
ed PWM
> > > > > chips can do that, so I hesitate to change a standard for it. I s=
uggest
> > > > > to make this a separate property instead.
> > >
> > > Using a separate property to enable this feature is a straightforward
> > > method, but I don=E2=80=99t understand why extending #pwm-cells isn=
=E2=80=99t a good
> > > idea in my situation. The feature =E2=80=98WDT reload=E2=80=99 can be=
 set for
> > > individual PWM channels, and the PWM subsystem has the of_xlate
> > > callback hook, which allows each driver to define its arguments for
> > > the PWM consumer. I=E2=80=99m unsure if I misunderstood this callback=
 usage,
> > > as I couldn=E2=80=99t find examples. If my understanding is correct, =
this
> > > method is better for adding our specific feature, rather than using
> > > child nodes or separate properties to indicate which PWM channel
> > > should enable this feature with the corresponding duty cycle values. I
> > > think using separate properties to achieve this feature would be quite
> > > cumbersome.
> > > As I know the arguments for this usage are as follows:
> > > First: PWM channel index
> > > Second: PWM period in ns
> > > Third: PWM polarity
> > > Therefore, I extended our feature to a fourth argument to avoid any c=
onfusion regarding usage and added the description in our yaml file.
> > >
> > > If my thinking is incorrect or doesn=E2=80=99t make sense, please let=
 me know.
>=20
> > It might make sense if your bubble only contains that single PWM
> > hardware. However if you extend the pwm cells semantic for your PWM to
> > mean "period if the PWM watchdog triggers", i can hardly refuse the next
> > developer who wants to extend for "period of the secondary output pin of
> > the PWM" or a step counter or some property that defines how the duty
> > cycle is modulated over time. And should the next one also use the 4th
> > u32 for his purpose, or should we consider it reserved now for your
> > purpose such that the duty_cycle modulation goes into the 7th cell?
>=20
> In my view, the order of arguments=E2=80=94such as PWM number, PWM period=
 in ns, and PWM polarity=E2=80=94is just
> a convention for PWM consumers to follow. Even if another driver doesn=E2=
=80=99t adhere strictly to this
> rule, it shouldn=E2=80=99t be considered an error if the YAML file docume=
nts the usage of each argument.

And it's a good idea to follow known conventions. There must be a good
reason to deviate because each deviation adds burden to the developers
making use of that device. And to patch authors, patch reviewers and
maintainers.

So I'd not say, extending pwm cells is an error. But it's an action
where the advantages don't outweight the disadvantages.

> For example, some PWM controllers set #pwm-cells to 1, where the first ar=
gument isn=E2=80=99t necessarily
> the PWM number. In google,cros-ec-pwm.yaml, it=E2=80=99s treated as the P=
WM index, while in marvell,pxa-pwm.yaml,
> it represents the period in ns.

Agreed. That is historic ballast that cannot be changed without breaking
dt compatibility. New drivers are supposed to use #pwm-cells =3D <3> with
the known semantics.

And if I would design the pwm references today, I'd just mandate
#pwm-cells =3D <1>; and don't specify a default period and flags in the
reference which I think don't really belong there.

> If users want to work with these PWM controllers, they should confirm the=
 purpose of each argument from the
> YAML file, rather than assuming the PWM driver follows a conventional arg=
ument order.

Yes they should. However doing surprising stuff cannot be excused by
documenting it and then pointing to that documentation.

> If the YAML file doesn=E2=80=99t specify details, it can be treated as
> described in pwm.yaml, which is fine. However, if there are any
> differences, I think recording them in their own YAML file is
> sufficient (Like google,cros-ec-pwm.yaml and  marvell,pxa-pwm.yaml).
>=20
> > Today the bindings are (well nearly) used in the same way for all
> > hardwares and I want to keep it that way. If your PWM has a special
> > feature, give it a speaking name that the occasional dts reader has a
> > chance to understand without reading HW docs or dt bindings.
>=20
> Using another DTS property to achieve this isn=E2=80=99t as elegant as ut=
ilizing PWM arguments, which will only
> be applied when the PWM consumer uses it. This is another reason I want t=
o extend the PWM cells semantic.

It seems elegance is subjective as I don't agree.

Best regards
Uwe

--wivfejt2eayn7ufp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcbcLoACgkQj4D7WH0S
/k5PIgf8DvAJswdKoKhqa0pXx9qPc8T33mvVsjlO5tR9bQ76xKfxuTHrOUW8DxnG
i4TjzmCH4tvC0QuRVhgodbiB3+t0PEXoRPd1guBYWAgHEVjKH0V04BPKjreFmdbI
DAr2ERc1OmVC53O9vFqJ8CILaWNpz7NwF/GfiCVKPtv569+4TcakSIuARoNWxMCA
dRhG0lRjiYQ5NQC3fOS+DuhFcTdM5gQxP/L71SKA2CktrBHXgS6z8b8bU4muuNT1
13RpkMBrXFmIuU+BRIk09gxG9LdlyE9fUaPE3TiPuo4Lh4E4abz4tmTIBoAPr13Q
+G7QE8xQb8p4ZFg2IAp4kSP0E1KTaQ==
=z2Vk
-----END PGP SIGNATURE-----

--wivfejt2eayn7ufp--

