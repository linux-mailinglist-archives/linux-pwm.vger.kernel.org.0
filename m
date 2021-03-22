Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047E5343B72
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Mar 2021 09:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhCVIPm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Mar 2021 04:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhCVIPi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Mar 2021 04:15:38 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40941C061574;
        Mon, 22 Mar 2021 01:15:38 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo8700503wmq.4;
        Mon, 22 Mar 2021 01:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/RWd7ZwHE3xycjYNtOxM50LUqOJd9/cKFSrwh2G6S3w=;
        b=BgIumkrnLWxF9Rq5eVnQGUkfPWZ6j9omthIh3tyZi/h+q/r29VJB+1KTDKZGH5OfnB
         ETd2eGyYOVZ/FONbhKQvOta2TAwugvyGhQYSBHbZKBA/GZVRdQejS4bXjix4P8UVmN/z
         nPUwf92nZWoKAKMc98kRLeg/62FM14yVPeoExkWSYD1EVO8p4zuloLgA3bSJwbKko7I/
         6yec2r16eoZdiDhc/+KKqm3AHplnyoqIBNfTUtlO8VLR6OEjRasKk0INK4k7NiCJN8M/
         75FFRh/WUWG8cmy3/0MjqtkrgA0CxeIvPviicCmC7GFPjjXn1iog5J5mHkF3F/sgEkWF
         5+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/RWd7ZwHE3xycjYNtOxM50LUqOJd9/cKFSrwh2G6S3w=;
        b=n3J87R4td9aaZ/LFleII9kNqat15CnHk8tP61iR21CnQ4NXynBBhXe4TtJMPO2RBJH
         jpZoL5mf7FikII3Bb2IXbn43TDspCjbR9ds5uA3MIjWNW4GjVaWOWHv6tzcbU+bobwvS
         nVNHSqIQWtghEDh8vafMh5nWtGs8/xmBDB7xyEdeqxVdiMRJstPvZkRDCWYQExwgq5DM
         AFZBXgt+k2MFRt8ZDJOxkuZ6gMSrTOUt3XJDpyId23jINwIMEyloczdNms+QW8FTch0i
         52zp6iNrfUODZLOV/G1rRXVm/EwlEQavLBISRMGQyS6wkhCMZWNzrdq4t23GbBnjyXtj
         M5NA==
X-Gm-Message-State: AOAM532czts9RXWjbZCZ8nJyemc421o3mTy48BLVhsBy1WhHLIijDnJD
        f9G6Vbn6/QOjdERolsWvy9g=
X-Google-Smtp-Source: ABdhPJxLktSDJOgU3BVQm2Q+ZjHDUnhzm+/6Rks1yPyzH06FJ0wQoeyJ6hgqjrWrj1CsTJukFngihg==
X-Received: by 2002:a1c:7e82:: with SMTP id z124mr14859045wmc.51.1616400936905;
        Mon, 22 Mar 2021 01:15:36 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id u9sm15277463wmc.38.2021.03.22.01.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 01:15:35 -0700 (PDT)
Date:   Mon, 22 Mar 2021 09:15:53 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 2/7] pwm: pca9685: Support hardware readout
Message-ID: <YFhSOXCEo5XTlvd1@orome.fritz.box>
References: <20201216125320.5277-1-clemens.gruber@pqgruber.com>
 <20201216125320.5277-2-clemens.gruber@pqgruber.com>
 <CAGngYiWkKZGkQ4TTTy8bQYvnGBK45V0A0JCe_+M5V+vuVU+zkQ@mail.gmail.com>
 <X9uYqGboZg5DuEtf@workstation.tuxnet>
 <CAGngYiUYOL6EF3VTGwcwTuN4EmE26ML3ye7689FTEpowjEcU2w@mail.gmail.com>
 <X/H5CqcRHelg5M4p@workstation.tuxnet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="L//akOo9iCkrBAT3"
