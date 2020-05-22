Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E5D1DE534
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2020 13:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgEVLRO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 22 May 2020 07:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728371AbgEVLRE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 22 May 2020 07:17:04 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68B2C061A0E;
        Fri, 22 May 2020 04:17:02 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id e2so12508560eje.13;
        Fri, 22 May 2020 04:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8mDupXnMdjL2i3nNZADOY8IyLaz3yGEmor/u0CUEwWY=;
        b=JbEymPjK5O3AVTzEVaqX/PIDSlIN46uOZW4vWKVQ79CxsRZ9W35q2r37H6h1okT7jA
         WS/EpLBB4B8ZbkU5GhPN1t9TAkKIWkGzSipyID8ksk5ErjNM2CcODBBiDibBYQ5FPk6W
         kv2WJ9Yv+7v11VrbVJRC5POWE9duDOs2DX/uYVnUpckeO204vBZSg6r5iQAG5qcllAVa
         VJSRkGIhh84VYj+0PNTY9IeTkCJ3t4LcA8RNDJ4ZPBURRyUN8LmJ0Pf6zEACMMQnf21Y
         m4N7ViQoxV4EGDnGz+3tNcivEarlUekRoq1iG7IJo5Js2Ol/B9fwQFMR/ddOtgSMyjfA
         bcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8mDupXnMdjL2i3nNZADOY8IyLaz3yGEmor/u0CUEwWY=;
        b=lolHn0aibGHCZgaAGxOvQNzUQO/LIEpqRvAcyrOU9oNgsL3wmk93KhcVj4/aX4v1qN
         E/ZQrdqDn3iVoWOoXTAahRBqfMJSFPgFjqIPAaXulZZv5GcG//63Iol2H0qbziLtFCGk
         Vv28/pSgHFebDVjMvMNOw+kVYiPs5zkeQFMSkWu5rQ7fzxRAFULjG8Qk5IlFdT+DpZPa
         Uxttk0sHFp+wnjscD2KNvbQ2nLigZokaNdcblqpg8XM2K5T53yAV3PcnjFgDM4ihhaa1
         LQNNy6DDvKJ99pMEyz5F9We6QwtyWBmG33E9FbfPYLqZeiFRhEZcdvwFSleZ15wjFCeX
         HrTQ==
X-Gm-Message-State: AOAM532tsb4mr7cMEeJD+AG+fWOe2vaRuWNgJSH+O+q7CM+7Y37kNK+U
        s3I+SlewwCEEYIrULOYsrkgIQUA8
X-Google-Smtp-Source: ABdhPJw8xdDqRHsPx8q4UtFi22HTNMKWc0t2E7LzLrC8zUuup8wdbruT6OoPFcnZYZQmkbSmzYxxgA==
X-Received: by 2002:a17:906:3943:: with SMTP id g3mr7523858eje.454.1590146221236;
        Fri, 22 May 2020 04:17:01 -0700 (PDT)
Received: from localhost (pd9e51079.dip0.t-ipconnect.de. [217.229.16.121])
        by smtp.gmail.com with ESMTPSA id v6sm7822719ejv.120.2020.05.22.04.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 04:16:58 -0700 (PDT)
Date:   Fri, 22 May 2020 13:16:57 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Guenter Roeck <linux@roeck-us.net>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v13 00/11] Convert PWM period and duty cycle to u64
Message-ID: <20200522111657.GA2163848@ulmo>
References: <cover.1587523702.git.gurus@codeaurora.org>
 <20200423114857.GG3612@dell>
 <20200423215306.GA8670@codeaurora.org>
 <20200424064303.GJ3612@dell>
 <20200424221422.GA31118@codeaurora.org>
 <20200427064434.GA3559@dell>
 <20200520231508.GA29437@codeaurora.org>
 <20200521071505.GL271301@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <20200521071505.GL271301@dell>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2020 at 08:15:05AM +0100, Lee Jones wrote:
> On Wed, 20 May 2020, Guru Das Srinagesh wrote:
>=20
> > On Mon, Apr 27, 2020 at 07:44:34AM +0100, Lee Jones wrote:
> > > On Fri, 24 Apr 2020, Guru Das Srinagesh wrote:
> > >=20
> > > > On Fri, Apr 24, 2020 at 07:43:03AM +0100, Lee Jones wrote:
> > > > > A great deal of mailing lists contain numerous protections against
> > > > > things like flooding and spamming.  One of those protections is a
> > > > > check for "Too many recipients to the message".  Most of the time=
 this
