Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4EB2FD497
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Jan 2021 16:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389284AbhATPx0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 20 Jan 2021 10:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391071AbhATPuy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 20 Jan 2021 10:50:54 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C503C0613D3;
        Wed, 20 Jan 2021 07:50:14 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id s24so3527022wmj.0;
        Wed, 20 Jan 2021 07:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EqlppPt+zKK98ux6mxMoGiAS/zm/3st9EqGh9uM7puw=;
        b=Z6Rt1bJygQMu48zj8lDlSwMXm4t2WK+HXlNwxuOS0/MJ+6fj98JDDyioQGomRgRWfm
         ZomKNprLEF6u3MvogHjtYDliFQHokuUP8Z5N/KFJmTkxeJd2JnHGG7FR6X3dFt3HwLcT
         jg6bbuhptCdiUQl5bKNr1fDqrpWe/l10UKWDOSDps2y2puIROlkX2mr2895TJ/DC1Ooh
         oG/I9aGGaNeDSLG1ZuKTDeyvp6N6qE6LC5E0Ps6oz33ay0+wd3ZUM0/y8I/BwfRPnZLM
         h09N7uZF6l3XLZbxYE715tPmgQNNaJZUDrf4R9eiBCMshEqbKdeJCW/I/kfHyHshM0La
         Kujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EqlppPt+zKK98ux6mxMoGiAS/zm/3st9EqGh9uM7puw=;
        b=tHh5pW0e/iD0M9gaY6OHmLMDfLX/6bJhWKySB/dSDjsmPXP9qHjb/nPDBWowxaTj0G
         LQi798lfcbdobIGG/HOxWk2p7E6hAzm9JnEm25CazZ7pqBDGI7wW0DgUd9rZq6VtKk1l
         WQYb5ZG2EwCd80FWHYQq8EFjFXuGguRJj+UFXVb9op7TQzW+BPGnimzNzdFBCzczgDpT
         IKUW0HkfPhP6yk74Owke0Hvxc9MW4eiR0oWyTXyVNFUmZzR4/tpLBygy9+kVJePu8Xec
         tp/5VjckJj8fB5MblcWi/smW3CbtCx8vk1PGckbk3EmObkdok91OMWMWFfSy7MDh3ZQ4
         Iykg==
X-Gm-Message-State: AOAM530wukAgrjxoIs1D0OyNIRpdnDM+iaIJBwMmm+1vpN5VNQmzTDnj
        oQDixER1/mpM3bNiA3tUd/oDhE9pFu8=
X-Google-Smtp-Source: ABdhPJz4sNocbfXVxnuMlfFi/+2wbcEfM9+A/RkiQaIGktR5doESPt3ITTPeGs8JWtxCKyLvKVpTHA==
X-Received: by 2002:a05:600c:2253:: with SMTP id a19mr959087wmm.75.1611157813078;
        Wed, 20 Jan 2021 07:50:13 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id p9sm3272451wrj.11.2021.01.20.07.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 07:50:11 -0800 (PST)
Date:   Wed, 20 Jan 2021 16:50:09 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Jun Nie <jun.nie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: remove zte zx driver
Message-ID: <YAhRMaJhYJZat2SI@ulmo>
References: <20210120150944.1688327-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h/58VpChfMcyTptO"
Content-Disposition: inline
In-Reply-To: <20210120150944.1688327-1-arnd@kernel.org>
User-Agent: Mutt/2.0.4 (26f41dd1) (2020-12-30)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--h/58VpChfMcyTptO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 20, 2021 at 04:09:22PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The zte zx platform is getting removed, so this driver is no
> longer needed.
>=20
> Cc: Jun Nie <jun.nie@linaro.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  .../devicetree/bindings/pwm/pwm-zx.txt        |  22 --
>  drivers/pwm/Kconfig                           |  20 --
>  drivers/pwm/Makefile                          |   2 -
>  drivers/pwm/pwm-zx.c                          | 278 ------------------
>  4 files changed, 322 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-zx.txt
>  delete mode 100644 drivers/pwm/pwm-zx.c
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-zx.txt b/Documenta=
tion/devicetree/bindings/pwm/pwm-zx.txt
> deleted file mode 100644
> index 3c8fe7aa8269..000000000000
> --- a/Documentation/devicetree/bindings/pwm/pwm-zx.txt
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -ZTE ZX PWM controller
> -
> -Required properties:
> - - compatible: Should be "zte,zx296718-pwm".
> - - reg: Physical base address and length of the controller's registers.
> - - clocks : The phandle and specifier referencing the controller's clock=
s.
> - - clock-names: "pclk" for PCLK, "wclk" for WCLK to the PWM controller. =
 The
