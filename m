Return-Path: <linux-pwm+bounces-5963-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DEDAB58DD
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 17:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DFB7189E014
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 15:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5DA2BE102;
	Tue, 13 May 2025 15:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/3UVW2R"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDFE1CA81;
	Tue, 13 May 2025 15:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747150788; cv=none; b=F2jjO4ZEYr/ZAXcHyYs7HBEjBCiOVQFHFLpZqLGmGWK1De8hMQHZpdD/22xtTTz4wPqrT7QU9W9h/7fCVedcons1udnsGyvFYGeckuIGHhHZSXYlGj6llDDE16bsc6XV4wnMXYrLjtzDS2tP63RxDwIz6OhhOAA95pfowvgMXnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747150788; c=relaxed/simple;
	bh=ZpgDiBKtDTwL3g3tSFFjAR9TqfDhJRcsvSCpsNqR+Ys=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i1IK3XJeEB0wXZ6MvkLMo7P2wCLfbVDpqtBcLv/0VKxA5QV6JTQogRsDYuqKmyeJGnEFraIh5RJiaDq+lqupAyfiaL0SKGc0itxIoPadMPKvPC1kruz2H4lXW64ln411V+mBvfvs7LJXqrlGXy7ssvpaqJjvWAp9BOyyQIW09Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/3UVW2R; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cf257158fso40110165e9.2;
        Tue, 13 May 2025 08:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747150785; x=1747755585; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ry0Eba4MwMMcyZ2+Rc0xrMihweabEFMaU34KySJtikc=;
        b=h/3UVW2R2oLHfV0K5bQoq9znu9I4WsMgChlg5fWeA7QS0gijNCb5u5Y82fKycosw+N
         zV8gD+KTyG8Kch6m1m/CBGob+2lFVhSmjtCd36iFXHTMb4+6Me8qMPAtOEMh4aaq3hUX
         EPSV7Ysyf7L2vstF2wN2KE439L69CQh7oMQ2wrx73nHUoPihTV+9DTHFOemwEz/Lt9KP
         Whv8/EHdR+2aUv7OQXUhmYLnTEPRBYlDVmVs2LNtJWDOeq0ehmzMoH11LxvaWIx2tW+j
         ZnmZkARWze+cq0jDCUH+w11kQvbulSeq8WW3acoG67DXT80jqc7aYvDcj5FKM8WFDp0I
         DWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747150785; x=1747755585;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ry0Eba4MwMMcyZ2+Rc0xrMihweabEFMaU34KySJtikc=;
        b=PofUg75BJBdgRWMRBBqIQ3zE3028AuTKWHls7FYQZ9yhYY5L6XEF/dG1yw2iG/21/z
         Z9PWkstV5sh+enwXuBeredzbQZ6UDZSLjIydVT8jqvNCV034CdKeGJBQxwY0cZnq6WQO
         lxFihJ3IMSdQxiQHR7k5ESWsP1QOo8UB5r2mexjtUAIKCBPtWSyQhqpdjCPWQYb7f5u2
         PuM4SwIuhKtK+Nd5LrV8jtcGH7yKwt5xBGSw5tR2VbRBotNEghetPFUogxMXYsEb1fy1
         VM0QpMCi5jdkobx+Gc6jwkPqQ7aAUa0Zul2Jn04Kqj9eXh4XWC50I6W2G32LbKPPsLAX
         pm7w==
X-Forwarded-Encrypted: i=1; AJvYcCUBMMsW/zIOkmYYmNe8me0YpycWAkkPkFJ20w7C07wbEtrt2eXMwbnDo64IwldYCRNgLJ3uiAYZjuNA4/Q=@vger.kernel.org, AJvYcCUiHkqR8vCl66POtUsdDJOhIdoh3MBc31FVt5iEuTHDJgMv59yKOw+O1HPDD6Z0JAKDkZ+xj89ldDcf@vger.kernel.org, AJvYcCVav+0uJ0LlKuR33s/wgAlIASxI7E9xHHXaT3iJtZuEL+PsYi1wqTh57HAgfzQ0ePbHsDy71nbltOMz@vger.kernel.org
X-Gm-Message-State: AOJu0YwtDVsUdMfswiQPPMSp6blzVFkgvLZmcu6ek+znVT/kXOsg1/s5
	QbrJjGkuwaIAB8xp9MuvmQJjP/Nm8BnABEIltnQjchth3doiPFpl
