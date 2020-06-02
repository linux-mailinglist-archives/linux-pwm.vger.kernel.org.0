Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E391EBBE8
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Jun 2020 14:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgFBMlb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 2 Jun 2020 08:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgFBMlb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 2 Jun 2020 08:41:31 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF17C061A0E;
        Tue,  2 Jun 2020 05:41:31 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id mb16so12601864ejb.4;
        Tue, 02 Jun 2020 05:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GHFMqUa98wqBWHtS9xjIzjQXZSVDldKjF1cbC0g4d08=;
        b=tnvwpLObLrEDtNs8U5Vl8qkSnTyyeCPMkkSaR3Kg9eUoRH3Hgn29or2fGpv7zHGk8M
         C8BNQ2tcJTDdzu1SUcIWaS2WWq0PO2v/NovoDLSOeqaMWAvipZKAHJuLY5TfkoE6gPzx
         CsfZW5NJUgYv/Gpqeioq6eumh/VelsnRuMOy9Ka5zXfPEnT+Fgdi2+ubHc36B7AGq72t
         oFD67tSFDwndvtWTXeSBI/QEeGD8j62j/uGgQwGDqHz9qRdfcBPtr40KKF0l37G94Q8J
         pgM27p0AeY4NlJcZX2uf2eEfgi8jr8pbWdUH64icu+Di8w8IYurTjt6RYRW74uVc8mFF
         w4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GHFMqUa98wqBWHtS9xjIzjQXZSVDldKjF1cbC0g4d08=;
        b=b+YxKp+6yw4mTHmj5wPw9GhPI9a60J4gB2Fy5ulOJX3ifKxZOoMKLAt3g/c7ZbHTq1
         fDJ0H3k3sG/hlWDLHjRsyBSgp0rw9UESNHvyR/5IUYzULUad3w6R0CvwwCmjmMRyP1ST
         cswQ0HYqcqeNyqIY8OBD7hd1vwylGZSj8mqHC0b4tHvvS4l/c5wMxQBeIUqRiO9Ue1kP
         z1ah4UyxyZspS1/OUQV9D8qNsmT85dHqna1X7EFroxapFagxh2F++dFAlPrHdJMTh4TV
         mQs+08bARY5od+nvSdMoWfC7DPOtA/yQKyJrCyUIhSwvKPGCoS/rfSK492zF90ibQwHk
         +oKg==
X-Gm-Message-State: AOAM533Q82ocuzYMdJRRCGWrGi0nwlBnH91NVysLlBrhcbmUvRqYsyEc
        JN+LIxEItSm5D1XUfHnMSQY=
X-Google-Smtp-Source: ABdhPJzyy7UvAUoIvRp6qrIztSS8RZHsRj3KwPTHNmzsC88Iv7frGG2V8KfjWdulFq5S2YkCi9eGig==
X-Received: by 2002:a17:906:2e50:: with SMTP id r16mr22811025eji.305.1591101689995;
        Tue, 02 Jun 2020 05:41:29 -0700 (PDT)
Received: from localhost (pd9e51079.dip0.t-ipconnect.de. [217.229.16.121])
        by smtp.gmail.com with ESMTPSA id f4sm1572869ejk.17.2020.06.02.05.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 05:41:27 -0700 (PDT)
Date:   Tue, 2 Jun 2020 14:41:26 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, od@zcrc.me,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] pwm: jz4740: Drop dependency on MACH_INGENIC
Message-ID: <20200602124126.GD3360525@ulmo>
References: <20200527115225.10069-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VMt1DrMGOVs3KQwf"
Content-Disposition: inline
In-Reply-To: <20200527115225.10069-1-paul@crapouillou.net>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--VMt1DrMGOVs3KQwf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2020 at 01:52:22PM +0200, Paul Cercueil wrote:
> Depending on MACH_INGENIC prevent us from creating a generic kernel that
> works on more than one MIPS board. Instead, we just depend on MIPS being
> set.
>=20
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>=20
> Notes:
>     v2: New patch. I don't consider this a fix but an enhancement, since =
the old
>     	behaviour was in place since the driver was born in ~2010, so no Fix=
es tag.
>     v3: Commit message changes (invert Acked-by / Signed-off-by)
>=20
>  drivers/pwm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

All four patches applied, thanks.

Thierry

--VMt1DrMGOVs3KQwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7WSPYACgkQ3SOs138+
s6FaCRAAnn+U7/uQz3zkEYTEbfnxMr8kVUv6gVcGH3Ix8HVWYWXpWh753iKyp8AP
vwfWWrO1oy5hh5JuygD21z+Ax5Q80jdohC5q88WMX9XrGuxxtk0ZdU/vXUKr1Jq8
XF9QGH6AyFVqqTmQb0vZfYpMqMIPmV2xOIosKvHr30MfxnzWgijcAQyCzqHDKKtn
nZVMeZXwOzwfGM3ZFGy27z4o2CqFepCzwtqdFBkGLM3pHASuI36M8luC64dYgRzq
/G4JRz22p2+0AJ1MurJmb7jTvujJbdBYKtm5hMJoDxjxONFqKEgfMPXbnVdSGWFW
eBuQpws8toP4Rzd5VTJAZ2deC8cd4gWvKCHLip9EtuWqHgIwPrVSLmRw/DiVSVif
r/Wex9A1iPHKAuo9yUAwph41N0qX6UegVSUV3yen9PZwduHGY2eJ0xhHsYQdlSLW
xqdDga5hvavcrg62EPWAHch1z1vrRKC7tO+DbRSnaQV/mJEqhnf7+jM0dB8723F5
9zirSWPQkWojhNPBE1dbMqeaitDoFOqHZ/U/OlMY6NHDFincfxk2jDQF32ehMfrm
c4iDIaarl73UlGCtgNYO1/9SFrRcdKXeBLhFaLJyU/5+J+eSO/LOCdcHVKDXXTuM
iGhac5iTre7gSZlU4CfS58AglrjmNMMbEbkt1Mh4PhxW++f20A4=
=yUQX
-----END PGP SIGNATURE-----

--VMt1DrMGOVs3KQwf--
