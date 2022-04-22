Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5A850BD88
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Apr 2022 18:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449823AbiDVQxQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 22 Apr 2022 12:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449781AbiDVQxP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 22 Apr 2022 12:53:15 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6624647F
        for <linux-pwm@vger.kernel.org>; Fri, 22 Apr 2022 09:50:21 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v12so5092925wrv.10
        for <linux-pwm@vger.kernel.org>; Fri, 22 Apr 2022 09:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vIda8rUPzAv0wsdC1hQLazIxXIg8LOpNVH2zqZLiyCc=;
        b=gb0Gmz0Ow5wwehxn8d/9Z4PyvSZwkA3Q09ZeFpIMdp9X3G9OwPjrp1iE2pLnNpApE8
         BwAPyoQgaTZaex258u3NJnXBwBKXdUjhK9DXZ+O6jfL8Rb6RrDNTIXFw9U5il/j1N8GJ
         NZoM6iHC8yU947HCKqEuuJg/luliSxARyIW/HjK4KG3E6hlV8xSpgkTyjVdN5xDlH/ZK
         6NElARQ+tfGJVAK+FS/n0cOPYw9EuzCQXHodp+0IBEd/zrZXfLHY4tGfN1mGydnK0DSM
         kM5xlql08y56+zR7wvA2EC/vaNTjdVDSFK4wJNYlCR0xuWWT3NuT2nXgGcAX1w6lkchG
         Bc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vIda8rUPzAv0wsdC1hQLazIxXIg8LOpNVH2zqZLiyCc=;
        b=M2bEJIYNhx7brbaiI1HQo6jwedRne7N3/7GbAjr4tXk7pA1AVoHngQ8nJxIKWdO9GM
         gJvTFYaPVOe6kiRUVKgZypp4Q9bwt8Itn+mY6DmcBb/xNQWfhJjlodBwmAWKQR2sF5DQ
         J9K801eQL09Vgf3mwNNEHpSf8XwS2z/9MvkNCgDkb97O8sEsWnFzpjlRA6abx+8XYG7g
         JCGpeN2OZ7tO1X3z2oXKENm3EXfWaSwqMYHjD41IEWA+ZKvsEnVKEkRQAL67BdcPNQqE
         1Jzel/uvLt3BHIm77No0QvSPyBAMll4dlXCLre0YJiEu8Rj34YWkEoBAOCUyrD/LM/6x
         fetQ==
X-Gm-Message-State: AOAM533VlQ0akHeT8oNsEWz9njhbw8/qez4n7YkNte43+fIYQXDUUelO
        E78pugDhtOVBcGsGigvbSM8=
X-Google-Smtp-Source: ABdhPJyvSk7lvK93TqIL5MUWqy8gXG/4/u12piQjx0B7vs/Rh6u2BOm3JlNebF+v3ypGSypd4Rotow==
X-Received: by 2002:a5d:64e2:0:b0:20a:a107:2c5b with SMTP id g2-20020a5d64e2000000b0020aa1072c5bmr4705055wri.205.1650646220164;
        Fri, 22 Apr 2022 09:50:20 -0700 (PDT)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id e4-20020a5d6d04000000b0020a8bbbb72bsm2749605wrq.97.2022.04.22.09.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 09:50:18 -0700 (PDT)
Date:   Fri, 22 Apr 2022 18:50:17 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] pwm: atmel-tcp: Make atmel_tcb_divisors static
Message-ID: <YmLcyeit1FYYG8je@orome>
References: <20220408152910.167698-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+k9i069/1B2yTqXn"
Content-Disposition: inline
In-Reply-To: <20220408152910.167698-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--+k9i069/1B2yTqXn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 08, 2022 at 05:29:10PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> The array atmel_tcb_divisors is not supposed to be used outside of the
> driver, so make it static.
>=20
> This fixes a sparse warning:
>=20
> 	drivers/pwm/pwm-atmel-tcb.c:64:10: warning: symbol 'atmel_tcb_divisors' =
was not declared. Should it be static?
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-atmel-tcb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied with the subject fixed up.

Thanks,
Thierry

--+k9i069/1B2yTqXn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmJi3MgACgkQ3SOs138+
s6FNwg//Ujqtn1sHtzT4GBw5mUMbtcvwspyyD9Gh2d/rK8uC7aC1XAgwD1944MEd
VFGBfwBq0ij//Wtky/kJW5qFPHjJ21sigP2ot1zQ065KHX0y6vGTTYCIpuqGCNTU
iKZPRp5Yes/OTbDgMy9l72++Sg1rEcJQA1PVEHacYOgTfzUV2YuK6MuwUXCEvRZs
rRgVo8FvXexLVQdGKETnU4FhZfrjcln6N1GokB0KuVOkzK44coULaKUUY6Yo2Ok9
Aw9+Pw9YDsIV/32236u6642MjO6uBepK94HL/C0zZ3uQ2a5/VKJ0FJbwvQlOkRk2
kbXcuSP7qawvCEbXhcioslPRpAX9iI7Vu4wEg9WyqMrnQieXnEnHiL1B0nfNbIMY
YVp8jBjbSyekDGzKFtxo20cLofrlTlL2n3z0cLWSJ4YgzkfRk+qiaMBzN7lUJICL
OimVDTfVamFFbGRdJP3fZZPsie8BIVMmU3grLDDGemV/kVgUZCcIBIRJkkZetCN0
cR0zbTjOtc7I/HuHhYlEhhnJCgu80wfl7HliPHVCRhLUoquTpFBZI8XnrgUHqGcw
qW95QM+Zb02Kr7qB/QM5qmXen/h3vh/iKKK61USNTLwziZ4pGYk41L2e6DEETJD7
/canHE4bfQqFERgSLMm5PpST9ak3Yy5Rn63oxJLuVk66uGdcI3g=
=8vGO
-----END PGP SIGNATURE-----

--+k9i069/1B2yTqXn--
