Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7B662E84E
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Nov 2022 23:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240719AbiKQWVD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Nov 2022 17:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240705AbiKQWUj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Nov 2022 17:20:39 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A1585EF9
        for <linux-pwm@vger.kernel.org>; Thu, 17 Nov 2022 14:19:43 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id c129so3512937oia.0
        for <linux-pwm@vger.kernel.org>; Thu, 17 Nov 2022 14:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ozCEbYk32pQvEGG3Cmvp94QInYcS7q+B/rZlsf6+8yU=;
        b=KFx3ZQS0f6FZtTrCF+i9JmEXVZLPZMLlGbVBkdcfpaaanNSyOuwGp4eWy9u0HZyuTl
         hHjYHPONxDrYdjId0k6B5Reh/VKB1af1V0jVtMDdSeij0hdNyqEzpag+6OgIfkAfhhxG
         L2d5MR1Rq2npYHsQ8msWmu82oGMuqe77cUyOfZWL4uRKlvtSKrwYNg6kvzFC72/4BAiD
         s6i6sw51cVio3O7Rac98pF5IV/qLCbGTk1ul/kkfaT5pakoD3GuOESjzvMTBpiTYfqat
         Q5zb5zpdGwac8q9s954trqgQFckCUtw2d66dMveL7ppcBVu2DbkWQG2dqSQrESd9g7jn
         4zDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozCEbYk32pQvEGG3Cmvp94QInYcS7q+B/rZlsf6+8yU=;
        b=0VQOL4DN/k/ufMBDLw3IDtse9JmXm4cZ5i9WThJ9ecS2ppZ2m8zLofnrM7ORy+uEx8
         Nho/QE/gbWPwJvOBptO/zRgTXvZ1ac8gA2nAFcbR/PWkP30e/fx2wgLJ8PglNKXE6QS8
         WKC5KYBDJ0XPoY5jUMnKEtdiuCnNzmI8cGbXnSDqbtil5ulDMTsB1dFtSFxd0kpFHnDR
         JnMNA5XELWJgCg0aVabaVtLuEROGFRv7T3gAHB0ytN64bgM3Q/TEFRZKn2Uy2fZxpWj9
         BDZgHzQ9k2YkUXYUK02uDkOJ7VBaK/nWaOd1szLzqcRy/T4WydThQ0NHJv+ZtOM0kcUX
         lJnA==
X-Gm-Message-State: ANoB5pmy2RsmSxLQ4xrC9GfW4Aoa6+RODGQ9HAGyhzvCo4CZHAlq5DCT
        +di55pdsHbq+MqwEUbSmwIlscQ==
X-Google-Smtp-Source: AA0mqf7FF16oaGrtaK+OZWAOB7i7IcifWwKLr1FdnPqT30p0LPrh/+rIbu0IDNFPNFYeOpIiRbYvhw==
X-Received: by 2002:a05:6808:496:b0:35a:308f:9c07 with SMTP id z22-20020a056808049600b0035a308f9c07mr2196457oid.242.1668723582768;
        Thu, 17 Nov 2022 14:19:42 -0800 (PST)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id y9-20020a4ac409000000b0049e9a80c690sm809264oop.1.2022.11.17.14.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:19:41 -0800 (PST)
Date:   Thu, 17 Nov 2022 17:19:39 -0500
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        kernel@pengutronix.de
Subject: Re: [PATCH 3/3] pwm: Make capture support optional
Message-ID: <Y3aze3B6/e5uWS/H@fedora>
References: <20220523174502.987113-1-u.kleine-koenig@pengutronix.de>
 <20220523174502.987113-3-u.kleine-koenig@pengutronix.de>
 <YrMdON4uOMfDFN8h@orome>
 <20220622170945.n7eyrnuezs52itt3@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wmySmM/8czyI2o/n"
