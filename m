Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0075359E1F
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Apr 2021 13:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbhDIMAA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Apr 2021 08:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbhDIL77 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Apr 2021 07:59:59 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E58C061760
        for <linux-pwm@vger.kernel.org>; Fri,  9 Apr 2021 04:59:47 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id w3so8243460ejc.4
        for <linux-pwm@vger.kernel.org>; Fri, 09 Apr 2021 04:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EqZuvfHPGOA5RQngcKk4IFJfX6BWGMWUrRpUWcSRILo=;
        b=jFKK2LhLbcijK2DUpHZ0D/0WKwF3H3u2wIOKd7oT37wOeoFsOCNFE1woSgHjc66G2+
         fGDlxHoGWST/9a+2wlFl0BD0MkSI0uc9C3QyQ352LMFtJ/8a47qG9ZowLdI1doUqpHRx
         muGz9zNt/LF+bSUfS5ZvRWTFsUuLG9wpkglTJ6nFcDaihjtNqQ+8q/h83i9mYeNZQG1/
         SperVcfceWxU3jSa7sFHaqgvA+Uml2g/2AuPaMpAtR+nzwXUm+uuIdezqpVIP+YlqXnc
         b3RlECks5g4J6vWVn347HdFJPFBaCvjU7iUFsfbSGkF2l8xLtDgxtIMHCjp7an4mQ3zZ
         9zuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EqZuvfHPGOA5RQngcKk4IFJfX6BWGMWUrRpUWcSRILo=;
        b=XawX8zyVMG2LWa4tHiGgNpRQe2ynVxx+58cX2irJzmPn3vaHsCVd2k1AKsuPM0FJV5
         W9oxcMEahYWuVQcHxxOHEyj3K0NovZRsYZ6l7ZlXfI/zy8eloXte/KQqIz05HBVAADey
         otl7lTfc61ykXzfC7TYjieLY0f/yPEsQfMPH2SCLtFXEFP64p4wzsoVtCzNnDKajLEoL
         q+w5s2U2BAGB2vTDRILCG1avCSEccqV7UGht+IOLkmD1XeMz8tpfp1x15adBB5cPx2OI
         IQtgrvsXTsrSHypP4vbsDR57Kyj9JpANh3NX8lS5nt7jqq2IoqHOPWAK4qLxd6cYQx+r
         3jfA==
X-Gm-Message-State: AOAM530UG0zNLREwHsxVs6/64sHM3KhfVoUitYxEdUGhvn6bQyhvaok3
        gNRvOXT6vEWNg3LNGA2U0NI=
X-Google-Smtp-Source: ABdhPJyXLPKEXuEYGViK3VZ3o47clEBT3L4l4yenG9w8ZDeVZFhv417PIq8qLkv53vGUASYxl2kWtg==
X-Received: by 2002:a17:906:b202:: with SMTP id p2mr15830552ejz.244.1617969585812;
        Fri, 09 Apr 2021 04:59:45 -0700 (PDT)
Received: from localhost (pd9e51abe.dip0.t-ipconnect.de. [217.229.26.190])
        by smtp.gmail.com with ESMTPSA id ml13sm677433ejb.7.2021.04.09.04.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 04:59:44 -0700 (PDT)
Date:   Fri, 9 Apr 2021 14:00:20 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 2/2] pwm: imx27: Don't check the return code of
 pwmchip_remove()
Message-ID: <YHBB1HrlQ/DMiey7@orome.fritz.box>
References: <20210324152058.69022-1-u.kleine-koenig@pengutronix.de>
 <20210324152058.69022-3-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fkNmZleXoVpzbNf1"
Content-Disposition: inline
In-Reply-To: <20210324152058.69022-3-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--fkNmZleXoVpzbNf1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 24, 2021 at 04:20:58PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> pwmchip_remove() always returns 0. Don't use the value to make it
> possible to eventually change the function to return void. This is a
> good thing as pwmchip_remove() is usually called from a remove function
> (mostly for platform devices) and their return value is ignored by the
> device core anyhow.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-imx27.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

It's true that there's not much we can do upon failure, so failing
doesn't make much sense and therefore returning an error doesn't make
sense. So how about we WARN on the -EBUSY case instead of returning an
error? That should have an even higher impact than an error that's being
silently ignored.

Thierry

--fkNmZleXoVpzbNf1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBwQdQACgkQ3SOs138+
s6FOLg//Z1Hl10UcZGAZSSw1QVKTJhOiAB4CsXlgwyvp2BdNKTaiJITuGmVVrOgp
pykXpVyRDLJ8diS2I0Gq6PeKBJQYh1RMf6Urji8gCfP5y1S1IKrvtnHqZfHQ0Q/h
7D4NfVAiOtUNplMd2XVyxpL5TRdW9C74xftR6kQtyajgMOjEWko4RE2xvydIKj7f
EwYdC8H1eYmt/3/ElmhvAMfo8157Kcq8hG0xImQabQxalQOMIPEEHQdlJ7aPL/a0
2mMkCmfdOcvnFecZkJv+mVfxQB2z7j0mjcDeLhBFOB2AwjCZMa67OUEPiG0FJQ0M
fV1SuyRKuKDSCzzOlxZW5vyfu2IGQ1xSCYsEcV7uUtcIdVdIPPcfgURRoPytBkYe
9M3HrPyMc0wiaTt2Uu0IGx+DdOCDfBHKXYFqjbrwjh6wYMx7Gib2/5x2XM+8Gapr
p41NUreKWnj6DzDzLWREwVJkeiJQ4Gg/Nu/ec0H5/f2RnNdb9GINrLw68quiAyF0
gJnWOfUnHVeXodw4DktFYr/lRtX3geYe7oLtCBiwOqYop/jG+LBKMddZtGbt+7v9
RQoE2+8WFtwDU2evP51ZAtFkHEBndNR/z8RQ4TtiXFvbfcE2oNynYtH7gW1h0J+c
P+lQkOz3xezMKLLQAKi1kjPTiz7zsJ3W0cmC+d6adBcZnaUsG8c=
=Q61Z
-----END PGP SIGNATURE-----

--fkNmZleXoVpzbNf1--
