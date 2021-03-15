Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F0633C023
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Mar 2021 16:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhCOPjP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 15 Mar 2021 11:39:15 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:47371 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231319AbhCOPi7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 15 Mar 2021 11:38:59 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 9AC5531BF;
        Mon, 15 Mar 2021 11:38:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 15 Mar 2021 11:38:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=KihjirBI0y2LCr9iPZsXu9dfFf8
        pbunm60I1vrevuGE=; b=re504VI5VPqIrJR8MMi+srNDk0IjO6ubqKasJEe3ORm
        1EHe4TOIo8fgpTaRMZdSSjGQYrOuZdKUVIfz8x2f4vhzqrrd/DXOjYZi4tISrt9L
        Nvg2SkUa+S0FPaqszG3PtYRZq9gSCUMt+e0x9xdBBF0baPS8dm9QKb5fFrhqa7MM
        mP8XuefQd93CfkdiEt8DFLiallTTDWoxIAjrDGJVvhhMID8FceM6X8ndAdqnFBb5
        rspt6atvo/6TmbQpNAGsYdp/Gp8RMfNM30FOeEfEL7kaZjecSndE7GJCB/PZjYYs
        g+rjfocrpO53Vk2bvue0A5ipVcn6wsoRFHFsiTQ4mgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Kihjir
        BI0y2LCr9iPZsXu9dfFf8pbunm60I1vrevuGE=; b=MQzAFq+qdcJDVtzBc9yMnC
        OOzx4GRjNXvILqXZRSMa4UDbzZP1MfKn7DZhgK+ck8RkQf44ZjA8+DyzXBhPLC/n
        jTGH8nja5u1YZZj61JvofysltT1r5Ebn6O6MVSj2zyNfSnCKSCaEEZsO0Cc0m7zT
        mMUB/qneGeh+lAu2e1+KgF3T3mm0WgsaLKB86K5PtVNu7c0ssv1CStYqVtNjn3eY
        J5GnwbGSCgQUp+IH/RsZPvddmwzWNgUnOKlzjXJxnUl+K4cJTtIU4pRziCGGPfdP
        epq2ChLSEQ3HgeOCK1wS60tnChwb7Ptu9l5vqHE7GKyZ67YKQ8TsMsvoYXJ78dKg
        ==
X-ME-Sender: <xms:kH9PYA_YrGTzMsQpo2uHZf6DjP1X2ZuMXhl7WlIMXqjI93pJLRQwSQ>
    <xme:kH9PYIuUf5-eKXm6xWVvSHvN0SmQOIaiMKDAVFfgftbX8G5vQz-9BkL2TyTI18kBh
    Fvwyxmq72YUjFJ6w74>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddvledgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepuedtgfejueduheevgfevvdettdduleffgfffkeeltdffkeegudekjeeuveei
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:kH9PYGB5S_rg0ds1IlQt0YnIxjHR6w0PUBDgesUJTJq0TKkB9A36QQ>
    <xmx:kH9PYAdaksqpqpJyfe0DKhXNivzlHQLqs-jAy-1_H-qJapG88uYfAQ>
    <xmx:kH9PYFNj6gmyv9F3-sg-GMxgYzCji5pUpfn_3o9PPbuRZTXniMrV9A>
    <xmx:kn9PYI1cSOLStsJL3JxyhNbj_no9Pn3_1N1QORaPjjlWM0gAIM9Tkw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 947471080063;
        Mon, 15 Mar 2021 11:38:56 -0400 (EDT)
Date:   Mon, 15 Mar 2021 16:38:54 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?54+t5rab?= <fengzheng923@gmail.com>
Cc:     thierry.reding@gmail.com,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        wens@csie.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/2] pwm: sunxi: Add Allwinner SoC PWM controller
 driver
Message-ID: <20210315153854.3p6d2uarwzcatk2b@gilmour>
References: <20210302123737.1867-1-fengzheng923@gmail.com>
 <20210304160747.pblbugvgsa2oueqi@gilmour>
 <CAE=m61_X7YAZ_X5ZiWY4g04Mfk+AY0-TrvDsXmVk73kq0LPWCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2lo5rsjkxxw57v4h"
Content-Disposition: inline
In-Reply-To: <CAE=m61_X7YAZ_X5ZiWY4g04Mfk+AY0-TrvDsXmVk73kq0LPWCA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--2lo5rsjkxxw57v4h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Mon, Mar 08, 2021 at 10:47:03AM +0800, =E7=8F=AD=E6=B6=9B wrote:
> Maxime Ripard <maxime@cerno.tech> =E4=BA=8E2021=E5=B9=B43=E6=9C=885=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=8812:07=E5=86=99=E9=81=93=EF=BC=9A
>=20
> > Hi,
> >
> > On Tue, Mar 02, 2021 at 08:37:37PM +0800, Ban Tao wrote:
> > > From: Ban Tao <fengzheng923@gmail.com>
> > >
> > > The Allwinner R818, A133, R329, V536 and V833 has a new PWM controller
> > > IP compared to the older Allwinner SoCs.
> > >
> > > Signed-off-by: Ban Tao <fengzheng923@gmail.com>
> >
> > Thanks for sending an update.
> >
> > Like I said in the previous version though, without proper SoC support
> > upstream, that driver would effectively be dead code
> >
>=20
> I'm not sure if the latest Linux code supports R818, A133, R329, V536 or
> V833,

It doesn't at the moment...

> But the driver supports most of the sun50i family of SoCs and some of the
> sun8i SoCs.
> Maybe I shouldn't submit this code right now...

=2E.. but if that driver can drive controllers found on other SoCs that we
support already, then you're very welcome to work on those first :)

Maxime

--2lo5rsjkxxw57v4h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYE9/jgAKCRDj7w1vZxhR
xbp7AP9tXT/cAsA0a7cCF482qX6R6//ybLvT4uWUAcKfz4eZUwD/ZebQpz449bQs
Coq4CQv8bG57kqddyB+YmkyawsWIlgM=
=q6Yf
-----END PGP SIGNATURE-----

--2lo5rsjkxxw57v4h--
