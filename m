Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20F1E197E1B
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2020 16:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbgC3OOm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Mar 2020 10:14:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33343 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbgC3OOm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Mar 2020 10:14:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id a25so21877891wrd.0;
        Mon, 30 Mar 2020 07:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RtcLEemr+obH6OpM9c5eqIcZq8owabr5tq+2H2uVvlA=;
        b=lqmC2I1rwnrjBnMkn1e5xQmpq5gYI/BckW5kerKBCuO1K8baOJaHPsLT9rxeSMPoWL
         AttyDaFlNQbbr4wAssV+I8/yDSaBJmITDMTKXDEvMx/kOKwoFj5smf3at7kOsHV10BU2
         ZgATNKQ7Sw/ZIqBE4RCLjrDIck2TbtS6uDJ/ZMrEjwhipjm642ksDkw4Yk4KwaXWvFs+
         HWx+etS4+v8c3z9cxCw9WsdxpKAObWhS+gZo5Z/9KY+iprUa+IOjh45FO5Xp/HPIm08h
         hGKLAxSqd/sq5TDUIjC8VbUeWmCejyKKOdL1AFZ6iHom5S3Sn6Frze1h34n9C5fq2aha
         AnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RtcLEemr+obH6OpM9c5eqIcZq8owabr5tq+2H2uVvlA=;
        b=tK1lbuzWE1jjABUG3siG5oMjTrzwnDk7Yylel1+7oL1CEmJnjgbW/K2XvhyNo3DBFi
         s2zHpoEEdQ66oho/gbQ6Qo8/kKa96BG6WX5Txisxmd9zILIPoT36XWtc3G7e5Q8U0E1/
         JoeO7fE/fI0tbSfbx7UK0Km9NUA55Lo8qf8xDow86eGgcYEl9CeloCZmxGObdwrtqtx3
         0aj42GAefIikRA+FeDqmbcw2J7+1QbB8qjTeUUm08EY7sbnLnXU6WLMq5cKcwp7K5q73
         MrudVP0p0hRZ/YO1cQg5jUJpoWmlj0Sj/FvgLCLsOR7mBrRryqH6q/NSXi3NnBPVMKyd
         k1OQ==
X-Gm-Message-State: ANhLgQ0JEn/ZMtrlPVh5UlO9d6GcWQLb1dnDtRrcSj8YFYvtDPEnGQvq
        3GM2xIRDEmzZS2/1nI7C3BnsRLhp
X-Google-Smtp-Source: ADFU+vsblrGgxy9v7hs+fCi00rURiGjaC1NJU6y5ByzBhD1iKasmhmLhIloq/aLfxXlpjZ7vUZiZvg==
X-Received: by 2002:a5d:6104:: with SMTP id v4mr16189125wrt.213.1585577680531;
        Mon, 30 Mar 2020 07:14:40 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id u16sm22923895wro.23.2020.03.30.07.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 07:14:37 -0700 (PDT)
Date:   Mon, 30 Mar 2020 16:14:36 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lokesh Vutla <lokeshvutla@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v3 4/5] pwm: omap-dmtimer: Do not disable pwm before
 changing period/duty_cycle
Message-ID: <20200330141436.GG2431644@ulmo>
References: <20200312042210.17344-1-lokeshvutla@ti.com>
 <20200312042210.17344-5-lokeshvutla@ti.com>
 <20200312064042.p7himm3odxjyzroi@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NY6JkbSqL3W9mApi"
Content-Disposition: inline
In-Reply-To: <20200312064042.p7himm3odxjyzroi@pengutronix.de>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--NY6JkbSqL3W9mApi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2020 at 07:40:42AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Thu, Mar 12, 2020 at 09:52:09AM +0530, Lokesh Vutla wrote:
> > Only the Timer control register(TCLR) cannot be updated when the timer
> > is running. Registers like Counter register(TCRR), loader register(TLDR=
),
> > match register(TMAR) can be updated when the counter is running. Since
> > TCLR is not updated in pwm_omap_dmtimer_config(), do not stop the
> > timer for period/duty_cycle update.
>=20
> I'm not sure what is sensible here. Stopping the PWM for a short period
> is bad, but maybe emitting a wrong period isn't better. You can however
> optimise it if only one of period or duty_cycle changes.
>=20
> @Thierry, what is your position here? I tend to say a short stop is
> preferable.

It's not clear to me from the above description how exactly the device
behaves, but I suspect that it may latch the values in those registers
and only update the actual signal output once a period has finished. I
know of a couple of other devices that do that, so it wouldn't be
surprising.

Even if that was not the case, I think this is just the kind of thing
that we have to live with. Sometimes it just isn't possible to have all
supported devices adhere strictly to an API. So I think the best we can
do is have an API that loosely defines what's supposed to happen and
make a best effort to implement those semantics. If a device deviates
slightly from those expectations, we can always cross fingers and hope
that things still work. And it looks like they are.

So I think if Lokesh and Tony agree that this is the right thing to do
and have verified that things still work after this, that's about as
good as it's going to get.

I know this is perhaps cheating a little, or turning a blind eye, but I
don't know what the alternative would be. Do we want to tell people that
a given PWM controller can't be used if it doesn't work according to our
expectations? That's hard to argue if that controller works just fine
for all known use-cases.

Thierry

--NY6JkbSqL3W9mApi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6B/soACgkQ3SOs138+
s6F2WxAAp3bIGtRCKqt67F7d3JG708w1+creHUOXONHOapSQCaWuU1SSJgI73p2P
AHdNHXR/YURCBKVTVrLizfkqAR6rQ1EE3ovlSuu5ZkaCMx1brw92l6MoVIHxlLQ1
XchiOycQgdI4BM03ENpihJi73/HHm30/SeAJ/pTgFMr3S0pr7iNvxI+AzLfiD0c/
7Y8tNjcDtMOesdLym/jMNelCxYovlQyB1gDYGPm65xrFb4cqWHuzuro1s71OqJzX
l3J9qYjcKF7XPNHze3Q75BP/wZc0+aztBja4N6ZqoR1nvkKLPAAuDBDPI87RD5LR
j4xBM/J7QSUhlh/anUfdbPxOx9YJswvfCswcifzIEwmzb7EOwpq2Yqh3BVyp4DoS
4027Z5g3sRwdR4OiNkTYHezpwp/qz1Wxrh9LWP8wqpoounrCYqTX5QDhiHSu9cr+
jfAaQGi0EgILeQjsAv3BqjoHnVjgMSVAtNV720U40J0MxkZKSf73Ak2/Jduk1dQv
j1jTJL+WYGZtFBBojS73HOkSHRk4sFNvab5iotVYaro8JaCTYGNWLohJvhG+bw5X
AfLthkohTXarCOkcHET4YI6PcDtzhU++HiCSfRZ+TBAiE5W2ZF5rKjFYCcBQuPCo
dnAbijxeDHJ33fRP905WbK6B+GhvcgyWIDI9mJxm3FhZf+1onT0=
=T9wd
-----END PGP SIGNATURE-----

--NY6JkbSqL3W9mApi--
