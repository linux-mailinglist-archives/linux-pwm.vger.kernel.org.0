Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E554D3467AF
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Mar 2021 19:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbhCWSc3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 23 Mar 2021 14:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbhCWScR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 23 Mar 2021 14:32:17 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7A8C061574
        for <linux-pwm@vger.kernel.org>; Tue, 23 Mar 2021 11:32:16 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id e7so24541512edu.10
        for <linux-pwm@vger.kernel.org>; Tue, 23 Mar 2021 11:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j1nZ6T5XxW97S5YVcuCyl+JRSTL6UDiFx9izkCZz8MY=;
        b=ZFuH/j1gnBUEXYYmeDNz0FhEK9iTvGl5hSTqUBwkBcZsxXFJx84a1Xo/VSg/qNcln5
         HOjnzmqHcL/Xpryd1qDtrf4VmCZwlUwtLBPOrcgl5g5TbAR1tULVj1PogvsheoWe0hXb
         sA2y7Qi9Q4dQ0SAUnHrauSIwZivbLBT8I3rZeZctmVkgvVVMqKAho2+MEbw8U40auJAa
         W0j2eyFBiMxntfC3VeOYB6uEpognvAsaHdgChfmcHHWtbFDa0TxL/0Zr2fy7QOd6fHu0
         1zVlmi4x4nVscecLXM5x/mkPpC1ZgLqePqEgwGD+Jaj33diEr5nJde6SWAZBlK3ccRun
         FZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j1nZ6T5XxW97S5YVcuCyl+JRSTL6UDiFx9izkCZz8MY=;
        b=Qlg421/dL89w741UD2pDinM3VG2kZ0o5D4OyBlFAbPLFHBsqNIA7qYfeb57ThhT54u
         UcWtSkr5rf0kRQTxFXVeTEikfS7RbjIX6OqrjN8rp/LjtDz1WweyZe/+ShdND7LUpT7f
         Fs91OM/wJmFTJZT+BjeXQbBSjiE1nh20H6S1c2GiU0ARVqoD8Sp+bwjBAS8b6DuzfFQ9
         Epej05jBDgVZVJf3flcckGwyW1+q8a1BSGkfBNHw6usHYUUCDTsEzGWWdhmFCHW5VAHF
         3ChECILS9I6OwUOIHeIRmn8dRqH3+rupH3x/NKfymVijXDv6UzBjle2PzussvplfZj9f
         zGWQ==
X-Gm-Message-State: AOAM531jK01W3FZz3B6RMPFZFDKQgWToWWzdHnt6/7LmNPCzVjHlL4Ua
        TdkJmkLfPE3GmsJrm2IpcfCvQi+DqsI=
X-Google-Smtp-Source: ABdhPJzGvXpbjkSOmET1DgiOd1wr93jriT9sWsJnahqxKVq1EpJBIPK/5KUodLWR0EMGfYWfTaO8qA==
X-Received: by 2002:a05:6402:100c:: with SMTP id c12mr5964197edu.200.1616524335261;
        Tue, 23 Mar 2021 11:32:15 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id si3sm11820591ejb.90.2021.03.23.11.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 11:32:14 -0700 (PDT)
Date:   Tue, 23 Mar 2021 19:32:35 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        kernel@pengutronix.de, Guru Das Srinagesh <gurus@codeaurora.org>
Subject: Re: [PATCH v3] pwm: Soften potential loss of precision in compat code
Message-ID: <YFo0Q1DHZbwfFzxG@orome.fritz.box>
References: <20210315080050.2337075-1-u.kleine-koenig@pengutronix.de>
 <YFh7uCgeir4L+ZTf@orome.fritz.box>
 <20210322112947.iru2dj3yggkhecwl@pengutronix.de>
 <YFiKY7nrIDj+ZD47@orome.fritz.box>
 <20210322154659.vwlavhpacfp5rdpw@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iMtPVwtKoT/ugtSd"
