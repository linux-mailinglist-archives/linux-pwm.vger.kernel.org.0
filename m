Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE0336DE94
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Apr 2021 19:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241696AbhD1Rqw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 28 Apr 2021 13:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239646AbhD1Rqt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 28 Apr 2021 13:46:49 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2E6C061573;
        Wed, 28 Apr 2021 10:46:03 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id t4so12593504ejo.0;
        Wed, 28 Apr 2021 10:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h2RE4z+Jxtp7vOs8Qo9qwYEL+D6JsSPYOLMcr5K3PqA=;
        b=uVpqX8puNdiIdw1gMqYody+9FTlK1hnaS76gg44ZhYHfAVz7BmbE1oYwX7k/M9N2hp
         E7RL/YAqKtMdbE2o39PDbulDQkN950fqevw12uqpymPXgPzYwcXTU5RN0lQcZAL9CeLu
         dpXhB5F8z8EABCBGmtDKqhmnTwY0U2XrVA5K1Dg9aJQLnMrqOKo5koe2lNOF4Aelgegx
         9FSzTNleAIhxoVRkzNmEltpdGkaWLLKrsakwW/y5twBmKB/Y9uSWmZ24wNpOEMl5a0Sx
         kWA8YGRaAG+erWXPKsI2Ub1DNauDhS/towmCcHDgD05RCXEsNV2U+qVKg4h5d6wOv/CI
         I13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h2RE4z+Jxtp7vOs8Qo9qwYEL+D6JsSPYOLMcr5K3PqA=;
        b=VashcTguOTXq43c752d5oUfUP6AA/SB585al6wglLyoyLjpDLSWRiyXV1nCUgIMKmJ
         uNrXkUO8CGuxvnOAqdJu3hZIIPDs7wfub7ziaxkK0GS++F3p6PtjN3wS892sgtiDHtg+
         JqOqxb+aXZAbKT+kcl1nnr2IM8KHk8dLP1uPA/rNH8kSwfuO9Z4WCYA7e5wMbG02bQkH
         HFkw00rnNKLIDoYT5+kU49KZVwpoEyzXRaVJav5QtjJ08M2jGXEcpJho5gYjwndYTLcP
         +lCD0WN8axH3tU+dP/UAUxAeCteLq+LYBPFxTiIU5KDvSk1c94p0QxMuWZFs108ZrEnN
         03ew==
X-Gm-Message-State: AOAM532rVqH+fna8n8rLM59gFSCLy6hx+TfVlJ/f4CZz37tZuhBIYcLS
        ILAkBe/MfO+AgVsYKinCdW8=
X-Google-Smtp-Source: ABdhPJwYo0SY80J8JTTNQgWf2m8xt4bJDqc1YPG86vMVA00UJV/8WFUy5ba53ToD7pnyToo25DK9nA==
X-Received: by 2002:a17:906:13d1:: with SMTP id g17mr2925366ejc.92.1619631961966;
        Wed, 28 Apr 2021 10:46:01 -0700 (PDT)
Received: from localhost (p2e5be10e.dip0.t-ipconnect.de. [46.91.225.14])
        by smtp.gmail.com with ESMTPSA id v8sm370882edc.30.2021.04.28.10.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 10:46:00 -0700 (PDT)
Date:   Wed, 28 Apr 2021 19:46:56 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Fenglin Wu <fenglinw@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        subbaram@codeaurora.org, collinsd@codeaurora.org,
        aghayal@codeaurora.org
Subject: Re: [PATCH 2/2] pwm: pwm-qcom: add driver for PWM modules in QCOM
 PMICs
Message-ID: <YImfkM/ll1nCmopq@orome.fritz.box>
References: <20210427102247.822-1-fenglinw@codeaurora.org>
 <20210427102247.822-3-fenglinw@codeaurora.org>
 <20210427170748.wglupc6zwrndalxs@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ecWP3/I3yNFzHkoj"
