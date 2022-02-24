Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB43A4C2E00
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Feb 2022 15:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbiBXOPy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 24 Feb 2022 09:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbiBXOPx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 24 Feb 2022 09:15:53 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F245294FE6;
        Thu, 24 Feb 2022 06:15:23 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id x15so3267144wrg.8;
        Thu, 24 Feb 2022 06:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iQu+mvnzdays90oPbetoHTlkq2SmIDkedVilWnLDVUg=;
        b=EHXo3YJpqrY7weRU1olhhLoVrnPh7HmBPqN7sa3PP0OekLWVs3IxtmgpbU0FaYqC6h
         /254EOfdGLDMtEC8LTWIrC3UnSFRihwebodtgYbYrhOvHrKKS+S+jhPXj2ovHIkAy3oA
         6rqOdRSK8LlWZ9Ooc5LHVd+m5lGUtm1UVxCqZWQkTzDWqzAwOP5W+DrZzxwmVw5KphAI
         yYS2fhJ/3qroVGrQWQ3ALsueh9NkWw0yInREZdQL127XbnTPyCgtDGsCGp7mGr8Oa+2r
         I1U7cElTVPZ3Yp7Url3f7RFhfAJtCHT7I7LBgdqazp+r2QLvIbB6FRLoux9lHZTXly7D
         XfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iQu+mvnzdays90oPbetoHTlkq2SmIDkedVilWnLDVUg=;
        b=pXbXM1H0zgv6YiPdMl436liFOG4Eyw0R1WlKfIzM6PEF+YsQ7PdyHKQ4Fm/LQI9Wc6
         orrmqXiVyZr0pe9vClDTR0khYrE/9+OUJbDIM48+FyaVyXOpDb4B0NmXiuzPnDAsQ+dy
         sn35uoMZoQwXX3TZK74aklvgMqHgJHQhmM+wxUSGKlCtLFrvidSht2qSf3cnEqG3uB2c
         SdSS/yujurNPHYsMhoCKTmrGWuGlmdEQw4Bug2Uh4jFFiq+8NrtmT47N/J0fTFfk8u8S
         jkPw0oeN7zgWojwo05u2+ZEWmfawrxjJ5fnsxs3FjNBbO7z4cX5NVMsTl8QlRZ8jP/x2
         XelA==
X-Gm-Message-State: AOAM533IFDoLUOeEtaJWAKQjKIqf/WuNsu92mbgph7yOvwJoTdCwHJha
        Oj26zwaeNUZt1NpideWjHNg=
X-Google-Smtp-Source: ABdhPJypnQx7G8VNogPvYu2trjCqyu4gZziaoGWTT3DKaBLGJLFgdfGyz5BCBEFZugLqKDjrWinmvg==
X-Received: by 2002:a5d:5885:0:b0:1ea:8099:1ed6 with SMTP id n5-20020a5d5885000000b001ea80991ed6mr2375889wrf.494.1645712122003;
        Thu, 24 Feb 2022 06:15:22 -0800 (PST)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id t9sm2977941wmq.47.2022.02.24.06.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 06:15:20 -0800 (PST)
Date:   Thu, 24 Feb 2022 15:15:18 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] pwm: rcar: Simplify multiplication/shift logic
Message-ID: <YheS9vXNYSqPYEJk@orome>
References: <4ddca410da1f52a8e2049e0f51f14196cc797200.1645460845.git.geert+renesas@glider.be>
 <20220221182213.wjh3lrnaoquinlxg@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nKBoE9VG8AfpvbWV"
Content-Disposition: inline
In-Reply-To: <20220221182213.wjh3lrnaoquinlxg@pengutronix.de>
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--nKBoE9VG8AfpvbWV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 21, 2022 at 07:22:13PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Mon, Feb 21, 2022 at 05:28:16PM +0100, Geert Uytterhoeven wrote:
> >   - Remove the superfluous cast; the multiplication will yield a 64-bit
> >     result due to the "100ULL" anyway,
> >   - "a * (1 << b)" =3D=3D "a << b".
> >=20
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Applied, thanks.

Thierry

--nKBoE9VG8AfpvbWV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmIXkvYACgkQ3SOs138+
s6G/ghAAoS7r0T4IB/MtGxKlr6PTiMXRhEIvXgz49j4EsMCZfvJ+nkWtOkknboX0
GsrERKWBIzN3SRZg2NUUP2GxQ8ePjOQKjQ3ThA3FEPlbH2CsJEgx04diCq8fInh0
ACedV6hIfa2s945EUzODp/37FEeCX+iOs2p9iSfwUZ6YKgFuUwuERYArK96yP/sC
MZIs5cb/Nl4MRIL6qWih9TWfCo7qPasdvMXqdzK9appAI8uNj0vrkkkvH2G+SsJ7
Ys0MaTnkqTH8NAcZicEDEyXM0SOo50dQRtxa4Puo30p1OqxJSzfhw/HNlUy7NuRf
tjdlIHrhBkc6zkVysRN/pWpiWxL6LW+orOJBW6HTaxznz4P/FYO1x2nH9tZb+l/N
TPTgBCKSUvpbYZdqI3GAqNOHqmjLC+T+Tk96INiapT5nY01oaawIY1DksiDVkQRu
C85FbY5C1QZSBWax1P4icY/nAcQyuEkGF5ujEz/pVPP7LlpYywdt8jNRSNMvDKcW
BVLTwKVpI7saLqVZhvOU4cNodjijUA9xWrYohb/mxtgzXpFrl/wmsi9k4vDDdLHf
NhqkUB6y1zockOJZr+PWrK7ROR9B+Cu+q9insXvh6cCSdj4kIAU8Qo3b32U+xwAh
gXcfILzQfcM7/rPw2W0Ycw9KJESXDd/sJD9q08pUEGV6dHd2Gdc=
=8n+d
-----END PGP SIGNATURE-----

--nKBoE9VG8AfpvbWV--
