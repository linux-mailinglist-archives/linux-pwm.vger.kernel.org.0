Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4231DE5CF
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2020 13:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbgEVLqk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 22 May 2020 07:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbgEVLqk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 22 May 2020 07:46:40 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EB4C061A0E
        for <linux-pwm@vger.kernel.org>; Fri, 22 May 2020 04:46:39 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id d7so12666515eja.7
        for <linux-pwm@vger.kernel.org>; Fri, 22 May 2020 04:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=saLxsP2aKws1OmnCRB3ts3ZvRgHFGIqXpowWJLZo9RE=;
        b=ulsimzNF0VmAW2KR75zA7JdDGc8dHXZe0z+os4LAqyGMwjQzfm0zE7w27FJQMY0mN7
         LwN/MOshAQ/Oo8JTIv6qHJJNPtphNgAQkFbewVtyzKDL8x7wYFwPH+/0NF1cQYUQy3v2
         CPhjdwxWv3ZS36A5Wwlp6eg1+VxcUm4dN3ddCBN4H4VKCu2C2WencD3oUc1XZMNBqvUT
         zKSXYmvCkeS61nNPzMjXmvYnFdDxd3Xfj6LcWq6A/A1euB6BEzJbbcihBUkjPFJgHnCA
         TM9R26eeTwpD0byCxmh3OCmr7BVuC9SqoPMhQ/OyT0oLn4AaVEQ2lpxOClo27JBxQwc2
         /ZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=saLxsP2aKws1OmnCRB3ts3ZvRgHFGIqXpowWJLZo9RE=;
        b=CO4JQy3hbu5YiWATmAjPJEkXkiY2RR6jNlT7Vv8uK3kLSC6T96FO8sP99PCMHjbLU4
         9+hTcxLdQVqxrllEZZHpiDsPjKCmzlZZ9MB+CbiAoLSd3vhw/qROXRv+7VE79VhCzZSR
         ekFYXYvO2rYqb6TA/4KxASt/9FoukXs51oPs8I1iB9wpN+B3h4HjYT8+q2vckJ8iLHBN
         zz21Amf4WIg4TD9ux9SMAAbxJRqZ5WsiwZr118H5bWDp/MzSEb+guFIOQfNo3LD3WDlb
         OwNxgLaHxCgDfzyfjQMQEx/PNaPxwHrr/Ugl3sT80hqS5sqrx7nWVBfL0ZKQ8sMnUtYF
         RrQg==
X-Gm-Message-State: AOAM532H2deYpcP08/X/9HwiWLlTWdtw874wtlU4pg9Z3a+s6gOZ8N7Z
        zeu8xTWGK0twC3voJBqRiRU=
X-Google-Smtp-Source: ABdhPJwwHBpkVJFq37EdFJ1eNsWQt/LVVfM8Nkzjod9Qnc+4EaD/7cLxNjyDqKq7LbvVg0PBO/J4bw==
X-Received: by 2002:a17:906:fa84:: with SMTP id lt4mr8176643ejb.318.1590147998260;
        Fri, 22 May 2020 04:46:38 -0700 (PDT)
Received: from localhost (pd9e51079.dip0.t-ipconnect.de. [217.229.16.121])
        by smtp.gmail.com with ESMTPSA id ay6sm6886420edb.29.2020.05.22.04.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 04:46:36 -0700 (PDT)
