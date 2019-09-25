Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B14D0BD959
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Sep 2019 09:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442615AbfIYHvm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 25 Sep 2019 03:51:42 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34866 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437273AbfIYHvl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 25 Sep 2019 03:51:41 -0400
Received: by mail-wr1-f66.google.com with SMTP id v8so5323948wrt.2;
        Wed, 25 Sep 2019 00:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KK67yuIkFsaQkINB9Eu+BWBSTsnh/Qbi0YgbzgTn/rM=;
        b=c9LsvzkC2UahQM7UsxwHEYILC+sW+LJN8PKvTE5AcffKIdC9teJ6yeqDt3GLKHE0Kk
         i6g+ixT+t5Fl9YYIghKagH0I+5cmWOoBj4ey2NqFGqyqRQ2eYNDA6iPFw8tBs6LojIsc
         gsEttSgoKUyl3ayfybejZlf+X6Urk6ZXpHC0NEFodz61tM4MNHxr25pKQUMunNlPIIPo
         W+CVt67+/WrZbj/DkAzIT3lFJT1qvqKfXRqLW7vkfGLxl8QKsJJ3ZZg1Z5OnWEvI02r+
         pY9tYrVAk5xhUS6mHsC8X8l0y4jLR9jmWrwJT/89ak2X7wAf7dj4S/AkTavUx1WFTx4z
         BCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KK67yuIkFsaQkINB9Eu+BWBSTsnh/Qbi0YgbzgTn/rM=;
        b=W44u7eZXIeyA//4QdN8EsL0bUuNDr1JGiqHD8yvbdHjRJjWIX7C7ycqNZ5TgwJo9gF
         add5zcjJHyXlteiJX8touuaE6TyW9tqJL4iK54KKDczMOpEqGq6aGYcbNXLVqyWncJST
         EbMluwuplGwjpMgUPS4ILPPEptDMxA5qfCuNR7leJggFv5jqD0xZZSGhS7oEXx/c6Eba
         MqbxzReg4GCePqAIci+iW/76evA6IxYT7GJ8R/7+7Z9MNa2SfdFSMDyIV+ayNR4YeCd1
         UH2rhH4PLXbLCU+ENOipY7QuaHDO2cgBw5WlDZ9m6qLm517hq9AYWZWNWNs4OG8hTeKS
         fP0g==
X-Gm-Message-State: APjAAAXVanR8BhsF4U0gh/lCT3HWKcz0lrEk5qBv4m7Bh4GslOjNWOBd
        Jh1X7Nt/DSopf6ys4WXcR+c=
X-Google-Smtp-Source: APXvYqwrOufVxF7BKJQix5uJfUddnzmRjLWMMYR6+d0GX5jXoiNnqDqhkvogXpYBFn1Befjg5UfCbg==
X-Received: by 2002:a5d:4307:: with SMTP id h7mr7547801wrq.393.1569397897860;
        Wed, 25 Sep 2019 00:51:37 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id t14sm2798946wrs.6.2019.09.25.00.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 00:51:36 -0700 (PDT)
Date:   Wed, 25 Sep 2019 09:51:35 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Sam Shih <sam.shih@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v9 03/11] pwm: mediatek: remove a property "has-clks"
Message-ID: <20190925075135.GA29006@ulmo>
References: <1568933351-8584-1-git-send-email-sam.shih@mediatek.com>
 <1568933351-8584-4-git-send-email-sam.shih@mediatek.com>
 <20190925063003.aht4platmfalcqru@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <20190925063003.aht4platmfalcqru@pengutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2019 at 08:30:03AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Fri, Sep 20, 2019 at 06:49:03AM +0800, Sam Shih wrote:
> > We can use fixed-clock to repair mt7628 pwm during configure from
> > userspace. The SoC is legacy MIPS and has no complex clock tree.
> > Due to we can get clock frequency for period calculation from DT
> > fixed-clock, so we can remove has-clock property, and directly
> > use devm_clk_get and clk_get_rate.
> >=20
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> > Acked-by: Uwe Kleine-K=C3=B6 <u.kleine-koenig@pengutronix.de>
> > ---
> > Changes since v9:
> > Added an Acked-by tag
>=20
> Argh, my name was croped and ended up in this state in
> 5c50982af47ffe36df3e31bc9e11be5a067ddd18. Thierry, any chance to repair
> that? Something
> like
>=20
> 	git filter-branch --msg-filter 'sed "s/Kleine-K=C3=B6 /Kleine-K=C3=B6nig=
 /"' linus/master..

Done, though I ended up doing it manually. I don't trust my git
filter-branch skills. =3D)

Thierry

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2LHIMACgkQ3SOs138+
s6FVWQ//ZCxxPqTJAJi0DQFkIwCq4Zezubiab3AKelA5for80UXfZRc4Mt04Nw6A
Kz9cafImwG+n6i2Lr1bkHmsiPjnweUMMqWHQz42B1veoQXas3iGrDgWjqjq0mCx0
/oELIxnCXP2gnkjkXzSzhtUz3lUWjxsZpVyMw5Lrrwp2zgp+FVGc4qFsCzSpZ1C2
Ns2kDIt6eqgEQnP8HC0JtX7f1BfAqY1iqh5jX/8Ex6yhkskmdhjLriPaFvMzwOE+
wnky4KAn0ehpwpMlTM+X+67QYinD2HF5ACm+KxiKNxDh8YnLzKc3mWlavYUUcgOV
KxZGtJCtcPg2FTz2BsJHIokllFDVYmcSApnkhFxHH7MeANNixbAo9rTe3ZY+eZ/S
bSemBr86T3ypkFKPddRyiVuw2NehYilTML9IjuTha8DzU0YatCm+ZoNrKXUCw21C
ybE2luElYxK8VI6R6M5T7u3eEy98T5gbw49Dtr324cIuF2blJjtqCTnuaNNSvare
TJ4fzjYPfIh0//q4lRWed6QLQkHXpciu+IgSuNtNhbLCPvqI6yju3uIOb/PwGLrH
AJvQgRpRX9ikbZPSD6vCnYad/JZhnGgOJWiKoviSnWbnWWWIvhk5JYMYh/stfTbi
Zk1m7BTKK6vyuyo3Hz9CxnIBpvht0e2ua62KjYCrAUKZaEVuOrI=
=o/DM
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
