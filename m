Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E411D4A5812
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Feb 2022 08:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbiBAHrx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 1 Feb 2022 02:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiBAHrw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 1 Feb 2022 02:47:52 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE3FC061714
        for <linux-pwm@vger.kernel.org>; Mon, 31 Jan 2022 23:47:52 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id j2so32057155edj.8
        for <linux-pwm@vger.kernel.org>; Mon, 31 Jan 2022 23:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OXwpypPprCxtY8e/4CjGLn2XMhoDuhJcb90FFRfLVgU=;
        b=h/joRXNroSiXYcyfh67qOX2sLX0JSoI3XZbePNcNWg0M91aHnnqkJupcxgi+AFooo2
         aVBK+SoktuifyfsOQgvCC/iNtgDQryBouSERmxTIFNHrGoi9bMEoA2SmDME5+LvyHJ1U
         vowActs2EUb+GlstTJXVrdFTvV4CWOwUcjDzxjGHZbgb1OwH3McnFROHK8KJohIHgdBS
         4RNc0Zy64y6oF1ULDf3PJWhq8BPcjzptXW1JBx1xUCdFAKM14HdjbBv29D9q6Pr5PL3G
         44SbPnTgbDg5wr/3f0Y2C+/21Mk9u2t3CMJO/4RcUtNw81P6qGXXIRGPydUO6Rwf2s1q
         c9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OXwpypPprCxtY8e/4CjGLn2XMhoDuhJcb90FFRfLVgU=;
        b=QNgbaSiPFfFsN+tqBgDcNSXFOrI18p/wu5CvVuzLUBbXJ60GaWJvbC5mMaWpQ5Xsca
         mxDqB84fR/bX/xifsO5ZXN3pgK6+S5JWeLkqYKRTY//fBu+zZd1VmgtFbKH+J2sdMmxX
         hU5dV3oZtdaIBTsRmrObii5YX0VblrZ1QyOD/7xn475Ed07ARRN6qhBMP9AfWnqkn8T4
         Vpv86IYgHyXuySk6o9PzktDCfHf7CC5QB/89l3ooU4X7RFQI1lSo4AlkNNPs/KdoHhIP
         I5YYiqG8yMKjhPinzEiYbySvM/0fZBiS5vk0Y1eljnfAfgKzPFEkN10VieBWM5UgvHLM
         w7oA==
X-Gm-Message-State: AOAM531VkHiWAKaN2mxm3/GQlDMfuSKVXlL+6ArVt8uHef1SJd+vbVRs
        7tGO5CFJ4yhq3TXkzPjcgyU=
X-Google-Smtp-Source: ABdhPJyULq4LQsDquOdq0yp0fUfXhyRLb8xd289UxduZB2vpdOJHotkGNbk9xEgyoKTlo/kOK/S42A==
X-Received: by 2002:a50:eb46:: with SMTP id z6mr23802731edp.229.1643701670985;
        Mon, 31 Jan 2022 23:47:50 -0800 (PST)
Received: from orome ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id cr8sm18726443edb.47.2022.01.31.23.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 23:47:50 -0800 (PST)
Date:   Tue, 1 Feb 2022 08:47:47 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 1/4] pwm: meson: Drop always false check from .request()
Message-ID: <Yfjlo4JS490V95hM@orome>
References: <20211108134628.120474-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pV92kODRvCrKSof2"
Content-Disposition: inline
In-Reply-To: <20211108134628.120474-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.1.5 (31b18ae9) (2021-12-30)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--pV92kODRvCrKSof2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 08, 2021 at 02:46:24PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> In .request() pwm_get_chip_data() returns NULL always since commit
> e926b12c611c ("pwm: Clear chip_data in pwm_put()"). (And if it didn't
> returning 0 would be wrong because then .request() wouldn't reenable
> the clk which the other driver code depends on.)
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-meson.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

All four patches applied, thanks.

Thierry

--pV92kODRvCrKSof2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmH45aMACgkQ3SOs138+
s6Fh9w//Ql8gqrdnYtrBphgXpsXa+yk/FR7NA5zyU+eSjy2ofl1u5wzR4KiOoXqX
/ieJL7czibRQSwCAiLymde6Fcd5u+wQCIzIQDTh+qX1AB/CUINB41rnBGW363r3y
SZLxiXyW8gG8XfNeiDHGMeT/16kdrOmmR/MecHyQ7hFfll65NdXkE6HRc72JKBS0
fK19zqYeeUDlP5nEvOByEeYjWAHmDsV5t7uZhurCILELTKWovkaUtpfrxl6hZFCg
fTuySv2AZ5uwKtkt2XhP5F+m/r6pC5DX+7HmbRTLhoboi8p7GHo0ruYp0GuLdYtC
9bqSSF29eLLzbeLXHsQnJds8L7cetQMHfskq2J34k68BAZnIiGnUKRgcKMvBKb8w
QomZtdaOLN+0K7s3jj0utSHzrG4qYSKg3qBixg3rOgSbSWfEY2kW9aZpzT6M0FuG
O2UpmKlBPD8zg2PNSmiMXGISoCwF2OlzDk46ucSTcC15a/Qg091SeghDf0CJNs//
5GUWcFwUY0p3FJPYeamdcV/00zWJiWpvwqo9J2L+/8Iv7Atax3jvYeUam6CXhtTQ
eCU5JOfKcmIXHxbKA7vng1P88jPCqhAboO+xEa8gkAeyRgcXNNvABSw0oOet08ze
sBNSnmONY8dzWELPtJLAsEVUuqoKXOTtmDfH2LwRzOhuuU++k28=
=p3pi
-----END PGP SIGNATURE-----

--pV92kODRvCrKSof2--
