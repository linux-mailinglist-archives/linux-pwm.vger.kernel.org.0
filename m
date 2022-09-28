Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACD35EDD24
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Sep 2022 14:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbiI1Mum (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 28 Sep 2022 08:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbiI1Mul (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 28 Sep 2022 08:50:41 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AF0165AD;
        Wed, 28 Sep 2022 05:50:38 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z13so17048779edb.13;
        Wed, 28 Sep 2022 05:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=aCbdLya+ld7bMamcEDTWwB9niwCrFGpu9B0QN9EkD9Y=;
        b=Zv5BcHp3fiCoDa+LSZ+xPzUoJEFCLPbI7jeryUI4F/uIM1FGNCNIq/2iTEp/WZN7wW
         Z516ZTNnIB7WZ4kV7qQyrxOiC5i7vJMKs4aOEYcWRYQmFcKURZY2cef6AqyFL46zI5IQ
         idlkJqJjlWjBS3r1hR10/v7Z5s7G9fiopyGTQnvj5XiYg4s0fuTo8OcfdZ3Eqwz0kaRs
         d6xWXbt828WEtqD5sk/5zyxvxF8mRRPwWz4QczIbDFF79Fy6iyWQo+QTAs4yqvSgrY9W
         qxSEJVgmi/+70kw9d9JBu0Da1QUZY+gH3+pIU+zmr/QByiuob5QG/5JEiZ16ciJJGnwu
         OVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=aCbdLya+ld7bMamcEDTWwB9niwCrFGpu9B0QN9EkD9Y=;
        b=sNXyZ1wtd1gzuyQl5MVQdSttfanXef6KzQfXilrc5OQQVpFKLc52i3XKrL/XqOlVGg
         ezhc2J9HYz3NXq3C/2m+5nkKGCOnj77Cll5qlEsm/8NjR9vzAIVJpIDdTH4SPPtjdB1E
         KumwdYtwuF3Mp2MdD9J3piTgq1p1Kr04EFoe2wGKZSfXBO4U1FZCqEG0qApV4OjLJjy8
         a3hO83tkZJNgvr1CIoLtnCpWbUIOWKsArUjhe+NIO6u/+MIIPk1WpEg9uR1l5JuujEhm
         S8qEbOk0u+/hupooV0xu3yYVuBuCXihrGMl/HNT2KNNvXJA3YuX4NcXsJz5ObTVYpApj
         kUig==
X-Gm-Message-State: ACrzQf1I1YtZoO9TJTQlXVXmGSf3nNPzh7QUDZe9EOUI/iSz2IJHTBYW
        23CuEMjBrs0I4OsItldhk4E=
X-Google-Smtp-Source: AMsMyM5iWWcJrZa5f2sHiUBkY0lZQMpUGmkqsvwtdHXRAJduc4O8iMtQXdKT+pwhM9pkNMdNTYhi3Q==
X-Received: by 2002:a05:6402:5190:b0:44f:2924:78f4 with SMTP id q16-20020a056402519000b0044f292478f4mr32402503edd.217.1664369437005;
        Wed, 28 Sep 2022 05:50:37 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id a3-20020a50e703000000b0044657ecfbb5sm3303222edn.13.2022.09.28.05.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 05:50:35 -0700 (PDT)
Date:   Wed, 28 Sep 2022 14:50:33 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Douglas Anderson <dianders@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-leds@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH 2/3] pwm/tracing: Also record trace events for failed
 apply calls
Message-ID: <YzRDGUxkah8Ridik@orome>
References: <20220916151506.298488-1-u.kleine-koenig@pengutronix.de>
 <20220916151506.298488-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1nXplf5oGjFx1iy9"
Content-Disposition: inline
In-Reply-To: <20220916151506.298488-2-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--1nXplf5oGjFx1iy9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 16, 2022 at 05:15:05PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Record and report an error code for the events. This allows to report
> about failed calls without ambiguity and so gives a more complete
> picture.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/core.c         | 18 ++++++++----------
>  include/trace/events/pwm.h | 20 ++++++++++----------
>  2 files changed, 18 insertions(+), 20 deletions(-)

Yeah, I like this one. Should make the traces much more useful in the
failure cases.

Thierry

--1nXplf5oGjFx1iy9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmM0QxkACgkQ3SOs138+
s6FH0A/9Hynr9rb8tCmQHfWWe5i6JIYSs5Xn70OcHYnRc98AFjPuXISUDbLUUfD1
epf/5ixVuASGD945ZOL7Ibci/7cPAJI3FECRUa520xN/EAv0f/39OYXy1xfk38oi
rCGHa2IGdSPZceAx/0CtB5dwDL6c0Z8nS6akQmrtSY6XQowy14C0t9sjcnRWyNGF
qw+uwHjSjglnPfZFWJOwwhJVRzbq4BcSww33AawYStTMvaWTBGmuwtxYbavrYDMl
/TEEPlRF1K2OAvbQNtShEf0WXQG76A9+1ikZzAdmJ4n2K2oaZuPDh4bNbj2j4EuI
a39I8Fgmduo+NsZClqQqH77wNZPDxEA1Nbl5RVa8r5D7kugXpfLWup+jdOuRdl9t
bsXfkuSWKu0SjRvLstBZIM0/mpcU3lTAxwVd6k6nNro+1QqkAP9lsXURsBDK1Jaf
NDs5q6+l5WoVxhPm5axZfYYXzX0wGr+IT79XKzVR9hgvuZbxNsiGo9HAzn22Jn9F
4fER8jLXcvfqiOCGGp9Pl3WJ6Zmp0mKwUx6AbqXoYDvVpqpw9r02k7YDdcpyq+wA
nA5YM6v+GD9QCBv0VmQF8ZJku0ktlG/eNGonA/N7naYNJnf/4Qj7LGWTXrmjUOQU
Kuy192hnVn+LpEizF2DPaGqSrosYVskFC6f1cRfVWMKaR9vIcnc=
=T2Ll
-----END PGP SIGNATURE-----

--1nXplf5oGjFx1iy9--
