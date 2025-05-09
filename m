Return-Path: <linux-pwm+bounces-5880-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0696AB1D69
	for <lists+linux-pwm@lfdr.de>; Fri,  9 May 2025 21:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E18AE1C40A91
	for <lists+linux-pwm@lfdr.de>; Fri,  9 May 2025 19:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF8E25DCFE;
	Fri,  9 May 2025 19:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3Aqll5P"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27FB1E1DE8;
	Fri,  9 May 2025 19:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746819839; cv=none; b=nUmhIcNWxyTfd+Ct/Pq78H9RW9usYfAq79b0U3hTiu7o+84A4Mx5TnYJxqbKIQ8r7z5A1ZB18LE+zPeYb8/AxFj6cM6IjCvb8Z+lUlNW4qjN9zq0oV6/EWGQsscMNO9aZ4XJQchxhPgQWiAIEYbBuCG3ZFtclhtK/0TVr626RPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746819839; c=relaxed/simple;
	bh=+ctr+VxutKdvpQrbAZLprliIoOY5xsaFX13IBaOKFYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fs9m1QzIFmX1RwCPzyJlnDH4bQ/4ujieX6E7uPC0JXs7n/cWBTCNAs5FMQyQemsADXL7q7tK0vDKKpEy3kCrLTyHw6QEj1RvzhOY6WlZMaOkRDjUOqO3li7nHvx809UpsbWkqdxsAoct6z2y7cu0eqm6OqBXJAJSnemwfY28w/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3Aqll5P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D81EC4CEE9;
	Fri,  9 May 2025 19:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746819839;
	bh=+ctr+VxutKdvpQrbAZLprliIoOY5xsaFX13IBaOKFYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g3Aqll5PXDGCn1YLqJO5MMfv8hpyctk5XuNbKZCKQo31cb7WU0os1HQ9N0UnecyH0
	 apbFEGkkWAjd9zIUm1bQnTaf5nST+8Ze7ClKaIIQ6Z2Sh932uRhTcV4G5xHkIOw7OC
	 lmYc83vAbSNl8ZaJKtm0beQV3RfzyMQ3Q4KLjGRCAjDTGtYp/8zbGDJl9kszhi1RNa
	 ZhkjUAZDfDEXXSuVJ8h03TMMMECJ2qCUz5r6rAKQNJ3+QTv5VvgaUhYajvSwWoECDS
	 DbpcEdz0Mq9Bs7+F3VLo5x1jBx5cuN3n4VVowO+P/UBJ9eU7aIY5uN4F74v8AfAG9r
	 bilj3BncP9TVg==
Date: Fri, 9 May 2025 21:43:55 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Benjamin Larsson <benjamin.larsson@genexis.eu>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH v12] pwm: airoha: Add support for EN7581 SoC
Message-ID: <pbutokheq6zm4gzjzvhhmxvnse3uudb5obpuyd55z7emlm3pju@7l7hocoktu37>
References: <20250407173559.29600-1-ansuelsmth@gmail.com>
 <q46vqvt4ebepk47as3vhx24fqfnv2ollatjzjw5hbxtcbaklff@exkozghztvlv>
 <681dfd1e.170a0220.1d9a3f.15ad@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wnvhn7ztzwmbzgi2"
Content-Disposition: inline
In-Reply-To: <681dfd1e.170a0220.1d9a3f.15ad@mx.google.com>


--wnvhn7ztzwmbzgi2
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v12] pwm: airoha: Add support for EN7581 SoC
MIME-Version: 1.0

Hello Christian,

On Fri, May 09, 2025 at 03:03:23PM +0200, Christian Marangi wrote:
> thanks a lot for the review. I was just starting reviewing some patch on
> patchwork so I could remove some work from you but you were faster...

You're still invited to comment ...
=20
> On Fri, May 09, 2025 at 12:39:37PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Mon, Apr 07, 2025 at 07:35:53PM +0200, Christian Marangi wrote:
> > > +static void airoha_pwm_get_ticks_from_ns(u64 period_ns, u32 *period_=
tick,
> > > +					 u64 duty_ns, u32 *duty_tick)
> > > +{
> > > +	u64 tmp_duty_tick;
> > > +
> > > +	*period_tick =3D div_u64(period_ns, AIROHA_PWM_PERIOD_TICK_NS);
> > > +
> > > +	tmp_duty_tick =3D mul_u64_u64_div_u64(duty_ns, AIROHA_PWM_DUTY_FULL,
> > > +					    period_ns);
> >=20
> > So period can be set to multiples of 4 ms. If you request
> >=20
> > 	.period_ns =3D 11999 ns
> > 	.duty_ns =3D 4016 ns
> >=20
> > the hardware should configure=20
> >=20
> > 	.period =3D 8000 ns
> > 	.duty_cycle =3D 4015.6862745098038 ns (i.e. 128/255 * period)
> >=20
> > corresponding to period_tick =3D 2 and duty_tick =3D 128.
> >=20
> > However you calculate duty_tick =3D 85.
> >=20
> > I would expect that with having PWM_DEBUG enabled you get a warning when
> > you do:
> >=20
> > 	pwmset -P 8000 -D 4016
> > 	pwmset -P 11999 -D 4016
> >=20
>=20
> I addressed all the other comments but this is the only thing that I'm
> confused about.
>=20
> Where 85 comes from?

4016 * 255 / 11999 -> 85. The problem I suspected is that duty_tick is
calculated using the requested period value instead of the real one.

> I tested your command and I can correctly observe the values getting
> set to the expected tick.

I didn't recheck in detail and now I'm unsure if that really happens
because period_ns might be already round to a multiple of 4 ms?
=20
> And I don't have the idempotent warning from PWM debug.
>=20
> With period =3D 8000 and duty to 4016, period tick is set to 0x2 and duty
> is set to 0x80 (128)
>=20
> When PWM debug repply the configuration and read the state, it gets
> period 0x8000 and duty 4015,687.
>=20
> And those are the expected values. Am I missing something here?

If you don't get the warning, you most probably only miss that I
misjudged the code :-)

Best regards
Uwe

--wnvhn7ztzwmbzgi2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmgeWvgACgkQj4D7WH0S
/k7ybAgAoC5qkDheAJEB8dWOAQUByinfG0JM9hMhzLzmcJYrkHIFq7BefD0JldS6
RGHTxqAsWdU0bbbjUY4SU3g1kLYYutqdtb5nrhlPpzVxFhQyRsKEgGj/nLYFOUnB
ihMfwGGh8puCR/Ghg76K529TeOlPFO3q2iLPpRsfKjRMmY2Lsu7dBg1/NlTefOrj
alu2nzV/m8Yh18JNw5weSpspr4u1iCjYrMZPI/twYMao6VFPOBg8ARLK/rUo47LF
cRHCUIu3IrH+fea248J+i0VZp2++Jid/ITspAvL2C5PTBme5mGDoS+oV8S8SGUTl
nU76C9CE1xuDZ3t/NN5qHakxI4Oosw==
=cW+x
-----END PGP SIGNATURE-----

--wnvhn7ztzwmbzgi2--