> > > > > simply requires moderator intervention by way of review and appro=
val,
> > > > > but this ultimately depends on the ML's configuration.
> > > > >=20
> > > > > The first thing to ascertain is why your recipients list is so la=
rge.
> > > > > Have you added every reviewer, subsystem-maintainer, maintainer a=
nd
> > > > > contributor suggested by get-maintainer.pl?  If so, consider prun=
ing
> > > > > that a little.  Contributors do not tend to care about subsequent
> > > > > changes to a file.  As someone who receives a lot of patches, I t=
end
> > > > > to get fed-up when receiving patches simply because I made a chan=
ge X
> > > > > years ago.  Stick to listed maintainers/reviewers in the first
> > > > > instance and see how far that takes you.
> > > >=20
> > > > Thank you for the detailed reply. I did this in the first few patch=
sets
> > > > and then when a few patches didn't get any attention, expanded the
> > > > audience thus. Still, around 50% of the patches in this series rema=
in
> > > > unreviewed by anyone.
> > >=20
> > > This isn't a reason to add more recipients (who are likely to care
> > > even less than your original group).  However it *is* a good argument
> > > for including all of the specified maintainers/reviewers in on all of
> > > the patches.
> > >=20
> > > > > If your recipients list is as succinct as reasonably possible, ma=
ybe
> > > > > just accept that every version isn't going to be archived by every
> > > > > ML.  It's still much more useful for the correct people to have
> > > > > visibility into the set than for it to be archived multiple times.
> > > >=20
> > > > Thank you, will prune the list and remove past contributors from the
> > > > Cc-list and add all parties to all patches.
> > >=20
> > > Great.  Once you've done that, we can start to help you acquire the
> > > Acks you need on your remaining patches.
> >=20
> > Hi Lee, Thierry, Uwe,
> >=20
> > In v14 of this patchset I've pruned the list of contributors, removed
> > past contributors from the cc-list, and added all parties to all patches
> > (except for the patches that are yet to reviewed, for which I've added
> > what get_maintainer.pl showed me). I've also resent v14 a couple of
> > times already, with around a week's time interval between resends, and
> > somehow it seems like this set has lost traction.
> >=20
> > Could you please indicate what next steps I should take to have more
> > eyes on the unreviewed patches? Only 4 out of 11 patches remain
> > unreviewed.
>=20
> Looks like we're waiting on Thierry (again).
>=20
> This has been a common theme over the past few months.
>=20
> Perhaps he has changed employer/project?

My work on PWM is purely done in my spare time. I don't get paid for any
of it. I currently have two kids that need home-schooling, as many
others probably do, and I have a full time job doing non-PWM related
things. As a result my spare time is close to nil these days.

I very much appreciate all the effort that others have spent in getting
this reviewed. I haven't been able to keep a very close eye on this, but
even the latest versions have some comments, so I didn't consider this
ready yet. If that's changed and everybody's okay with the changes, then
I can apply this to for-next. We haven't got all that much time left
before the merge window and I had hoped this would be ready earlier so
that we'd have more time for this in linux-next. But I'd be willing to
at least give it a try. If it starts to look like there are going to be
issues with this I can always back them out and we can have another go
next release.

Thierry

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7HtKYACgkQ3SOs138+
s6H5ZBAAoAqPDYAGotFEMnwiD82oNJe0dIuG+OV4t35cMTn1xEo2mpKWDYfKV0Hv
6aDWw/ZacV/jAG+4jjyPgLVyFiMZTvS57rpfwaVGPMzfjiEB1Y+3+J+QSCRlpOvL
jFd8a7rBGk3DdpYOzxM2HsQSmkcYJe/AAoG+XIHzuEBTafAl+DkLonWdBrDyMYD2
JDl07OJz7cVPptsOw2OosYDWLaQ7iHffxvzTvpPZ9hp8FDR6ryB9xCdbPYgjzuD+
bqUpCuqvPQmgTOSIxYZwS4km0ezXbSPP0Z27Df5f3GgXx+S1bn4rNrKG/lkgWwib
Ph8xbFRR1okONXRvoWTltWWDsgfAO9/aTV4rTjTEeg8C8siYTGspLkK/Elvgiftn
GYpSBtNA0ayIXGjYym8Jx67wNOp0J2tKFCtxNh31Viy5wGLExocaYgAcL3+Y6iAT
7cy5hKG2L83J79pXh05Ld2ge4qeqgGLKTYbBsS71IoLTKWTo08Cn/vdiAlbp3yQO
ucSeTCqJ4/vvZA4JE7TOJG1Y+XeZ41FMDCPgiVokW+KIrtpn+m+Tc7YYSdOO49eZ
/xUBwhn1RX+Lqg0eQN8WhgWAGpIvHSSHxPiGv3EwXfCzBNvnXSdMVf8eDCSU1kkg
x2DxGuTh90Kly/FX8hCgLRARx0GH/sAFCzSBJ2ntZnjVEshKC5A=
=b2vB
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
