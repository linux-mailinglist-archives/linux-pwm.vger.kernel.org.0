Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26CB36E0A14
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Apr 2023 11:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjDMJXQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 13 Apr 2023 05:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjDMJXP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 13 Apr 2023 05:23:15 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338D8106
        for <linux-pwm@vger.kernel.org>; Thu, 13 Apr 2023 02:23:14 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id z9so8759047ejx.11
        for <linux-pwm@vger.kernel.org>; Thu, 13 Apr 2023 02:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681377792; x=1683969792;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzTTbhfFcZTGMDra4ZzytX8FtG7O0yt+/KOC/gcA42g=;
        b=MS5UrRavGhMkko2goaKDguazFwRR3eHaZscHm70DVgnFWrOb8bfdgVf0MIds2d/dZE
         qyUxWMIqH9YyS22gzZzAgkUi2x+PJGE0yCgItRVu8RcNNK1mJFI3X9pHS2TeifrzdNVZ
         TQ31qi7Y/bvfeIuEJs9YfFIrp1dYcROE879fnXc0E4gIF0FZy0PTnHAIc43+g4x3mFn3
         Kr9RLYpCS0B/JtOb142LmmkhsJtqFJYODtKHzSfd29GrjFjNuwFZISNp1GqhWIsdalub
         q9h9YYWo/20k4jFN58lJDyOO7kD2a15MqagzCEkzdtGjWaySjyfud3HcQVKWCdd7dDph
         fhNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681377792; x=1683969792;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nzTTbhfFcZTGMDra4ZzytX8FtG7O0yt+/KOC/gcA42g=;
        b=D1C2VtRL2eEC0YxYBtYQKM8Mn21o1of0pVF67+nHmqZhPaRkj70McQjwuBH6KDobjy
         8dZK3cWMHIdUUagU40IXjYbG4fxaKys52EGnjAL3MopMSfpjMY4OkxyXyu4GDfrsLvo9
         RetaB81oBzgjbehHIJ8wp5kVkpzbrlkIUuxIH5hEi2sHCjPdiN9XwRBOvGwsejhKr3Pz
         R0icRLfiDxqsL8ja5B3STzZZ4ZEgyVXf6+teHr7JMWZByuZtTx42gy3a4Sx33wZRms49
         GiE/VVpLP2umEssYsJL93AExJsv27uwKebsZa+0ccVzOUFLDfubHeBsQOU+1aJRt3Nig
         28TA==
X-Gm-Message-State: AAQBX9d3C6KtziyLoHFv29O2F3GCa1mgKQagJDCvnfTKNOpg/TAervI2
        NRxwP6Oa8rsRrRl3OlLBLjo=
X-Google-Smtp-Source: AKy350b+0wfw7dVL91U9xvbCROvtI06Ebusi+QNQCVM6y3b7U26QgoeOhAtqd/T8n8CMpiwbMTy4DA==
X-Received: by 2002:a17:906:a841:b0:94a:4499:ec30 with SMTP id dx1-20020a170906a84100b0094a4499ec30mr1944498ejb.15.1681377792565;
        Thu, 13 Apr 2023 02:23:12 -0700 (PDT)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id b11-20020a17090636cb00b00930aa50372csm703184ejc.43.2023.04.13.02.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 02:23:12 -0700 (PDT)
Date:   Thu, 13 Apr 2023 11:23:10 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-pwm@vger.kernel.org, Jian Hu <jian.hu@amlogic.com>
Subject: Re: [PATCH v2] pwm: meson: fix axg ao mux parents
Message-ID: <ZDfJ_iaRXlXzd0PL@orome>
References: <ffc3e4e7-b2ea-1a56-4fff-6554ad3775c0@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JY0L2Q8GjmC/YsxM"
Content-Disposition: inline
In-Reply-To: <ffc3e4e7-b2ea-1a56-4fff-6554ad3775c0@gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--JY0L2Q8GjmC/YsxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 09, 2023 at 05:15:52PM +0200, Heiner Kallweit wrote:
> This fix is basically the same as 9bce02ef0dfa ("pwm: meson: Fix the
> G12A AO clock parents order"). Vendor driver referenced there has
> xtal as first parent also for axg ao. In addition fix the name
> of the aoclk81 clock. Apparently name aoclk81 as used by the vendor
> driver was changed when mainlining the axg clock driver.
>=20
> Fixes: bccaa3f917c9 ("pwm: meson: Add clock source configuration for Meso=
n-AXG")
> Cc: stable@vger.kernel.org
>=20
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/pwm/pwm-meson.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This looks like it supersedes this one:

	https://patchwork.ozlabs.org/project/linux-pwm/patch/e7a95baf-5f9d-be56-93=
dc-82ca83b69c7a@gmail.com/

I don't see any discussion on on that one, nor does v2 here have a
changelog and the commit subject is slightly changed, so you're making
it more difficult than necessary to correlate the two.

Anyway, since both patches conflict, I've picked up v2. Let me know if
that's not what you intended.

Thierry

>=20
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index b5c746fab..0fe0400c2 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -381,7 +381,7 @@ static const struct meson_pwm_data pwm_axg_ee_data =
=3D {
>  };
> =20
>  static const char * const pwm_axg_ao_parent_names[] =3D {
> -	"aoclk81", "xtal", "fclk_div4", "fclk_div5"
> +	"xtal", "axg_ao_clk81", "fclk_div4", "fclk_div5"
>  };
> =20
>  static const struct meson_pwm_data pwm_axg_ao_data =3D {
> --=20
> 2.40.0
>=20

--JY0L2Q8GjmC/YsxM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmQ3yf4ACgkQ3SOs138+
s6HqNw//YI7ly5943Ef3PUyEnJsR3phdH4mHTCJ/u908QspsLWp9d3rwJR6bln95
PA5S8hbymwO2EbLEW9C4XtX3SelSQqy1+DOJeDN5YuRpFRRdrlErbch1lPSNIMTm
SK99Saho5jZe4VYZhNtMUD7vvGhcLGtgn54cBoU45dTTWJuVqLPZOPLIfvUo/jm7
cU9fR49DhmlOSTTJrrmapKKD5Fz8ciYkHq734fQYL6KtPJjKk8fMjvDMPDDVx69F
BOBqczdoIvKoh2u26kg6X0l9/yjrQdscaNsn5nJg4C0bydgmpuE9hideGDyIbmkS
7/2l8gEWxznWC2hAasfVz0mCd1prH/7yJ75cbtJLjmEIQI1McUq5tu1MWg7bjink
9PZBaOCw1nZTBCYLtDVxJN4ANQGOO+fDEW3c95vYFrIwuC+ER4EhafyOt0Mr0FX1
jkNbIyPhvCxtq+J1RFA7ScES+HhVYyE6OHhlfCdHNSL34YGJigIEuJSbtRI4S7X6
+UrtTK3VAPkWZIjU/l1oEt7KFwzerg8S4Q6Bae80RxWpVHaP1G+2JSbnh11GXZjY
qFHzvOan+374UyQ4xJIfZOuKivtb1v2SqQ3mRVrhkLzZkbf7oktVsUUdP3BW9vip
zN/g2SaY8PWGWFWGzYmp/8lp8/SD2b4xeZLm1sGLzifAbr7z5sY=
=I0Iv
-----END PGP SIGNATURE-----

--JY0L2Q8GjmC/YsxM--