Content-Disposition: inline
In-Reply-To: <20210322154659.vwlavhpacfp5rdpw@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--iMtPVwtKoT/ugtSd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 22, 2021 at 04:46:59PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Mon, Mar 22, 2021 at 01:15:31PM +0100, Thierry Reding wrote:
> > On Mon, Mar 22, 2021 at 12:29:47PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > On Mon, Mar 22, 2021 at 12:12:56PM +0100, Thierry Reding wrote:
> > > > On Mon, Mar 15, 2021 at 09:00:51AM +0100, Uwe Kleine-K=C3=B6nig wro=
te:
> > > > > The legacy callback .config() only uses int for period and duty_c=
ycle
> > > > > while the corresponding values in struct pwm_state are u64. To pr=
event
> > > > > that a value bigger than INT_MAX is discarded to a very small val=
ue,
> > > > > explicitly check for big values and pass INT_MAX instead of disca=
rding.
> > > > >=20
> > > > > Acked-by: Guru Das Srinagesh <gurus@codeaurora.org>
> > > > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix=
=2Ede>
> > > > > ---
> > > > > Changes since v2 (Message-Id: 20210312212119.1342666-1-u.kleine-k=
oenig@pengutronix.de)
> > > > >=20
> > > > >  - Fixed indention of comment (noticed by Guru Das)
> > > > >  - Add Ack for Guru Das.
> > > > >=20
> > > > >  drivers/pwm/core.c | 13 +++++++++++--
> > > > >  1 file changed, 11 insertions(+), 2 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > > > > index 4b3779d58c5a..b1adf3bb8508 100644
> > > > > --- a/drivers/pwm/core.c
> > > > > +++ b/drivers/pwm/core.c
> > > > > @@ -605,9 +605,18 @@ int pwm_apply_state(struct pwm_device *pwm, =
const struct pwm_state *state)
> > > > > =20
> > > > >  		if (state->period !=3D pwm->state.period ||
> > > > >  		    state->duty_cycle !=3D pwm->state.duty_cycle) {
> > > > > +			int duty_cycle, period;
> > > > > +
> > > > > +			/*
> > > > > +			 * The legacy callbacks use only (signed!) int for
> > > > > +			 * period and duty_cycle compared to u64 in struct
> > > > > +			 * pwm_state. So clamp the values to INT_MAX.
> > > > > +			 */
> > > > > +			period =3D min(state->period, (u64)INT_MAX);
> > > > > +			duty_cycle =3D min(state->duty_cycle, (u64)INT_MAX);
> > > >=20
> > > > Do we want to highlight this using a WARN()?
> > >=20
> > > That would be fine for me, too. In the past you were not happy with
> > > WARN I added, so I implemented this in a silent way.
> >=20
> > The WARN that I remember was in a completely different context. There
> > are occasions when it's good to be loud. I think this is one of them.
> >=20
> > > > It seems to me like doing this would always be a programming error =
and
> > > > easy to fix. Silently truncating this to just INT_MAX may not give =
the
> > > > desired effect and be actively wrong most of the time.
> > > >=20
> > > > Come to think of it: why not just refuse such requests with -EINVAL?
> > > > That's what drivers already do if they're faced with values that th=
ey
> > > > can't handle.
> > >=20
> > > No, the strategy I ask authors of new drivers to implement is to prog=
ram
> > > the biggest possible period not bigger than the requested period. So =
if
> > > a consumer requests INT_MAX+3 it must already today cope with the case
> > > that it gets a smaller period.
> >=20
> > That just seems wrong. I mean to a degree this might be sensible, but
> > the way you do this here it's completely out of hands. What if somebody
> > tries to configure this?
>=20
> The charm it has is that it is simple and doesn't cut somewhere
> arbitrary.
>=20
> > 	duty-cycle: 0x0000000100000000
> > 	period:     0x0000000200000000
> >=20
> > Clearly what they were aiming for is a 50% duty-cycle, but with your
> > proposal, this will now result in a 100% duty-cycle, which is cleary not
> > what's requested here.
>=20
> OK, can you please formally describe how a hardware driver author should
> detect these clear aims? Some document that for any given request and
> any given hardware capability tells what setting to pick would be great.
>=20
> Assume that the longest 50% setting some driver can implement is
> duty_cycle =3D 0x7fffffff ns + period =3D 0xfffffffe ns. What is the bigg=
est
> duty_cycle + period where you want 0x7fffffff + 0xfffffffe to be
> configured?
>=20
> I expect that anything that targets to be practically better than my
> approach is damned to be complicated, arbitrary and still doesn't catch
> all clear aims. Still more because "clear aims" is something that is
> subjective to each developer. And assume you really produce a recipe
> that clearly dissects between "round a little bit" and "clearly not what
> was requested", do you really want to implement that in each and every
> low level driver? I don't, this would be a maintenance mess.
>=20
> So that's why I think we need pwm_round_state with *easy* rules.
>=20
> And given that this easy (and admittedly practically imperfect) rule
> was "Use the biggest possible period not bigger than requested" and I
> still consider this a good choice, clamping instead of returning an
> error is still the right choice in my eyes.
>=20
> > That's different, in my opinion, from a case where you may have to round
> > a little bit and get a deviation of, say, 1% in the resulting signal.
>=20
> Let's assume "1% deviation is ok" is to become the golden rule. If
> the nearest possibility to satisfy the request
>=20
> 	.duty_cycle =3D 1000 ns
> 	.period =3D 2000 ns
>=20
> was
>=20
> 	.duty_cycle =3D 1010 ns
> 	.period =3D 1980 ns
>=20
> would this be within the 1% rule or wouldn't it? (The relative duty
> cycle is > 51% and so it's off by > 2%, but the individual values differ
> by just 1%.) Or should we prefer
>=20
> 	.duty_cycle =3D 1010 ns
> 	.period =3D 2030 ns
>=20
> where the period is off by more than 1% but the relative duty_cycle is
> actually nearer to the "clearly requested" 50%?

