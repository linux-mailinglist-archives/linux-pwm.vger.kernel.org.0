Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57467BB41C
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Oct 2023 11:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjJFJUJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Oct 2023 05:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjJFJUI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Oct 2023 05:20:08 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA44C93
        for <linux-pwm@vger.kernel.org>; Fri,  6 Oct 2023 02:20:07 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9b27bc8b65eso324140266b.0
        for <linux-pwm@vger.kernel.org>; Fri, 06 Oct 2023 02:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696584006; x=1697188806; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmyRyG79LR4NLAyyWP9wCEFQgAHy/+ONKYF6SbqGm+A=;
        b=mUe+hOD7fF30abJq/qz5cjD5BmvMtfFz9z8BEih3/VoMi1RRC9bdf8P4VxPYMtxQvn
         LRXr5Rfyf22V4LB9D3rNCgZICAo9ov4Nv6Vja54m6cPhcFQuOt8TFzszbcjjs6PCdxqv
         QxYNKKa9JOh2ZgjGWYexVXbwrbq5c5aA4REPozZPGJMbKiILtBZYIIvZLDBheYzFyvRU
         kcj7CWUqkdiKOATD09QBXprYmLQUtBGSQA4fEjnnnpkDStEDCmejctG3GnpZkY4EaH9X
         PvICwV6B2o8ou0v73wwX9PLD1SXn4GL8n7nrDjMDnErAMgyvFeAL8q7iD+eWSR/kCHrl
         zcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696584006; x=1697188806;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PmyRyG79LR4NLAyyWP9wCEFQgAHy/+ONKYF6SbqGm+A=;
        b=XSpHshNRH3/3wjx/P+d4UNBIxR/pDpyuLU/39FkDnmRQzI8Sm2rcaBXB0KYnRytgXl
         eNqMKajjJGI+SjYsxc9k0GVGTqVNWnYGO5ckpri6hDNWSzmyUKqpJ73jOiOLBIm1AUPH
         TNiuXh6qVyhPf19vB12hSBW+wJXjcyktHtZRteZKeV8deJClLI2aU7mGhxB8SjmJHlXZ
         +sOYNSRjzuhqDnAoVpXPHLAyEE3ENALd7/kH3B8qVEHhXW2vwfJJeMLv7SRSLcYyhYpE
         hm4UZcUAFYOAMTS/aJ2bjB3SsrcX52I2GlqvRD0yuLGUs+u3hBXyZI6n7JaGMLRnVhyf
         jFJA==
X-Gm-Message-State: AOJu0YwWs01ZZOnqjRTzRLwuu6qiCvU8IopYwcafhmqt/1SeL4xCVREx
        QqrmOXf7xrKTdT94PCvz48YopGc2EWY=
X-Google-Smtp-Source: AGHT+IEISdT8Eez66etq97blUcK4626cxBXq02t6jNlhoyb3qXweUdEufjJQ7BRFwyjSoEyLi6u0NA==
X-Received: by 2002:a17:906:2d2:b0:9b9:ed52:8230 with SMTP id 18-20020a17090602d200b009b9ed528230mr3518738ejk.62.1696584006158;
        Fri, 06 Oct 2023 02:20:06 -0700 (PDT)
Received: from orome.fritz.box (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id z11-20020a170906074b00b00988f168811bsm2590436ejb.135.2023.10.06.02.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 02:20:05 -0700 (PDT)
Date:   Fri, 6 Oct 2023 11:20:03 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 000/101] pwm: Fix lifetime issues for pwm_chips
Message-ID: <ZR_RQ-PMqfrDPGwE@orome.fritz.box>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WnvlS8796A9XNP45"
Content-Disposition: inline
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
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


--WnvlS8796A9XNP45
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2023 at 07:17:50PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> this series addresses the issues I reported already earlier to this
> list[1]. It is based on pwm/for-next and several patches I already sent
> out, too. Maybe some of these have to be reworked (e.g. Thierry already
> signalled not to like the patches dropping runtime error messages) but
> in the expectation that I will have to create a v2 for this series, too
> and it actually fixes a race condition, I sent the patches out for
> review anyhow. For the same reason I didn't Cc: all the individual
> maintainers.
>=20
> If you want to actually test I suggest you fetch my complete history
> from
>=20
> 	https://git.pengutronix.de/git/ukl/linux pwm-lifetime-tracking
>=20
> .=20
>=20
> In the end drivers have to allocate their pwm_chip using
> pwmchip_alloc(). This is important for the memory backing the pwm_chip
> being able to have a longer life than the driver.

Couldn't we achieve the same thing by just making sure that drivers
don't use any of the device-managed APIs to do this? That seems like a
slightly less intrusive way of doing things.

> The motivation for this series is to prepare the pwm framework to add a
> character device for each pwm_chip for easier and faster access to PWMs
> from userspace compared to the sysfs API. For such an extension proper
> lifetime tracking is important, too, as such a device can still be open
> if a PWM disappears.

As I mentioned before, I'd like to see at least a prototype of the
character device patches before I merge this series. There's a whole lot
of churn here and without the character device support it's hard to
justify.

I have a couple more detailed comments, but I'll leave those in response
to some of the other patches for better context.

Thierry

--WnvlS8796A9XNP45
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmUf0UEACgkQ3SOs138+
s6G7Jg//RIkc6aDRAunTy8AkJT5jzHpScbhDQWiNXs2JwhCg9gwKYi8Y4eXyt9Ii
imjMWTmN6rlwcQRPor1LGNWCpbgHt4dKRUXcR6jM1fSsTlFPb8EMyOEobBr1u3wt
XbMfcvrg4CJGD3W4hdAROEP5i8DQOZ7NESQmRkedhR5/j7MlHW3Hh4dBKcr4nCT/
Rq+ujykvzMroJTGHH2HVAFSmH5tvxabL5eBEuG3exrlw0ddf8Rgexg7fSJs7UuQO
+6AuwOkjwxN0LTwaixvEl6Tt8YfdxmSVrY7gIxGUCz5AIDqTRtaAlqsRkFEnK6KQ
K0QaLRnpkTPrPgkRN/E/85zrBdBHvj20awPhF0emO1dLvl7uMLajsOzPbZ0wR/w2
CV79/n9yIEw+8pTGlAlXbJeLKcO7k2M//1fDPfGU8M4dJLjEw4DAylFmMLuNV8rC
Dly/QXRlvtf8gSZuZ9TKj0/EqCuw3dn+wjhCqfo2+AEUCfuyktq7xVCQ8aodtGN/
Ew3hjw52lNvNQjBvf1+AZloQeM8i6n0/nY9mAxQc3DxF7//D19qSEPNArgTvf62z
fyyHmZjE3iNOjQypJyogJuMop+0AMYY2h4ygefCzlDU7ZTN9a0xES46xjtCQdCAA
z6nQ3y0dpgGCdowOs0CpO+Kmefmjgp0NEDT36NsSks50a6/U3To=
=McdZ
-----END PGP SIGNATURE-----

--WnvlS8796A9XNP45--
