Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B751F7413
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jun 2020 08:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgFLGrY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 12 Jun 2020 02:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgFLGrY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 12 Jun 2020 02:47:24 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D94C03E96F;
        Thu, 11 Jun 2020 23:47:22 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id q11so8556220wrp.3;
        Thu, 11 Jun 2020 23:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bEDPE0wLH9mbIJMf0kGvWOirp0WuDO4dvBhX04ygBLA=;
        b=PDnKhcR2OKWwop1uvkMULWT6i/7vk+O9RNJihHhNTy6RkG3AMx2zlkW11DMKdLgtTb
         ac5XQSh1LuUTTDbsN6AyZ11+Fv/KwLCXeDP03o/hkjb6656V2MGNVkRUf2sHcwPIOTv7
         5OGCY77qTnoulvA/7h4BirLJ9RCSdxXQeldgZF+nkwW37WboQDU6OVdgJvq7yM0jvjjh
         qEm8DUGQQumSiU4mG0+ZBYRA5GmpaDmD9GWhvm+Q/cm6HQcOtSLNPI597bX3P1mJWNwy
         hoJcNrPXAo02glX3D5Q2yU7jsE936IfX9Q2UlzfjuzsucwJPUdrZ5XlYk6hyIop6OXee
         IPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bEDPE0wLH9mbIJMf0kGvWOirp0WuDO4dvBhX04ygBLA=;
        b=S00WYaDNlipxNcH1Px5zVjkW5/t6StRvpAjaj1rbl3PqvzWL0jSjUhTaXqeN7CIPu4
         GF7FEsIksm7rNGxGdsyxNLgFdWmkjzVboTUrj3pwHFDFI2+OgeI84iNbduWRvGRGNlL2
         k5+Hz1tRbXlSkp3fEP4f72Eoe5n4UgpDptgn3bbDszhosmmIHZdch6WRwHXes1oUb+Pl
         X3HGupUmDL9J4n5nfXKLKSxagTZebRGDsD2v+06S1jOMcGYRLnbIFgjNlZtzP+BJ3+sh
         VKz5wilamvemgdyanOVuuZopMjrLXIsUTp9jpwQ/sucj/1M98H7oR3AvVCLdv6bLttHC
         BtkA==
X-Gm-Message-State: AOAM5301TIbyo/JsJrqVSdJvt4RcDBHJEI5++wgpOMrisNfyHeZEsek8
        runtni+C0KxYr61LE9dLBDSYYPkr
X-Google-Smtp-Source: ABdhPJwJAOei45XC0j5S56zzU0K7jY8wa+9ImMnUqdJ5h6skzOSWjMqam59s69hL/DHXMXwE5cdlXA==
X-Received: by 2002:a05:6000:100e:: with SMTP id a14mr13202217wrx.349.1591944441631;
        Thu, 11 Jun 2020 23:47:21 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id s8sm8514759wrm.96.2020.06.11.23.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 23:47:20 -0700 (PDT)
Date:   Fri, 12 Jun 2020 08:47:19 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Anson Huang <Anson.Huang@nxp.com>, linux-clk@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Remove redundant 'maxItems'
Message-ID: <20200612064719.GA2295929@ulmo>
References: <20200611194738.1480393-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <20200611194738.1480393-1-robh@kernel.org>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2020 at 01:47:38PM -0600, Rob Herring wrote:
> There's no need to specify 'maxItems' with the same value as the number
> of entries in 'items'. A meta-schema update will catch future cases.
>=20
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Anson Huang <Anson.Huang@nxp.com>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-pwm@vger.kernel.org
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/clock/imx6q-clock.yaml     | 1 -
>  Documentation/devicetree/bindings/clock/imx6sl-clock.yaml    | 1 -
>  Documentation/devicetree/bindings/clock/imx6sll-clock.yaml   | 1 -
>  Documentation/devicetree/bindings/clock/imx6sx-clock.yaml    | 1 -
>  Documentation/devicetree/bindings/clock/imx6ul-clock.yaml    | 1 -
>  Documentation/devicetree/bindings/pwm/imx-pwm.yaml           | 2 --
>  Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml | 2 --
>  7 files changed, 9 deletions(-)

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7jJPQACgkQ3SOs138+
s6HL2g//ZoscfSZkpDxD3dW2jxtxiLW+++f387MavWHS9QM8PYT+3MexQxkUWyjo
MAxhB4FCLFjHaMCl2sD1vH/FkkfIMPzdV8TEtEGlIm+YO/pDci2EYfHOUHsmZe/A
Dnn+e7XBzuJ2P9DwUaqszRXB1oO6zb32T9tklAN3qeF/W8Z44kNWE1C5AzlM7Ivw
q1AoGUYx47iq0Wcqwq/DYATIc1BxT8OGl+rEUGnXXWbLS+NYVT4wi7ML6heNqdBl
+2KbtWFzbdF3DyA1/b+3XVCGHGrGAnsLMjcNqJiLNnnbIS3v9I+HvzCGNGDDQiM1
Ld8CfrsPzbKqMWYXhAcFTDtf7oyHrjPt/t1FiTok6i7yQNZ2waHpPF1GKbQ5SXe2
ITA1XWnSaLJEIqXZMllgQ6cZtxIJmb9rjmbGtzq+YjjNTBWn2Us8K4hDGdx65ILl
vL8fZd6DPHTyJF3CwK+D7ObJBWqjaZjNf+ViQRGzXTIsRufnA9xR3hNDMeAETJKX
TGxOheAe1S9O0Rma6V0G1g0nbqX8V45/z1Tpd5L3rp9/ZRrg2RK+70+hBtbR2Jc4
vLdDpb/4lyskRTU+DKgNtReVD2DP9okNErL5eGTXO81URug5Kr1mZB5+RqKjelnI
mV/2sKfFnSX33cg3hbP/sDwDxMB+sjjGP+K1JXWxVj9Ez6osPPU=
=WSuJ
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