No matter where you draw the line, you're always going to be able to
find a case like that. But that's completely besides the point. I'm not
suggesting any solutions here to the problem of drivers guessing what's
right or of consumers detecting what drivers will set.

What I'm objecting to here is essentially ignoring what the user has
requested and doing something close to arbitrary instead. This might
yield a reasonable result in some cases but it can just as easily be
complete nonsense.

If the requested values are outside of the supported range we should
just reject the request and be done with it. Then there's no need to
even attempt guessing what might have been the intention. Instead we
let the user deal with the problem and provide values that are
supported.

Thierry

--iMtPVwtKoT/ugtSd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBaNEMACgkQ3SOs138+
s6FfTQ/9E+7w+hxQ44G3m5EKA12ABqt3SxlyPybtsGw6km+sBlRQBMZSIpfFX4wt
Lz7mWvVh+kyVOw5ERa+mgFPaAoCbkSVEYVLwUvg/whmAxUWc3liWo4LBjQJyOldF
3idxCkoA3GA/enP8Bnt30OTbu1lDQRHTgRnnGj7aLmV5JMNZduDUJMEpu1LTT5K4
zbvwbnw3MTiu5uV9Z6aFM488tMPVTEvsPgO+gWO+2BVpX2KSPx7XOH3WA7ZxhD99
/upZnC+0OglKfILxuLrTACKhZ/cM6bXMKrXlQp661ODYiO20b7vOcmHS0+H9/yJu
MV+SQdQsyopNQwSyWgNMnBzE/ZhRuwLzMqhxVciCJnFSOZVLlYXp/djNcRTelaTP
kIRemkRlVmtCcNWHL4be+IR6jJdJh5K7WEJ845r7qhN0b2nF07vzthgr5TLOgnPb
MwjNZM8fI5TpJVPhJWfuVCKFpw5auGShqJUyJqmszAJ9p9vtx7iZU7F1XCR3tE0u
3eCTITXHBbjvWK3wQTulyIdtdbWLG0juXKLVBwJSt6rxACKQ3sV4fsf0SEaIa68+
i7eT/nfy55unzEedT8qITQk/HyvW2n7Y57Ny0P9a812mTrtJNXeze/QCF2wWAikP
5WUr+VaNHKMg8jZTPWxy68lgr0X0xTqRDXHdyX3PQWdmIt9Ha6g=
=uMLi
-----END PGP SIGNATURE-----

--iMtPVwtKoT/ugtSd--
