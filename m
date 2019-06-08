Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21A7339C70
	for <lists+linux-pwm@lfdr.de>; Sat,  8 Jun 2019 12:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfFHKbI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 8 Jun 2019 06:31:08 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:60816 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfFHKbI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 8 Jun 2019 06:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1559989866; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mjUlMAfq0xB1yqTJJJZKG9pZnAqTQaYVUiyezB1q1UQ=;
        b=aI8QzaakpPRpb0PGEhibv4Pb8bb4V5fAmJlFMM0vaHkZ9d+sHJDhI3BSecbG0r7TxZdTDW
        2GABj9M8K6aCfH67SSc/oypLI235h1h1O59x/LiJBr/LO1LVi4v8fgHnieO3Zp1FgDVAQu
        ablMqrked8DNPfL0/Z6VVp6LMsvBfUs=
Date:   Sat, 08 Jun 2019 12:31:01 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 6/6] pwm: jz4740: Use __init_or_module and __exit for
 .probe and .remove
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <1559989861.1815.10@crapouillou.net>
In-Reply-To: <20190607154410.10633-7-paul@crapouillou.net>
References: <20190607154410.10633-1-paul@crapouillou.net>
        <20190607154410.10633-7-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

I misunderstood what __init_or_module was for. Please ignore this patch
(the rest of the patchset is OK). Sorry for the noise.


Le ven. 7 juin 2019 =E0 17:44, Paul Cercueil <paul@crapouillou.net> a=20
=E9crit :
> This allows the probe function to be dropped after the kernel finished
> its initialization, in the case where the driver was not compiled as a
> module.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>=20
> Notes:
>     v2: New patch
>=20
>  drivers/pwm/pwm-jz4740.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
> index f901e8a0d33d..1b5077825721 100644
> --- a/drivers/pwm/pwm-jz4740.c
> +++ b/drivers/pwm/pwm-jz4740.c
> @@ -145,7 +145,7 @@ static const struct pwm_ops jz4740_pwm_ops =3D {
>  	.owner =3D THIS_MODULE,
>  };
>=20
> -static int jz4740_pwm_probe(struct platform_device *pdev)
> +static int __init_or_module jz4740_pwm_probe(struct platform_device=20
> *pdev)
>  {
>  	struct jz4740_pwm_chip *jz4740;
>=20
> @@ -169,7 +169,7 @@ static int jz4740_pwm_probe(struct=20
> platform_device *pdev)
>  	return pwmchip_add(&jz4740->chip);
>  }
>=20
> -static int jz4740_pwm_remove(struct platform_device *pdev)
> +static int __exit jz4740_pwm_remove(struct platform_device *pdev)
>  {
>  	struct jz4740_pwm_chip *jz4740 =3D platform_get_drvdata(pdev);
>=20
> --
> 2.21.0.593.g511ec345e18
>=20

=

