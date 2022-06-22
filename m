Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5BC554B60
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Jun 2022 15:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236864AbiFVNdI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 22 Jun 2022 09:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236483AbiFVNdH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 22 Jun 2022 09:33:07 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68BDF5A4
        for <linux-pwm@vger.kernel.org>; Wed, 22 Jun 2022 06:33:05 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id o10so23930322edi.1
        for <linux-pwm@vger.kernel.org>; Wed, 22 Jun 2022 06:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FcLlXIO6MNTuA/DtJphXo2NWkbrh5Y0yDYtPPosioOU=;
        b=gjqj86+N1QLdHsOwy1L0GrGIXDCarm3OqHHvQS35smrP5HWj58Rhq7DAkYdfM9PjB1
         Cgi3scIZPSsmnEF9jjobbBsmk8f6XZ6jzk8RkoGtXjQOk1Lr3ED1XCGC0bO0YqbLfGTY
         3enxVvfqa1gzscBjjJB8aU5wzfTsIce/8l8gqwTxl0lf0JaV/2yV1nO+SoYyP4+cLgUN
         myqr7pdexy5y9PGYKS4AQ23fRQMKCkd5N5uKRGzH/yOPb8PC2Lhpu5Ij1Qqu+EcY5CCS
         b1RS7EdxvCu9mboTeIfbykJlI16pj9ybdZFVNpEFs7MNScUGapkIWjUALj3vp26aFuf4
         KFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FcLlXIO6MNTuA/DtJphXo2NWkbrh5Y0yDYtPPosioOU=;
        b=gC4DiNdzPNQmz+zWm9mXNMDcXoX+YlAdncNLlBLiC4/nILJ/v4ntkOEwfu0tN9mvYf
         iftdiE5NRSVGIEV00rKCEsFit/fjaoS9U4pD6wsXRe0bw9trzk/BpVKSBiulfvQfQTPw
         q0tyogIhZ3ix+oH22FvW7E99YInxsVjOSl2NkWJIcrB3ogAkdS7O0O/as/8Op+hV06Jz
         LpnXYr0fQdsTCNSimJZIgipIc0Fw4wvb38aWUqQ/mXLRv32ugep0H8/RKmZcJ7uJdYUd
         5ZtEoVSO0JVQXSsQqqrsTwyizl0poNwNjuZBAXPQu2L0IvJS7iCXDjIQPfKIS5gblzQC
         EkUw==
X-Gm-Message-State: AJIora/hVR5vHaW8HFNdO3B3f2Ol11yY5mK7iZWzhlSm09+4bvNzwhsp
        E3WT7+8+1P5hS8kdCrWrbqmpcO3ds9I=
X-Google-Smtp-Source: AGRyM1tpFBH2/UUcoqbq/T8k/yDqPOC52ajF+VdIsuhUSRp7S9okVlMnuHhOX/LHXCGw3FbVumQBNQ==
X-Received: by 2002:a05:6402:5384:b0:431:6d84:b451 with SMTP id ew4-20020a056402538400b004316d84b451mr4182545edb.46.1655904783439;
        Wed, 22 Jun 2022 06:33:03 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ss17-20020a170907039100b006fed787478asm9237043ejb.92.2022.06.22.06.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 06:33:02 -0700 (PDT)
Date:   Wed, 22 Jun 2022 15:33:00 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] pwm: Drop support for legacy drivers
Message-ID: <YrMaDKs3GubDfXA5@orome>
References: <20220521110203.790597-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aOZkvts9VrZFHxOs"
Content-Disposition: inline
In-Reply-To: <20220521110203.790597-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.2.4 (c3baa83e) (2022-04-30)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--aOZkvts9VrZFHxOs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 21, 2022 at 01:02:03PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> There are no drivers left providing the legacy callbacks. So drop
> support for these.
>=20
> If this commit breaks your out-of-tree pwm driver, look at e.g. commit
> ec00cd5e63f0 ("pwm: renesas-tpu: Implement .apply() callback") for an
> example of the needed conversion for your driver.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>=20
> on top of current Thierry's for-next branch this compiles just fine
> an allmodconfig on arm64, m68k, powerpc, riscv, s390, sparc64 and x86_64
> after cherry-picking 357ad4d89828 ("sound/oss/dmasound: fix
> 'dmasound_setup' defined but not used") to fix an unrelated problem.
>=20
> Still I think it would be nice to have this cooking in next for some
> time after the next merge window closes.
>=20
> Best regards
> Uwe
>=20
>  drivers/pwm/core.c  | 82 +--------------------------------------------
>  include/linux/pwm.h | 12 -------
>  2 files changed, 1 insertion(+), 93 deletions(-)

Applied, thanks.

Thierry

--aOZkvts9VrZFHxOs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmKzGgwACgkQ3SOs138+
s6Fd5g/+KoZRbLjDVfCj68W7Aczc9aNFL7ysuQuIIGKwroefYXY/baJdj7LzHkL9
vei1d+T3ZuH4pB8xmX3N1DEa81Z9qxKfxFCpm6kjbwgoMKzIymkuwrck6fg0eD5L
e1AahEuIkwjiBR50MUThYczvKPbKPoIjv7fkq/9ArtV6MSndb6lnM23lNVjzgnJd
Dh4mkUyHR+sB8oB6lvO4gLgKV7hrxaFenrjOt14nw7nf7/cWkfqEjMdwZNMVL/UH
QL5S1r4T8Tcy62IFBWvpoBZfPoKqd8MyyhMClsZltQUwxdHjxI8SscjGRKZX9x15
iK54d8W9FmEDBNv8M6rloPFZHharpsLMguyCeOBNkYx4OAkWehJONRfsLxdvZU9w
DL100JQp49Xl32VMaaWXH4lYSzRW1KVZ9tLbHQPhYkOWDxCg3lZW6Ey7+CxxEMaN
xdq7J37MLFwzrLPJXdgB51PccsDYW5GQd8Aiz5mKQ3X5yhNlhQUuP4orFVrVLLlQ
8PHaFuGH9vymzglJ7SnJz0ciEnBoYwP7LI9U/hkq6tZyrOtDLKizU9fSCbsla1A5
MLVWBz0FoEXf4nbjIxyRFYsFH+tVvnYqoMnPmCU/sufIR+3yiAHUvwJc+kXMsfm8
6ZQe+g+P9nrh9ke8eo8GDtKXcSVI6D8LfTtrwW+AFfE+9+ag5mA=
=lpJt
-----END PGP SIGNATURE-----

--aOZkvts9VrZFHxOs--
