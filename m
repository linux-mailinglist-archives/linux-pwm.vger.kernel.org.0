Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445F11BDB4B
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Apr 2020 14:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgD2MDM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 29 Apr 2020 08:03:12 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46277 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726426AbgD2MDM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 29 Apr 2020 08:03:12 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 227005C02A7;
        Wed, 29 Apr 2020 08:03:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 29 Apr 2020 08:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=nVZXdFyTqU+EhOsehAD10jUm04V
        bj//It/g0NXiaLkg=; b=X8wqnXfhKyWGkf049IbZs608tmy8mJCmB97oKx3hsz9
        FaUGK4faP3+9l/IDNK/bZHg1Bl5jExOiq0rRK2TdeUa5fZM4RylgCkpAoldPnyep
        x5hgoKR6Ik/opWp2oKwc8IvE57b8vLSDSBCotOeIBOJwLD9qy0cemBTLbvOpH6Sp
        9Nfk5cjYTDo64jpfp/nhBP6mOb3z+H2lxJdjYjPL1Zd8FCoXo8dNN3j1mj06y/aG
        phOsLFxxQKXp6Wd7qe/ZCgf96Y7lTmtKiRZZTzcjevGmQ90UeCQvy4aWswvcP8mO
        6E77Wl8fon1D467hK6pLxdGnSElFv4qVKNUNGhfFKkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=nVZXdF
        yTqU+EhOsehAD10jUm04Vbj//It/g0NXiaLkg=; b=YiOs9rvySj87qc8DgiPek6
        o2tiGM1pXPKef5LZsZF4iLCpyIYt2alVyMwaMVhuNe46xPHyTDRk18wJydgTRIit
        PWP1+kbpXpMcv+9FdP7RDLHtyI2j1HeNZbb0byU+UdHMeNcSUDK0CHJIoZz2fmp1
        8KU3J1dG9r7/j6RCoFBUA8H4rkWes7gKve3/zmevRZn63G2FTsDAkgGWlafHpcou
        LohYvzEI1f8QBmKQqeX3CkVSN4V4CQwSM6XejvLPCYRU/JchuQd8B6xsq3EWEPNp
        exZJ6fxCXh+N0Q72xLj5TlwlHd75tWMSoU2eoxaCzjal7HvL1g9SGoEBH63tOYjA
        ==
X-ME-Sender: <xms:_GypXuO9jt2LA5aXfajnxJ90VtPBpDNAiN7o5oCcaPJ-JWyt8VqbaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrieefgdegjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:_GypXg71DSEMhi_VhbzzVZwin2YtY1P4zz7pKUG38S-g-qZ-zjCLqA>
    <xmx:_GypXuXpNum4U1ejXsUJpiHS6i8M0qKSiK08zERfmJQnj2fzTT8MZA>
    <xmx:_GypXnPcR5B1K018RCyGma-EKlFFnhq5d6m5hR2CDJcyBdB87jaTUA>
    <xmx:_2ypXoOkMplzris1jy1zdrZ3tLca1ufOKvoO3I_6yhnYNo65pXJWKw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 65EDF328005E;
        Wed, 29 Apr 2020 08:03:08 -0400 (EDT)
Date:   Wed, 29 Apr 2020 14:03:06 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Peter Vasil <peter.vasil@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Chen-Yu Tsai <wens@csie.org>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, nightwolf@relghuar.net
Subject: Re: [PATCH v2] pwm: sun4i: direct clock output support for Allwinner
 A64
Message-ID: <20200429120306.7bqg6d5z2qomt4bj@gilmour.lan>
References: <20200428164150.366966-1-peter.vasil@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vmsinkl72f7e2isg"
Content-Disposition: inline
In-Reply-To: <20200428164150.366966-1-peter.vasil@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--vmsinkl72f7e2isg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2020 at 06:41:50PM +0200, Peter Vasil wrote:
> Allwinner A64 is capable of a direct clock output on PWM (see A64
> User Manual chapter 3.10). Add support for this in the sun4i PWM
> driver.
>=20
> Signed-off-by: Peter Vasil <peter.vasil@gmail.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

--vmsinkl72f7e2isg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXqls+gAKCRDj7w1vZxhR
xXL4APwJ1frhThTxfINLI8+qwKzaB+xsWZPuoydUkyE2hxzV7wEA2Mq/A36nL3jr
dEXEVKmCa8o8lDHAr2fo9TOwjIuX+AU=
=w8vE
-----END PGP SIGNATURE-----

--vmsinkl72f7e2isg--
