Return-Path: <linux-pwm+bounces-5271-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8EBA6EAD5
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Mar 2025 08:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A7D03AD9BF
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Mar 2025 07:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38F01F4C83;
	Tue, 25 Mar 2025 07:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjUpSktb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D328460;
	Tue, 25 Mar 2025 07:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742889006; cv=none; b=Q/F5ypSbomNE+TVecq8IgZPq42VGnba2Uo1btm8OWee0ilpRtz780QV+DGFujW9BAOCAAS+HF3uht6WL8BjGHYMRNyFQ0vHunXHgr011HpCp27oo/Pl86glUiKDEm5NYiBYvTgajYe128eFngmBsSYM3p0gYC9UW4hTuWPB0e+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742889006; c=relaxed/simple;
	bh=gl7aw1gXR43jv6B8C8DV/bzy1B8aMUYob8A9EmYJ0dI=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=pL1KHKT6fXPMgs034ab7bfq+GadCsYwHcdJCT736VCVs2BAHA4PlPlRR96igu+0U7znFyvxsHKzVcpaYNAWAbLY5EAP5spts/Uk7MREIr6114ES486CRG7PydR3vWObuUSmw9/9FBBAmdg3JevDl/3+ImF7nDDFKleKaV8g4HiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjUpSktb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB1AC4CEE4;
	Tue, 25 Mar 2025 07:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742889006;
	bh=gl7aw1gXR43jv6B8C8DV/bzy1B8aMUYob8A9EmYJ0dI=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=gjUpSktbafio8QcZYsqZxOSgzLTrdgCWMi+nnIqkRovKENgOHSdJcxt7Fcp232cO9
	 Go0SzbrvCB7Dvom6tTe7lbLJssaQKa4U1+H6HFwEHcXFjjzulnpnv06RnAFd4d+Sqm
	 WDVCS6Bg8u+lSbcViC0F7oqauQMkG6YjCkb7tGHju3Fose+a8XtdpV4E8ih5eo2Ne+
	 NsSEfqV2F/kGdiTB1FDdMOsFLxJq+Don13mwr6jWAqgKmpf3rodR5pT75KVs0STX32
	 Ahq/iyqClRturu+LvUEx4i8a9BMQ86mIa9/EONx8v73mOWQgpUAHC6edo9FUd7NM32
	 TB/VPu7WEWogg==
Content-Type: multipart/signed;
 boundary=b5386466c50b7c8f35d2b14e7321876c2e3b218f6e31ca8e0fea76d5f944;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Tue, 25 Mar 2025 08:50:02 +0100
Message-Id: <D8P6L65D69PS.1VQKHJJA8TNL4@kernel.org>
Subject: Re: [PATCH v5 06/11] gpio: regmap: Allow to allocate regmap-irq
 device
Cc: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-input@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <andriy.shevchenko@intel.com>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>
From: "Michael Walle" <mwalle@kernel.org>
To: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>, "Lee Jones"
 <lee@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Kamel Bouhara"
 <kamel.bouhara@bootlin.com>, "Linus Walleij" <linus.walleij@linaro.org>,
 "Bartosz Golaszewski" <brgl@bgdev.pl>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, "Mark Brown" <broonie@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.16.0
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
 <20250318-mdb-max7360-support-v5-6-fb20baf97da0@bootlin.com>
 <D8K23TCWC5TO.3T1YPKL3G0OY5@kernel.org>
 <D8KYF2DZOBT4.1337YU51E0ZKH@bootlin.com>
In-Reply-To: <D8KYF2DZOBT4.1337YU51E0ZKH@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>

--b5386466c50b7c8f35d2b14e7321876c2e3b218f6e31ca8e0fea76d5f944
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

> > > +#ifdef CONFIG_GPIOLIB_IRQCHIP
> >
> > Why do we need this ifdef?
> >
>
> Hum yes, on second thought we probably need to depend on
> CONFIG_REGMAP_IRQ here.

But then, you'd also require the regmap_irq support for chips that
don't support IRQs at all. devm_regmap_add_irq_fwnode() seems to be
missing a stub version.

-michael

--b5386466c50b7c8f35d2b14e7321876c2e3b218f6e31ca8e0fea76d5f944
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZ+JgKhIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/gQDgGAu0gZkp5tnVphjXMlX9N85/T1hedWo0sj
TAci3j5/eirJaHtI2qhUzGDVOpMtgKQjAYCkk3nqGplW+nghtvFBMgj0mKsadvwV
or/OTN6lsHFE7+kc8CUvHgHMA9imk5i/txQ=
=4ggC
-----END PGP SIGNATURE-----

--b5386466c50b7c8f35d2b14e7321876c2e3b218f6e31ca8e0fea76d5f944--

