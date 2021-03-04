Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A119132D772
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Mar 2021 17:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbhCDQJ4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 4 Mar 2021 11:09:56 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:39531 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236552AbhCDQJ0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 4 Mar 2021 11:09:26 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 01D625C00AB;
        Thu,  4 Mar 2021 11:08:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 04 Mar 2021 11:08:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=VvFT4sIhdl8OyKsNfoGv3dd+znZ
        o0k02xfI9z9hC4D0=; b=XZazelhem4TOTu0xYqFtjJQl0zEuaRFBaxOcBOwEMNM
        T5iSyktLx0CRQBEu3gHZLckeKg21uxOsJomMltTwE92Qoo4MLUE16UyhnXMKRcZt
        ujNSk5iy8Dn+CVCt+MRmfjaIJo0ZZsVDl4mC9tPxiiEh0zHlF7Bt4Tkvc+UTIQ0T
        AtW2l2HX4J2AieydWqJYqq60WgkZtE7exxESp01mdtah1/cAQ/aah5fEGD41xTT/
        MRmO97W7figG1R+WhQHLUpIOU4of6XRJ5McVfBho+JS3maP4mrZfeLZdqiUR6EE6
        1cJkcR/AzB9VZIOmnGopVvkm4pjut4cvOHh6iiCYq7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=VvFT4s
        Ihdl8OyKsNfoGv3dd+znZo0k02xfI9z9hC4D0=; b=Kc6QB4rcrlIAw8IXYIIOli
        /RIhXnWZzv3t42tiKT8Go5o5ulfklLlWc2fKULX2BQWuSCzi56XY1U64lK3MRNju
        4BeRk0hlfLJBZ9UFxOiu0cfnoMuuQZeRikfwcfVqWpHE7fbZbrxdQ2bnwmJ5sT8F
        AmFPCheLKUlyusd91WMgwAvaCIYaPTW4mUnoLu2iJ/7urkylTET3s4lzJZUSgYR8
        MA6TU88JB5vkbtp78PqCPwbZDVkfPj9F+9XDzdx0TNT84dbgIplLEgSX4ofLf8LM
        PQ7oejzF50VjOIdacKltnRpUtPqiRRBicxOQkjwVHbHa/CYPSxfl93vnGVYFYZ6g
        ==
X-ME-Sender: <xms:9AVBYF-2Ux7LMHmOdmudwkSTPB6QLYp9uC1zaSVpekF9eHzF7_sACA>
    <xme:9AVBYBVc7BT4KPbD-ePkCiWMeZXY0uXK2yLVXVIMMSP3lGCzKTn-0xylx0wn5nn-S
    eD2s5fs5x0Bupzhu2Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddtgedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomhepofgrgihimhgvucftihhprghrugcuoehmrgigihhmvgestggv
    rhhnohdrthgvtghhqeenucggtffrrghtthgvrhhnpeelkeeghefhuddtleejgfeljeffhe
    ffgfeijefhgfeufefhtdevteegheeiheegudenucfkphepledtrdekledrieekrdejieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigih
    hmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:9AVBYAoOI-v8r2qxXXoBnWpvh7vpJt52I4jaS3aqU9VteZSr5wZKLg>
    <xmx:9AVBYDm0Ts0gtq6U9ef5x3W3C2gB-ku9H946J8Eg_1q6i1QMIzD3PA>
    <xmx:9AVBYA0Q4yfowOM5jKqNmysvQLxrEFrubwXhH-gvEA7ChQ_oxzt7fQ>
    <xmx:9AVBYE9DFqWVWqZXkWlzJNS-JPPz2aeAKvrDuA5ltFd3bWPo4Bj36g>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 008EC240057;
        Thu,  4 Mar 2021 11:08:19 -0500 (EST)
Date:   Thu, 4 Mar 2021 17:08:18 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Ban Tao <fengzheng923@gmail.com>
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, robh+dt@kernel.org, wens@csie.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] pwm: sun8i-v536: document device tree bindings
Message-ID: <20210304160818.ngdf24sblgbmhcca@gilmour>
References: <20210302124023.1923-1-fengzheng923@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mf2l3wudhboi5bor"
Content-Disposition: inline
In-Reply-To: <20210302124023.1923-1-fengzheng923@gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--mf2l3wudhboi5bor
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 02, 2021 at 08:40:23PM +0800, Ban Tao wrote:
> From: Ban Tao <fengzheng923@gmail.com>
>=20
> This adds binding documentation for sun8i-v536 SoC PWM driver.
>=20
> Signed-off-by: Ban Tao <fengzheng923@gmail.com>
> ---
>  .../bindings/pwm/pwm-sun8i-v536.txt           | 24 +++++++++++++++++++

Bindings should be done using the YAML format now to enable the DT
validation.

Maxime

--mf2l3wudhboi5bor
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYEEF8gAKCRDj7w1vZxhR
xThOAQCUIrgVrNny2WM62JV0jO5zSxDb6zX/KP+vHMx8zDYhZQEAx1/gI45vvLdv
x/XJHHE2oH18MyjEri4P7IRDGsoL7go=
=fmbw
-----END PGP SIGNATURE-----

--mf2l3wudhboi5bor--
