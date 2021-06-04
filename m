Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A10639B63A
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Jun 2021 11:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhFDJur (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Jun 2021 05:50:47 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:41756 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhFDJur (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Jun 2021 05:50:47 -0400
Received: by mail-ed1-f44.google.com with SMTP id g18so8411715edq.8;
        Fri, 04 Jun 2021 02:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Elbap0HGzMIcO+Zuj29OM5Suci0Pol92u8bIy/bu0tM=;
        b=XYI4pRqO7CxjXXGW2ynVvcxHxaJutB6ESSmUvgiuaPvAkJUSW58lb9Vsvl9lE2BtFg
         5mMPuymcd7yJ9duHGjL9U9Hho8sCMfeWJXldR/CiRpSPlZJhSvvP8OX1SiLgXb27WVvE
         ueGVe+gEphFiy8ZDDNSdzoIqQ+1GJiCkFiLfbSGwhEn7s5uPvDxUv/pdjffW4mLsvF5D
         W33f00lLkoXuCNzUOtRinGwxVXXC6x85O0jH1+RbjG5T37iMH4taTygasCwa8itPeFp/
         2KKCZ4RZcaU0J5wtmnt4o9I5MWD1a4PK1ET0hvYvrEzr8vgal/q56J0K9A3KDpLpx5QU
         eAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Elbap0HGzMIcO+Zuj29OM5Suci0Pol92u8bIy/bu0tM=;
        b=CtEj5kH/d0AMl4VPVMWKYTmLXYnpuwfiOGRNszqZv06+fsW7nN5eSo0a8nbFYgwrRZ
         cir0hgONtEX0nChmNAeUrHO7DA0yU9KaJ95pKnjBhhRd9AOYXH721IuYZy+3pxzmX6TQ
         ougYUFOiAPamuhmDaX1J+YCH7mlzV+Fj9C2LuHm8nbARpRFYLU9Yf+J4PUTp7qXgYqBI
         je1t5CQNs+v9UMNvHhjN5k0Y6tso5Q+cUI8N4NquaeF//UsHz3WVC9+HyC/9xjoRI2O2
         78wz7o0b7SoS7JfPEHVnDjfWiBTS+71DgxKfa44CXnPRGk1U1rgMddRPRJfZ8C1nmZLv
         XGKw==
X-Gm-Message-State: AOAM531a/GhaXP43qg2B+M9LJVBQynVOePmIuLTRBQimyTeD36JWj4HO
        Cse1JAc7jPJZVD7sjhyHC90=
X-Google-Smtp-Source: ABdhPJz2n4dgcQWLoFAJCGgc5IF8rJLCa/X7kOF7dDP30KaiVHQM6datVigWtfL44xAgqGo7LAeXmA==
X-Received: by 2002:aa7:dc12:: with SMTP id b18mr3809077edu.52.1622800080667;
        Fri, 04 Jun 2021 02:48:00 -0700 (PDT)
Received: from localhost (pd9e51d70.dip0.t-ipconnect.de. [217.229.29.112])
        by smtp.gmail.com with ESMTPSA id bh3sm2584694ejb.19.2021.06.04.02.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 02:47:59 -0700 (PDT)
Date:   Fri, 4 Jun 2021 11:49:37 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Sven Van Asbroeck <TheSven73@gmail.com>
Subject: Re: [PATCH 1/4] pwm: core: Support new usage_power setting in PWM
 state
Message-ID: <YLn3MZ+6HJM/UrRT@orome.fritz.box>
References: <20210507131845.37605-1-clemens.gruber@pqgruber.com>
 <20210507150317.bnluhqrqepde4xjm@pengutronix.de>
 <YJVhLrkeNXBp6M1p@workstation.tuxnet>
 <20210507231831.zmvyspcq7xhm25y4@pengutronix.de>
 <YLUK8GXHaBYyVe1R@workstation.tuxnet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rtonuN3GLetRQitm"
Content-Disposition: inline
In-Reply-To: <YLUK8GXHaBYyVe1R@workstation.tuxnet>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--rtonuN3GLetRQitm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 31, 2021 at 06:12:32PM +0200, Clemens Gruber wrote:
> On Sat, May 08, 2021 at 01:18:31AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > Hello Clemens,
> >=20
> > On Fri, May 07, 2021 at 05:47:58PM +0200, Clemens Gruber wrote:
> > > On Fri, May 07, 2021 at 05:03:17PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > > On Fri, May 07, 2021 at 03:18:42PM +0200, Clemens Gruber wrote:
> > > > > diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> > > > > index 5bb90af4997e..5a73251d28e3 100644
> > > > > --- a/include/linux/pwm.h
> > > > > +++ b/include/linux/pwm.h
> > > > > @@ -54,12 +54,17 @@ enum {
> > > > >   * @duty_cycle: PWM duty cycle (in nanoseconds)
> > > > >   * @polarity: PWM polarity
> > > > >   * @enabled: PWM enabled status
> > > > > + * @usage_power: If set, the PWM driver is only required to main=
tain the power
> > > > > + *               output but has more freedom regarding signal fo=
rm.
> > > > > + *               If supported, the signal can be optimized, for =
example to
> > > > > + *               improve EMI by phase shifting individual channe=
ls.
> > > > >   */
> > > > >  struct pwm_state {
> > > > >  	u64 period;
> > > > >  	u64 duty_cycle;
> > > > >  	enum pwm_polarity polarity;
> > > > >  	bool enabled;
> > > > > +	bool usage_power;
> > > > >  };
> > > > > =20
> > > > >  /**
> > > >=20
> > > > If we really want to support this usecase, I would prefer to not ha=
ve it
> > > > in pwm_state because this concept is not a property of the wave for=
m. So
> > > > for a driver it doesn't really make sense to set this flag in
> > > > .get_state().
> > >=20
> > > It is related to the wave form in so far as it allows the driver to
> > > change the wave form as long as the power output remains the same.
> >=20
> > Yes, the thing I wanted to express is: usage_power is a software thing.
> > Just from reading the hardware registers you can never know if
> > usage_power is set or not. So it is conceptually slightly different than
> > the other members of pwm_state which all are represented 1:1 in
> > hardware.
> >=20
> > > > Maybe it makes more sense to put this in a separate argument for a
> > > > variant of pwm_apply_state? something like:
> > > >=20
> > > > 	int pwm_apply_state_transition(struct pwm_device *pwm, const struc=
t pwm_state *state, const struct pwm_state_transition *transition);
> > > >=20
> > > > and pwm_state_transition can then contain something like this usage
> > > > power concept and maybe also a sync flag that requests that the call
> > > > should only return when the new setting is active and maybe also a
> > > > complete_period flag that requests that the currently running period
> > > > must be completed before the requested setting is implemented.
> > > >=20
> > > > OTOH the information "I only care about the relative duty cycle" is
> > > > relevant longer than during the transition to a new setting. (So if
> > > > there are two consumers and one specified to be only interested in =
the
> > > > relative duty cycle, the other might be allowed to change the common
> > > > period.)
> > >=20
> > > As you said, usage_power does not only apply to one state transition.
> > >=20
> > > > Having said that, I don't like the proposed names. Neither "usage_p=
ower"
> > > > nor "pwm_apply_state_transition".
> > > >=20
> > > > In a non-representative survey among two hardware engineers and one
> > > > software engineer who already contributed to PWM (!=3D me) I found =
out
> > > > that these three have an intuitive right understanding of
> > > > "allow-phase-shift" but have no idea what "usage-power" could mean.
> > >=20
> > > One advantage of usage_power is that it is not limited to phase
> > > shifting. Drivers could do other optimizations as long as the power
> > > output remains the same.
> >=20
> > Freedom you give to the lowlevel driver might be a burden to the
> > consumer. I think it makes sense to split the concept into:
> >=20
> > 	PWM_ALLOW_PHASE_SHIFT		1
> > 	PWM_SET_RELATIVE_DUTY		2
> > 	PWM_SET_POWER			(PWM_ALLOW_PHASE_SHIFT | PWM_SET_RELATIVE_DUTY)
> >=20
> > This way a consumer (e.g. a clock driver) who doesn't care about the
> > phase shift but wants a fixed period can specify that, and if a consumer
> > really only cares about the emitted power that's possible, too.
> >=20
> > And given that your driver actually only implements a phase shift I
> > suggest not to generalize more than necessary here; also because the
> > semantic of usage-power isn't well defined. So this is something where I
> > agree to Thierry: Let's not solve a problem we don't have. (Though he
> > comes to a different conclusion here.)
> >=20
> > > > On a side note: The hardware guys noted that it might make sense to
> > > > align the shifted phases. i.e. instead of shifting channel i by i *
> > > > period/16, it might be better to let the 2nd channel get active whe=
n the
> > > > first gets inactive. (i.e. try to keep the count of active channels
> > > > constant).
> > >=20
> > > I am not sure what you mean exactly, because the duty cycles of the
> > > 16 outputs are not necessarily the same and can all be active at the
> > > same time. The idea is to spread the edges out as evenly as possible.
> > > Shifting them by period/16 is the best way to smoothen the current
> > > spikes in my opinion and the implementation is also very simple.
> >=20
> > Yes, the algorithm needed to satisfy this wish is more complicated. And
> > maybe it even isn't possible to implement it in a sane way, I didn't
> > think about it much. I just believed them that if you have two channels
> > that run at 50% it's better to have a phase shift of 50% between them
> > than 6.25%. Maybe it makes sense to align the start of channel #i+1 (if
> > allowed) to the end of channel #i to already get a better behaviour on
> > average than the fixed offset depending on the channel number.
> >=20
> > > > And as already mentioned earlier I still think we should define the
> > > > concept of "usage power" better. It should be clearly defined for a
> > > > driver author which setting they should pick for a given request. T=
his
> > > > removes surprises for consumers and guessing for lowlevel driver
> > > > authors. Also a uniform policy brings conflicts better to light.
> > > > (Something like driver A does the right thing for consumer C and dr=
iver
> > > > B makes it right for D. But once D tries to use A things break. (And
> > > > then maybe A is changed to fit D, and C doesn't object because they
> > > > don't read the pwm list resulting in a breakage for C later.))
> > >=20
> > > I added documentation and comments to the header file as a first step
> > > but we can always improve them.
> >=20
> > In my book the documentation is inadequate because it doesn't define how
> > a driver should behave and so doesn't define what the consumer can
> > expect. With your description all settings I suggested in
> > https://lore.kernel.org/r/20210413175631.pwbynvwmnn7oog4m@pengutronix.de
> > are allowed. I don't think this is a good idea.
> >=20
> > And given that all people I talked to about "usage-power" were unable to
> > correctly guess its semantic, I'm convinced that we need a better name.
> > This is something you cannot outweigh with documentation -- most people
> > won't read it anyway.
>=20
> Thierry: Would be great to get your input on this.

In the interest of making forward progress, I've applied this series.
The good thing is that with the current proposal none of this leaks into
ABI, so nothing is set in stone. If ever somebody comes up with better
names we can change them.

Thierry

--rtonuN3GLetRQitm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmC59zEACgkQ3SOs138+
s6GN1g//W5JlZn/O4F4mtez/mSBQBQVhIYB9DUTL0qho4JRTUxCLzjC3DjzkD5EB
fgSPVVSBColLotKeBgnjSIsTBRr5G6OaJPfEWflzjIwUPKMbmyzJoACVDRYUIXMI
iLqbywJ4fz/gC9S3Eq+l9+XX4Aq2EgR79MNyZLs97WzJQHCiPyqOJSAJO8OBBfEs
PsR4IkAT5Mm3vKQO6K8AD3p1mURBluh3kr3p07irSTH3EGZhxK9BoEfKZYDUwbS6
SCT3eNxYUu6lzngXjLRRdtRJr+E/EpPhpiXFHieUjQPNXIIysZwQ5b1V+qTim2Ml
rKkNjsOJlzhciicR52jyrIdewGFDDQyBLjEavSLkO4zH4FpKkXOqxg8ZrbiGmwCV
rvYG2KCd3sTlvkCJgzTTrBT5ctxNRKbzIHHT3KrbvKSr+SMG/sojT2JlsUHuhHGp
NM5S+iE0YSk0pY0pGV+kSvweUeUjQsu1CT85m82num2uuhqoZRGldbE34SoUyUTm
rse18b8DRgiTylDwDDfcOTivu5Zuisr0FHYm96rMnfvN9sXKo1NJZvB/9yKmwSgH
8p3tE3H0qow7HRP+ala3BlK0VJv4YWjhGH92JFYM6O2A6QgtUrhHAinQQxkaKNo+
V5JmUQjZ0pmP9XWYSHfPCe2Gv6A0xKU7zUjcM9wmvLj5c9XIMfU=
=HzXL
-----END PGP SIGNATURE-----

--rtonuN3GLetRQitm--
