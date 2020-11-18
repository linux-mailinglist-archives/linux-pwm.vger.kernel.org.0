Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A1A2B836B
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Nov 2020 18:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgKRRyv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Nov 2020 12:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgKRRyv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Nov 2020 12:54:51 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181B8C0613D4
        for <linux-pwm@vger.kernel.org>; Wed, 18 Nov 2020 09:54:50 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id o15so3088369wru.6
        for <linux-pwm@vger.kernel.org>; Wed, 18 Nov 2020 09:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nZmuCf+It/OPETbe6/xvpbMXjzpKho14+DSnNdmU/kA=;
        b=opmjglZdHhPkB9T3EnKRVQ+RIjcqyziB+pURvdKluwpZWp8jYW5IokffCUUeyX8N/w
         w/C8Ni1SQ1BanQ9NXD5OtyleEY4fjPTA3nJgqqkGVn+rLWHsWi4zoVeG3JGhZnVHQ71L
         JtCp7F1q9XFdyDKbvBlTvNhA99qIH0qiy6+YCOib7cmEB+WM1uCepR/ybUrujoxmnc0w
         wBsVt/GOlr2gVItSlWjNs5XqvrYNLUOENFTA4dRgmWBCP4ZkAutv2e4PeeFOa8RDSw/N
         gKjeeG0iQpeQy+xm+bppxb9ITX6PY8S6BvldvOEXwxM88noG0CuqwpgrDZwbcGrpjXug
         V0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nZmuCf+It/OPETbe6/xvpbMXjzpKho14+DSnNdmU/kA=;
        b=R+QopBAtt9Hkv45jBDBdOmfxXoq/s+74cjsU17wOY/2Jg3wUnkiPT7z2H3x+wVpwLa
         gokJ1QDVfDfAALd9DwJf6Y8Mf3s5IDvazWBTU4HHREKaQuBCRANlviFu0TPJtpMtmFcH
         7j3J4caSOhAs4U/vOOcV8oLywUJE9+v+ZAhwVNGZ/HHWhxphSaRY3tjWwBFCd8phKdiP
         +f9ytOegoFw0M0grUT/q0MBrEjEhHjVbujd29KsQ17N0RM2IGUYqRiILfTrPGl4wy4St
         jENb0GTORk5nH0hVCIXQC2wCzbsHU4gC7nxxOzjST1GXG3Qk77aAw+XDIWz/yS6zMIud
         acmw==
X-Gm-Message-State: AOAM533rnSH9ROPhVxvAb8P2pVuXyLFyATQpM74M3gGyFavAmTUlXfnQ
        TbePqRYztF7Gw+QwB7MUQV0=
X-Google-Smtp-Source: ABdhPJznmCI2BfzgvuU1vlnhd8uPhK3/2fYsTJR2yqgBnssTNqNQC42TMOxXnFO0/6TFree8VOSzqw==
X-Received: by 2002:a5d:5308:: with SMTP id e8mr5897086wrv.299.1605722088858;
        Wed, 18 Nov 2020 09:54:48 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id k64sm5166250wmb.11.2020.11.18.09.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 09:54:47 -0800 (PST)
Date:   Wed, 18 Nov 2020 18:54:45 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/2] pwm: fix dependencies on HAS_IOMEM
Message-ID: <20201118175445.GA3552669@ulmo>
References: <20201118094509.365684-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
In-Reply-To: <20201118094509.365684-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2020 at 10:45:08AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Drivers making use of IO remapping must depend on HAS_IOMEM.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/Kconfig | 35 ++++++++++++++++++++++++++++-------
>  1 file changed, 28 insertions(+), 7 deletions(-)

Both patches applied, thanks.

Thierry

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+1X+MACgkQ3SOs138+
s6Fdsw//b5/u8Y/mddviNq1ZgRV/bEgihx+C24bpBVcxCKHmlmo7iTiCmBg8YbTP
eanbAupCGZRLsOJ58FKVQKphbNVKWu7F27V2VhdVQRjz0AqH2vFKHIDcCLNnN9Lx
waxWJ0UgaqL7bweYwiclzhIUgmlIEsFVjhIhmX/FjoydD0gWHNLD99BaHLVmWCm3
DAQWnrothkITmglvMMlXzT2sG9WLh5nxFaWrs5Q2wLU1oB0to6l/VdpsA9TAMrpH
IDp7Xg/e2ZRgMQwn0PNpKa98wGciLobfWfr7kj6f6xkmOt1zdrXxgF574lrgw+Ku
5cAxjp6rFsEGAMY/WHepRBSPCCT800Fbot5Ck6EjEEOAqB0kjh/7VA7yq1X2cUuM
qwVoxUaIPMylVpr6CLYSnb1l2rcYCFM/LOmQdaJ2DIIUUYz2rBe8TRC0ovB08agO
mRPiSs6jzecJPCjx5ijTY0CPsVISAPXccHwL+AVxT/DcVqv/sWMjfZq4W4tLSv18
mOJSXcYiU5pNYi6w2GKcuRYh6gspeC8q3Tmqas65Oc22yAwom0F4Ok4QNQdO35SI
Ag+12gEIf4AbaYyXkXQazLWjzW1+kOZpoLizTYNkaNzPWjkJtdrvjyuFoScN0Gzp
P2SVsSiHwFzyzWbgDsZ/MKunnOmqm9YpkcFALAqQPkKau8uJOOg=
=qRZF
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
