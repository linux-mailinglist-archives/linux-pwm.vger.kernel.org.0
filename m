Return-Path: <linux-pwm+bounces-4781-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCAEA2966F
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 17:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 103C53A2C7A
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 16:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB2418A6BA;
	Wed,  5 Feb 2025 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8YpoFAh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9358634A;
	Wed,  5 Feb 2025 16:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738773222; cv=none; b=Jvmh/+b8ij8dic86GDcoJGFuGsZkD72QcJbqij/UvDqPBe6sBjwJvWMlT5UPV5nDMyh1VfQ1rCZyrf/4loMsfuDYLWzYF5DrTftrAXAJAcTb/1tnDi8dgAJnsjJJ+yRneIBGKgeZJ2k+h3cfnKj7CK8ypnYvIlR8f4706eb82aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738773222; c=relaxed/simple;
	bh=b5FN7Zyasw9i6k/qcwNoo9FUtmrLQ8B6OivoODJIKDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jo8BSwTjDlHi4x91iWm9G0ROf24uaAfMsOze/LIOxPCl5kRMWjpEm7cLFJaHIRSrnVS9KSNp8AMYY6+RKnWAPPNbX4ZoXZMUiFjVPY+MbQ1cyRjLg/odrliiXTc4917c2NfJKpecokfzLoOJMoZBM73RxpDaxil/0M8tWln9srg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8YpoFAh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22FDC4CED1;
	Wed,  5 Feb 2025 16:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738773221;
	bh=b5FN7Zyasw9i6k/qcwNoo9FUtmrLQ8B6OivoODJIKDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f8YpoFAhfLezEahtdBWj0U53UKdwR0eKTTpmFc45NYdUJd4kEArGbxvC7zWh4W3EJ
	 ipI44W0xTeEkgpdHil7mH4HwQnFgRvq/59rc1JsG76rCfk/QLSU0VbPPlYKOiw9kOu
	 RwBRKK24eF5jwlxMK7k5kkfd0h6kCao4ozQJ891u4aTnxK/HOAiCBNZAlmq8OdcPWR
	 ubS/SCeFpU15OTaRQmG31CeEDMG0Xl+vO61Fy0jIvAjJNO+nzE7341nSFqlNxMDDPi
	 iJaVF3/W+nrON3KOqHpC6OBiA3uiGZdW7GEagW2vjSn9fI4PKDuLOXVJdeEij7cuXO
	 LsMffDRf0nsBQ==
Date: Wed, 5 Feb 2025 17:33:38 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Chen Wang <unicorn_wang@outlook.com>
Cc: Chen Wang <unicornxw@gmail.com>, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, inochiama@outlook.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	chao.wei@sophgo.com, haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, 
	chunzhi.lin@sophgo.com, Sean Young <sean@mess.org>
Subject: Re: [PATCH v7 2/3] pwm: sophgo: add driver for Sophgo SG2042 PWM
Message-ID: <o4j72fdw6v6aiuvgeufugzptmfpmpws26zp5bf27hdq2i6cng5@yqmdasof3ynp>
References: <cover.1738737617.git.unicorn_wang@outlook.com>
 <ae8ea1bf0bb0a09336cd8b7f627a994630524bba.1738737617.git.unicorn_wang@outlook.com>
 <ivgsidvdx2ypntnlopww6fiwyuzj2sadt3znyofr54dsz3c5d4@3mr25vhwlwy3>
 <PNXPR01MB7488BA555BDE96E59741DBACFEF72@PNXPR01MB7488.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gcbt5fz4vt234fhk"
Content-Disposition: inline
In-Reply-To: <PNXPR01MB7488BA555BDE96E59741DBACFEF72@PNXPR01MB7488.INDPRD01.PROD.OUTLOOK.COM>


--gcbt5fz4vt234fhk
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 2/3] pwm: sophgo: add driver for Sophgo SG2042 PWM
MIME-Version: 1.0

Hello,

On Wed, Feb 05, 2025 at 08:57:20PM +0800, Chen Wang wrote:
> On 2025/2/5 18:06, Uwe Kleine-K=F6nig wrote:
> > I was tempted to apply this patch while reading throug it until nearly
> > the end ...
> >=20
> > > +		reset_control_assert(rst);
> >=20
> > This is wrong (well, or unneeded). With
> > devm_reset_control_get_optional_shared_deasserted() the devm cleanup
> > cares for reasserting the reset.
> >=20
> > > +		return dev_err_probe(dev, ret, "Failed to register PWM chip\n");
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> >=20
> > If you want I can apply and squash the following in:
> >=20
> > [...]
> >=20
> > ack?
>=20
> Ack.

Great. Pushed to=20

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for=
-next

with the suggested fixup.

Best regards
Uwe

--gcbt5fz4vt234fhk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmejkt8ACgkQj4D7WH0S
/k6tmwf/VsE147RXuGyKeMumDiqov5FrMqU5PIEyDnZc7Wz4rEBB71mQ7o0iiSMF
tgfgCnylkVxBX9w9F4AliHkHFPYsQuGv6ibyrBim3M0JCI1M4AMTwpfmbSdPxYm4
GufsQGUIGAIME0Hey4bsHiPFla+LOk02vO9Vcrba1eZDkn9cqfbhhWsOFTe31oR5
EmQLlLt/n5w7JkCrknvMW4MuzSXRCgVgEyqVJyGEKY1ZHR8uxxhgwNTnHmH6Wjne
/bSaEcAtxHyCAkO/vBx9LUdtpR2hbBoDH/80OmXYfWJ+uVWx854v8VBe9Xvuzb41
x2EjvqOV1TcK7+7KZPb8C0D3I5PU8A==
=pX1Z
-----END PGP SIGNATURE-----

--gcbt5fz4vt234fhk--

