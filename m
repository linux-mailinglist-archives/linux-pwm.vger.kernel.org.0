Return-Path: <linux-pwm+bounces-1898-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DAE8A18AF
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Apr 2024 17:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75AA8B28F59
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Apr 2024 15:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B4B13FFC;
	Thu, 11 Apr 2024 15:21:52 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450A6E55F
	for <linux-pwm@vger.kernel.org>; Thu, 11 Apr 2024 15:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712848912; cv=none; b=DJ2OVJwLh3laGjZo2VGuXuFf2sF6UP2ydA407bfUhtW0ODfonfrAsugXnFTyGwcwmZaEUcDJ4OfgK6wjcqOdCGKDHpGfb3zlp6uMYOQ3+mAJLbPXv+tL4dLFms8sK1sdqOXOY47QWblN7Q1ejtnqlroQA8zut+A6vh0ztIQV1Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712848912; c=relaxed/simple;
	bh=QyeqS9RPExYydZbTetjSi1LbmSNI8g2MYTEU0GBVC5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EktDyhbdnlILJfEL08NRSWopbeT1lXWk9CLCNr3X4o9yKEFJFMvahbuVaOXz9QMOp30qHJBGY9blAb+sJY+9znuXUVHSPEFElGw2Nh+DAWyJ4i5TL3w/ZbPc0hlZdq7DZSuxsEmCFtCLRNr/HssPHK5ff5+nZ92qZNkepnStoZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruwEz-00036b-QG; Thu, 11 Apr 2024 17:21:29 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruwEv-00BiDu-32; Thu, 11 Apr 2024 17:21:25 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruwEv-000fG9-01;
	Thu, 11 Apr 2024 17:21:25 +0200
Date: Thu, 11 Apr 2024 17:21:24 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, 
	Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Juxin Gao <gaojuxin@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, loongson-kernel@lists.loongnix.cn, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: Add Loongson PWM controller
Message-ID: <k2v7ibfc5vjprfw6gvrcelbknhxqf7mnybsnbb2avj6qblkmqz@graeaj372hcg>
References: <cover.1712732719.git.zhoubinbin@loongson.cn>
 <38c234d548b4b9c334cda6e7664a803896b31f6f.1712732719.git.zhoubinbin@loongson.cn>
 <c1399191-6c6d-4eb4-b05b-f87a9f2b4152@linaro.org>
 <CAMpQs4JiLGJ-nBDmj1pe0SCqKeCnz5DrybJAKE8_6up293YNpw@mail.gmail.com>
 <98d12a5e-e291-40f9-8334-3b5f53ed79a8@linaro.org>
 <CAMpQs4KgzOjJe52BAhTb5P4t5ZynkW9AUEzPBkX_1h5XHuk5Ew@mail.gmail.com>
 <b551f712-ed95-4d90-b0fd-7cf471bc9eee@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i4ouf7pscroqa5m7"
Content-Disposition: inline
In-Reply-To: <b551f712-ed95-4d90-b0fd-7cf471bc9eee@linaro.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--i4ouf7pscroqa5m7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Apr 11, 2024 at 04:44:37PM +0200, Krzysztof Kozlowski wrote:
> On 11/04/2024 16:35, Binbin Zhou wrote:
> > On Thu, Apr 11, 2024 at 5:07=E2=80=AFPM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 11/04/2024 13:01, Binbin Zhou wrote:
> >>> On Thu, Apr 11, 2024 at 4:26=E2=80=AFPM Krzysztof Kozlowski
> >>> <krzysztof.kozlowski@linaro.org> wrote:
> >>>>
> >>>> On 11/04/2024 11:16, Binbin Zhou wrote:
> >>>>> Add Loongson PWM controller binding with DT schema format using
> >>>>> json-schema.
> >>>>>
> >>>>> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> >>>>
> >>>>
> >>>>> +properties:
> >>>>> +  compatible:
> >>>>> +    oneOf:
> >>>>> +      - const: loongson,ls7a-pwm
> >>>>> +      - items:
> >>>>> +          - enum:
> >>>>> +              - loongson,ls2k0500-pwm
> >>>>> +              - loongson,ls2k1000-pwm
> >>>>> +              - loongson,ls2k2000-pwm
> >>>>> +          - const: loongson,ls7a-pwm
> >>>>> +
> >>>>> +  reg:
> >>>>> +    maxItems: 1
> >>>>> +
> >>>>> +  interrupts:
> >>>>> +    maxItems: 1
> >>>>> +
> >>>>> +  clocks:
> >>>>> +    maxItems: 1
> >>>>> +
> >>>>> +  '#pwm-cells':
> >>>>> +    description:
> >>>>> +      The first cell must have a value of 0, which specifies the P=
WM output signal;
> >>>>
> >>>> If you have always the same value in PWM phandle, why encoding it in=
 the
