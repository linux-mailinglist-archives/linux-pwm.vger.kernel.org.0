Return-Path: <linux-pwm+bounces-4700-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F9EA18F19
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Jan 2025 11:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73E46188C05B
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Jan 2025 10:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F181C3F04;
	Wed, 22 Jan 2025 10:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ji74LSfJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E18136A;
	Wed, 22 Jan 2025 10:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737540206; cv=none; b=RoKdl6mdbJb0KcdSHcrDGCWyeA5KnZZ4yUh1lJ5LLsFAra4kVKKMpugMeQfpzsTybPyJm76aJpmJkX+Wc7FDP9CG6xHW+4k9xUGQA/iqgcCjuodgL1koUJA8fSF8JuEr7hfEPnMW4DXWedBiDtPHRS/boxtZGBcOdXWe9UgEGEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737540206; c=relaxed/simple;
	bh=Dtna4X4kUOTIn/2TE5vGjCOO4vkwDc6jwkfCRfVrpKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcbqlNZs0x2dSg/NKMGh3QimcE/J9KPcW1FrmATtbb8yHNGSkMnMBKNzzR9iGNBlzdG5cyA45ClfvcIrjWYtT/Bt4+RMwZcQ47JFsYQ2QgODc9P03oBCm0vHS0CMu/mbq2+vimRjUCGpRnHzmzDqv71u+VLP3NDguHw/D7lFmns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ji74LSfJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26600C4CED6;
	Wed, 22 Jan 2025 10:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737540205;
	bh=Dtna4X4kUOTIn/2TE5vGjCOO4vkwDc6jwkfCRfVrpKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ji74LSfJVkRnyAqWpsATfujRQZH0P4tlRY+6ea3/hknDY3aO0WaocKjlcmU8P3kES
	 zkyBt1CjiQIK72ZjLTnmdh7UAK6t8iK2OjxGiRNleasyfcnNC2w78IhHYWYJ8eUzYS
	 15UcMapTO/b9tXWUgdIZ9Jxus/GeARMkhbUNhLOPkEM9E4d1bDTOqtO9H9bA5jCN8m
	 zV9WYXmrpdquWrr0SlMoE3x2faSRe/od2/h9V8wgojFA8EP/1XtETu1KJ6OB4iEvi/
	 7/gVMKdYGfcoGZtL73MRl4iorRI+yu9yUER62a5l/dvCN37GdVvzk+T7TmlLunr2r8
	 M+pxM6F1iflEQ==
Date: Wed, 22 Jan 2025 11:03:22 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Chen Wang <unicorn_wang@outlook.com>
Cc: Chen Wang <unicornxw@gmail.com>, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, inochiama@outlook.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	chao.wei@sophgo.com, haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, 
	chunzhi.lin@sophgo.com, Sean Young <sean@mess.org>
Subject: Re: [PATCH v6 2/3] pwm: sophgo: add driver for Sophgo SG2042 PWM
Message-ID: <dlnfivdhol7faotaqygpvdi2zbgpwrvcruppbkgfleoa6msxib@voe7dhqvfmy6>
References: <cover.1733281657.git.unicorn_wang@outlook.com>
 <4a7db3ecac9ac2b00c063360334834d6656672e3.1733281657.git.unicorn_wang@outlook.com>
 <e2we4klv7w234zyc4vnbcydieyhcte63sdwcp43vmolmlasv5f@scsiepnnw3db>
 <BM1PR01MB2545319120D9B3932C8C8806FEE12@BM1PR01MB2545.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5rqt2gca63irfwgt"
Content-Disposition: inline
In-Reply-To: <BM1PR01MB2545319120D9B3932C8C8806FEE12@BM1PR01MB2545.INDPRD01.PROD.OUTLOOK.COM>


--5rqt2gca63irfwgt
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 2/3] pwm: sophgo: add driver for Sophgo SG2042 PWM
MIME-Version: 1.0

Hello,

On Wed, Jan 22, 2025 at 04:58:26PM +0800, Chen Wang wrote:
> On 2025/1/21 19:14, Uwe Kleine-K=F6nig wrote:
> > On Wed, Dec 04, 2024 at 11:17:18AM +0800, Chen Wang wrote:
> > > +	ret =3D devm_clk_rate_exclusive_get(dev, clk);
> > > +	if (ret)
> > > +		return dev_err_probe(dev, ret, "failed to get exclusive rate\n");
> > > +
> > > +	ddata->clk_rate_hz =3D clk_get_rate(clk);
> > > +	if (!ddata->clk_rate_hz || ddata->clk_rate_hz > NSEC_PER_SEC)
> >
> > Please add a comment about why you check for > NSEC_PER_SEC.
>=20
> Seems no need to check this (> NSEC_PER_SEC ), I will remove it in next
> version.

The rational is usually that

	mul_u64_u64_div_u64(ddata->clk_rate_hz, state->period, NSEC_PER_SEC)

cannot overflow. Your driver relies on that, too. (Which somewhat
proves that a comment is indeed necessary :-)

Best regards
Uwe

--5rqt2gca63irfwgt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmeQwmgACgkQj4D7WH0S
/k6shAf/fIa202RMQ1Kz8jovEjXgT90JjSA2u7S9Tm5/BH9nwdVWhEKmGiUDt+PW
x2wPFGiwq08fsW3RVGuXA1sZMQmYnAm3K0gsNh9XNr557m5jW/u+yGw4WI16VDLk
GACo6JbF1yQ/C5FJqmi+m9+5cx5fRR1/ISVo27hQegVxl0g7M673FLOLTwv2frMQ
KwYqvRUzgL3A3GW0IPiUuDYclqCI9kWi2E3lr6acoYwI9s3RvewJ27M9EtO1tKCk
YDpyhU/0WeZQB49lv1oc0RmXDaT70v1Asv0HMX8QN4jS4EIVUPTF3Nsl/wxXPe0y
Kg3T05a+4P4pB6gHuDMTdUVgqpGvwA==
=/wBO
-----END PGP SIGNATURE-----

--5rqt2gca63irfwgt--

