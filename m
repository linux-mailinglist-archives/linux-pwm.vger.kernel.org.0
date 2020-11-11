Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA6B2AF985
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Nov 2020 21:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbgKKUJ3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 11 Nov 2020 15:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgKKUJ2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Nov 2020 15:09:28 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C880AC0613D1;
        Wed, 11 Nov 2020 12:09:26 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id s8so3722822wrw.10;
        Wed, 11 Nov 2020 12:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xiuab5loLiZQ4GVsxMBNthWxs97cvVYwFd3nDnMmqgk=;
        b=D9VOymny/GjO8Dta8qvkdEajDwH/kAlYUet+sY+pJRvP44LyaiB1GaUWTzi6PLKk/F
         FDgaAX+suXosQlbCO3mUYREqIYeE5uD4joYzCygSLtCmoiRX7mfSbxXnUsSq2DpHdPEz
         GCQG1YhrqumW+DemUqN6pP7b7Rux1vFdyPk9FSVr7LhFYbWo3eNe0ZYZR1enxdRdW740
         0dCPAYzeKOh3N6V7MsgPP0gqT311Sxx/R/XaZGodW3unmrq55ymQiMbflgbNLajHH2I3
         IaNeHbyE5IY0iCThcA5s0XhstJfkt8KV23wA9bfXHriHju3mXzBm6A4HUSSz8wzj8QwU
         uDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xiuab5loLiZQ4GVsxMBNthWxs97cvVYwFd3nDnMmqgk=;
        b=bwavL6xW8ZOzq2biYN/AvEhfir20Nz2pbjQriKvlu73dvIAKOtkUQ/faWekxYz4kyv
         WoYYxom0pm0TLVhSqC92W1lDPwrdtlH8IGcQBLYy/gSkKTwiwVtglimHBb/KfOG8uqCq
         0z07SoxDujnLRGR3rGzxDEeCzZZARw9dsg45x96jOXzVQPJIqpfeL8ndH+qm4sdIkPNK
         7yp7jk+SHVJjGNMRAeTew4klQaUGurJA81OPYoTX+0V2sb73oMH4DvzNaxhTDtTTiqp9
         bi3mjbteE2JbP5+LeaQxB1hibMO92+DMjX/yutSiWP5R/2W6bgJjVho+dGXSPgtH2cgu
         bijQ==
X-Gm-Message-State: AOAM532wkITg5u4qb1v2Rn76Mwu4nW3t8zjmd9xnnNj7vqqWTF7x7IeS
        ZiCSkIAHMNkc2njUdM1750Q=
X-Google-Smtp-Source: ABdhPJwq7FKsezH6nXrx4aFnOFjKW00DQEGCftsmVgeTppuOgRzBDAUh7nSqZ2c7kErtOPbBgcBIMw==
X-Received: by 2002:adf:eb08:: with SMTP id s8mr33448589wrn.12.1605125365553;
        Wed, 11 Nov 2020 12:09:25 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id y16sm3356603wrt.25.2020.11.11.12.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 12:09:24 -0800 (PST)
Date:   Wed, 11 Nov 2020 21:09:22 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] pwm: atmel-tcb: rework device tree binding
Message-ID: <20201111200922.GI6125@ulmo>
References: <20201030183658.1007395-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fmvA4kSBHQVZhkR6"
Content-Disposition: inline
In-Reply-To: <20201030183658.1007395-1-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--fmvA4kSBHQVZhkR6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 07:36:54PM +0100, Alexandre Belloni wrote:
> Hello,
>=20
> This was sent as part of a 58 patches series back in 2017. The bindings
> were agreed upon back then:
>=20
> https://lore.kernel.org/linux-arm-kernel/20170607211752.avts3cofvac7ks3q@=
rob-hp-laptop/
>=20
> There is still only one user of atmel,tcb-pwm in the tree and I still
> think it is worth doing that change now.
>=20
> The various dependencies are now in v5.9-rc1 so it is ready to be
> applied.
>=20
> I have another series removing atmel_tclib once this is applied.
>=20
> Changes in v2:
>  - rework binding commit message
>  - use enum for the pwm node reg values
>=20
> Alexandre Belloni (4):
>   dt-bindings: microchip: atmel,at91rm9200-tcb: add atmel,tcb-pwm
>   pwm: atmel-tcb: switch to new binding
>   pwm: atmel-tcb: add sama5d2 support
>   ARM: dts: at91: kizbox: switch to new pwm-atmel-tcb binding
>=20
>  .../devicetree/bindings/pwm/atmel-tcb-pwm.txt |  16 --
>  .../soc/microchip/atmel,at91rm9200-tcb.yaml   |  34 ++-
>  arch/arm/boot/dts/at91-kizbox.dts             |  45 ++-
>  drivers/pwm/Kconfig                           |   3 +-
>  drivers/pwm/pwm-atmel-tcb.c                   | 264 ++++++++++--------
>  5 files changed, 220 insertions(+), 142 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.t=
xt

Patches 1-3 applied, thanks.

Thierry

--fmvA4kSBHQVZhkR6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+sRPIACgkQ3SOs138+
s6EjIRAAtR608Qmo8RQVZLEXLwAC8ZuqnunjrxJxrzNKdFQ4EzdOBXp7XHquYp6b
w+NRvsDLrl7qTHJe39G/TzX187h0rGA944QKXuEpUoJUjN413xb6yQ24LKSdze+S
YBTDxtiDi9MKEH0v+Q80l0QYQ71dg59IQmkbSEu922eLIDfwucYC5hEqLh8iylpT
owt1X0xFE4g/cyX10SSvXveYZiQZQ9jDFRPpQY/HZFixHKSpHIiQP/c479qeh/Nq
Bd7W16YgLZ59iyxFwvBfEBPu/jMRKAzo7r786hoBLdGwqajKMjSnoag/YaBKR/tR
nqG604+SEoqtWz76UArW0cwNGgCZuCZ0HmEDgAXS5eRDjdWYRxaA068rDKLYmk6C
K4chBp7kn51YL/xIGhzt8OBArsdWtJLxpzCG3NmbUg9wM9oMtSlqju12fXtvTgBi
uYgHtWStTD5EUd0r1w7VsJ989FDXn6CYE5xaN9vrcP1nhbxcmWkUUtXeEpHAdMb8
Ng2oz+PqSuT6aNZp4oY0fT1ErFvSA+pNkh1Ek1NSSyjSnJIUuV1y45O+Nm7pBYnK
wHphDrErPVqNTi2y6UmItE/r6D3+7ranz7lNXOwAsPx7h+cnjgT3a7W8f6B9/WVV
BTe0P79UPgvQ+2VwAyfd4EWjs2CitUQNoJVFTGhD5QcVWV4hQv0=
=xnU/
-----END PGP SIGNATURE-----

--fmvA4kSBHQVZhkR6--
