Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F662B6921
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Nov 2020 16:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgKQPyG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Nov 2020 10:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgKQPyG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Nov 2020 10:54:06 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC3FC0613CF;
        Tue, 17 Nov 2020 07:54:05 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id d12so23633948wrr.13;
        Tue, 17 Nov 2020 07:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/5kLcO6t171ljhvclwiXieo9BdxgiCA8GIjPWPG6CNU=;
        b=dli8pEx+cYLg5vrMGETcovDelUmv8mOh7gSsncrblAYgGa46TN31/t+Ua+xuDfWYqk
         t6SVahY0dnC1iKhoGi8U1v7hEodc5znwf3TXNDEcvk3mh4t6TjhDyqEIlmY8Lo7Xjj1g
         joedr42jedXtpqrfZ4O1Rj8DAnlaiEsfoR1Vi83hZz6LH0iZtdpFvsBt+gXSl05tJmmp
         HbmpyIKoCYkS9kIjYGXL2CUaIQY4sHciOpYhvRpwz6OSN5v+enb0pqle7Dt9wlvs3exB
         TiSTPjowtrYYNzmX/r6M6C5qlXJ3qYb/krcjmc3h4ItBxqbdxT0SH7nhOxtdtLmWquqM
         5HNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/5kLcO6t171ljhvclwiXieo9BdxgiCA8GIjPWPG6CNU=;
        b=lbrYyYZmdmeOAxueor8DmPjvraWzW8aj+hTubTSz+Tq5pkHyw/CYjszRiCBsyC5/vP
         /nR8KMWT15U1m9vap/UpLpAz4An06yT62zF8Vts6500ACxE+uhatLiU4yjiMNVLg8W1t
         yAXCzmNruEJGvUUBPZX8jQZoL55h9WgKRR1jvrwqaHyT23gxn4NkdAxQvw4XwtY9iYkR
         8t8WpxsPmnWzAIFUK+yprQqlTgVbeGKNwIWUZ558eo9JnvDalurPMxlwZaWfInDEXJqI
         hnr0Ec0lr6jn9ttNnkuZ2qUej4pOh64nZnu1T63wVnstKLlxVCAoUtcD2DRCAuh8613/
         YG9A==
X-Gm-Message-State: AOAM533y1geOcxwMwnXHlV86RAkYNC9PqwB33gwfIU+bvLSZlnE3rsZO
        7pKtEdzmsEQVoWXy59ijV8o=
X-Google-Smtp-Source: ABdhPJy1N5cAf+VLK1jyIS6wJPsISmbrHUZ8whxHH2tBW1fmsFoSIQasqMW4O0KlZlsRxEXSq7VYNw==
X-Received: by 2002:adf:f183:: with SMTP id h3mr138198wro.239.1605628444259;
        Tue, 17 Nov 2020 07:54:04 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id p4sm28568824wrm.51.2020.11.17.07.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 07:54:02 -0800 (PST)
Date:   Tue, 17 Nov 2020 16:54:01 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, andrew@aj.id.au, albeu@free.fr,
        f.fainelli@gmail.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        Eugeniy.Paltsev@synopsys.com, hoan@os.amperecomputing.com,
        fancer.lancer@gmail.com, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com, vz@mleia.com,
        marek.behun@nic.cz, matthias.bgg@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, grygorii.strashko@ti.com,
        ssantosh@kernel.org, khilman@kernel.org,
        manivannan.sadhasivam@linaro.org, p.zabel@pengutronix.de,
        linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] drivers: gpio: use of_match_ptr() and ACPI_PTR() macros
Message-ID: <20201117155401.GC2589875@ulmo>
References: <20201117154340.18216-1-info@metux.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f+W+jCU1fRNres8c"
Content-Disposition: inline
In-Reply-To: <20201117154340.18216-1-info@metux.net>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--f+W+jCU1fRNres8c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2020 at 04:43:40PM +0100, Enrico Weigelt, metux IT consult =
wrote:
> The of_match_ptr(foo) macro evaluates to foo, only if
> CONFIG_OF is set, otherwise to NULL. Same does ACPI_PTR with
> CONFIG_ACPI. That's very helpful for drivers that can be used
> with or without oftree / acpi.
>=20
> Even though most of the drivers touched here probably don't
> actually need that, it's also nice for consistency to make it
> the de-facto standard and change all drivers to use the
> of_match_ptr() and ACPI_PTR() macros.
>=20
> A nice side effect: in some situations, when compiled w/o
> CONFIG_OF/CONFIG_ACPI, the corresponding match tables could
> automatically become unreferenced and optimized-away by the
> compiler, w/o explicitly cluttering the code w/ ifdef's.

Isn't this going to cause a lot of "defined but unused" warnings when
built without OF support, for example?

Thierry

--f+W+jCU1fRNres8c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+z8hcACgkQ3SOs138+
s6FfaA//aqVfUF1MPmGuiib2ySGJqA3j6uXaK6UyaP9sIBxy0HGwTDDvPa1988JE
Rf8k6pipA56hbeeoO6cgi0TSlI47g/uZRjMMRO4QeRyfMDaShigw+5CQ70P1kBku
y44LrSK9CVLI1gZ775/HtNVlDB7qC+Qo48aHEKhSU2L2gE0LouJrIwSC9Fz6aOrI
d9b181DyykfbdRy8rijZzt1Y8Lc6/1HMI/Htfy9J4RvxCFWplHxnoKFHm+JeB8o5
YAl7MB1zNn43tOJwQJMhXUerfJ+aEAs3R+GyubzomQRLr1T+UDx+ITE1gzBXP76m
ZA50cuGvzFlY8wSK23a/YkOvgLqyxSY+b9AU34rkfH9t+pxurfzLh4lodtR7wbQ3
CsacvDumSFQ/IxNS5EmyHPMQoHxCMMZ3RL4FTgQegD1a72otSZTiW7luv7mV3A7a
cydkIiGtaW9rZD2xpmcQUlFziTdFKHDv+QzXBXJVFqNjtaZ650TkqItloLqEi1PU
phboKfrlfIeeIl09+UMlgLNmMg21xFMycylUdUepIIxcLZhEQQ408FD2WOUFvZ9x
6qoidPLoE+AmnVK2Cqg+W7hLZaY8toHO0j5C7IdyglWRQuvU6GtgGNz0BoGtqRyL
ArHVHA9cI1nQA7NJ1xtaFnKAI/xu3TN+JoEHoEgqCRzmnwv6g5Y=
=WjVu
-----END PGP SIGNATURE-----

--f+W+jCU1fRNres8c--