Content-Disposition: inline
In-Reply-To: <20210427170748.wglupc6zwrndalxs@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ecWP3/I3yNFzHkoj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 27, 2021 at 07:07:48PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Tue, Apr 27, 2021 at 06:22:10PM +0800, Fenglin Wu wrote:
[...]
> > diff --git a/drivers/pwm/pwm-qcom.c b/drivers/pwm/pwm-qcom.c
[...]
> > +#define PWM_FREQ_EXPONENT_MASK		GENMASK(2, 0)
> > +
> > +/* REG_PWM_TYPE_CONFIG */
> > +#define PWM_EN_GLITCH_REMOVAL_MASK	BIT(5)
> > +
> > +/* REG_PWM_VALUE */
> > +#define PWM_VALUE_LSB_MASK		GENMASK(7, 0)
> > +#define PWM_VALUE_MSB_MASK		BIT(0)
> > +
> > +/* REG_ENABLE_CONTROL */
> > +#define EN_MODULE_BIT			BIT(7)
> > +
> > +/* REG_PWM_SYNC */
> > +#define PWM_VALUE_SYNC			BIT(0)
>=20
> I would like to see the register definition to use a common prefix (like
> QCOM_PWM_) and that the names of bit fields include the register name.
> So something like:
>=20
> 	#define QCOM_PWM_PWM_SIZE_CLK		0x41
> 	#define QCOM_PWM_PWM_SIZE_CLK_FREQ_SEL 		GENMASK(1, 0)
>=20
> even if the names are quite long, its usage is less error prone. Maybe
> it makes sense to drop the duplicated PWM (but only if all or no
> register contains PWM in its name according to the reference manual).
> Also maybe QCOM_PWM_PWMSIZECLK_FREQSEL might be a good choice. I let you
> judge about the details.

Please stop requesting this. A common prefix is good for namespacing
symbols, but these defines are used only within this file, so there's no
need to namespace them. Forcing everyone to use a specific prefix is
just going to add a bunch of characters but doesn't actually add any
value.

> > +/* constant definitions */
> > +#define REG_SIZE_PER_CHANN		0x100
> > +#define NUM_PWM_SIZE			2
> > +#define NUM_PWM_CLK			3
> > +#define NUM_CLK_PREDIV			4
> > +#define NUM_PWM_EXP			8
> > +
> > +static const int pwm_size[NUM_PWM_SIZE] =3D {6, 9};
> > +static const int clk_freq_hz[NUM_PWM_CLK] =3D {1024, 32768, 19200000};
> > +static const int clk_prediv[NUM_CLK_PREDIV] =3D {1, 3, 5, 6};
> > +static const int pwm_exponent[NUM_PWM_EXP] =3D {0, 1, 2, 3, 4, 5, 6, 7=
};
>=20
> Please also use a driver specific prefix for variables and function
> names.

Again, these are local symbols and there's no need for namespacing. The
only case where this would need to change is if the symbols started
conflicting with global ones, but until that happens, let's just keep
the names short and concise.

Thierry

--ecWP3/I3yNFzHkoj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmCJn5AACgkQ3SOs138+
s6EanA/+KxtrprYC/29QQIirySzAAgLCoW++tjUw/uvLAB0/mCqC0u0XGHuDf1co
WO2yw8nD9RWkOLdVzLbCiw/NVxjg3O9VDdPq+XMHc6mqwmRApt4i7Sq4zmYex4AR
ldflsnuV6wp5ZJcHrT9UPR6Sd/UGBWzAindxVPvqpCwQJwJ6seHc1U7PaM7dVLdh
7Ee0GYgA5HjmT6Xa/jfn6OBieoJT2VWfN3mdrYCXHCiEnjUjyiRKX50jwKxWiERI
l2+HiKrQ46vumvQqV1+HJrUGxLYZfCGjYGvHc2sd0uWTMxaH9LteNByFFjDPrLl9
QY6Ox95dWp6qys1fIkqPp5NWJyqNB8v6XCTcqx7TlxTe/KmZcywnKmFK+jnHfOWw
aFl7m7ylYQjtsbCl1OnWs48G6dH6LfcReHKCaCxeVywu6+3SfRSfebryC7B3Vfxs
oB0PTlkr7sy3EiPUwfRQa72xn/NFqzPCn9XzwM9oGmOFmFBHyn2olCPqzAcu23cY
6T+YOtD2QYa7W0PYYJ/kjMTXalgoMfLRaC4bhNkaVhwzd3iStBrIcrJJrGeAOAlo
26NH7f2gODb3sGqANRGC7905EV2goOCLVKQh5FstZeFqMiXqqSyBEcYU8QLXYUVt
BK97V+s7RtVIr8wgDV7HqiUlAJmVQvUEj1M0U1TqxaZs5IQJVpo=
=PQGL
-----END PGP SIGNATURE-----

--ecWP3/I3yNFzHkoj--