> >>>> phandle in the first place? What's the benefit of passing 0?
> >>>
> >>> Hi Krzysztof:
> >>>
> >>> My thoughts are:
> >>> First of all, our pwm has only one output signal, so it can only be 0.
> >>> Also, as you know from the pwm xlate function, the first cell is the
> >>> pwm index, so I fixed it to be 0 here.
> >>>
> >>> The xlate function:
> >>> https://elixir.bootlin.com/linux/v6.8/source/drivers/pwm/core.c#L106
> >>
> >> You refer for xlate for PWM with three cells. You do not have three
> >> cells, as you have only on signal, so why insisting on using other
> >> xlate? Do you do the same for clocks? Or resets?
> >>
> >> I don't think you use appropriate argument in this discussion. We talk
> >> about hardware and your argument "I don't want to use my own xlate in
> >> the driver" is about driver.
> >>
> > Hi Krzysztof:
> >=20
> > Thanks for your comments.
> >=20
> > Emm... Indeed, I used to think about it from the driver's perspective.
> > From the binding perspective, two cells really should be more appropria=
te.
> > I try to make the following changes in the next version patchset:
> >=20
> >   '#pwm-cells':
> >     description:
> >       The first cell is the period in nanoseconds;
> >       The second cell flag supported by this binding is PWM_POLARITY_IN=
VERTED.
> >     const: 2
> >=20
> > Accordingly, the custom xlate function will be used in the driver.
>=20
> If your other, upcoming variants had more PWM outputs, then I would find
> reasonable keeping cells=3D3 to have one approach for all of them. But I
> guess that's not the case here.

There is an easy way to get rid of the 0, just use chip->of_xlate =3D
of_pwm_single_xlate; Having said that, I don't particularily like that.
If it wasn't for dt bindings being stable I'd argue for all PWM chips to
use #pwm-cells =3D <3>; and accept that the 2nd field is zero for
consistency.

Some statistics:

There are only two drivers that use of_pwm_single_xlate:
 - drivers/pwm/pwm-pxa.c
 - drivers/gpu/drm/bridge/ti-sn65dsi86.c

There is one driver that uses a completely custom xlate function (and
#pwm-cells =3D <1>, to specify the pwmid; the period is fixed):
 - drivers/pwm/pwm-cros-ec.c

All 65 other drivers use #pwm-cells =3D <3> with the "usual" semantic. At
least 21 among them only have a single output and so always use 0 in the
2nd cell.

So I'm all in favour to stick to the approach used in this binding for
the sake of consistency among the drivers^Wbindings.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--i4ouf7pscroqa5m7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYX//MACgkQj4D7WH0S
/k5hYAgAl73szsvM5vALB+37WjqD5T0wFgC7QiGMtiol4cvOUHeLNfaUU45bfAlD
iMKEZjMjecR1GSc1G4lCFcmc83KpHenLdalMXvEva/LEa+u325JY9Xng3y0WY+MX
iQ11DCnD1MJh/O09E89BcgzjgAYCQcwwL8e+v9SQvK38RWqI+n7NVubiW1pfLtxZ
r6er3I3vpbiJ44tmnKi5ush0DXOXYCZYk2iIljAoMsNVugtSDB5CSZVIisO0KV3U
r26FtpeqigeHpgepz9SG9YLNkJH19Ur2Cr954ZD/xpC8xk3cBdAt/CST0IAKsTr4
G8kagvYuwM0kaBU2MYmgML6JZM74SA==
=JJWz
-----END PGP SIGNATURE-----

--i4ouf7pscroqa5m7--

