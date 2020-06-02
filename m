Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27F91EBBD6
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Jun 2020 14:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgFBMjS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 2 Jun 2020 08:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgFBMjR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 2 Jun 2020 08:39:17 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C07C061A0E;
        Tue,  2 Jun 2020 05:39:17 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id e2so12565814eje.13;
        Tue, 02 Jun 2020 05:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F1vjzv7szM2SvYyH6cUhGI5pKgsWnnEULj32MB0yFS4=;
        b=WYnvAJWjcIH5V3n93yd+hBCgHBYATbMf4IhCsfwQ9Oy1ZM9Z6rPS+WbFRPRAFWV/bF
         g8NVrkY1eAE3itDiEE0aGbFh82DXnCYGwNCAVEFB9InkZi2h89PET4FN6iEgxXtQf0uv
         Tx1pit9Jd6xv3AdFKIWO7ZejWVHuRhkC878hAEFOiQFDje52U6ZlKNLeqXVPUoQX4T4e
         GB7+N4Vxwux1TDzFrN8dajdxWthW3Hz1N2MRMmG9WVU48aO+F4QH0DSedqbufQ+5ESWw
         ZkycrkFkAvLKMSlCKPX3yzohcyD9cGBxC439RRXOlwZ/WsIsfF6eXyxeDckOKQLJ9FRJ
         WJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F1vjzv7szM2SvYyH6cUhGI5pKgsWnnEULj32MB0yFS4=;
        b=BB14d8SyuMFwGhoajjNKDuiPWim1rAEeDZDpvIgcFSNy9BBXt1gN0KY8BticqwPm5q
         YS5QmpjD9FvwkaP+YVP5xaM4F8PPLAORGf++kXhmHk2OrUEFySZnpmxtFTySwV0XPpna
         K2uEKTRK+7kT2cYPsDSqfoRqYpg+nePLspO4LypWyz3s5EVMu0PMo7d6vonH5xueXsrI
         e+fwR0YV9vSk+g/kHr/+h0aCfCJ4gzzJ1sgO/drawwC1eqJWG2q3yEUN469rtrmyvIc3
         3wA1m14/qUF1EOZMpSSrcBEHguTLLQ+ZsRveFkMT1KEYs0kPKUmc0lF63DvKOsDvfS7K
         W6jQ==
X-Gm-Message-State: AOAM530MRXOy8JEtVMlYmXmdtQws+Pze+iWfC0RLSPAV1cZppN5SIUad
        ZomhbtDaBwcHEOXnGleicesgGxXZ
X-Google-Smtp-Source: ABdhPJy0URsgXsVIryc33w0XdDF5+UsNv9pCt38qFg7zKESxBcV+HSUzFeWuuPBLGmUt+XridHj6UQ==
X-Received: by 2002:a17:906:7ad3:: with SMTP id k19mr22505707ejo.464.1591101556221;
        Tue, 02 Jun 2020 05:39:16 -0700 (PDT)
Received: from localhost (pd9e51079.dip0.t-ipconnect.de. [217.229.16.121])
        by smtp.gmail.com with ESMTPSA id dc8sm1522400edb.10.2020.06.02.05.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 05:39:14 -0700 (PDT)
Date:   Tue, 2 Jun 2020 14:39:14 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        David Wu <david.wu@rock-chips.com>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: rockchip: simplify rockchip_pwm_get_state()
Message-ID: <20200602123914.GA3360525@ulmo>
References: <20190919091728.24756-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
In-Reply-To: <20190919091728.24756-1-linux@rasmusvillemoes.dk>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2019 at 11:17:27AM +0200, Rasmus Villemoes wrote:
> The way state->enabled is computed is rather convoluted and hard to
> read - both branches of the if() actually do the exact same thing. So
> remove the if(), and further simplify "<boolean condition> ? true :
> false" to "<boolean condition>".
>=20
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
> I stumbled on this while trying to understand how the pwm subsystem
> works. This patch is a semantic no-op, but it's also possible that,
> say, the first branch simply contains a "double negative" so either
> the !=3D should be =3D=3D or the "false : true" should be "true : false".
>=20
>  drivers/pwm/pwm-rockchip.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

I've applied this. Irrespective of any feedback David would have this is
correct and a nice simplification.

Thierry

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7WSHEACgkQ3SOs138+
s6EIvA//U+YBcRa/yOWyp3jhnv0UxhIHPIk4tcP1l5N4cNtnj23Y4VCdv7baJM4M
k2OKqKanjnp0AROTYeu150CEqI+xXuND8W7PKRIcCTLkS2Gy7WBXh1ezlCRupzyH
uYRPi+PY5ZkX/owSFRy+2Ii5o5ywzPc5aH6hqsLfKGzkUrJA/wFsTH85JfmEwwTu
8WOYkvO8zGqaA32B5Orx42x4jH020aa/PorZsl1WXjEnqN7zc0Ke5CZxZN/puoE+
YuTAqG9NDMFiZzkeN2vHbuafUyBk0zSRiz+/1KTkKPnubJ0bLncbCZRonghCCCNV
3hWEB8Fm5pP9mo5Ht4q6Z4or2JkuWbcu3IwyE9SrerLtcTbkbCqaU3kkvKFm72Gy
QN2iUJiGHk4i7PYqNEAWfQ9i16U7+2nbb6rroHiHcKR8G1boWJcwyg6dwVto5uUN
47k4J8HTAZBsDysAH4GVavggIig9WwMMqprGhVRA7CLhMtp5i/g+9fyN6OmxmwAO
9N4Sxs/ScWdReU63b0DbWRdEQa9OVK0BWz13uoESETZcfeH9ggZpY2EDBQ96KRY5
cG9Ka88WfHJJ7qth/PcHsu94fFnbcPkZeca16guCWoYIi5SdCJeDuPVfbjV1xn9T
Fu/bhyvbAecyGACpTbIwZb5DhtT4HYr0IX4Q4mJ8PfM8b0BdR4o=
=OaiW
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
