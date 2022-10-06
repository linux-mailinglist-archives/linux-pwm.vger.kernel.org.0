Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336E45F6770
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Oct 2022 15:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiJFNKh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 6 Oct 2022 09:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbiJFNKV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Oct 2022 09:10:21 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9D163A0
        for <linux-pwm@vger.kernel.org>; Thu,  6 Oct 2022 06:10:18 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id nb11so4478073ejc.5
        for <linux-pwm@vger.kernel.org>; Thu, 06 Oct 2022 06:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMEFVHVdaaNnA49UJEYgYmhgQXDjLz4/UJ1mvi4Mpyo=;
        b=IM9GnHO/NwEc5ni2QQewryCLAppjbwQLN0QqhJ5jR7+Os/qvKQCyXUNZyTik+XTUvR
         xUk3U2aVWs+RoE4qeItIAMnly1toYgJ6AeBWDJyJt6y62OTwsqPnEixOtBBK21rULVYw
         5KyVlYUlmfYk+JTLekXPtxAgv2rY9NAs3rjpYia0RI2iKoiBgCXit9gEZrm15GFzLgxP
         LHj1koypq0v12hANc1f4UtFVwntrkra25qcildHI6Uz5LUQAnikle0TVqETPob+eiIJX
         4pZUiifvJjhdVlK3+M+MlBTigzC3w8f+SAi6ks0Fh8fyDkGLyOwW5IYMJaUz3jTIf2O9
         wM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hMEFVHVdaaNnA49UJEYgYmhgQXDjLz4/UJ1mvi4Mpyo=;
        b=iVWOLtajBL5rnmapwWZ+N1I+O//GmRGT8+xC8jBJ4DbTEMjZmwbgaspqWXuSclinSo
         bqPGDrcYOuXfLl6Wn801JsLEeeuIpaPjHgolbkxoImOjliSahSOW6hf9SnxSuVI+blBI
         +anDrypSzMh5iH4UNHHIenw7TtDDWxThswcL99q/951iwjXxyeuJkigBYfmpiO3OiKbi
         sgsTNZtXP2DbInbfbXw8NGFmJEzcP9StMNcvLeiLFN+4CuRRfIO8yKdFJxvIOXsLp+eL
         LXVn5f88oI0n3vHKmnFHkDaFlRCbssxyg+vBc+ScJPwv+IcpQNXohaJZxE60aX9x/1qI
         l99w==
X-Gm-Message-State: ACrzQf2MwUHiQcfhHIJinaJaSouSCnWLvLTzd3RA8wiJZGdHocmRmpPG
        bTHnY3UaMxU/fkeuT28XEms=
X-Google-Smtp-Source: AMsMyM5fmSumSH/pFsWksXCmkCI2FwR0MQ4aRQ6yhRE28jr8+agBHzoL5FZBEq3GIyywq5bGNvm9Jw==
X-Received: by 2002:a17:906:58cc:b0:785:f030:19c2 with SMTP id e12-20020a17090658cc00b00785f03019c2mr3915922ejs.88.1665061816449;
        Thu, 06 Oct 2022 06:10:16 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id z21-20020a1709060f1500b007708130c287sm10229375eji.40.2022.10.06.06.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 06:10:15 -0700 (PDT)
Date:   Thu, 6 Oct 2022 15:10:13 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Lee Jones <lee.jones@linaro.org>, kernel@pengutronix.de
Subject: Re: [PATCH 3/3] pwm: Make capture support optional
Message-ID: <Yz7Ttd0WXv7MeKtc@orome>
References: <20220523174502.987113-1-u.kleine-koenig@pengutronix.de>
 <20220523174502.987113-3-u.kleine-koenig@pengutronix.de>
 <YrMdON4uOMfDFN8h@orome>
 <20220622170945.n7eyrnuezs52itt3@pengutronix.de>
 <20220930154355.3uymms4xtmlshgmd@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Vb2KO2bqtfcyP+O7"
Content-Disposition: inline
In-Reply-To: <20220930154355.3uymms4xtmlshgmd@pengutronix.de>
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


