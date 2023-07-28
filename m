Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D42A76655B
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Jul 2023 09:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbjG1HaT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Jul 2023 03:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbjG1HaS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Jul 2023 03:30:18 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DA72728
        for <linux-pwm@vger.kernel.org>; Fri, 28 Jul 2023 00:30:17 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-522382c4840so2400596a12.2
        for <linux-pwm@vger.kernel.org>; Fri, 28 Jul 2023 00:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690529416; x=1691134216;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tst4myfrWrQ5Y9AUL2skGTkKYfF/vlQNM2dAGYjFZ4o=;
        b=EFlL0AjDGRDxS+vSpjVKn3xWTXOn/oq9YfcZ46ciRzscdImh8j7Ncbh8EUXldmDurp
         96gWmVHOpkv+K1GH31qbT3RgaGdLR1QHOUZb70l/yW4572+qqN3q+PoA5veiJklSU27E
         PNhIXo0h0yzLT6cJRSV4saToPmdnNgCsfpGaVeGN9R+9seK8gmYYshf9eO6z8+lP42gH
         9f7S+S6QfFoHsARlLs719yPxMsqZ/pmJmKUS6sj3hPAdP+FkjQDv/gqEHOpUUor9jLiw
         onY4REA3TqovU3UoTAVWAoiBcfri/DFHcGDB2JTvBe5Y+Wcagh3FehpxX8Z7TEKRDRRK
         8Gdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690529416; x=1691134216;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tst4myfrWrQ5Y9AUL2skGTkKYfF/vlQNM2dAGYjFZ4o=;
        b=Jurzg5CDwpNtiJVmgiwruQZYr2R8j4Qtiqz+4pAIJp/h5sRS9LwNPnKXiKvWgXdHu2
         0H7pjwJi+nA2Y4ARhxsHDbyWsbvXobKQU3j+SN/v49mc7Xzzj9uAi9XjRFnv/IZekJHK
         oHJibiLVrwFmYGS7d3g4/ZW3KWUmbeDSEe+/xBqOaor5+gHFIWPQaq4VG7DkPxnjY/E3
         IIqIUf53VrPEW07zoNDv3wKAKa2RKPMW/lS2iwjQv99kU85E4Jq8OwXp/Wekz5SQIc4H
         AfPY2yv8t3vitXCdlLVC4l5rRlfKOtAlMFYIVr1FL/YrrkW2CI/vi8lVsOrz3RZ5gAk0
         KVyQ==
X-Gm-Message-State: ABy/qLaAD565tCXmyZevdeBf6LfOUb/SLFQJH6UKLOI486kPRVJ8Ursg
        AFQp7+KM9WYpWhEIsgrdhXnuiOfQxzk=
X-Google-Smtp-Source: APBJJlEpWbqNAJiYbjnb7J/zhAxDiVvCA+UtLSy8k/lyn1OvN8Rg5gusoou0UEEmT/hJMheiZX9MEg==
X-Received: by 2002:a05:6402:78e:b0:522:678d:45e5 with SMTP id d14-20020a056402078e00b00522678d45e5mr1279453edy.30.1690529415505;
        Fri, 28 Jul 2023 00:30:15 -0700 (PDT)
Received: from orome (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id l1-20020a056402028100b005224d15d3dfsm1497520edv.87.2023.07.28.00.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 00:30:15 -0700 (PDT)
Date:   Fri, 28 Jul 2023 09:30:13 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: Drop unused #include <linux/radix-tree.h>
Message-ID: <ZMNuhcw1CIczzfxe@orome>
References: <20230728071259.590902-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9FcwOlmGEfv071V3"
Content-Disposition: inline
In-Reply-To: <20230728071259.590902-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--9FcwOlmGEfv071V3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2023 at 09:12:59AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> core.c doens't use any of the symbols provided by linux/radix-tree.h
> and compiles just fine without this include. So drop the #include.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/core.c | 1 -
>  1 file changed, 1 deletion(-)

Looks like I forgot to remove that when the radix tree support was
dropped in 247ee6c780406513c6031a7f4ea41f1648b03295. This didn't apply
cleanly, so it breaks the b4 tracking.

Applied, thanks.

Thierry

>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 3dacceaef4a9..5b0794858ad4 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -9,7 +9,6 @@
>  #include <linux/acpi.h>
>  #include <linux/module.h>
>  #include <linux/pwm.h>
> -#include <linux/radix-tree.h>
>  #include <linux/list.h>
>  #include <linux/mutex.h>
>  #include <linux/err.h>
>=20
> base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
> --=20
> 2.39.2
>=20

--9FcwOlmGEfv071V3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmTDboUACgkQ3SOs138+
s6Gacg//fFyRy8kTKe6DzC1xB1fGkY8lTauSqqzTejWZBy21fI2lJARkGJ3fQ6fs
iawo4yoXHZ5mXpjOxIVgOvKAe9i1P8wCNK8bMVDNpONGmFawUoucBiy+ZThhNhSI
0tcyIeBKHqeotP7FjbhT+ud/v1cjecvUPyIO79fYohEc1lkkfc+/sWGPnCYSigtp
ArcSYR/PurOknXmiTtUn53Fxyngw0Scne2ZtbpXXszj+LNXFfmW2AXXoIPgP4mkm
6tdwPU+V+Ew2wmkEj8fH8LGHDkW/ac82BD92Ra8Qv+BUtzfNHjyjSwduCLWhgVxF
I6sj1CuUPG4Jq3lpXVpcyOoJAaKJR2oEOpGFaYUrcP1dlEA38IQYIhnbvJpJettj
1pLf+420QjZdasPOINegKdHgHkuGkm0ljkJEOYTvKwFB4kv1qz9TF/k5qfs9Z3OB
vmDBjSXgPd6sMBfzyu0mFuxVQxDli2dt2b2vUM8OHVH+SKiXq4SzAvmrNiHonIjG
bgqO7MswtfhZ5ol5veEIYkBNgTYqhyfae/jWT4naLBlk2msooUjLrc6sltKQ6jLA
2Jlk4PM+pkyLUvN7UXerlp0cgZDzQQaHVaU4UWPWWB0OrfbbniwfZPDZ1rncjthH
ANBW/WEDbaeEP8BoSTRZwRZvujPVDMLIvtgOD3r+myt9115E8WI=
=PEqp
-----END PGP SIGNATURE-----

--9FcwOlmGEfv071V3--
