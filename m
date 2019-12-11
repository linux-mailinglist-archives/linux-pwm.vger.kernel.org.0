Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B52C411A6A1
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Dec 2019 10:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbfLKJUY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 11 Dec 2019 04:20:24 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:59127 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726983AbfLKJUY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Dec 2019 04:20:24 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 9DBEE222DC;
        Wed, 11 Dec 2019 04:20:22 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 11 Dec 2019 04:20:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=ySBDIdCmN4b66v2rt406sMgYC+s
        60FnStsfbyOUEeeg=; b=lK3T3o0giemtq3YQD+fdy6n4+Y/JbEWxUJb9bw8gReN
        n5F4wacWdJPv+fNbXUmgQinwkM9DbNryV6OY6tdKGxVpHYUdXtafvkKVXWXghBi5
        +AjSUVkQi9IMtFpRpiGiWnvlg3aQw/IMICrFDHqLhVgrYDMyC8CzJxglgzzrRxX+
        U844BRkkEdHObMkqKEmcu6GjwpRofqQ1Ij2zk3JtvEkIis/R67mWvhgTTm2aSWck
        +xV2O5CAhrMxO4Nrf5Vx89Jg3/HSP+8oqcyOi9o2Z4w8xRymjKJWCPTYlXREzRhx
        ASEsNnwajSU36b8S1oABFe7b3PLasijc5QjFGZIck1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ySBDId
        CmN4b66v2rt406sMgYC+s60FnStsfbyOUEeeg=; b=i8CiQ1AekbDbtnMa1MAQlH
        jJNEnytU+axw0liKJijffIqf5hg3KCBDAiDwHWXp15UBNzTV8Yn2EdYe2GzQwXzU
        6RJ+SRSP+nANzWN86Kb+sssedgXVhJ0Jws4cNLnE41gbrLXvettTicKNcB0Ij3Mo
        eE1J8BWjhGab3l1QQO1o0QT+BRoHUiTkPNob8GXqJaDOypWGy431TtehIBz0SdiQ
        4KskTGurDGlcPoDI0eluej4hEY1d0H1MfZwva/qYQWe/ZP+s2eQqdZE/rxnxJarJ
        37NE5cRITLcDBtZA7PgGHV9pCN35ZrcbabQ7xnwzZpdRqwhNc6luWaOOMHBgdMUw
        ==
X-ME-Sender: <xms:07TwXUWgUUFvb1atOGXCsPcKBwfuNGuUrQlyiAVeD59E5yyHpMOrbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudelgedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkpheple
    dtrdekledrieekrdejieenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegt
    vghrnhhordhtvggthhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:07TwXdhN2bVbCV7eHGBM5QkkmlxgQ1jPByWumAuN-sSI-u70vGTX6w>
    <xmx:07TwXQhImlbXa9AqY88BnXKuo4po4AT1C-yf1ChICA5zl8C8NeOBCQ>
    <xmx:07TwXTxRgR3W0QjStv0V5nLeYZsd66UbpuwfPYpi01bmrGLaXjJ_hw>
    <xmx:1rTwXT2rlkpc4W9MzzJ5PJkn4VGknYNT8XaJngsRlGFujWfsGf2LYg>
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1A7E88005B;
        Wed, 11 Dec 2019 04:20:19 -0500 (EST)
Date:   Wed, 11 Dec 2019 10:20:16 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: pwm: allwinner: Fix missing header in H6
 example
Message-ID: <20191211092016.2hhjw6mn7iefupql@gilmour.lan>
References: <20191210174710.10649-1-peron.clem@gmail.com>
 <20191211080633.a6yzwbxi7fcmislp@gilmour.lan>
 <CAGb2v66mWgDKyZEWVVYqq5McOaYmiY0PSP7iXE8TBtVZv03u1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tt72ar2obv6t5rpi"
Content-Disposition: inline
In-Reply-To: <CAGb2v66mWgDKyZEWVVYqq5McOaYmiY0PSP7iXE8TBtVZv03u1Q@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--tt72ar2obv6t5rpi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2019 at 04:33:19PM +0800, Chen-Yu Tsai wrote:
> On Wed, Dec 11, 2019 at 4:06 PM Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > On Tue, Dec 10, 2019 at 06:47:10PM +0100, Cl=E9ment P=E9ron wrote:
> > > Latest linux-next doesn't build due to the following error:
> > >
> > > Error: Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.=
example.dts:35.37-38
> > > syntax error
> > > FATAL ERROR: Unable to parse input tree
> > > make[1]: *** [Documentation/devicetree/bindings/pwm/allwinner,sun4i-a=
10-pwm.example.dt.yaml]
> > > Error 1
> > >
> > > This is due to missing header in the device-tree yaml example.
> > >
> > > Fix this by adding the missing headers.
> > >
> > > Fixes: 4ee929b3f08e ("dt-bindings: pwm: allwinner: Add H6 PWM descrip=
tion")
> > > Reported-by: Rob Herring <robh+dt@kernel.org>
> > > Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> >
> > Applied, thanks!
> > Maxime
>
> Maybe squash it instead? :)

Indeed, I just did.

Thanks!
Maxime

--tt72ar2obv6t5rpi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXfC00AAKCRDj7w1vZxhR
xaW5AQD69VlsGmpCynvOIn/zNXum5pWnY3SEEbx2GLYyZPdLZQD/TXS6GjJD2+MJ
MiEEHgbac/j7/sn/oCxDjRN5XAUaoQg=
=9JT0
-----END PGP SIGNATURE-----

--tt72ar2obv6t5rpi--
