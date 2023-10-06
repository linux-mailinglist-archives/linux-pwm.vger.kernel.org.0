Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B677BB7CD
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Oct 2023 14:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjJFMhX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Oct 2023 08:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjJFMhW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Oct 2023 08:37:22 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F20C2
        for <linux-pwm@vger.kernel.org>; Fri,  6 Oct 2023 05:37:18 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so3616549a12.1
        for <linux-pwm@vger.kernel.org>; Fri, 06 Oct 2023 05:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696595836; x=1697200636; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9j9ypxq47lcYO3kmKyRqdYs2948zPY9f7tVytYIx1ZM=;
        b=NpiuK2hvJlrzwdOpeF/LBHxH3Znof34l/BaPgi5YL6TbSm9umUyewrZB3bgNboP7uJ
         UuIeRZmO+QQ5vWjR380iwHvcJpQRSQ2OHc4WNiw+vOhHemxMzb+RgG7Qv730FsStxItm
         mhxYtUW/sD+qDGrB8xdeu0XS5Gp/8uVIPwpDm9nR/90m+pqAH+0JXmQW0aHIXUbFoga0
         RQeXSgiXHFvDuP2k6JN0IIuU4znIb/wSwuSv73OeGD9OxkukWyrPryEyCCJLMa3YA2aE
         DRHQfV6QVjo/XW5EByJbzYerBelCTOIgT3JxbT3O8kTm89c0rooFdY6IkVBQztsJ4VPY
         WWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696595836; x=1697200636;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9j9ypxq47lcYO3kmKyRqdYs2948zPY9f7tVytYIx1ZM=;
        b=WKwwJdzZPFCsJFv1SNY0uCNVRDv/MZwrzlNpIflqWT1eX7YdMH5NsdHoTPoXGNVdqu
         RWAD1gbt0UqxWkWSF8A5fM4dBZJSuMLAys1y4aQbAzRvsKR4c0yrLtAvrUKx2BmPx8zg
         kVnx+jygZmTCNXbOKEVbZMi87KuNyDFzfaOLrXa0Id2ovBTbxIDQhzwes6XCk4qiFFrc
         az2B5rRGGCxkpB7SGB8cbY2nKbmNu8oRgRyOh8XPyYn8uOm3u8bsmJyf9fPaHnfyQ4K1
         h85B/3aZ2GmSPw645JKLYXdj/M1ZsbGSp2HKfnQZFQZiCdoFlctiT+tX8EdEWsJpB63F
         y7QQ==
X-Gm-Message-State: AOJu0Yx6eOl0q4TiQ/jNyANJtje7p1DA6hDbld5f60JZg211OcZxrupV
        8yG2JVapYaGb9hEyVr0i2S1+GaRVPvo=
X-Google-Smtp-Source: AGHT+IFd1/PW2O2DNw0D3WJm1W7Csh0Q5c+cXrsSuZ6iOW/58RaOrQxBCqDmP9qeXYmdSkKyu4LA1w==
X-Received: by 2002:a17:906:cc55:b0:9ae:7088:6e5d with SMTP id mm21-20020a170906cc5500b009ae70886e5dmr6817895ejb.3.1696595836298;
        Fri, 06 Oct 2023 05:37:16 -0700 (PDT)
Received: from orome.fritz.box (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id k18-20020a1709065fd200b009adc7733f98sm2800927ejv.97.2023.10.06.05.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 05:37:15 -0700 (PDT)
Date:   Fri, 6 Oct 2023 14:37:14 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 100/101] pwm: Ensure the memory backing a PWM chip
 isn't freed while used
Message-ID: <ZR__enSpj7_TBcrj@orome.fritz.box>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
 <20230808171931.944154-101-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uqByKH7ALOBvSX20"
Content-Disposition: inline
In-Reply-To: <20230808171931.944154-101-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--uqByKH7ALOBvSX20
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2023 at 07:19:30PM +0200, Uwe Kleine-K=C3=B6nig wrote:
[...]
> +static struct pwm_chip *pwmchip_alloc(struct device *parent, unsigned in=
t npwm, size_t sizeof_priv)
>  {
>  	struct pwm_chip *chip;
> +	struct device *dev;
>  	size_t alloc_size;
>  	unsigned int i;
> =20
>  	alloc_size =3D sizeof(*chip) + npwm * sizeof(struct pwm_device) + sizeo=
f_priv;
> =20
> -	chip =3D devm_kzalloc(parent, alloc_size, GFP_KERNEL);
> +	chip =3D kzalloc(alloc_size, GFP_KERNEL);
>  	if (!chip)
>  		return ERR_PTR(-ENOMEM);
> =20
> -	chip->dev =3D parent;
> +	dev =3D &chip->dev;
> +
> +	device_initialize(dev);
> +	dev->class =3D &pwm_class;
> +	dev->parent =3D parent;
> +	dev->release =3D pwmchip_release;

We could potentially make this a lot simpler if we add the new struct
device and all of that and add it during pwmchip_add(). Really the only
thing that we need to make sure is that struct pwm_chip is the first
field in driver-specific structures and then all of this should work the
same way.

And of course we'd have to eliminate device-managed allocations as well.
For cases where pwmchip_release() needs to do more than just free the
memory, we could add a new pwm_ops.release callback that drivers can
implement if needed.

Thierry

--uqByKH7ALOBvSX20
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmUf/3cACgkQ3SOs138+
s6EYnA//ZE6EmaS1DftC/QncjtEyzsYfvEq1aESpMbwVsUK/v7byXBSeo/lBsgDC
O1mkxomgyTo8xa7izGAzcs8i8Lov2u1UNt7g7vz4HB6sWTndAcDkOil+qp2eOgVX
3+0URT+3sO0e4CrlxgnxWXMTp4wuHkiZqrvaQ+tJhupvjkR5zm+463jMYrWnoosU
/usF3Uuejq4X7Ibjc38/0SlGonmQKPPzGLKZhOv248zp88+6oF0fqCBasIOe8x+/
4Sh6ghFaG4KHSwkIqBcPGRZR6hVqni7Hbo50Z1Jrorf/OHompDgLVC6/WCqViToI
QxWWrPmX0n0F/XgF6TtMI72B6uXaXVGUx4y/oU7tGS5urYZ3rbERPoi/w45lQQ3F
sik8nDiRleaK32QGg+zLLDSdPpUUbmQOHHCQsqK5u+gmmwcWbnyIv+g1NYx14Egc
QXb7hDro+xJUE8euI/IVFyU2XQxmRbWQ6oHlk0hHFBkU/O1UbLOZQbPcFV5miaRc
dxq4b9rbMinQQ1hVthWnw/ZjBOeVONZ+rBSezovBb4paaADQYvUMtNfjs13M9xEA
zKZD+g1d5ok0bk7kcq/xqhmZD6O99ka/5vmJMjOBwPLDOehjxfoOt/0iIZDeHmp5
Ie+RrTE08+yavREq+j/qUnBr8IPcDkOkaDMYhlMLtocRvVxSgIY=
=JGdr
-----END PGP SIGNATURE-----

--uqByKH7ALOBvSX20--
