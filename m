Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498E62CEE45
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Dec 2020 13:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbgLDMmH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Dec 2020 07:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729522AbgLDMmG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Dec 2020 07:42:06 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B01C0613D1;
        Fri,  4 Dec 2020 04:41:20 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id lt17so8498606ejb.3;
        Fri, 04 Dec 2020 04:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y1M3EYdNK/8z1PK3n0VaQ6Xz9V5XW9g5IH/bOGLHeQI=;
        b=SzKD2LmYFTazsYtgG42labILo+rpcMn4QS04++gjVF1xbFc3ZDY68HVyEWa0Hc3Eoc
         r/uigFJI+q2Afkdi1Fpa8f2A2wfmpx+Pb9XAK09P1Iy/9tYxg/hC5qHTPXSBUgjH/F2Q
         OJltvdpmjhVENSr8Vw9+ayUr4IAT5/M1PYVBEQ2Vert9G/R4urLme2UtNlG5B5x9Mo0b
         30Q66vJN+7aes3QB4fC522y92cOPj06TBc0reymqWu0ANYcwHldQiEIQbLxrSrbIyg+S
         1N24Re2ZzpXXomG6XkjKr+HIz4AsZITbBl+1StJrH1wIFprwBxwjvd2uxK53htPZhDWS
         EuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y1M3EYdNK/8z1PK3n0VaQ6Xz9V5XW9g5IH/bOGLHeQI=;
        b=FUrAzKbDdoS9NeE6lPJ99sUamMN4xRPJkTErY66AXIyzNJtZUYawNIxHOieoymbCFY
         c40w58YfyUPCRQ2ChsIwR0Q1T3ayrjLVYjQkzlXX7J7TS4vQoOdHIzi+yneKbBhKMP5f
         W5GqRulNFHyga0e/QuoCELmqNh7Y4EysWK0o7Y2+1YS1xR1OyxoBOi3szRrNOvjf5r1t
         AMH0dK3C/LoITGN2kkwpLJQeTSt5qCTkJSsVjtHi/8yKvyl3Kpc9xZQo+wJjUYCmFapU
         xJn1usniOm4VtX+PayiUHyiUEMABRjzRsD9OfYO45s0eec4jgDPl/uOB53CxSS5Sy+RA
         GTvg==
X-Gm-Message-State: AOAM531gnyPjdx5miM0K46UmhYBuAKmhmGGZlIQxploTZ2s4grBm2pUR
        qGz01q7Wod8O4rya2BOm+IZGML/Qhqg=
X-Google-Smtp-Source: ABdhPJz/8lvDIRzaH+Vsrk51iTZmaili0yFAtZm6bvQRMXTth8+1kejfGkybKkF+2Wc5cYCLXKg6KQ==
X-Received: by 2002:a17:906:fa12:: with SMTP id lo18mr7068509ejb.354.1607085678991;
        Fri, 04 Dec 2020 04:41:18 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id g9sm3407800edw.67.2020.12.04.04.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 04:41:17 -0800 (PST)
Date:   Fri, 4 Dec 2020 13:41:16 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, kernel@pengutronix.de,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH RESEND for 5.10] pwm: sl28cpld: fix getting driver data
 in pwm callbacks
Message-ID: <X8oubGP9CvoOQKtF@ulmo>
References: <20201203084142.3810204-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d8r6Z/bcujLR9Wvg"
Content-Disposition: inline
In-Reply-To: <20201203084142.3810204-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.0.2 (d9268908) (2020-11-20)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--d8r6Z/bcujLR9Wvg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 03, 2020 at 09:41:42AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Currently .get_state() and .apply() use dev_get_drvdata() on the struct
> device related to the pwm chip. This only works after .probe() called
> platform_set_drvdata() which in this driver happens only after
> pwmchip_add() and so comes possibly too late.
>=20
> Instead of setting the driver data earlier use the traditional
> container_of approach as this way the driver data is conceptually and
> computational nearer.
>=20
> Fixes: 9db33d221efc ("pwm: Add support for sl28cpld PWM controller")
> Tested-by: Michael Walle <michael@walle.cc>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello Linus,
>=20
> Thierry (who usually sends PWM patches to you) didn't react to this
> patch sent to the pwm Mailinglist last week
> (https://lore.kernel.org/r/20201124212432.3117322-1-u.kleine-koenig@pengu=
tronix.de)
> yet.
>=20
> Given v5.10 isn't far away any more and I don't know when Thierry will
> take a look and act, I'm sending this directly to you. The affected
> driver was new in 5.10-rc1 and at least once the unpatched driver
> created an oops:
>=20
> 	https://lavalab.kontron.com/scheduler/job/108#L950
>=20
> Michael Walle who tested this patch is the original author of the
> driver. IMHO it would be good to have this fixed before 5.10.
>=20
> If you prefer a pull request, I can setup something (but I don't have
> access to Thierry's tree, so it will be for a repository that's new to
> you).
>=20
> Best regards
> Uwe
>=20
>  drivers/pwm/pwm-sl28cpld.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

I thought I had seen you discuss this with Lee and gotten the impression
that you were going to respin this to move the platform_set_drvdata() to
an earlier point, which I think is the more correct approach.

container_of() isn't exactly wrong, but it's really just papering over
the fact that platform_set_drvdata() is in the wrong place, so I'd
prefer a patch that does that instead.

Now, I can no longer find a link to the discussion that I recall, so it
was either on IRC (where I don't have any logs) or I'm loosing my mind.

I'll prepare a patch that moves platform_set_drvdata() for Michael to
test. If that works I'll send a PR with fixes to Linus early next week.

Thierry

--d8r6Z/bcujLR9Wvg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl/KLmkACgkQ3SOs138+
s6HvQA/+Pu0xmlT6i7j5KYxREHg/lWTsukqSYpPr+5s2Jp9g1GfiZshJsZeOlVxB
GqOc9VKtvFcqLFklH/4Rts0y2tWoT/XEDOJzKkKjMdWMIS2rA1BYYxd69LQDab03
BWI/n0pwT5FOjxRcyeT9FNVOEZysLJNq/VneRL4C6ci/6dUH1p1MJX/vVigUOqjU
FjTwNwCSm7pHAlKU+gXL6yKetgaWCSCfuX9FQKskPNhuY0HxoDRf9duNs1s5tuaC
h+qWjP8oRheQJDeevF+86WEZUOSM7u6X+0Hu3GCPfhMnoRVOsksaNC5RGLLe9w/o
Ovd8XxUT/7iABb9qKC88inoQdOg1Dqnay2dW1ggX5QVzayfFjiandupZpRxaKCA2
Q/hZ8Xhp1ppu+1gl/uJoW8wsVWtDX5wqIt8lWO60nKmX9Y/6NaocVFW8dXeBwyUv
eQCI0mWsQfvKad33N3MfOAWj9tZWsoUvXBYwTXf5FrHMat9rY+tgbt8oFAnlCMHc
emocdvnkCUHlC8obc4dd6HlZ0eR1vzqZPqSb/knAmwFTVsSxNDgGT59uSliRLazH
8NYb3JDSce2vQrd3VceD6ydr8y2aDEt3zJtnGErqO5QJVJkNvJcVj0p89Vn+82Tr
xBEZ1Dbfmb0ANwI+wGBjViDL4WoS8U6lXf4PCArrV71seqUDkyY=
=jME2
-----END PGP SIGNATURE-----

--d8r6Z/bcujLR9Wvg--
