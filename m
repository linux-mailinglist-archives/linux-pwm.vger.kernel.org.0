Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878BB758FC7
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Jul 2023 09:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjGSH7n (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 19 Jul 2023 03:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjGSH7l (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Jul 2023 03:59:41 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B777B1FC8;
        Wed, 19 Jul 2023 00:59:33 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51e5da802afso9297988a12.3;
        Wed, 19 Jul 2023 00:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689753572; x=1692345572;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SY33JB6mC06OX+KVuVVPGO/hdA0681iQksC22lBI39w=;
        b=liuKUqJaUlnKfEF8tXwzSZ49YiRIlsc7h1XPQEDoYy6gsuhiF8c4HJCRILWSRJsMBJ
         1olJrfyfekaaEnjVx+tmP2AJqXnczuPHJ74w58LITgN+rP9mtpulsVwZ+zn+vnXhLuQR
         Uhym8tWeE7khXi2Qzp1di3JKvZl/CM0xS9gqCpcCG8dolwy5U2eang7d7BujbWvruxc+
         /nHY42aAhVSgPn9+kFtjX/VzzAHMPcCp/A/FgW2Ooiz0m0AeWmqLhoFNGRFqJytHMkXz
         4zJKvmPuOockRHief8wnp2KoZEY7Q5N6P5IdsyFXSER7nwMDXTniyxM10RqfGteyZ/W6
         2vtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689753572; x=1692345572;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SY33JB6mC06OX+KVuVVPGO/hdA0681iQksC22lBI39w=;
        b=egou8S8qwbQM88+BP1AX9OZsQa+MO7G2A09xAD4EASSegknn6OTYC3ZozLaIfLvxnN
         2itZIDSlLPCAvFJIRC7xz5QHvxDJWAZpDyYOMKStIAzQx5coIrKoAOAwAOf4nhVcieQO
         PkT3db/4uQ5gTTZze12rQnW2yjXvkJuEVmMcW+PascyFu3UMP+3Mt3hdShTbfFhGmitv
         OLLfkHxTXDKHEPZ3Hi7KYunmQpc9k/Nz1dLkyXb/BJL3fVdf+0pkcLeOaSKvKo2ouvzb
         ygv8QsS+Ho63OL/s7keFYLaiR++s07JMgfEUtf0qpDaKvMDWJzfnorq3zam28ErMnudS
         LaJg==
X-Gm-Message-State: ABy/qLYX2BW3sPwkEi1udfUD720WZ6BQ+eq5bUUKwnMAnff4sh/AOy2Q
        q6tAYmQ5p8A2PCtdBfrnY74=
X-Google-Smtp-Source: APBJJlEc2dwWmDy7Bm2SJDKNnr3eVPMKtYL5zZyHQ5J0s+PDo/mH3pp2hKySUA2Q9wvbJO1vfvKWjA==
X-Received: by 2002:a05:6402:181a:b0:51d:9b4d:66bd with SMTP id g26-20020a056402181a00b0051d9b4d66bdmr1857165edy.9.1689753571518;
        Wed, 19 Jul 2023 00:59:31 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id v17-20020aa7d651000000b0051de3e1323dsm2304242edr.95.2023.07.19.00.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 00:59:30 -0700 (PDT)
Date:   Wed, 19 Jul 2023 09:59:29 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        James Clark <james.clark@arm.com>, linux-doc@vger.kernel.org,
        kernel@pengutronix.de, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 01/18] pwm: Provide devm_pwmchip_alloc() function
Message-ID: <ZLeX4UbFaY592HIa@orome>
References: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
 <20230718181849.3947851-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zj8p4Nk1goxewME3"
Content-Disposition: inline
In-Reply-To: <20230718181849.3947851-2-u.kleine-koenig@pengutronix.de>
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


--zj8p4Nk1goxewME3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2023 at 08:18:32PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> This function allocates a struct pwm_chip and driver data. Compared to
> the status quo the split into pwm_chip and driver data is new, otherwise
> it doesn't change anything relevant (yet).
>=20
> The intention is that after all drivers are switched to use this
> allocation function, its possible to add a struct device to struct
> pwm_chip to properly track the latter's lifetime without touching all
> drivers again. Proper lifetime tracking is a necessary precondition to
> introduce character device support for PWMs (that implements atomic
> setting and doesn't suffer from the sysfs overhead of the /sys/class/pwm
> userspace support).
>=20
> The new function pwmchip_priv() (obviously?) only works for chips
> allocated with devm_pwmchip_alloc().

If this is supposed to be similar to the GPIO chardev, why doesn't GPIO
require this way of allocating a struct gpio_chip? I'm not a fan of
doing all this upfront work without seeing where this is ultimately
headed. Please hold off on reworking everything until you have a
complete proposal that can be reviewed in full.

Thierry

--zj8p4Nk1goxewME3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmS3l94ACgkQ3SOs138+
s6GbQQ/9FNu04+Be3HbKY179h5Sp0Nc/r7oY7Mfv0aFqL5bBhlQFNjiiZE73n7AK
6qUfXstBKYLaMWTFLQt3pqpx5JoupwmEfr7gDLRzLUcXjQt0C2IqQak0yzmxMe/l
pdT9XbdJHMD2/zpbJ6H4Fp/GwtRw2oA3Yv9XnEv56sRFTFSqMY7Ync+JwMvLxsmN
LHVNqC8psDnCpUQk8yfV3LbIenfEpBGIWDIs7s5HPZ7ylvdw9i4Z6uPmklbusZ1T
XZ39wTU7adrQahZ5GawUmnIexKjXD7TiqIF9tR4Lcc7ycr0KAPb49+ShuNb9ka/F
eWY5DTfZ4pcmtXbIzWohwoME5O4q94X3ZikG1LbVhjD3syJcHkC6Xw2u4LCwnHmh
65HaTngGwpRo8PLx+yysv6Qs9mB4aPPgkaenExAbX7Wo6QL5ydiHMIRuwYQGL5rs
pVnBzX+gIK/i6cx+H32vJrxHRR1tXhMNPmFh3CS0XI3U3U5Q2/zHFxKJgmz+Bghi
R3DL6Z4+8X2xJqNfQ6MIW7h8mdr4Dw7ipONEHa3ErnoPYMxHeEv7oDhtn2SjKxZb
SUGQud2jT05aucQoEZpq5eCUUysmyZlEkl6ZY1bVYR7VgaF9cIl3tJuqn5OQldU1
0hZ8h7PlDt20RcsO2OgCflm4u8WgZUa7EB4KTG0LWmH7LU+6OwM=
=YVVW
-----END PGP SIGNATURE-----

--zj8p4Nk1goxewME3--
