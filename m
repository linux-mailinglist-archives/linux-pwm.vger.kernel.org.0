Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2BCA134337
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Jan 2020 14:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgAHNAa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 8 Jan 2020 08:00:30 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45474 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgAHNA3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 8 Jan 2020 08:00:29 -0500
Received: by mail-wr1-f65.google.com with SMTP id j42so3214190wrj.12
        for <linux-pwm@vger.kernel.org>; Wed, 08 Jan 2020 05:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vu/TEPKi3gH8supR1Fm33b81xSnPq5jh2aLIJG+pAp8=;
        b=C38VsHkaSiTnMp8oEqik2sQ+UdujLVRJBOZhWNt4HwDT8TYYXUfc63GaVwY5Bm1w9C
         l1wjcqYxCFc4z5QuoCYAByJVCEomoXceMFWonezy3nkqwlFOVaQtUzOMEjcSI1Gqndrq
         PwCGeih3fbaQqS/TdXBE0iIUpYSKxkmOmnOc7cWU47OH5VHIXcTwa2YBK3zXz0eWEA9k
         zHctIPV5y0jf0OR4wDs4zphKIonZ8+snGFwIaWWURmlXByQoWBXh7/Mz2/I5AV4+eouP
         hOVz3Jf+EF58eqmBJBljqNoiroJzL/84XqKfiH7SXJgg/ez26ejE9IxJHfZFbjZmwl/R
         66hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vu/TEPKi3gH8supR1Fm33b81xSnPq5jh2aLIJG+pAp8=;
        b=nbj9CqLGVtPVQA1tS241BMMzMl7St5DVUDiF5l+VR+a8X/JhDClRMRw2BF54pqrQA2
         wfZv8iGnNQUpeUGxKq3xvo+N2o/K29tR0g5QqcrW1M8clLDDN3R22mhUJWeOEjzyZBrV
         zCKrJZV6/CNM/rOKx9c6/XIK2AqIFOWKqMLzkXWgPjx5DvFadpoux1cNANsycpxDnAjV
         yPiBJU1p9Mr+tit7y/w4tvsgYCPAchCQBLUm0+y3JCG0mwNvbVmf5l4WmllR0or7D2Ko
         40eeelA2kgd7cUnSC9AsZ4dnSaqGhbULZkmGU9trHgjAWqVY7q49xzXFqvK5J4jTuOG8
         JvPw==
X-Gm-Message-State: APjAAAUckixjyPEq4/6t2dEtL9Ir65JTbO6pY0qxO3osuy+bta4BNeAV
        Qw8IaZ+9VVkPEAtFW8MQ2BI=
X-Google-Smtp-Source: APXvYqxfk6AD/hSdePxpW2VxHPJad/imk9QQ8DFlIIefqzAfODMxbLf89oGNQR1D54/rKDHPVZzaTQ==
X-Received: by 2002:a5d:4386:: with SMTP id i6mr4444474wrq.63.1578488428368;
        Wed, 08 Jan 2020 05:00:28 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id g9sm4228133wro.67.2020.01.08.05.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 05:00:27 -0800 (PST)
Date:   Wed, 8 Jan 2020 14:00:26 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Updates for the atmel PWM driver
Message-ID: <20200108130026.GE1993114@ulmo>
References: <20190824001041.11007-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7LkOrbQMr4cezO2T"
Content-Disposition: inline
In-Reply-To: <20190824001041.11007-1-uwe@kleine-koenig.org>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--7LkOrbQMr4cezO2T
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 24, 2019 at 02:10:35AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> this is v2 of my series to update the atmel PWM driver. (Implicit) v1
> was sent on Aug 15, starting with Message-Id:
> 20190815214133.11134-1-uwe@kleine-koenig.org.
>=20
> I updated the patches from the feedback I got in v1, see the individual
> patches for the details.
>=20
> Best regards
> Uwe
>=20
> Uwe Kleine-K=C3=B6nig (6):
>   pwm: atmel: Add a hint where to find hardware documentation
>   pwm: atmel: use a constant for maximum prescale value
>   pwm: atmel: replace loop in prescale calculation by ad-hoc calculation
>   pwm: atmel: document known weaknesses of both hardware and software
>   pwm: atmel: use atmel_pwm_writel in atmel_pwm_ch_writel; ditto for
>     readl
>   pwm: atmel: implement .get_state()
>=20
>  drivers/pwm/pwm-atmel.c | 86 ++++++++++++++++++++++++++++++++++-------
>  1 file changed, 73 insertions(+), 13 deletions(-)

There were two patches in this that were not reviewed or acked, but they
seem trivial enough, so I've just applied the whole series.

Thanks,
Thierry

--7LkOrbQMr4cezO2T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4V0mgACgkQ3SOs138+
s6GwPxAAi8QbyZuxjXTyrcwXhceTZn1UkH51OaRD7myFIQ8A/sanP7QV2f4jKug8
TbrVlK9dpSj96Ne9UfXBW3+5+JvNpVshrqsc/IcIq6i+honBrJz9upJMKxt0+YRB
wNMO5dM/XEzr93hAilRGrzW/63rPsqkP/Vj14Gf3lOo/qW9WoCbWx+3/1bupYwm2
2ih1zLbDrR6d8PZ2mFkTl7WRXqOVcTpk/pyauBy2R/sq+7iK92lL4dugjlgtLO/W
mwW1g/hswT2D0FQ7QYBgApRUIsKsaSjjcLairZFTTmYvYvGSzyAsSbWPkQfMrh/T
qmMrL6TP49Ba0Ce1X7sff1hIeGsMMuhveg1viKbXDwPV0pvuT0ANejXHoPsW0Dum
6iB9xNSGyYupsbFq+Wn2LXO6dkVNCAsMVoMnxTzgAMvxoxQ7erpktjOKl5vi2dna
MHid3SqGo4kdRmGyKbGPATocpC/+A4f5fqx36Wo2sixGFpfsZhfoh2uXB9jo2bNx
b1zVcUfHxjzckt3QJPgYALNtkv5cYqbfE5nayz2m14oJDzYd8LCBloEsqak3+RMm
I4xoip1+vrA8c9qF30qHJTz4ef9s0sVB25GPd/rtOEduWvRm2rAPRmpij2u326su
N4tqKheeJJ8vscS8j+9t+WYdAOVFECuCO6YHC9wikPuZ+o6PoPA=
=opLK
-----END PGP SIGNATURE-----

--7LkOrbQMr4cezO2T--
