Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E5163EA24
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Dec 2022 08:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiLAHJ6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 1 Dec 2022 02:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiLAHJ5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 1 Dec 2022 02:09:57 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8998A45A2A
        for <linux-pwm@vger.kernel.org>; Wed, 30 Nov 2022 23:09:56 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p0dhd-0003np-8T; Thu, 01 Dec 2022 08:09:49 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p0dha-001VIm-T0; Thu, 01 Dec 2022 08:09:47 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p0dhb-001gym-0c; Thu, 01 Dec 2022 08:09:47 +0100
Date:   Thu, 1 Dec 2022 08:09:38 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 02/11] pwm/tracing: Also record trace events for
 failed API calls
Message-ID: <20221201070938.nk2ifi52dwtuenq7@pengutronix.de>
References: <20221130152148.2769768-1-u.kleine-koenig@pengutronix.de>
 <20221130152148.2769768-3-u.kleine-koenig@pengutronix.de>
 <20221130151511.7f0d4fa3@gandalf.local.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5hvcugvraf4vk4xu"
Content-Disposition: inline
In-Reply-To: <20221130151511.7f0d4fa3@gandalf.local.home>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--5hvcugvraf4vk4xu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Steven,

On Wed, Nov 30, 2022 at 03:15:11PM -0500, Steven Rostedt wrote:
> On Wed, 30 Nov 2022 16:21:39 +0100
> Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> wrote:
>=20
> > diff --git a/include/trace/events/pwm.h b/include/trace/events/pwm.h
> > index cf243de41cc8..12b35e4ff917 100644
> > --- a/include/trace/events/pwm.h
> > +++ b/include/trace/events/pwm.h
> > @@ -10,9 +10,9 @@
> > =20
> >  DECLARE_EVENT_CLASS(pwm,
> > =20
> > -	TP_PROTO(struct pwm_device *pwm, const struct pwm_state *state),
> > +	TP_PROTO(struct pwm_device *pwm, const struct pwm_state *state, int e=
rr),
> > =20
> > -	TP_ARGS(pwm, state),
> > +	TP_ARGS(pwm, state, err),
> > =20
> >  	TP_STRUCT__entry(
> >  		__field(struct pwm_device *, pwm)
> > @@ -20,6 +20,7 @@ DECLARE_EVENT_CLASS(pwm,
> >  		__field(u64, duty_cycle)
> >  		__field(enum pwm_polarity, polarity)
> >  		__field(bool, enabled)
> > +		__field(int, err)
> >  	),
>=20
> If you are changing this, perhaps order it a bit like:
>=20
>         TP_STRUCT__entry(
>                 __field(u64, period)
>                 __field(u64, duty_cycle)
>                 __field(struct pwm_device *, pwm)
>                 __field(enum pwm_polarity, polarity)
>                 __field(bool, enabled)
>                 __field(int, err)
>         ),
>=20
> And that way the struct pwm_device pointer will not cause a 4 byte hole on
> 32bit architectures.

I'd do that in a separate patch, thanks for the feedback.

> >  	TP_fast_assign(
> > @@ -28,28 +29,27 @@ DECLARE_EVENT_CLASS(pwm,
> >  		__entry->duty_cycle =3D state->duty_cycle;
> >  		__entry->polarity =3D state->polarity;
> >  		__entry->enabled =3D state->enabled;
> > +		__entry->err =3D err;
> >  	),
> > =20
> > -	TP_printk("%p: period=3D%llu duty_cycle=3D%llu polarity=3D%d enabled=
=3D%d",
> > +	TP_printk("%p: period=3D%llu duty_cycle=3D%llu polarity=3D%d enabled=
=3D%d err=3D%d",
> >  		  __entry->pwm, __entry->period, __entry->duty_cycle,
> > -		  __entry->polarity, __entry->enabled)
> > +		  __entry->polarity, __entry->enabled, __entry->err)
>=20
> Hmm, and why not show the values here:
>=20
> TRACE_DEFINE_ENUM(PWM_POLARITY_NORMAL);
> TRACE_DEFINE_ENUM(PWM_POLARITY_INVERSED);
>=20
> 	TP_printk("%p: period=3D%llu duty_cycle=3D%llu polarity=3D%s enabled=3D%=
d err=3D%d",
>  		  __entry->pwm, __entry->period, __entry->duty_cycle,
> 		  __print_symbolic(__entry->polarity,
> 			{PWM_POLARITY_NORMAL, "normal"},
> 			{PWM_POLARITY_INVERSED, "inversed"}),
> 			__entry->enabled, __entry->err)

Ditto.

@Thierry: While the suggestions by Steven are cleanups that usually come
first in a series and only then new stuff is added, I suggest to be not
religious about that and implement these in patches based on this
series.

Independent of that, I'll wait some time to give others a change for
feedback.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--5hvcugvraf4vk4xu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOIUyYACgkQwfwUeK3K
7AnAxAf+JpaxZFRXjH2HhlBtXTk+VpVrGLusHs9xIQ/cE10v7oVBlzdS3I/vqaLI
KOBwyvax+o/f5XI6nwGFDFFqLmlRrDbpeJ5/8lawi03I6UngYHW1AWaiOALun6DU
OW1xgAJLIT4yI1a89RWSaY6CVCzOWiCuSRF/g5oS2Yk+oTlzqMeYp+wddZ9oenXA
XvBNM15ipn4tKUQaHTolaaWM2CHqWb5R5YzAaCQnX4ecO9pEMXT76Uez9MyNFxFW
wn7V0eG7hJLxrBXHAYcv5Tq0Mwwf4ABJ2kNxpNCxV1EibU5GOUaFSNj/fwCMlayn
PkpySfBAAhTxCB+d+tkCvosx30vgGg==
=jZeJ
-----END PGP SIGNATURE-----

--5hvcugvraf4vk4xu--
