Return-Path: <linux-pwm+bounces-7595-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3838C375F8
	for <lists+linux-pwm@lfdr.de>; Wed, 05 Nov 2025 19:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A3701A21D52
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Nov 2025 18:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146F82BE7D9;
	Wed,  5 Nov 2025 18:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ls6BkYyp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9FC29D27E;
	Wed,  5 Nov 2025 18:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762368521; cv=none; b=GKCiOiyqmQBpEr5HvEhb6bVPKDz29OQMA/YjXoGYzv+OroG4PqYw79j5chRkZVzK7iZZ6DheEW1pDfI1KPip7kjwwl945W2QoeQuNlP3uaPGGstv2D6RkXjrVNxrOzcoVmgARBsOUCzeuHy6wJ3l5pNoetd6vu5fF8bPZnrjpek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762368521; c=relaxed/simple;
	bh=QpAk4E6BGFif1XF3W70SXRZPyO+sXGIfN3AUjg8WOro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4UctUxAN+lHNmqMAb34dt1W0vqCQVr5uVH66rbg7oqMe446iO/T4uSoskRqhSeLejnlttS2zr75/UVqkvMTwlRdxQlbReZ3VA/HUYorWjfXgOmrriqmv+2ivhSiykQnCyianNVMzNS3FprzvwBRy+HvpYK9J5PNnOrj6UrK+Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ls6BkYyp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597D9C4CEF5;
	Wed,  5 Nov 2025 18:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762368520;
	bh=QpAk4E6BGFif1XF3W70SXRZPyO+sXGIfN3AUjg8WOro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ls6BkYyp/6FP75ZGgQ207aC8eZckuU4XR1qRbSNT8HlQAadjHGF00GBc/40GwG1RU
	 xG8nvLZW6LlEHGodtR3NrkVPcEuqxAp6BzTArrd6qrCHY4bysMhzbEeX5qxPV2jsXq
	 AlRDRsfSojvI5M4jKOC94Uly3RFI5MVN7HMHz7u/P24VE1PM9HZhDa1Vg/Ro3GDY8F
	 K4DM1Yj3MiNNcASKXn+tZ33u80kfNBwF6oEKGFFa/GiGGjHNBi5wQDVVJ3kCZYDPsn
	 fzK5w2HwfqPUdoO0NWhZn+zLtwPgVG1gIixLE+mHYoYowDQDaLEb2K9CufccqKYIor
	 YcNAt2HB/9/0g==
Date: Wed, 5 Nov 2025 18:48:32 +0000
From: Conor Dooley <conor@kernel.org>
To: Jh Hsu =?utf-8?B?KOioseW4jOWtnCk=?= <Jh.Hsu@mediatek.com>
Cc: "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
	"ukleinek@kernel.org" <ukleinek@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"wim@linux-watchdog.org" <wim@linux-watchdog.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andrew-CT Chen =?utf-8?B?KOmZs+aZuui/qik=?= <Andrew-CT.Chen@mediatek.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"nuno.sa@analog.com" <nuno.sa@analog.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Chunfeng Yun =?utf-8?B?KOS6keaYpeWzsCk=?= <Chunfeng.Yun@mediatek.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	Zhiyong Tao =?utf-8?B?KOmZtuW/l+WLhyk=?= <Zhiyong.Tao@mediatek.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"andy@kernel.org" <andy@kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	Sean Wang <Sean.Wang@mediatek.com>,
	Lala Lin =?utf-8?B?KOael+engOiKrCk=?= <Lala.Lin@mediatek.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"dlechner@baylibre.com" <dlechner@baylibre.com>,
	"srini@kernel.org" <srini@kernel.org>,
	Jitao Shi =?utf-8?B?KOefs+iusOa2myk=?= <jitao.shi@mediatek.com>,
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux@roeck-us.net" <linux@roeck-us.net>
Subject: Re: [PATCH v6 00/11] Add mt8189 dts evaluation board and Makefile
Message-ID: <20251105-unbolted-kosher-8812a5349106@spud>
References: <20251030134541.784011-1-jh.hsu@mediatek.com>
 <20251030-deodorant-unglazed-190cbfb4a69b@spud>
 <d75decc54a4fc129e5f011cd6e91191896203b48.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZsHRXwF3s1ooiJYk"
Content-Disposition: inline
In-Reply-To: <d75decc54a4fc129e5f011cd6e91191896203b48.camel@mediatek.com>


--ZsHRXwF3s1ooiJYk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 05, 2025 at 07:06:50AM +0000, Jh Hsu (=E8=A8=B1=E5=B8=8C=E5=AD=
=9C) wrote:
> On Thu, 2025-10-30 at 19:49 +0000, Conor Dooley wrote:
> > On Thu, Oct 30, 2025 at 09:44:32PM +0800, Jack Hsu wrote:
> > > In this patch series,=20
> > > we add Mediatek MT8189 evaluation board dts, dtsi and Makefile,
> > > and also related dt-binding documents.
> > > Jack Hsu (11):
> > > =C2=A0 dt-bindings: arm: Add compatible for MediaTek MT8189
> > > =C2=A0 dt-bindings: iio: adc: Support MediaTek MT8189 evb board auxadc
> > > =C2=A0 dt-bindings: nvmem: Support MediaTek MT8189 evb board efuse
> > > =C2=A0 dt-bindings: pwm: Support MediaTek MT8189 evb board disp-pwm
> > > =C2=A0 dt-bindings: serial: Support MediaTek MT8189 evb board uart
> > > =C2=A0 dt-bindings: timer: Support MediaTek MT8189 evb board timer
> > > =C2=A0 dt-bindings: usb: Support MediaTek MT8189 evb board xhci
> > > =C2=A0 dt-bindings: watchdog: Support MediaTek MT8189 evb board wdt
> >=20
> > Please drop mention of the evb from all of these commit messages. The
> > compatible has nothing to do with the evb board, it's going to be
> > common
> > across all boards using an mt8189.
> >=20
> > > =C2=A0 arm64: dts: mediatek: Add MT6319 PMIC Support
> > > =C2=A0 arm64: dts: mediatek: add properties for MT6359
> >=20
> > Wait a minute, what are these two patches even doing in this series
> > in
> > the first place, when it is otherwise about the mt8189?
>=20
> mt8189 evb board include mt63xx.dtsi,=C2=A0
> and the dtsi files maybe for other boards in the future,=C2=A0
> ie. mt8189/81xx custom/OEM/ODM boards.
> Should i separate those two patches as a new patch series ?

They seemed unrelated to your series and poor quality to the point that
they looked like an accidental inclusions, given there's no mention of
them in the cover letter. Since they do appear to be related, sure keep
them. That said, the "add properties for MT6359" patch is in need of
major rework, so you'll have to rework it.

--ZsHRXwF3s1ooiJYk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQub/wAKCRB4tDGHoIJi
0ir6AP90xu+aGanLuoK0WwBJq4K8acOpc3uO0VRr/ryQ3e1A0AD8DQUJX5vyOEmp
5sMx4n5jdewxF92Mn27H8usu0gybwAQ=
=oepw
-----END PGP SIGNATURE-----

--ZsHRXwF3s1ooiJYk--