> -   PCLK is for register access, while WCLK is the reference clock for
> -   calculating period and duty cycles.
> - - #pwm-cells: Should be 3. See pwm.yaml in this directory for a descrip=
tion of
> -   the cells format.
> -
> -Example:
> -
> -	pwm: pwm@1439000 {
> -		compatible =3D "zte,zx296718-pwm";
> -		reg =3D <0x1439000 0x1000>;
> -		clocks =3D <&lsp1crm LSP1_PWM_PCLK>,
> -			 <&lsp1crm LSP1_PWM_WCLK>;
> -		clock-names =3D "pclk", "wclk";
> -		#pwm-cells =3D <3>;
> -	};
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 0937e1c047ac..4c28d0634ce9 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -601,24 +601,4 @@ config PWM_TWL_LED
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-twl-led.
> =20
> -config PWM_VT8500
> -	tristate "vt8500 PWM support"
> -	depends on ARCH_VT8500 || COMPILE_TEST
> -	depends on HAS_IOMEM
> -	help
> -	  Generic PWM framework driver for vt8500.
> -
> -	  To compile this driver as a module, choose M here: the module
> -	  will be called pwm-vt8500.
> -

I assume that you dropped the PWM_VT8500 symbol by mistake? I can fix
that up while applying, so no need to resend.

Thierry

--h/58VpChfMcyTptO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmAIUS4ACgkQ3SOs138+
s6GorQ/9H03QpIsEKocl4Q/E21QjGC1fWkImdJDDJ/WlagJJp7JQJygAkUzsrzyp
6KdVa/1fzVdpi8JWLwwaFI5gWWP0fBejR5W/2idob48AU12LDp3BgPdH+xz8CDLe
IM92d+oNIwGcfbbbSIB46TMAJ4Z2QvWFTt0L1CYpxcJLikGzPazeLyh6VnbtNQMc
DDO7fUkxwD8ILeI8C+TCGpls3jiXDoCR/M0C0+aNkw4ZhsUydsQlY0TBZWUABWB2
9mOwpRx/Nm6ASuvwiSGWKsFgpths9d+6QowAq6L3vjnHFVvRSQVnQklIbqWzEhzH
QVk/Q4dkFILnGlW3ciIgoj8/Lj79ecXkiCLmhBpsw8ABk9MUe8JLowOGFsYzJXNO
I4MtpkTk8T5wrnendacB7XTbneutQSTgxnIaTs1ZVix3eBWx3TxsI4wIfkymzV5a
t++fvjQtrY5qRAuiqhynjnRL2KOyA55hryuu26c57+dl3hvQKPVeuAZ1EgLPic5C
uf/CuzQGlPibwZNI8NqzV5dtBaHZm+FcZnYJwSQhzfJaKd9qbspDP08umI6x8ica
jUemm/5LtYNbw2UiXiVNl2pHliwSW4429woEwsMmSTCgEHoiQCQG5mR+0PF3mYQ8
r7ZVO5+J9C2YA7ncaEn1/9kwBYhZLU16J6/LHjfNa8QxJ/tt3K0=
=EytG
-----END PGP SIGNATURE-----

--h/58VpChfMcyTptO--