Content-Disposition: inline
In-Reply-To: <20220622170945.n7eyrnuezs52itt3@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--wmySmM/8czyI2o/n
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 22, 2022 at 07:09:45PM +0200, Uwe Kleine-K=F6nig wrote:
> Hello Thierry,
>=20
> On Wed, Jun 22, 2022 at 03:46:32PM +0200, Thierry Reding wrote:
> > On Mon, May 23, 2022 at 07:45:02PM +0200, Uwe Kleine-K=F6nig wrote:
> > > The only code making use of the capture functionality is the sysfs co=
de
> > > in the PWM framework. I suspect there are no real users and would lik=
e to
> > > deprecate it in favor of the counter framework. So introduce a kconfig
> > > symbol to remove the capture support and make the sysfs file a stub.
> > >=20
> > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > ---
> > >  drivers/pwm/Kconfig     | 12 ++++++++++++
> > >  drivers/pwm/core.c      |  3 ++-
> > >  drivers/pwm/pwm-sti.c   |  4 ++++
> > >  drivers/pwm/pwm-stm32.c |  4 ++++
> > >  drivers/pwm/sysfs.c     |  4 ++++
> > >  include/linux/pwm.h     |  5 +++++
> > >  6 files changed, 31 insertions(+), 1 deletion(-)
> >=20
> > I've applied patches 1-2 for now, but I'm not convinced about this yet.
> >=20
> > The PWM capture is something that's typically useful for applications
> > served from userspace, which is why only the sysfs implementation
> > exists. So anything that's based on another framework is likely not
> > going to have in-kernel users either. Can you specify exactly how this
> > alternative implementation would look like and how it would be an
> > improvement over the current implementation?
>=20
> The counter framework would generate a continous stream of events while
> you measure and from the timestamps of the events you can determine
> period and duty cycle. So this is even more flexible because pwm-capture
> only supports one-shot mode while with the counter stuff you can stop
> to measure whenever you want to. Having said that, I didn't actually use
> the counter framework for something like that, but that's how I think it
> works and the framework has users.
>=20
> Other than that I have no better reasoning than the commit log. It's
> some time ago something happend in pwm that concerns the capture
> functionality[1] and the 13 new drivers since then all didn't implement
> capture support. Also the capture stuff was done by an ST employee for
> an ST driver, so that might not even be an active user but just a
> developer fulfilling a management roadmap such that the marketing
> department can advertise capture support. (Added Fabrice Gasnier to Cc:,
> maybe he will comment.)
>=20
> I don't know of any user of this, but of course I cannot rule out there
> are users I just don't know of. So the suggestion here looks reasonable
> to me: There is a Kconfig item now, people who don't use capture can
> disable it and the ones who rely on it set it =3Dy. I expect that when
> this switch hits the distribution kernels it will initially be off. Then
> either people will wail to enable it. Or they don't and in a few years
> we can be even more convinced there are no active users.
>=20
> Best regards
> Uwe
>=20
> [1] ab3a89784783 ("pwm: stm32: Use input prescaler to improve period capt=
ure") from 2018
>=20
> --=20
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |

Hi all,

I want to give some context about the Counter subsystem as I think that
will help in deciding whether to deprecate the existing PWM capture
code.

Support for PWM input capture was added in 2018 as part of the 4.18
merge window, but the Counter subsystem was added later in 2019.
Although ST engineers involved with STM32 were at the center of
discussions steering the requirements of the nascent Counter subsystem,
the Counter events (capture) system just wasn't ready at the time the
pwm-stm32 patch introducing capture support was accepted [0].

The Counter events system enables drivers to push device events on
demand to a kfifo that userspace can pop via a respective character
device node [1]. Each event is timestamped at the moment of capture, and
userspace has the freedom to select what particular data should be
captured (count value, signal value, supported extensions, etc.). The
system really is quite flexible to what a particular user desires to
capture from the device.

As an example, suppose a Counter event is pushed to capture the current
count value every time a change-of-state is detected for a signal. Each
event will have a timestamp of when that change-of-state occurred. We
get a time delta by comparing the timestamps between two events. Because
events are in a kfifo, userspace can skip and combine events as desired.
This is how you can determine period and duty cycle, among many other
data computations.

Of course there may be current users of the existing PWM capture system,
so it shouldn't be removed outright. However, given that now the PWM
capture system functionality is essentially provided by the Counter
events system in a more flexible and extensible manner, I think it makes
sense to deprecate support for PWM capture and encourage users to
migrate to the Counter interface for such functionality.

William Breathitt Gray

[0] https://lore.kernel.org/r/1526456161-27865-4-git-send-email-fabrice.gas=
nier@st.com/
[1] https://docs.kernel.org/driver-api/generic-counter.html#counter-charact=
er-device

--wmySmM/8czyI2o/n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY3azewAKCRC1SFbKvhIj
K3ncAP9QZiP2bgmesG8cAwOPW9hDbgRuM0xhYEnIQl9MNju4KAD4gVDGmvly6vf0
+rrPwDZs0f3QSKi/SPLtaDGj+TZFCw==
=uMdi
-----END PGP SIGNATURE-----

--wmySmM/8czyI2o/n--