--Vb2KO2bqtfcyP+O7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 30, 2022 at 05:43:55PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Wed, Jun 22, 2022 at 07:09:45PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > On Wed, Jun 22, 2022 at 03:46:32PM +0200, Thierry Reding wrote:
> > > On Mon, May 23, 2022 at 07:45:02PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > > The only code making use of the capture functionality is the sysfs =
code
> > > > in the PWM framework. I suspect there are no real users and would l=
ike to
> > > > deprecate it in favor of the counter framework. So introduce a kcon=
fig
> > > > symbol to remove the capture support and make the sysfs file a stub.
> > > >=20
> > > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.d=
e>
> > > > ---
> > > >  drivers/pwm/Kconfig     | 12 ++++++++++++
> > > >  drivers/pwm/core.c      |  3 ++-
> > > >  drivers/pwm/pwm-sti.c   |  4 ++++
> > > >  drivers/pwm/pwm-stm32.c |  4 ++++
> > > >  drivers/pwm/sysfs.c     |  4 ++++
> > > >  include/linux/pwm.h     |  5 +++++
> > > >  6 files changed, 31 insertions(+), 1 deletion(-)
> > >=20
> > > I've applied patches 1-2 for now, but I'm not convinced about this ye=
t.
> > >=20
> > > The PWM capture is something that's typically useful for applications
> > > served from userspace, which is why only the sysfs implementation
> > > exists. So anything that's based on another framework is likely not
> > > going to have in-kernel users either. Can you specify exactly how this
> > > alternative implementation would look like and how it would be an
> > > improvement over the current implementation?
> >=20
> > The counter framework would generate a continous stream of events while
> > you measure and from the timestamps of the events you can determine
> > period and duty cycle. So this is even more flexible because pwm-capture
> > only supports one-shot mode while with the counter stuff you can stop
> > to measure whenever you want to. Having said that, I didn't actually use
> > the counter framework for something like that, but that's how I think it
> > works and the framework has users.
> >=20
> > Other than that I have no better reasoning than the commit log. It's
> > some time ago something happend in pwm that concerns the capture
> > functionality[1] and the 13 new drivers since then all didn't implement
> > capture support. Also the capture stuff was done by an ST employee for
> > an ST driver, so that might not even be an active user but just a
> > developer fulfilling a management roadmap such that the marketing
> > department can advertise capture support. (Added Fabrice Gasnier to Cc:,
> > maybe he will comment.)
> >=20
> > I don't know of any user of this, but of course I cannot rule out there
> > are users I just don't know of. So the suggestion here looks reasonable
> > to me: There is a Kconfig item now, people who don't use capture can
> > disable it and the ones who rely on it set it =3Dy. I expect that when
> > this switch hits the distribution kernels it will initially be off. Then
> > either people will wail to enable it. Or they don't and in a few years
> > we can be even more convinced there are no active users.
>=20
> You discarded this patch as "rejected" without any feedback to my
> explanation :-\

Sorry, I hadn't realized that there was outstanding feedback on this.

> Do you think that capture support is such a vital part of the pwm
> framework that everyone who makes use of a PWM should also have the
> capture stuff even though only two drivers implement the needed callback
> and all drivers that were added in the last five years don't?

Just because only two drivers support a feature doesn't automatically
make it useless or non-vital. This feature was added because somebody
needed it and I haven't received feedback that this is unused, so I
see no reason why this should be removed. The overhead for drivers that
don't use this is negligible. There's exactly one function pointer that
would always be NULL for those. Then there's one sysfs attribute with
associated code and one core function that's just a teeny tiny wrapper
around the function pointer.

On the other side of this we have an additional PWM_CAPTURE Kconfig
symbol that introduces another combination that needs to be compile-
tested for along with the potential to confuse users when they don't
get capture support, etc. And that's just not worth it.

If you really think that the counters framework is a better fit, the
right way to deprecate this is to add support for equivalent capture
functionality to that framework and get everyone to transition to that.
Once that's done we can deprecate (and eventually perhaps even remove)
the PWM capture stuff.

Thierry

--Vb2KO2bqtfcyP+O7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmM+07MACgkQ3SOs138+
s6EwAg//eQOXFZmt9hZFtCnDZrNRw50WFeFCJIR+u6myBYOofcIvskKFfMdOUk+u
qCszurzN0hLTXC0JNuI9wccRyFNmjsT3rEDTWg/W9bDQDKl1Mo/UPA4SvjgoubTB
6iX0qZ4kZzRHe1w6iTVe6x853wqgCErAQLrikHMxAXdghYBJQNYbVFOEBIdy5xnB
1+DTi4SmZ2+EdNwvU0LoSV48NYG/GLULBzre3WWiKEeUM053iAQR5HFDDVcS6ZTV
7nkhks86Bb6+jPOzFnpEf1SP2L5XhZWoq9WygtYp97Yve0QLsCfaBofB80ekaqAq
prH8HVzHyYt+4gTCi49SgNb/7gg9PTannBvWFwggMeHinyZKVHbTMdefB+RDUyxQ
SaH7UWXPmvdWyjw9bpep+VXSLC1zEWz6DTAyBhcT2duk/p2vDa+ChSKvgm4MLfIz
nF+hVojlsV7J66AU7CyEI1Y/Z9QhIWlTl1Ob5UYJ0kOvz4hlm0JrX7O5FXQkWO8i
MWfuFfwejLg1egSolHjWVGfHqOt0eMUY7gYbjyvUbJWFk6kcmKxfHuMDHZrabMnR
Xuq+l+41+tcNCPOOqtLwIx5DA4OREnW/LSJEUclNsDRTrGlc8yo4CZeNFkfrIis1
OzDfCuAyrhRot3m0pLDJ/1cZBc99W57mWfzXZOpwry+ZYRJJZF4=
=oxIo
-----END PGP SIGNATURE-----

--Vb2KO2bqtfcyP+O7--