Content-Disposition: inline
In-Reply-To: <X/H5CqcRHelg5M4p@workstation.tuxnet>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--L//akOo9iCkrBAT3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 03, 2021 at 06:04:10PM +0100, Clemens Gruber wrote:
> Hi everyone,
>=20
> happy new year, hope you are all well!
>=20
> On Thu, Dec 17, 2020 at 12:52:42PM -0500, Sven Van Asbroeck wrote:
> > On Thu, Dec 17, 2020 at 12:43 PM Clemens Gruber
> > <clemens.gruber@pqgruber.com> wrote:
> > > >
> > > > Conclusion: .get_state() will always return "pwm disabled", so why =
do we
> > > > bother reading out the h/w?
> > >
> > > If there are no plans for the PWM core to call .get_state more often =
in
> > > the future, we could just read out the period and return 0 duty and
> > > disabled.
> >=20
> > I'm not sure why we should even read out the period?
> > When a channel is disabled, the period is not externally visible,
> > therefore it's meaningless ?
> >=20
> > As far as I can tell, we can use this for .get_state():
> > memset(&pwm->state, 0, sizeof(pwm_state));
> >=20
> > >
> > > Thierry, Uwe, what's your take on this?
>=20
> I will continue working on this series in the upcoming weeks.
> Feedback on the .get_state issue would be greatly appreciated.
>=20
> To summarize:
> Is it OK for a driver to expect the chip->ops->get_state function to be
> only called from the place in pwm core it is currently called from?
> (Namely in pwm_device_request after chip->ops->request)
>=20
> If yes, we could always return a 0 duty cycle and disabled state,
> because this is the state we left it in after .probe (and .free).
>=20
> However, if in the future, the pwm core adds additional calls to
> chip->ops->get_state in other places, this could lead to problems.

It's not safe in general to assume that this function will be called
only at one specific point. If you implement the function, then it
should do what it says (i.e. read the current hardware state), and not
bother about when it might be called, or guess at the state that the PWM
might be in.

If you can't implement hardware readout, then that's fine (there are
some devices for which no physical way exists to read out the current
hardware state), but it doesn't sound like that's the problem here.

> Another point is the period: Sven suggested we do not read out the
> period at all, as the PWM is disabled anyway (see above).
> Is this acceptable?

No, if the PWM has separate bits for "enable" and "period", then they
should be read separately. The hardware state isn't about representing
what the currently configured output is, it's a representation of what
the current settings of the PWM channel are.

> And, if we never return anything but 0 in .get_state, should it be
> implemented at all?

Yes, not implementing .get_state() at all is better than lying. If you
always return an all-zeros state, you're inevitably going to return the
wrong result at some point in time.

Thierry

--L//akOo9iCkrBAT3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBYUjYACgkQ3SOs138+
s6FQCxAAhL5sNQDsJCjXIQddAmRoO/t8EwYDI3UOY4QLAYx+8ntkGlLSNfyjt/Nf
zD6nc0lgfmVmZIIO5ljfI1hvfOrEDZrBgghTxaPuLGVVL6KW7eNTbJjsPqhrQ9yC
Lc0ugnv8Xa01lKOU3YCZ5fHvz5g862Hdt8OmK3/lK6syRmmVfGmtWjmU4v0XrJag
cUxhr0vHww4uFZBqwLLxNFt+QV0fzMZxevCM9xrKJgBtJK31sm4EKdmtjWfvAOSK
EUrBXl5c5WodcMclCRyDt+QbbIFraA+rWaJbucykblBwe13l4cDbDN+ks2x6Twpx
y5HmCZW18WT4tqJRTtcZvBsNi3balI2EQ/AEwpZw26mob3pcnoclNoduk2nBer0O
A+S6mzdWzGKt52NCT8rqTXgzrd8e8q8dgWXLMBObpTy4uvmepUjGSdYfm1ficQ75
Oc0BnAK9jxcNR6Bj7Z+J8omTmWBNc2cRn7fAfDzJwc1Zlr1C2O8CFHMMP2pK2MoK
Q+zYY7S8iyrMz4RbIDS/M4NG0RfEGQovKtiu0SpafpCAT4bykezzOevszhSWkew7
D5o1GLq53L1py22QPbAeL4kuFANjV7YLvXeaFc8PZcWtnKamFzFwJ+gIN1J0f6wj
3yx/O3LGZfCvtXQgthLRBYDYqiAovkeyWVbc1c7VKHjKwUj3Bto=
=oc5y
-----END PGP SIGNATURE-----

--L//akOo9iCkrBAT3--