Date:   Fri, 22 May 2020 13:46:35 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: Missing feedback
Message-ID: <20200522114635.GB2163848@ulmo>
References: <20200522101355.x4td3ehkfhp636ft@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Content-Disposition: inline
In-Reply-To: <20200522101355.x4td3ehkfhp636ft@pengutronix.de>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2020 at 12:13:55PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> there is again quite a backlog of missing pwm feedback and missing care
> for patchwork.
>=20
> Patchwork has several iterations of a few patch series where the old
> series should be marked as superseeded. If you want you can give me
> write access there, then I can go through the list and mark patches
> accordingly. (I'm user "ukleinek" on patchwork.ozlabs.org.)
>=20
> Patches/mails where I'd like to see feedback (or just application) from
> you include:
>=20
>  - "Convert PWM period and duty cycle to u64" series (v14, feedback)
>  - pwm: sun4i: direct clock output support for Allwinner A64 (v2,=20
>    application)
>  - pwm: imx27: Fix rounding behavior
>  - docs: pwm: rework documentation for the framework
>  - adding linux-pwm archives to lore.kernel.org?
>=20
> but I feel the backlog on the list is much bigger.
>=20
> In the past I did less review on the list myself, partly because I
> consider it frustrating to invest time and then still have patches lying
> around without application/feedback.

To be honest, I've been feeling this way for a number of years now. PWM
isn't exactly very "hot" and it's difficult to get much of a reaction
=66rom anyone. You do get a reaction when you apply patches that nobody's
been willing to review or test and then they end up breaking things and
people only notice when they're updating their product kernels to a new
version and by that time it's becoming really difficult to fix things.

On top of that I've been having trouble finding any time to spend on PWM
maintenance because in addition to a fulltime job (which doesn't include
PWM work) now I have two kids that need to be homeschooled. This may or
may not get better in the weeks or months ahead. Now, don't get me wrong
because I know there are plenty of other people that are struggling with
the situation, so I know this is difficult for everyone. Just saying how
things are for me and why I can barely find any time to spend on PWM.

The lack of participation isn't very uncommon for subsystems such as PWM
and I've seen other subsystem maintainers voice the same frustrations
over the years. I'm not sure what a good solution to this is. Some have
tried a group maintainership model with some success, at other times it
might just be time for someone else to take over.

To be honest, I have occasionally considered just abandonning PWM and
let somebody else take over. Until recently this wasn't really an option
because there was nobody else showing any interest and doing an okay job
of it seemed like a better idea than orphaning and letting someone else
with already too much work handle the patches. It's not like the review
situation would improve that way either.

> I think getting patchwork more up to date would already help
> considerably, but in the long run I can also imagine taking care for
> patch application and sending pull requests if this helps.

I very much appreciate your help on reviewing patches. At the same time,
even while you certainly have shown an interest in the PWM subsystem for
a while, if you're already frustrated by the lack of progress, even
though that may be partially my own fault, I'm not convinced the
subsystem is going to be in much better hands if I were to leave it all
to you. It sometimes may seem like a trivial job, but it's also very
frustrating because people really only tend to get mad at you for any
number of reasons. People take it for granted that you will be there to
support them and offer little to no support in return. They will also
sometimes completely overwhelm you with patches and won't even let you
review patches before they send out new versions.

What they don't realize is that that actually doesn't improve the
situation because it keeps adding to your maintainer work queue. You
mention patchwork, and while it's a great tool, having to go through it
and mark all of those patch series that you haven't even looked at as
"superseeded" is tedious work and takes away precious time that you
can't use to actually do review.

Anyway, I don't want to discourage you or anything, just want to give
you a fair warning about the differences of being a contributor/reviewer
and a maintainer. If you're really serious about being more active, do
you have any concrete suggestions on what would help? Should we maybe
start by giving you access to patchwork so that you can mark patches and
keep it in a better state?

Another option might be for us to share patch application, though that's
honestly the least time-consuming part. Once patches are reviewed and
ready, it's easy for me to apply and push out a new tree, so it's not
like sharing the workload would be much help.

Like I said, I'm open to let you take on a more central role eventually,
but I'm going to need a bit more time to convince myself that you will
be doing a better job than I.

Thierry

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7Hu5kACgkQ3SOs138+
s6EIPBAAu7RIX58wv716J+SwOa4s0AeeX0zz7bMethcNJSQMkT4wVZ9WV5Yivg9o
Tb2iXL7Wwcuxp02k+cU/pO/Dm2ejmw5r6dgL1sdZSCjiTDDPQ8f12W2dzADFZhYP
n4NZB2miwIE4Uu7vMDnNc9BSqY/W1vjgom+T1ZVabLiVJXjHWiojQ5Xg49m2S1ch
2XQWpos9Z6orqMBCSlwQfrCB2zxDljmDni8C3OPpnIYSCQm9vF5QB/c8P9Uu/xPi
i9h+5ZssgirtxRlAol0xin4FWXn3vfRzk8RufFdviez47jteIyHaX898ngAdUTe3
UszDSxRVJUk1StdrM9f8pOONzUY1vdtVIr19YsGaMzaf7VciWvpcdO18dsp/SZb0
t8dV7CbXDc6MAApKgYqyILZS3Vt3OWj2lvNZJKAkWMAgmbfLgHXV+V1OmY378gih
Y7h8af8A2jnKxQyO+Eh8hU2DQaodO4A3EA5/5wwdwgYqfhSX830sfRWJf02ec5Tr
JgJ8jPGW3XHurhowQwff18Wx/2qbrC4xcIzlfnCds0VqBfZ9r90xGSDrjuu35gyw
0W+l2WXJ8MlyxPtNKcKKoj1Jsz1HmYovnwwEGcoAqaypKoo2CSBwEyPShrKO9Pp2
oraqwDK94L7AuopQmzXQTGgc9Jo3GELbNz7m8jo2FxHZbwxs+x0=
=AAzv
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
