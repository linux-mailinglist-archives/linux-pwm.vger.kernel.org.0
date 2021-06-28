Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7243B5DF3
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Jun 2021 14:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbhF1M3x (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 28 Jun 2021 08:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbhF1M3w (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 28 Jun 2021 08:29:52 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED56C061574;
        Mon, 28 Jun 2021 05:27:26 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id o22so10391094wms.0;
        Mon, 28 Jun 2021 05:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iQRqD1hmQxQYQdy9yTVFY+obxJxwa/bp+3TJRW7YBnc=;
        b=jqtEmnwAxPw8R0y/vZBwXbfrplyZFpZY+gX1f6YU9nyBuU/jqvQRl1Kms1mWbm85d9
         RSD9UhIOgzpHMfZXM/qAWfKMNbxtx3QVnfoAEV+HqSdO/a0GdsJSrFbNPj1SydfVR08f
         OfLR4HX0GLhx9yQjos5W75+IFstMC0WbHVc/oGsOPUXcSz7g7QCbwUtpsAsbyW3qOx1G
         LDVwsVnoabqHKTDApJ/RSJjrd5ylfm/7XNJxc4O9kTS15q/urvcEuYGW+bQeaKHwOwFs
         DiGfFu+6kC2LkzAu6QfK14G5pbfbdbkVBba0SKK+GAYGNpOUzqf5EIqnkKW3GinfuM+x
         nMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iQRqD1hmQxQYQdy9yTVFY+obxJxwa/bp+3TJRW7YBnc=;
        b=p797AQS3sfuiGEsK9I0bZRSJBT/cxyHt9g+fiHLnZysEm+LVZl7CHpVogQDc+ZwEpe
         FVXutOlOT1DeXU8bI6MPWQsCx/dvfgv9BSvNOfytBbSHDcJ3oZzcFLJhdhPgFIzTmcwV
         iQjPPkuCHl04AI8kVnUfgVgAlqq6ghBbPw/LtAcA2KKmSias3NsRc97W/C3dBSJyOMab
         rkoSoXyZMGCYEZ03kqJEqvj3nEQi4RLFmfuZLJ/oXm1Dt3U6l3mT7Z8+ApzW+hIWQLit
         HKkeND9eihjpA7ri1o5eihkngdASlnOFeiPaUai6FzxbSLQvF23Bu+QoEIh1X+5S+TzG
         uU1A==
X-Gm-Message-State: AOAM530D0z6AWLz8NsdWRb1TvnVgxbmqEdPuAU8ZYJi/twLW+9j4W5N1
        10OjXX4ewKNH8ee8Rr5m4Dc=
X-Google-Smtp-Source: ABdhPJzu+Hkm1uflUklKWqGf56ONDt61rFasIAROPDkD6tppmurMVzdJm+5tCdYkxl1z1ahZNy9jgA==
X-Received: by 2002:a1c:c90c:: with SMTP id f12mr26315327wmb.80.1624883244703;
        Mon, 28 Jun 2021 05:27:24 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id y20sm13212152wmi.25.2021.06.28.05.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 05:27:23 -0700 (PDT)
Date:   Mon, 28 Jun 2021 14:29:35 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v1 5/6] pwm: tegra: Implement .apply callback
Message-ID: <YNnArzeS/DtIlFa9@orome.fritz.box>
References: <20210617095145.163694-1-u.kleine-koenig@pengutronix.de>
 <20210617095145.163694-6-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oa/u8ID5+y++Yt33"
Content-Disposition: inline
In-Reply-To: <20210617095145.163694-6-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.1 (4b100969) (2021-06-12)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--oa/u8ID5+y++Yt33
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 17, 2021 at 11:51:44AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> To ease review this reuses the formerly implemented callbacks.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-tegra.c | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> index 11a10b575ace..1161c6323e60 100644
> --- a/drivers/pwm/pwm-tegra.c
> +++ b/drivers/pwm/pwm-tegra.c
> @@ -227,10 +227,36 @@ static void tegra_pwm_disable(struct pwm_chip *chip=
, struct pwm_device *pwm)
>  	clk_disable_unprepare(pc->clk);
>  }
> =20
> +static int tegra_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			   const struct pwm_state *state)
> +{
> +	int err;
> +
> +	if (state->polarity !=3D PWM_POLARITY_INVERSED)
> +		return -EINVAL;

Where does this come from? I can't see this condition anywhere in the
existing driver.

Thierry

--oa/u8ID5+y++Yt33
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmDZv/8ACgkQ3SOs138+
s6EoWg/+OW+/0r7pZfoau/gkUOEbkDAaRUDlbG8ZLMVnxi9wN+S04QcpTqAqa27N
iw4gaApGepRnJUjuCz9KmBX8lDS5mXAc57XWxnYScF0P8aZiK6+pYdbwKCUp48PV
FiE43YyQRlPNggyp2jM94Yy5/xNzRBS2cGmq8SAGniNVbbJRys4q5aRFGBYv0xe/
UB1uFkgl7mtYzZQYTN62xJS774DKlP/cvMgP/r2kZtu46bcWXw/CYl9F0eWGrN49
jHuvjWbeafhMGxSaGXi04Cp2YgiCh8rdn4CwOpGA9RFgt42a9ijR4+R5S3bEPeKP
ynOVvzIGJPYgtdvpRqvlwjVy3EZplCkNpSL6qQRq7e8mAZPtfQnJfjWgISvt8dWq
SQ25GQc9bswFicCGxEnJZVsB9HAE0yOmDJlSiO4pw7kJz8qkeAd2ZPrQ/0whj/bB
9Y1/t5YtxlA6IQJfM8pY549KFqlXzEEYMiObNaoWJ1G1aq5WwdvmV3SPFTN9Ku+L
g6lFREwnkbLwR0VrFznYKqqQ2JNHfDWKrBd3zKsIqnTlwOwS3DRGExHLgIbr2PA0
681OkyzoyJt87kEUiQjmIyQp1tR02clRdatgBFXdporlOUZ8JX+RMVJeep+G8ooZ
GT0Z69gTHg3H6UrR7kk4YENwcbep2E2D77CFtudJ8fmnEnOqCCE=
=UOCg
-----END PGP SIGNATURE-----

--oa/u8ID5+y++Yt33--
