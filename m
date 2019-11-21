Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA89104C5F
	for <lists+linux-pwm@lfdr.de>; Thu, 21 Nov 2019 08:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfKUHYL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 21 Nov 2019 02:24:11 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:32981 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725842AbfKUHYL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 21 Nov 2019 02:24:11 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id A2C58640E;
        Thu, 21 Nov 2019 02:24:10 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 21 Nov 2019 02:24:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=dcB24XFxUA/iOC9697pOKl03qd+
        53/LvU+J/gD6p5OY=; b=FwVr7C57Kjm3aMwlRIYzy4K1/tpGNKzj5qf+bZ5tKGV
        lVY9I7uiv9l4zATehBAXzEgLNPZFiv4GVIjlSYuKpqVYNHRRcIwxyhBWpSyf2KS6
        VfU67jAsX4/sQTJjWQ6cqXERnXq5hStGD9GtEVeJaXXjKnTTeX9uFWOOs3v8/V2A
        wESqNTDNUjlnO6QdWvv5kSjB6mOoWpTDp4cRes1an8MpSMERMaWrTV2l0dskurQq
        aNN+sLTWNOGERUQggHuNf+BA0dHjuJROBWt9gCRV0MMmoovFSxhKUKdcCHQFbvKl
        LYn4DFYr8OFumdnfIOcvSeLHkcHfSQuD5PdoHtnFuLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=dcB24X
        FxUA/iOC9697pOKl03qd+53/LvU+J/gD6p5OY=; b=saoAdWVJ4y9DYJD7kEOtJH
        eodbEv2meQPC62TXeDvhQvx2ksypxzjTrSeOxA346AxyTveBn18bjvPD6lHiFDRg
        IdR3F1fG1cFsIsVeRMHMRgQEAgRQnztSPHcaoFgVVIncXqZk1q6avzlwOwLMyHYM
        Tp77nLctOs+iXo1pbaCcLuWmd/74n0afinrio9OIvQfwqlymsgdMzHzcYgWWsfeN
        rmt0JkAkpCZBvGIC3jGVq0yE0R2O6xaw9rZA0AmnvHX/HcrzHep4XgyQ4tlVP6DF
        FYA0DNxgwBa7KHdk3ONSAQvQLGVwHfwhgtea7E/nYEeRD52Qp91JUg1pSsUBgMzw
        ==
X-ME-Sender: <xms:mjvWXSgTPFVq6NKV-KcJEBYMfswHVBPryLUalwhm93JYlxLMUtHlQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudehuddguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujggfsehgtderredtredunecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppe
    eltddrkeelrdeikedrjeeinecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvges
    tggvrhhnohdrthgvtghhnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:mjvWXSkCZYG7rudfHBNHnqg6JvOlXzaMYPGsQH-4aly4II5eZA9zVA>
    <xmx:mjvWXTdFCuCWaked9eYgvIhpgUancv9t73p75_OQ4i0SuNkAd80L5Q>
    <xmx:mjvWXUFKqEuTuvBneGAI_lV2JbOSxXZt1npllQzKX4u4GwxLZ9-VmQ>
    <xmx:mjvWXWJPttQshbGz5eceanv_mDEc5XVVpTjimHa1s1yrZ690_iLsNg>
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0E76C3060057;
        Thu, 21 Nov 2019 02:24:09 -0500 (EST)
Date:   Thu, 21 Nov 2019 08:24:08 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <pza@pengutronix.de>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v7 0/8] Add support for H6 PWM
Message-ID: <20191121072408.GE4345@gilmour.lan>
References: <20191119175319.16561-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cnZewGtz8xdCmwBG"
Content-Disposition: inline
In-Reply-To: <20191119175319.16561-1-peron.clem@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--cnZewGtz8xdCmwBG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2019 at 06:53:11PM +0100, Cl=E9ment P=E9ron wrote:
> Hi,
>
> This is a rework of Jernej's previous work[1] taking account all the
> previous remarks.
>
> Bindings is still strict but probe in the driver are now optionnals.
>
> If someone could confirm that the PWM is not broken, as my board
> doesn't output it.
>
> I didn't add the acked-tags as there are big changes.

Applied 1 and 7 for 5.6, thanks!
Maxime

--cnZewGtz8xdCmwBG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXdY7mAAKCRDj7w1vZxhR
xTFOAQDiMAy9dHGZ7PpP701iv2RrsZe3P6MNSle9BJ2doLno4AEAtUYireLcQZ83
bb4k15ybFyplkNifvIeEgxnolldKeAE=
=atTd
-----END PGP SIGNATURE-----

--cnZewGtz8xdCmwBG--
