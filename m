Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B59823697F7
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Apr 2021 19:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243310AbhDWRHW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 23 Apr 2021 13:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243246AbhDWRHW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 23 Apr 2021 13:07:22 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6056C061574
        for <linux-pwm@vger.kernel.org>; Fri, 23 Apr 2021 10:06:45 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id z6so8596068wmg.1
        for <linux-pwm@vger.kernel.org>; Fri, 23 Apr 2021 10:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GeNC38T5dHxMBu24uT7gyu9gPGAEn5EuXtFTyIHTKi4=;
        b=fEef3xffsw/n5iQsrsHSQZgQXjnvsbaVRAO4VE2+7wxjQQ6FECQMtdvUlGDzBj/QKz
         U809nXjkxX4hPeYu6kMhBCQketBBJf4tYFOb2ABDTe/M7qMEZJGhA5od76BFjaURef5X
         AP+Nl5uUqqnMlYz1sMjuL3iAcXbuqzbTuLP3kkMDBJkQVoLoEr5rt/PJb/rYrSadEtLU
         OYbKd9R3RbmdpourUfYc84Agf4DdzCKCGxPCR1lZ4YUH2zm4xjetkilntTFq037w/4yy
         X3VeFMJym+7Jr+PdtONjc9ztMg7Smg0wzNKb0h5H3iqS+CnqXTew2ql4Tyw66GsaJa/k
         K1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GeNC38T5dHxMBu24uT7gyu9gPGAEn5EuXtFTyIHTKi4=;
        b=YW1zCbRPfuYjVxGns4GwKVR1M546TAUdpj18aKNqdEtzAu0z0dmXGo+xOQfqWOUdn1
         edqJSeFmsXBkigpvRUic+f62mCd/9C/qmKuDrxlfrHlF3TBXEAu3ZSMLzB7aKAuJNJOE
         i8+UJ5iZAN95RBmzTfY035TMMLLB4nfBRT/Cibb/1HY4d39iujDlwi4LdkP4iJjVFg5W
         dujkmEXR60Xv73kTi6UrqUkoQXJRTWHuqZ3eu31mAn3+54oiqw+jEHh5yeJ7k7HGbGpq
         zMwPjdspHSv3LTUNkpbw+LzkBG1/xHVaFGz13l04VtN6pMMZZcfTejlCQiCTRRcHjR68
         lwdg==
X-Gm-Message-State: AOAM533obw27+eZnIIgiScgrTLVxr91oY31uB2vhJZDLk5F5UDyXhPmU
        2WKQbVMm9Svq7uaOBnsXo3A=
X-Google-Smtp-Source: ABdhPJw9aKdppA2puyid2A9p4VUDmBhqP7xfd5sjLy1KB2OKeexu6hzE4hB0c+HdfbxNNxsm+tePdg==
X-Received: by 2002:a1c:a9d5:: with SMTP id s204mr5422623wme.24.1619197604475;
        Fri, 23 Apr 2021 10:06:44 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id x2sm10539976wrg.31.2021.04.23.10.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 10:06:43 -0700 (PDT)
Date:   Fri, 23 Apr 2021 19:07:32 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Lee Jones <lee.jones@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 2/2] pwm: atmel: Improve duty cycle calculation in
 .apply()
Message-ID: <YIL+1APYTqWSKRIc@orome.fritz.box>
References: <20210420095118.1571344-1-u.kleine-koenig@pengutronix.de>
 <20210420095118.1571344-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yZbWICAcXqer7Kjy"
Content-Disposition: inline
In-Reply-To: <20210420095118.1571344-2-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--yZbWICAcXqer7Kjy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 20, 2021 at 11:51:18AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> In the calculation of the register value determining the duty cycle the
> requested period is used instead of the actually implemented period which
> results in suboptimal settings.
>=20
> The following example assumes an input clock of 133333333 Hz on one of
> the SoCs with 16 bit period.
>=20
> When the following state is to be applied:
>=20
>         .period =3D 414727681
>         .duty_cycle =3D 652806
>=20
> the following register values used to be  calculated:
>=20
>         PRES =3D 10
>         CPRD =3D 54000
>         CDTY =3D 53916
>=20
> which yields an actual duty cycle of a bit more than 645120 ns.
>=20
> The setting
>=20
>         PRES =3D 10
>         CPRD =3D 54000
>         CDTY =3D 53915
>=20
> however yields a duty of 652800 ns which is between the current result
> and the requested value and so is a better approximation.
>=20
> The reason for this error is that for the calculation of CDTY the
> requested period was used instead of the actually implemented one.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-atmel.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)

Applied, thanks.

Thierry

--yZbWICAcXqer7Kjy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmCC/tQACgkQ3SOs138+
s6EneBAAiYyw7jW7tEb5ZqjfZ/YbBSeYPHnRYC8Cm2tzLVldsyFf7QruHnqzDRb+
MtrhwVT97N1/g575JcxsCuKm3dYGny75LcnjewwY2dEMz85aL0YhEdZeZdzYd6Zo
XpOr7xQXq4xSdCjKhcZEQn66ZJKfzaTCtOwUqSbCujgU6Vpliucxkf0a3/nEohXt
mAVOkbir1zzRZVo5mV9h5rRUhd6SMfDzdvFafclnm+LcxVj8lYrCF6W4GZSimt95
1SG/YRs78QWTB3fR7R5TY1oWEnBPOLzc4BIvNDHOw1/0c3zT3Hh6qmjbxoK9FGUY
m0fBMO9uswnYIlD5CyRs47k+bn5HzykOh6wAOnqX3SqAy3CDi/s1bwwqm4EatSjM
vNgJ7lRxfcl0GrihpyWEdCEkgN7E03ThGYpHD8XZtKnCvv3nXdMnpX6apakMyr0O
p8IFA11hmGKffOxFIclpMBCAlkio1TPWX9rBGmqXrt7x3uuGiV37hAcSxFIPuMqn
2gj/Vuellx/VLR8VQEdiSSSh6STsaV2g1nC4MttcHORnQQTN9o9UdVi2L7a2rMDw
sfQApdrcxPktx8R5nrmuoAXh1N8rLMf6zvzoh+aEWZotedimEfQu7ifLki22p9QS
D/Y2l1LJHVgRE91pV1q7KgKM1DSnC3imSslFCp4BFSj90WKAxsg=
=J+nG
-----END PGP SIGNATURE-----

--yZbWICAcXqer7Kjy--
