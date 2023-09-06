Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4E8793EBA
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Sep 2023 16:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241343AbjIFO0s (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 6 Sep 2023 10:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjIFO0s (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 6 Sep 2023 10:26:48 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B96EE4C
        for <linux-pwm@vger.kernel.org>; Wed,  6 Sep 2023 07:26:44 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52889bc61b6so5305335a12.0
        for <linux-pwm@vger.kernel.org>; Wed, 06 Sep 2023 07:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694010403; x=1694615203; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bs+W/u3S403yXjxn4vONJBldMdIB4gft+2a5Itd2PCo=;
        b=oypaEpNiq3w9fQ4DvpmOjfBVx5Oxjufa9P2KVGcT/9vETXGPGW6Za1lzABsUfgBFk+
         h2HHjnvlGrqcwvO/ybVJlN0L9yFKg3xFPxKX7zL9ZWYSlautVZq/HDA+dxyAKIr51Ef2
         VTvTw1ZansM2WsmDtRZX9IQ7oCrkDRqOLBVI/GdjUrVTXaswOTdgdLWug1ZmKNdl5V+4
         fKjSAJyFMIFocbDTq2fCxQE9Bgi9scD8z5toADczApo2HR+mDHfP1ZO7AG8y6qhtGbDO
         61FbRBN0HBTYUlJ01ioAmUBf2rajrZPqas1DKvbX1lbewUOUu1TIR9JzQHVx/iU9k6ij
         ZmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694010403; x=1694615203;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bs+W/u3S403yXjxn4vONJBldMdIB4gft+2a5Itd2PCo=;
        b=lYKGr+ovbCIN0ldJlQQmFK2qxir1RHx1eDUIh0iQxLHl9IbcSn6aMpwwsdlo+lsKen
         OMyJR9qpc3zvPS0m8rpND/VkH2lpBOXeiIYibMM6fdkceFnmVcCJ4UrbzCIaF9xn0SVn
         3Z6ac9SRZD4osCSwL8Gb0XIPL0IN9/4nBCPSwyhmSN4S918bqxRwdX+oZxzHV8KkeE/R
         chk7dJTn/rGEXehctUMFvZU1w5HLn9tMZv2zgSJvkNuhezR/9qEAysAjgR86qFfJ8Q4B
         dVknBRM4sMXaUSffUBbH4gbY8oI4FjWA+ZN2ef659DIVfpMySOWMs82472W6lA4+eqBc
         8ATw==
X-Gm-Message-State: AOJu0YzvQ6NTOD/XTjGh3UcUdLipiHJNUdNFq5BtnPYqCxUcgoTQ/Y5u
        pfPSS/QeBXi3hTGtgmEE1AyMFevkgnM=
X-Google-Smtp-Source: AGHT+IF6yELDWL5gXf9ZQS/BjPUPQf9FVvfGolbQodzw2JzBpbVPRcUiKR4rr3p0Dszz66QmhnqGQA==
X-Received: by 2002:a05:6402:608:b0:525:6ab3:dd22 with SMTP id n8-20020a056402060800b005256ab3dd22mr2660080edv.38.1694010402706;
        Wed, 06 Sep 2023 07:26:42 -0700 (PDT)
Received: from orome (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id g10-20020aa7c58a000000b005227e53cec2sm8491122edq.50.2023.09.06.07.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 07:26:41 -0700 (PDT)
Date:   Wed, 6 Sep 2023 16:26:40 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Vladimir Zapolskiy <vz@mleia.com>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] pwm: lpc32xx: remove handling of PWM channels
Message-ID: <ZPiMILkEznOJNTU-@orome>
References: <20230717155257.2568627-1-u.kleine-koenig@pengutronix.de>
 <20230724140032.g7vriv72uuvxbohd@pengutronix.de>
 <20230728092329.i43omkxgkryui6ku@pengutronix.de>
 <20230906094730.w2igbdq75jms266o@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QkR731jkCIIdfmCv"
Content-Disposition: inline
In-Reply-To: <20230906094730.w2igbdq75jms266o@pengutronix.de>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--QkR731jkCIIdfmCv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 06, 2023 at 11:47:30AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Fri, Jul 28, 2023 at 11:23:29AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > On Mon, Jul 24, 2023 at 04:00:32PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > As noted by Dan Carpenter in
> > > https://lore.kernel.org/linux-pwm/919cac5d-491e-4534-baed-bf813181192=
d@moroto.mountain
> > > lpc32xx->chip.pwms is NULL before devm_pwmchip_add() is called so this
> > > patch fixes a null pointer exception.
> > >=20
> > > Maybe add the following to the commit log:
> > >=20
> > > 	Even though I wasn't aware at the time when I forward ported that pa=
tch,
> > > 	this fixes a null pointer dereference as lpc32xx->chip.pwms is NULL
> > > 	before devm_pwmchip_add() is called.
> > >=20
> > > 	Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > 	Fixes: 3d2813fb17e5 ("pwm: lpc32xx: Don't modify HW state in .probe(=
) after the PWM chip was registered")
> >=20
> > You (probably with b4's help) picked up the Fixes line. The description
> > and also the Reported-by was not picked up, though.
> >=20
> > IMHO adding the missed bits would be beneficial.
>=20
> I'd consider it important that this is added before you send the PR to
> Linus for this cycle. Is this still on your radar?

This has been in the for-next branch for a few weeks now. Can you check
and let me know it's what you expect? I was planning on sending the PR
today or tomorrow.

Thierry

--QkR731jkCIIdfmCv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmT4jB0ACgkQ3SOs138+
s6HvaxAAgsxePyU8FbfUk7b9Su6ev2Mcj0QVBWN+lhqt8MXF+k16wotqJEPNc4Ec
NeXLF5KIo6EnNX0DEmHMNEyynroZpmfeRMi4CJ5jC28rUKGjJr/di78Fw4cGSd/J
ZDIDTzje6IYnaRs3UiDs4yvQjNaQrnQgMmU0FKqsb2L43BhaVws8U7a8p3Iqxyvu
bh/jECxSz8Po6GxfvCzi3QlNVebUPDEar4DG67JfRqgZKXiMDz20u8EPel6Aj+JV
w7S5dIiM+D+Mvj/HD3vlc25vNdbmSqkOilKHkz/dJIX5exYlv/nl4NomJHBzSpSr
aPU3qNEL+ROCwzJ2lf4daHC3O4vg3qzX4rFdBW6h2+5pr1lcehG0cp8dmyxy2e1M
b3Psvo5xjHlzg5xgRZVe7pwz5WAZDL3hT0BRtoQVHJkvHlrHELSpGSF4ob/t+wFr
GTVKyw69OZz5eGjvwCE8gGE+7h2zPmtSawsFJnbWBV2gFflNa8+coY/omFqz+HBW
R8jZqDE+rMoeRWfRWHmYfPjed8CxinF4QIa48TabRvCjtNjwRIH0qoED1cfv4kyX
WFUMcFo87F7aj8/goj8iBMQ8j9zv36w6Gc+T153ZQnk2B9NOpr77AqM5sNuYkLdq
6aVfWFwHvQj2M+Q6RU0h9nuRUxhDoezXSe6dje/fZPDT3fQOAe8=
=mBL5
-----END PGP SIGNATURE-----

--QkR731jkCIIdfmCv--
