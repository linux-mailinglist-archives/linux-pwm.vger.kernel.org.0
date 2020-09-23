Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD712759A2
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Sep 2020 16:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgIWOPR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Sep 2020 10:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWOPQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Sep 2020 10:15:16 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6695AC0613CE;
        Wed, 23 Sep 2020 07:15:16 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c18so173160wrm.9;
        Wed, 23 Sep 2020 07:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CCpG6jWr4GZzW1CfQaSnnmzY1h1hQX+z5GfUGphu6mo=;
        b=WyrzDX2hgEfYU9YEV2oB2Vy6Tk0kl11zvxMh4GY5Zt2ZGXDlcM0bIRvJURSeI8ygz8
         K7BOrYW6NZZZZ8WNO359lHGhMUBKLp8RYVFb1RA9XE6CqaxCBH28mpQ9VlNnCEYpp3oB
         YaiQ5Pj3XC5d+3qWk61xf4Xl2LYrqI3P+6YmLSDhln3QT1ToaJ/YKV/EMYVvYoFY1K/n
         CYQfJkBIqbqGPooaLBU3l8dRSPFw3jl+SdGXFuDyljkKofyPmTaHKCbPTQL6hm3orrk/
         wFBw5Rfz51qnFjDZ6W5wZswA+McLUuOlY4QMfhiXajTRVEeG7MBrNA9HnrmSlEwbsek2
         V/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CCpG6jWr4GZzW1CfQaSnnmzY1h1hQX+z5GfUGphu6mo=;
        b=j9SmZ4sBiSMf4g2btvHev7WDIpJIdRN0dhxjbWsGERL+LJBZqQ20WrVptNvv6jf6yv
         IJeBhVu8iP2usmmWCFiA8Qtlo1z/L894jKg8nNbhJj5/eqbPDv193PCBiqFiy5YjxxcF
         b7ns7unDr0lv2xpiuwcjY4az/hJywusbujDdo1UXBRFvb6EcU8NXHqhg3W/spbN++3jF
         gf/nLM6JMBLNuc3SJIGOaaJ+yxDHdF7wDvhXTeOUi4uofBRd8P93q7vPJzVXhhHbW9hT
         7KKjeOG2Ik0wmd1VXHFlgMiLukLNOqEuEtUxEpHfVkbxBWQx7h/CYJeCnSX/0OuafBvP
         B4fQ==
X-Gm-Message-State: AOAM533fqfkRPjCJQhTEiWnkgWxSeb9GvLKWoVpPPTmMOdVNYYPqvQPo
        HZKGdMiQrJbnZ9hbmnVBm9o=
X-Google-Smtp-Source: ABdhPJxE/2vXIiL4kN9hTjYGmAYGf/ntfPr0bNkLM/DKOX5sQazw3tKXKwd9st2bXep+5i7oBXEVXA==
X-Received: by 2002:a5d:568d:: with SMTP id f13mr1056599wrv.303.1600870515112;
        Wed, 23 Sep 2020 07:15:15 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id o4sm29300893wru.55.2020.09.23.07.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 07:15:13 -0700 (PDT)
Date:   Wed, 23 Sep 2020 16:15:11 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Han Xu <han.xu@nxp.com>,
        Frank Li <frank.li@nxp.com>, Fugang Duan <fugang.duan@nxp.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v3 06/19] dt-bindings: pwm: imx-pwm: Add i.MX 8M
 compatibles
Message-ID: <20200923141511.GF1848911@ulmo>
References: <20200825193536.7332-1-krzk@kernel.org>
 <20200825193536.7332-7-krzk@kernel.org>
 <20200923115201.GD1846003@ulmo>
 <CAJKOXPcZuonCBK1Fc9r=rHzOL02MArrsE=R4x1tWGqov2nP0fA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SxgehGEc6vB0cZwN"
Content-Disposition: inline
In-Reply-To: <CAJKOXPcZuonCBK1Fc9r=rHzOL02MArrsE=R4x1tWGqov2nP0fA@mail.gmail.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--SxgehGEc6vB0cZwN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2020 at 04:08:53PM +0200, Krzysztof Kozlowski wrote:
> On Wed, 23 Sep 2020 at 13:52, Thierry Reding <thierry.reding@gmail.com> w=
rote:
> >
> > On Tue, Aug 25, 2020 at 09:35:23PM +0200, Krzysztof Kozlowski wrote:
> > > DTSes with new i.MX 8M SoCs introduce their own compatibles so add th=
em
> > > to fix dtbs_check warnings like:
> > >
> > >   arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: pwm@30660000:
> > >     compatible:0: 'fsl,imx8mm-pwm' is not one of ['fsl,imx1-pwm', 'fs=
l,imx27-pwm']
> > >     From schema: Documentation/devicetree/bindings/pwm/imx-pwm.yaml
> > >
> > >   arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: pwm@30660000:
> > >     compatible: ['fsl,imx8mm-pwm', 'fsl,imx27-pwm'] is too long
> > >
> > >   arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: pwm@30660000:
> > >     compatible: Additional items are not allowed ('fsl,imx27-pwm' was=
 unexpected)
> > >
> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  Documentation/devicetree/bindings/pwm/imx-pwm.yaml | 14 +++++++++++-=
--
> > >  1 file changed, 11 insertions(+), 3 deletions(-)
> >
> > Applied, thanks.
>=20
> Thanks Thierry, but this was already picked up by Rob into DT tree.

I hadn't seen any email and since Rob had given a reviewed-by I assumed
this was supposed to be picked up into subsystem trees. I'll drop it
again.

Thierry

--SxgehGEc6vB0cZwN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9rWG8ACgkQ3SOs138+
s6FYZA/+J5rgjcPTqcNSA6/9QwG56DhiJV6FV2eQhf5UbL1l2RFHvVGpAnZxjxM7
UFP1CVWZIFEYJlXCAjEjHeKrz8wz/M8+j2UYqzCnew7XwH2QOKvJRiQYyjMzJyLh
Z9AI7zgkZXqz0xH+WIjkynmWnoz1jZw2Ct331f2jaPHmkD4B2CURyhkVtVNhW0Kr
5Vq8t7NQ7tqQjh2+q4cxf6ge1zc1J2PCNNdc6MDdTHFTBhpqGp4IF7Sx7aMq79OT
/JtEp0TZohhPUXtkDl1ZghDzryf9pksNOf+HwgpgrbrbZl5tP0y2K3TL+9uIXjfT
6clna7VIx9ofQpnAeL1RzJMGM93laLOpvdcAj02cgUcNcOU3Bj3oVGBx076M8WyA
i58nto1/wlQEcZzlMcQigyNCFWu6nhXjebM5U9WdEWAm9xkGv4OSbHQw7ZV7TM8b
JI334Uvholn1f99bt3JosCAOYTV/88sn4Px8SAxvwGy6EttBPKdnUvBwZdk86xTa
eKbDtGkvF2pFAgaO7ylV2ADQnVW+A3JEXF+RbT/u5jiFiHUEz8XncHiJmB+e4xrf
4W3V2QqbWkF6y7BQ+OaNYk98m5dkNE/e7kSCdXcmjjJwazDunejXvQvnNDr70LIP
oNqvMzEtfA0q5K2Fee3TyE31GBycFO3i6PjxrIad0PsInjVV2Ok=
=J7v2
-----END PGP SIGNATURE-----

--SxgehGEc6vB0cZwN--
