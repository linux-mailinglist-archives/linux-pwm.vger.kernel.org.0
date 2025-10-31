Return-Path: <linux-pwm+bounces-7572-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E368C2484D
	for <lists+linux-pwm@lfdr.de>; Fri, 31 Oct 2025 11:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AE199345BCF
	for <lists+linux-pwm@lfdr.de>; Fri, 31 Oct 2025 10:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CAF33F8DD;
	Fri, 31 Oct 2025 10:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTUrI/kp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1BB327214;
	Fri, 31 Oct 2025 10:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761907114; cv=none; b=i5oYK1Bgk/AG73dM18jZMMUu+t7DqjNPGzPVkkQmAmFz/jH3jPlYAazkcr6KjFgYTrFezhLbqyWcsgzT9Vvlyr92QKCH9i7lqeCIj/pqf3lxubkzhsyxOct3MQfKsKjOaOd+KddnEDnRbiuhXXY35nCMLHzCL6BaUhubXw2PyeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761907114; c=relaxed/simple;
	bh=pCW3mqiYKpJ+hdcxPaMD/6xe2J8m7xgEe48dlvDZ3gY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shnnbyq9qK5vLxpSPz09Cz1UTHLsL5XRmaFLm9AU8JVjKHV87ERo590g6FgJSWzRdoBlXyfwiqkdozMO8fY2sHVxIL2PQbvzSngtAeio2oiQsFTWOL1vZSZK51W4Em770/kOe7i52z2awEk/3pGiekYrytE/DBCFYQB791j0/oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTUrI/kp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372BFC4CEF8;
	Fri, 31 Oct 2025 10:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761907113;
	bh=pCW3mqiYKpJ+hdcxPaMD/6xe2J8m7xgEe48dlvDZ3gY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JTUrI/kpTP1FK7p2e+8hPfAZy7ga0BoJ9cSl7qZorGTNxxiKLgt6MZyK57ZH1Lr07
	 6tcdKn+x6niUhnZl8r++Hx6gZMQvGcURlMLzPbdJefISbiIGWao0PzaldpHaRet2Pi
	 Cq4+XtreH74oI49663XJEq8RhZy81HhMOo7ZF/v+h4a6GB9KlbXGyTSpmtPy28ONnE
	 jR8BK8GJZqikTWRoRhv8xMpUxdqL6rTxF7QAawZaDAAcj8QW+gwoolUfWPi8C5eKSL
	 s3Cenygcd5JjViuZ8K86iaUzocAk7iBxH3mc40jbKfBca0ugRTaQX5nIvmzjKiblQq
	 H5F94Oe9DISAw==
Date: Fri, 31 Oct 2025 10:38:24 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jack Hsu <jh.hsu@mediatek.com>, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, srini@kernel.org,
	ukleinek@kernel.org, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, daniel.lezcano@linaro.org, tglx@linutronix.de,
	chunfeng.yun@mediatek.com, wim@linux-watchdog.org,
	linux@roeck-us.net, sean.wang@mediatek.com,
	zhiyong.tao@mediatek.com, andrew-ct.chen@mediatek.com,
	lala.lin@mediatek.com, jitao.shi@mediatek.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pwm@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v6 07/11] dt-bindings: usb: Support MediaTek MT8189 evb
 board xhci
Message-ID: <20251031-overbid-renounce-e6f3b03ee18f@spud>
References: <20251030134541.784011-1-jh.hsu@mediatek.com>
 <20251030134541.784011-8-jh.hsu@mediatek.com>
 <20251030-underwent-courier-1f4322e1cb34@spud>
 <20251031-nifty-sticky-hoatzin-eeafeb@kuoka>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YeQbD5mvaLkqbUCf"
Content-Disposition: inline
In-Reply-To: <20251031-nifty-sticky-hoatzin-eeafeb@kuoka>


--YeQbD5mvaLkqbUCf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 09:19:26AM +0100, Krzysztof Kozlowski wrote:
> On Thu, Oct 30, 2025 at 07:32:26PM +0000, Conor Dooley wrote:
> > On Thu, Oct 30, 2025 at 09:44:39PM +0800, Jack Hsu wrote:
> > > modify dt-binding for support mt8189 evb board dts node of xhci
> > >=20
> > > Signed-off-by: Jack Hsu <jh.hsu@mediatek.com>
> > > ---
> > >  .../devicetree/bindings/usb/mediatek,mtk-xhci.yaml         | 7 +++++=
+-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.=
yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> > > index 004d3ebec091..05cb6a219e5c 100644
> > > --- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> > > +++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> > > @@ -34,6 +34,7 @@ properties:
> > >            - mediatek,mt8183-xhci
> > >            - mediatek,mt8186-xhci
> > >            - mediatek,mt8188-xhci
> > > +          - mediatek,mt8189-xhci
> > >            - mediatek,mt8192-xhci
> > >            - mediatek,mt8195-xhci
> > >            - mediatek,mt8365-xhci
> > > @@ -119,6 +120,9 @@ properties:
> > >    resets:
> > >      maxItems: 1
> > > =20
> > > +  reset-names:
> > > +    maxItems: 1
> >=20
> > Is this reset required on mt8189? Does it appear on other mediatek xhci
> > controllers?
>=20
> reset was there, it is the name added for some unknown reason.

Ah, so not helpful at all since no name is defined and therefore making
the property unusable :)

--YeQbD5mvaLkqbUCf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQSRnQAKCRB4tDGHoIJi
0kPCAP96dXVUKgWcbJl1yhQ4f4EkFhlKfrn2Z7Gj6M2yxhUAZwD/XjwGvcKdjEOk
OaeQJhtXQLUywWYtJY6pBr35YwUCWQo=
=AXz7
-----END PGP SIGNATURE-----

--YeQbD5mvaLkqbUCf--

