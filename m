Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2520735DDEB
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Apr 2021 13:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhDMLlD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Apr 2021 07:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbhDMLlC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Apr 2021 07:41:02 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A68C061574;
        Tue, 13 Apr 2021 04:40:43 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id s10-20020a05600c318ab029012d7c83637bso25129wmp.0;
        Tue, 13 Apr 2021 04:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MkaJsdRxcT7X9SeJC6tmjhb8Lb+kbsYW+1qTzC0vHSg=;
        b=NbbEjj+8QyG7yInSEnyfAVZV6f6bHqYIPq95qqf0KoINEPGw0i3ulBOFhROAIWORdQ
         g+s8tG8VHqKqpxZsAnX/0KCumHKedofe0vc7poTggkp1+dOm1Fa8pOTF/lseWzDzcIq1
         alicTMoZ8XNxDCY06jnaNIiwdHP1cyj/zuKUqlPk674rX6W1Qw/yQDT/41o71/HjAFIJ
         UizZOzTRJNAPbh9ZtRmnXFMJJ2u5NTnQPov9XN1iCBECoSF95psRq38s4cHxIMgj7aGj
         msPPuytaklTeVc1vv2mgdIUgozwZVj08eCsvD1NliWMziUep0Fni0JPvfFnRs1fcebX4
         AdYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MkaJsdRxcT7X9SeJC6tmjhb8Lb+kbsYW+1qTzC0vHSg=;
        b=IeHuel2DMqne24nSt+u1NR0w9xmUvzv5EjeQViv1ncoJukbfjcbQGpAwz58Yp6Kwrd
         V/QAgSFWbOrOl+pt3B+Bvc305X9ovV4UsZXGrJ3Z7fXLqUQZLO13+yKmLYYA8YMoIuB5
         tgGma1o2p+uVxI9VGlzzDtg0YAhlqAUiJQaUwBjr0MfVmXUccgrcwQrUsAeLjMSK+PSK
         Grd5TQ6Kl/+SMVDv3Z6v498zmbx5wNYIRpVNvsTscmmlHzU7wdf9ZQRc3NBLSd8I4mSk
         CVzI/SSPqdpufYOQXfvgWLc82dF43I+t0XL7PmymO2ph+xHDD2Y0io1LscadKLfIIVGl
         1s3Q==
X-Gm-Message-State: AOAM532wpeWueSKC2I3nGGs2sp8oczNcmxQ+LCD3O9GPTuk5S13Ldzz+
        VW3gFAMn/21k2T8SHd0Rte+VrdCS4+4=
X-Google-Smtp-Source: ABdhPJxOAUE/BxJoRtiCqbQFHbbi/VfFLPUrutL9mYtMCQ9Eg2HJvT1cDY7t0WOv6pvny2LQphBirw==
X-Received: by 2002:a1c:6887:: with SMTP id d129mr3770013wmc.114.1618314041846;
        Tue, 13 Apr 2021 04:40:41 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id z8sm20198827wrh.37.2021.04.13.04.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 04:40:40 -0700 (PDT)
Date:   Tue, 13 Apr 2021 13:41:20 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Clemens Gruber <clemens.gruber@pqgruber.com>,
        linux-pwm@vger.kernel.org, Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v8 4/8] dt-bindings: pwm: Support new PWM_USAGE_POWER flag
Message-ID: <YHWDYOPKGylFKQvl@orome.fritz.box>
References: <20210412132745.76609-1-clemens.gruber@pqgruber.com>
 <20210412132745.76609-4-clemens.gruber@pqgruber.com>
 <20210412162723.7hlhgqp6wlfbkeky@pengutronix.de>
 <YHR5eyLPqiwhTGrr@workstation.tuxnet>
 <20210413113805.mjft5jxt3qhsxg6e@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1vkEgIoTkhyBIpER"
Content-Disposition: inline
In-Reply-To: <20210413113805.mjft5jxt3qhsxg6e@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--1vkEgIoTkhyBIpER
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 13, 2021 at 01:38:05PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Mon, Apr 12, 2021 at 06:46:51PM +0200, Clemens Gruber wrote:
> > On Mon, Apr 12, 2021 at 06:27:23PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > On Mon, Apr 12, 2021 at 03:27:41PM +0200, Clemens Gruber wrote:
> > > > Add the flag and corresponding documentation for PWM_USAGE_POWER.
> > >=20
> > > My concern here in the previous round was that PWM_USAGE_POWER isn't a
> > > name that intuitively suggests its semantic. Do you disagree?
> >=20
> > No. It is more abstract and requires documentation. But I also didn't
> > want to waste too much time on discussing names, so I used Thierry's
> > suggestion.
>=20
> If you introduce API thinking about the name before actually introducing
> it is a good idea in general. (OK, the name doesn't become part of the
> (binary) dt API, but we don't even agree about its semantic here.)
>=20
> And IMHO a bad name with a good documentation isn't good enough.
> Otherwise we can better just agree on using plain numbers in the .dts
> files.

Plain numbers or not doesn't change anything. The meaning of the bit has
to be defined. This has nothing to do with the symbolic name at all.

Thierry

--1vkEgIoTkhyBIpER
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmB1g2AACgkQ3SOs138+
s6GFIhAAsJVQtvNUbdNjFIrlooVmgFsgZDdz6nvRDINjq5wAXhr9VC25lzKFUu2y
M3obnsBkTZ54FR4GGbtMFmQnrQcDj+E8xpxqNMaupLBmTwWpgZgsSCqxag1quVFL
NNZvyIrnYKDaRRfxvWVVPI8GXWlzceEuCpStmggjjp8qv2isqlvPGq+VxW9AURLR
zuGWp7a7DIgO5i5bbhJ7gPAI48V0QIqN0c1Oq4jkPsQm0x5L8+qoTlD/4o1smhxE
HKBqgKyLtcnT2FJKvcbVsVhCQK+ZtWBYiTM/NIQ2Ym/70jD9Ktz6a3w5EDMu5Rfl
S0iUTFQ0tAZUGlDs3aLl0EH95/bdvlu5eEp8r7HzTh/vrvcv+fSI5Fj1Isek37+c
NEDuJb0LP7CChm7KiN6WCtpxeBQSJ9t7MUk0/1EEqR++PD/iFQ04X6I66gxBBJLf
Su6ho/Pet3SgjkridToUUDmxZqTrfZ4fzxG1Jf4yIAO9ePfwPxTnLSrayZDVFl6M
IymcjlBuel15E5rXIhUIBKQjNamZQUG11LEviQtvmF3YWddsaOQcFyoc27lM508h
nLjyFhxSGa+AXSM3GB/eR8ZRHt8XfQ76JFdSK4MKT+VwJKZnWClH03IRo+XnqsKM
xWmvvP3aT9+/sInV4Fl5FyKCcdmEw0oSCSWGbSQx2+AbFWbAk7M=
=GeVW
-----END PGP SIGNATURE-----

--1vkEgIoTkhyBIpER--