X-Gm-Gg: ASbGncteiOgsrSDi6S72hGoe2BcBtNB28RODZSVnmfm+GmfL/JhS17eedlBnur194vU
	AmGA9N3fH+SA/5QE3BKpXRvO1i4rsiOPnIvNKCF3J4cSg+Kdp+h1Beh4rlRkGRxe5nhoapqlH9f
	Iud/tLHyw2p1dGe7nuITGhEDIgFN5WwUmoCWIgyqsgjBd+4bQ5DEVWRfdYPqrcUQ61KmvqYZeHA
	2WZgE0+0r6CuWLvcVg8KQRREbh5Wg0JubjnY6eRPlhher75sWYluWarNCwq0lrrp4snV6F7pmMl
	BmWcJ93SqCdQF1pjJ6beVSedyCF3hhZWWJJ0/yD36y9HcFcZq+i2
X-Google-Smtp-Source: AGHT+IEqGadDfAkVQ8Syt4B7G02YMw1GB2le4yxAbees+BwOy23eddnMvYQzSM3MmmtvH6tdZ8Q4eQ==
X-Received: by 2002:a05:600c:8208:b0:43b:ca39:6c7d with SMTP id 5b1f17b1804b1-442d6d19269mr180696655e9.3.1747150784982;
        Tue, 13 May 2025 08:39:44 -0700 (PDT)
Received: from [10.5.0.2] ([195.158.248.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d6858579sm171094915e9.28.2025.05.13.08.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 08:39:44 -0700 (PDT)
Message-ID: <f3d6bd26e9505855051391c6bd35bb756eb59bef.camel@gmail.com>
Subject: Re: [PATCH v3 04/22] pwm: adp5585: don't control OSC_EN in the pwm
 driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, Lee Jones
 <lee@kernel.org>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?=	 <ukleinek@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry
 Torokhov <dmitry.torokhov@gmail.com>, Liu Ying <victor.liu@nxp.com>
Date: Tue, 13 May 2025 16:39:44 +0100
In-Reply-To: <20250513152655.GC23592@pendragon.ideasonboard.com>
References: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
	 <20250512-dev-adp5589-fw-v3-4-092b14b79a88@analog.com>
	 <20250513152655.GC23592@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-05-13 at 17:26 +0200, Laurent Pinchart wrote:
> Hi Nuno,
>=20
> Thank you for the patch.
>=20
> On Mon, May 12, 2025 at 01:38:56PM +0100, Nuno S=C3=A1 via B4 Relay wrote=
:
> > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> >=20
> > The adp5585 is a Multi Function Device that can also be a gpio
> > controller and as it turns out, when OSC_EN is not set, we can't
> > reliably read the gpio value when it's configured as input. Hence,
> > OSC_EN will be set during probe by the parent device (and cleared on
> > unbind).
> >=20
> > Moreover, we'll add support for the keymap matrix (input device) which
> > definitely needs OSC_EN to be set and so, we cannot afford that disabli=
ng
> > the PWM output also breaks the keymap events generation.
>=20
> I think you can squash this with 03/22 if you send a new version. Moving
> the OSC_EN bit handling from the PWM child driver to the MFD driver is a
> single logical change.

Will do... happy to reduce the number of patches in the series

>=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/pwm/pwm-adp5585.c | 5 -----
> > =C2=A01 file changed, 5 deletions(-)
> >=20
> > diff --git a/drivers/pwm/pwm-adp5585.c b/drivers/pwm/pwm-adp5585.c
> > index
> > 40472ac5db6410a33e4f790fe8e6c23b517502be..c8821035b7c1412a55a642e6e8a46=
b66e6
> > 93a5af 100644
> > --- a/drivers/pwm/pwm-adp5585.c
> > +++ b/drivers/pwm/pwm-adp5585.c
> > @@ -62,7 +62,6 @@ static int pwm_adp5585_apply(struct pwm_chip *chip,
> > =C2=A0	int ret;
> > =C2=A0
> > =C2=A0	if (!state->enabled) {
> > -		regmap_clear_bits(regmap, ADP5585_GENERAL_CFG,
> > ADP5585_OSC_EN);
> > =C2=A0		regmap_clear_bits(regmap, ADP5585_PWM_CFG, ADP5585_PWM_EN);
> > =C2=A0		return 0;
> > =C2=A0	}
> > @@ -100,10 +99,6 @@ static int pwm_adp5585_apply(struct pwm_chip *chip,
> > =C2=A0	if (ret)
> > =C2=A0		return ret;
> > =C2=A0
> > -	ret =3D regmap_set_bits(regmap, ADP5585_GENERAL_CFG, ADP5585_OSC_EN);
> > -	if (ret)
> > -		return ret;
> > -
> > =C2=A0	return regmap_set_bits(regmap, ADP5585_PWM_CFG, ADP5585_PWM_EN);
> > =C2=A0}
> > =C2=A0

