Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350B45844B8
	for <lists+linux-pwm@lfdr.de>; Thu, 28 Jul 2022 19:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiG1RMQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 28 Jul 2022 13:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiG1RMP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 28 Jul 2022 13:12:15 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E5A61B0C
        for <linux-pwm@vger.kernel.org>; Thu, 28 Jul 2022 10:12:14 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id va17so4347347ejb.0
        for <linux-pwm@vger.kernel.org>; Thu, 28 Jul 2022 10:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uzaYzu/7YpWdMzqpQ1Y/ZAohuFNkiDQbSm5ara1NJVU=;
        b=BAsucz+Hz5v/kpd7FHUcdbnOqnjbw0IdK3L6ici654KuNt+EXJEmCp6iU2f2xjvDuV
         i7PkEEn0r/64W3x9f3vehW24PEN1pvanEVIUIc3y9mz7tBrZ92RYrZlF1Fi7qqFye6up
         pFO9+LC7S7fB2/iqkqO0/Mh6X2lJISc/In+oC5eHxM+j1Sm+1N8uszIOHjq08wG/bSco
         0lu8DsTCrkwUqrMlh2nELFXOWR9PoDe88AEBKSjdz9THeRQMYYqdilYNNWshAMJKttlX
         FQUwirmEnbvonChSTQwMD43+JpQsKd5YN4yBRVDc6YHLHfTtAlxs/jxPep67QGbclYVE
         LisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uzaYzu/7YpWdMzqpQ1Y/ZAohuFNkiDQbSm5ara1NJVU=;
        b=D4zeWl53AHM6KDJWaQrINskznEbl424ZbCEWvvaP5JDhPf7MfxzdOGv5RoM1bShvdX
         w9aP3QVVDLg0xTinJX41LiY3i90K6u6MfI6nDqviay8ed50gJ05u2WE4rRJiyU7MWkKa
         3VemVqd2fvfyuHlvYgPLV35g6a1rB2yfu57Uk9LUINa+sU97wm4L5LXZjwlD3KuRofD5
         uO/Ft4D0xkNYmKFwige77TqYd9R10fN4ipfRbjlAG6IJBhCRXyA80Rkbi3VUNZEbP9Rj
         NICTwGGcEmd2kXX4H1Y5trsvrfSFYOqP1FlV53D2r5a1Pg8QxlXQ46EKFFBvM4WTlzlt
         sw7Q==
X-Gm-Message-State: AJIora+wVw8dCOY1X2ZQOCqdQq/fUOBgvpsnqZo61mV+sLHY68DOdrot
        q/bPsaWep4zvPsXS9+u37CKoE6Vdv+8=
X-Google-Smtp-Source: AGRyM1vAAv1IAbdH5r/BCjTknzu9ruuKTH7W5MxzEtu7d3GCD1p7btWP7WZK9+g5UutNMvYrwfm2Og==
X-Received: by 2002:a17:907:7f9e:b0:72e:d375:431 with SMTP id qk30-20020a1709077f9e00b0072ed3750431mr22295254ejc.580.1659028333247;
        Thu, 28 Jul 2022 10:12:13 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id g17-20020a170906539100b00722dcb4629bsm629302ejo.14.2022.07.28.10.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 10:12:11 -0700 (PDT)
Date:   Thu, 28 Jul 2022 19:12:09 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wan Jiabing <wanjiabing@vivo.com>, kernel@pengutronix.de,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Yash Shah <yash.shah@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        "Wesley W. Terpstra" <wesley@sifive.com>
Subject: Re: [PATCH 7/7] pwm: sifive: Shut down hardware only after
 pwmchip_remove() completed
Message-ID: <YuLDaawwep6noOJL@orome>
References: <20220721103129.304697-1-u.kleine-koenig@pengutronix.de>
 <20220721103129.304697-7-u.kleine-koenig@pengutronix.de>
 <CAJM55Z_+AOmyFs-QgaQdnk4m7SN=JMcszjG+mtANzBcWkGYBkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5sXYq7NI5EQUbDCH"
Content-Disposition: inline
In-Reply-To: <CAJM55Z_+AOmyFs-QgaQdnk4m7SN=JMcszjG+mtANzBcWkGYBkQ@mail.gmail.com>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--5sXYq7NI5EQUbDCH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 22, 2022 at 07:45:32PM +0200, Emil Renner Berthing wrote:
> On Thu, 21 Jul 2022 at 12:32, Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > The PWMs are expected to be functional until pwmchip_remove() is called.
> > So disable the clks only afterwards.
> >
> > Fixes: 9e37a53eb051 ("pwm: sifive: Add a driver for SiFive SoC PWM")
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>=20
> Hi Uwe,
>=20
> You didn't send a cover letter so unsure which mail to respond to, but
> I tested this series with
>=20
> https://lore.kernel.org/linux-riscv/20220705210143.315151-1-emil.renner.b=
erthing@canonical.com/
>=20
> ..and everything keeps working, so
>=20
> Tested-by: Emil Renner Berhing <emil.renner.berthing@canonical.com>

This is fine, I've applied the tag to the whole series since you said
that you had tested the whole series. I'm not sure, but I don't think
patchwork automatically adds tags to all patches if they are given to
the cover letter, so in those cases a bit of manual intervention can
be necessary. Perhaps b4 can do this automatically. I should probably
test that at some point.

Thierry

--5sXYq7NI5EQUbDCH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmLiw2kACgkQ3SOs138+
s6GyVBAAhAQ9zC9phmeAQTqcxqO5Z5LtK6QeNJcWghr384o6ChUV+AVPb/3gh31Z
P3hGn9/aKarKOZnYcVWweOzEYvwxyGkaR1zrLQKp535RaG9BO6t+gnusW2Ckc78t
v7l7+3OwsUCUsc9WJOoRppQjT3ukcPCe+2KU1Vn6ExezmMz8IBpDHN9axtER3Pxt
UDHH0HRVDttj4KM01XPJ/SVWYDbrXtLHOEGw0RM2VG4xjBA8y9hqd394Dg5d3y5o
8d3P8CfnxhXkjCw6PH9gS65K0xSQ9+rAR59IVMtUw9Kon5X8yX5dgkAcjEY/I41c
ngvsVojR4ioq6ynjlS5/TybkpOWSjjVlvDn21TbfqE78/aWKXecE0R7LGcqTkzPB
YYcjDlXLfaoJHScATL1GpdTg7Ea58CilLbe+QBE0PqmdxjjETv4T923uIZfyYDxt
zEjsvpgkr1NZT2NrIV6CaRJoMQS8r0vlfREC5oUMEhzzHPkNyBI1WTfott9U7T24
l3bqXcRGAkYTrg069UlgSApVQwjX1WiBa2F/VxBcM//hq0E7Glbu0CZ8fH5LUBEc
BDzHCNlWKql67OXsowFHix6HOFGl2H8s4iAHZ8aOBNAXIL3Qf4vNXOsaJ4vMJWdr
WHLg3FmwlxGtaV3xKVjB/l+gRRuWbUR5usJLK/yqVc2AH8Ehwfw=
=FYFF
-----END PGP SIGNATURE-----

--5sXYq7NI5EQUbDCH--
