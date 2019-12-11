Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6981811A593
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Dec 2019 09:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbfLKIGi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 11 Dec 2019 03:06:38 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:55957 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726543AbfLKIGh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Dec 2019 03:06:37 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id C866B22138;
        Wed, 11 Dec 2019 03:06:36 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 11 Dec 2019 03:06:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=hwPGVZSfhiMxz+WWKnEgFwPNaIp
        NoOUWvpk6+9E3qN4=; b=pNip4IpkG9LKvVBXYoyj4iVJS/ovoPIw9uWvOPk5cd9
        aeaF/jCv7glBQ+oKn8wpOl6n3UrLb0rgftmS04wkr50FD1IkkFHTMYvonRZw86Lj
        rIxwCZ6cNOEPfbb0UmR7pNOh3W8Tin3r2rF48bQskZY+1mLE/4zjEU7Lttik/FJI
        n8jQEQBF1wfSCShgauIgmygzeTmEYzHl8gW9Cipklj/+z0SGicb0Oef+ZCrnXbpy
        2LtsLThBsWK9Q7i5Mvc8GxhhFC6z6Cg0whP53l11XVHQwbn1CHVNnpEOK3kAStYf
        PYwKSDBhhcd95w233qcW/ZL7lhTiWF7eewTLoRU07ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=hwPGVZ
        SfhiMxz+WWKnEgFwPNaIpNoOUWvpk6+9E3qN4=; b=jj9j0YlySSDVxgY0h/vfI/
        aBM5pZSEUheItTPmultGLLgrgaBhHTdUTeNy4c41344yAtToDW3qW6/G83+QyggH
        sm3g6pf7cEXj1zUWIfLGKTsY44dhhovQamRUtTQtBA+p8tqvMA+14KLCSOCjGMnp
        wXMHTL2W+IfRxZrpRy5xOQAzkd4wt0TJ/Oy1dsxlCXGAtRrX5GwLqfns5zgxJWgt
        adK9eQS9r5Rud6MWzRraNXrxsG1MtxQ9/h9lBnNK5cCJ7KV+XtjpWF86PMoKEP18
        dFSX8G8JlEcREUqZwBpXrBhvKyj1SduXIfRAePAw817s1//ZjTbA5OkZYf4u2r8g
        ==
X-ME-Sender: <xms:jKPwXfXqZ_5EeTjpf0WKqXeWJktHHwg9Hv0q58PoZoj3nTZoHjIwSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudelgedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkpheple
    dtrdekledrieekrdejieenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegt
    vghrnhhordhtvggthhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:jKPwXSl6xGsb9BnnvKa9iCOm1T5zBt8VRYeehfUjcihda8tyWGH7sw>
    <xmx:jKPwXYg_duZ4YteFKA2eq--62RBE3EUDVTzlmiFFH1OgnjMeCKELKQ>
    <xmx:jKPwXS5eunZZjFT3NveH4Rpe-x2fnIaaEwQZn7a1LrmQs-O310SuYA>
    <xmx:jKPwXXnbpFRNjLVoZD7ulW-OOlvofq2rh8P0vhnr9WhEweg_S1Xe_A>
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id B864880070;
        Wed, 11 Dec 2019 03:06:35 -0500 (EST)
Date:   Wed, 11 Dec 2019 09:06:33 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Chen-Yu Tsai <wens@csie.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: pwm: allwinner: Fix missing header in H6
 example
Message-ID: <20191211080633.a6yzwbxi7fcmislp@gilmour.lan>
References: <20191210174710.10649-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="44tksmdnwrh2gezn"
Content-Disposition: inline
In-Reply-To: <20191210174710.10649-1-peron.clem@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--44tksmdnwrh2gezn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2019 at 06:47:10PM +0100, Cl=E9ment P=E9ron wrote:
> Latest linux-next doesn't build due to the following error:
>
> Error: Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.exam=
ple.dts:35.37-38
> syntax error
> FATAL ERROR: Unable to parse input tree
> make[1]: *** [Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-p=
wm.example.dt.yaml]
> Error 1
>
> This is due to missing header in the device-tree yaml example.
>
> Fix this by adding the missing headers.
>
> Fixes: 4ee929b3f08e ("dt-bindings: pwm: allwinner: Add H6 PWM description=
")
> Reported-by: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>

Applied, thanks!
Maxime

--44tksmdnwrh2gezn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXfCjiQAKCRDj7w1vZxhR
xTcEAP9uGGmta1bRoVSRk92LUIUmW8iSPPITd+A+9/tLuXcG3QEAkBBswRhpwUQ9
IcmAHUp2Yo34CHA+/krrKKxL0JUADQc=
=UP4/
-----END PGP SIGNATURE-----

--44tksmdnwrh2gezn--
