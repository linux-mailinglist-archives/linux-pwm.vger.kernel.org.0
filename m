Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1790632D76E
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Mar 2021 17:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236626AbhCDQJY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 4 Mar 2021 11:09:24 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:47377 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236552AbhCDQI4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 4 Mar 2021 11:08:56 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 990DA5C00C3;
        Thu,  4 Mar 2021 11:07:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 04 Mar 2021 11:07:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=eHQ4QqGgtqjhOexEwbL14ScFJ6g
        3yh7pxR25VkwY/Ic=; b=MJ1Ws7L8OmyqfpEGlRpTCOdfktu/g5jU69MoTBcnvZ3
        kYpXIuwrfhfLSzTzaokp5ImgTiT6VMeh7YZG6o7zfvcRoyvrAIPkKB83UnSMSd9C
        Zu7qMfRZmOWXUFLsU10DqSsY8PJ25jp+I/1ox6aDg/XNoA8n+A+yS0Wlkol0Oute
        sFOas2vZxRsFHT1ZuwylfvJzr0aJg3IE2iWy0sCG6ljDc5xJ+fFIwxWYb0IQxa4/
        o4yr2vB60vmzaOY6J2tyjAFFluPekv8v8Qa6XZ2cn/Y4XzikoQYiTb1fbzMw/PDa
        TJUXIMjvb9tanIPVtEvvGaLzdXtRybto5PxuBhdpiTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=eHQ4Qq
        GgtqjhOexEwbL14ScFJ6g3yh7pxR25VkwY/Ic=; b=CpXGbfw3qk0WrcVJuPZYWT
        wrriOMSYc7Tl1AHHNzLDc24DhAX5E4rBB3TPr9mG1FUYAGD0gtDA1IEb5zQ93R86
        7w+JTfKrntPFzfDW3MrEay9ZT97S2VavMUrJf+IiavbSOWG7d7Ep9WG3Wms35PqJ
        dqKCGO9DRuP0+uu1HzNKiOzJQM9Jq9VFWfOYrdDXROvXk5kaP0xeCRYzsFT9SABt
        W81gffk55HRPqAOWMSJ3TyJCoy0dx5rn43sYJjPkYat88PcZ5dINYgJKrZEAKUXc
        mtrzKSyJxeJaU+d4AkpBL/2boWJYnNtKmPRqkpNWhMsDEVgArYCNdrzwkbf0dDCQ
        ==
X-ME-Sender: <xms:1QVBYCu8GocI-DiQtchUMZC8z6PoaBountsJg9dxZ6cHfknrF3rmYw>
    <xme:1QVBYHfcCpX87i9H0GJf1f90va3CyPfv9WtKZjYnD4sUNBUhQtcXmVmzrmMZyuXQs
    -OtdoWjlIA3cmSARC8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddtgedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomhepofgrgihimhgvucftihhprghrugcuoehmrgigihhmvgestggv
    rhhnohdrthgvtghhqeenucggtffrrghtthgvrhhnpeelkeeghefhuddtleejgfeljeffhe
    ffgfeijefhgfeufefhtdevteegheeiheegudenucfkphepledtrdekledrieekrdejieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigih
    hmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:1QVBYNwgx55SbUkruUWRzuObz5GnLdHseN9kFg5F3WB-ybqH34ryCQ>
    <xmx:1QVBYNMRAtqXg3LluksfKyLGzC01q_XxNlRHef2NBiVMQRNESnlCdw>
    <xmx:1QVBYC_trFO-o5iuTTymg7DZXg8gCYlh4m6L6csmksN08zBvJks_0w>
    <xmx:1gVBYJlKoHCbxFdZLzpxs7j8oKe6H_Pmml8Cwp5K1tVIaKNGh7A5qA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 347991080059;
        Thu,  4 Mar 2021 11:07:49 -0500 (EST)
Date:   Thu, 4 Mar 2021 17:07:47 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Ban Tao <fengzheng923@gmail.com>
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, wens@csie.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/2] pwm: sunxi: Add Allwinner SoC PWM controller
 driver
Message-ID: <20210304160747.pblbugvgsa2oueqi@gilmour>
References: <20210302123737.1867-1-fengzheng923@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7riidxa4uwozvogo"
Content-Disposition: inline
In-Reply-To: <20210302123737.1867-1-fengzheng923@gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--7riidxa4uwozvogo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 02, 2021 at 08:37:37PM +0800, Ban Tao wrote:
> From: Ban Tao <fengzheng923@gmail.com>
>=20
> The Allwinner R818, A133, R329, V536 and V833 has a new PWM controller
> IP compared to the older Allwinner SoCs.
>=20
> Signed-off-by: Ban Tao <fengzheng923@gmail.com>

Thanks for sending an update.

Like I said in the previous version though, without proper SoC support
upstream, that driver would effectively be dead code

Maxime

--7riidxa4uwozvogo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYEEF0wAKCRDj7w1vZxhR
xWg3APIDan8axufR1ZCgDgHwNEkc0R0qwAUGJ5edYjZDlUbEAQC8ZUuURKbh+QZB
RalYcFqwjPRNeDHlKWHmKqik2tVDAA==
=V0ju
-----END PGP SIGNATURE-----

--7riidxa4uwozvogo--
