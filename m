Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73175F7690
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Oct 2022 11:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiJGJ6z (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 7 Oct 2022 05:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiJGJ6y (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 7 Oct 2022 05:58:54 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D2095E43
        for <linux-pwm@vger.kernel.org>; Fri,  7 Oct 2022 02:58:52 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id m3so6274812eda.12
        for <linux-pwm@vger.kernel.org>; Fri, 07 Oct 2022 02:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bm98SkZVNbQq+JX4G2o4lJBWxLpogwRu0pq62Mc0ug=;
        b=UUh3+5+ppuSeh3uzHQDJx00CyFTPN57KyQO5cEoPj7jq+zo+O+5ITi+VBX6SLgNBOU
         XPm8lSji1UhDCNv0yk9TkZYFwimJhp6m3qWSSFwBBIgJtSRueW2bcK2OTwwiquX0tJ7g
         jRgXhXWjZuHF+DpeORXIM5z4Hrd29jXK9++bwcjuN8fxXCJTJTFRYp950G33Sj5XoReq
         MQhMbFZMBptTu+Q/veRal8B1xNzHVp+kBGx/FiiuGK9mwQ53ddhSIBhiiIdORK925CR2
         t6aFUcVWhX+VmXfuBaPj82igCMEJh0rIyn8T9wo97YaZ/BeI6/vce9TqGcVfNrRkwUUQ
         FhEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9bm98SkZVNbQq+JX4G2o4lJBWxLpogwRu0pq62Mc0ug=;
        b=rsmfe1Tytqr1BgRjRSt2yxnDJAyYwrI6Ty55J0Ycxj0YgOYoLzxK2rXp4+nxbtf7uQ
         DbbweMXYXLbMVPAMwQndlPJ99uni07sdkv/EoqaKNsw60bMjP3rgBgm7W/Sti8pI8Kyp
         6+lLsirxN4e/81nAVz8bOG4WNpnH1lBix0NlZ04m70yz8JrEYtP9LYgJd0rXXOB7y8tP
         Lbad0UksN4aiOE8b7xVrDRp3zoYLystkj1wfAxDQ7wITu1Y2iopS5urUTzKyq4uCRIJK
         /+JdVeqRsfdgN18R7XGXuXXLMwd4Sf2E33hiA0e3e5FIArwyEWrcb6zegj9SCna8TcEb
         0vew==
X-Gm-Message-State: ACrzQf3ozFWe7l28npWggfmzK8qHE7Nwqi1c2vz9m8aLGWBm3HAjHvTA
        S6EYSSaRgEpnk24I+OxO7pNB/lwDFIk=
X-Google-Smtp-Source: AMsMyM6XUWS4Yvcx/i/YAkg56hvsiGF48vE1e7JxeCom9OfJ/HInOQPRSbllglSYHUpFds/GmwoseA==
X-Received: by 2002:a05:6402:3208:b0:458:9e25:50d0 with SMTP id g8-20020a056402320800b004589e2550d0mr3705931eda.283.1665136730317;
        Fri, 07 Oct 2022 02:58:50 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id k1-20020aa7d2c1000000b00457a92f8ad6sm1147217edr.28.2022.10.07.02.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 02:58:49 -0700 (PDT)
Date:   Fri, 7 Oct 2022 11:58:47 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Lee Jones <lee.jones@linaro.org>, kernel@pengutronix.de
Subject: Re: [PATCH 3/3] pwm: Make capture support optional
Message-ID: <Yz/4V0gH/vrWSS8U@orome>
References: <20220523174502.987113-1-u.kleine-koenig@pengutronix.de>
 <20220523174502.987113-3-u.kleine-koenig@pengutronix.de>
 <YrMdON4uOMfDFN8h@orome>
 <20220622170945.n7eyrnuezs52itt3@pengutronix.de>
 <20220930154355.3uymms4xtmlshgmd@pengutronix.de>
 <Yz7Ttd0WXv7MeKtc@orome>
 <20221006143544.ivhjruazd5m673hf@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PZvoMRxUkj0GnaKV"
Content-Disposition: inline
In-Reply-To: <20221006143544.ivhjruazd5m673hf@pengutronix.de>
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


--PZvoMRxUkj0GnaKV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 06, 2022 at 04:35:44PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Thu, Oct 06, 2022 at 03:10:13PM +0200, Thierry Reding wrote:
> > On Fri, Sep 30, 2022 at 05:43:55PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > On Wed, Jun 22, 2022 at 07:09:45PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > > On Wed, Jun 22, 2022 at 03:46:32PM +0200, Thierry Reding wrote:
> > > > > On Mon, May 23, 2022 at 07:45:02PM +0200, Uwe Kleine-K=C3=B6nig w=
rote:
> > > > > > The only code making use of the capture functionality is the sy=
sfs code
> > > > > > in the PWM framework. I suspect there are no real users and wou=
ld like to
> > > > > > deprecate it in favor of the counter framework. So introduce a =
kconfig
> > > > > > symbol to remove the capture support and make the sysfs file a =
stub.
> > > > > >=20
> > > > > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutron=
ix.de>
> > > > > > ---
> > > > > >  drivers/pwm/Kconfig     | 12 ++++++++++++
> > > > > >  drivers/pwm/core.c      |  3 ++-
> > > > > >  drivers/pwm/pwm-sti.c   |  4 ++++
> > > > > >  drivers/pwm/pwm-stm32.c |  4 ++++
> > > > > >  drivers/pwm/sysfs.c     |  4 ++++
> > > > > >  include/linux/pwm.h     |  5 +++++
> > > > > >  6 files changed, 31 insertions(+), 1 deletion(-)
> > > > >=20
> > > > > I've applied patches 1-2 for now, but I'm not convinced about thi=
s yet.
> > > > >=20
> > > > > The PWM capture is something that's typically useful for applicat=
ions
> > > > > served from userspace, which is why only the sysfs implementation
> > > > > exists. So anything that's based on another framework is likely n=
ot
> > > > > going to have in-kernel users either. Can you specify exactly how=
 this
> > > > > alternative implementation would look like and how it would be an
> > > > > improvement over the current implementation?
> > > >=20
> > > > The counter framework would generate a continous stream of events w=
hile
> > > > you measure and from the timestamps of the events you can determine
> > > > period and duty cycle. So this is even more flexible because pwm-ca=
pture
> > > > only supports one-shot mode while with the counter stuff you can st=
op
> > > > to measure whenever you want to. Having said that, I didn't actuall=
y use
> > > > the counter framework for something like that, but that's how I thi=
nk it
> > > > works and the framework has users.
> > > >=20
> > > > Other than that I have no better reasoning than the commit log. It's
> > > > some time ago something happend in pwm that concerns the capture
> > > > functionality[1] and the 13 new drivers since then all didn't imple=
ment
> > > > capture support. Also the capture stuff was done by an ST employee =
for
> > > > an ST driver, so that might not even be an active user but just a
> > > > developer fulfilling a management roadmap such that the marketing
> > > > department can advertise capture support. (Added Fabrice Gasnier to=
 Cc:,
> > > > maybe he will comment.)
> > > >=20
> > > > I don't know of any user of this, but of course I cannot rule out t=
here
> > > > are users I just don't know of. So the suggestion here looks reason=
able
> > > > to me: There is a Kconfig item now, people who don't use capture can
> > > > disable it and the ones who rely on it set it =3Dy. I expect that w=
hen
> > > > this switch hits the distribution kernels it will initially be off.=
 Then
> > > > either people will wail to enable it. Or they don't and in a few ye=
ars
> > > > we can be even more convinced there are no active users.
> > >=20
> > > You discarded this patch as "rejected" without any feedback to my
> > > explanation :-\
> >=20
> > Sorry, I hadn't realized that there was outstanding feedback on this.
> >=20
> > > Do you think that capture support is such a vital part of the pwm
> > > framework that everyone who makes use of a PWM should also have the
> > > capture stuff even though only two drivers implement the needed callb=
ack
> > > and all drivers that were added in the last five years don't?
> >=20
> > Just because only two drivers support a feature doesn't automatically
> > make it useless or non-vital.
>=20
> Ack, but two drivers also don't automatically make it useful or vital. I
> never used it even tough I already used PWMs a lot. Did you ever use it?

No, I have never used it. But I don't see how that's relevant.

> > This feature was added because somebody
> > needed it and I haven't received feedback that this is unused, so I
>=20
> So you expect people to tell you which part of the PWM framework they
> stopped using (or never used)? <sarcasm>Has anybody ever told you that
> they don't use CONFIG_PWM? Maybe we should compile it in
> unconditionally.</sarcasm>

No, they don't need to tell me. This was merged because somebody needed
it at some point, so I'm going to assume that it keeps being used. If we
start removing existing features because we think they are no longer
useful, we're going to end up annoying people and worst case they will
be stuck on some old version of the kernel.

> > see no reason why this should be removed.
>=20
> I don't want to remove it---at least for now. Just make it possible to
> disable this code for users who don't need it. (To pick up your line of
> reasoning: I haven't received feedback that it is used.) I'm happy about
> every unused feature I can disable, even if it only affects a single
> sysfs property. Code that is compiled out cannot trash cache lines or
> bring in runtime overhead or security problems without any gain. Yeah,
> this affects only very little code, but flipping a Kconfig switch is
> still easier than even to consider to review the capture stuff for
> unwanted effects. Given that more than 90% (99% ?) don't use capture, I
> do see some benefit.

There may be some benefit to disabling or removing this, but I don't
think it outweighs the downsides.

> > The overhead for drivers that
> > don't use this is negligible. There's exactly one function pointer that
> > would always be NULL for those. Then there's one sysfs attribute with
> > associated code and one core function that's just a teeny tiny wrapper
> > around the function pointer.
>=20
> Agreed, the overhead is small. Still code that is hardly used, not even
> by the maintainers of the framework is a bad thing in my eyes.

Heh... I don't think there's such a rule. Code doesn't have to be used
by its maintainer for it to be part of the kernel. If you continue that
reasoning, then anything that Linus doesn't use would have to be
removed.

>                                                                So being
> able to disable it (and ship kernels with that item disabled in distros)
> is a good way to find users who care, should they really exist. Either
> outcome is a win. Either we can get rid of an unused feature at some
> point in time, or we actually know there are users and we know their
> email address.

I would agree with you if this was somehow problematic to maintain or a
burden in some way. It's really not, so adding the Kconfig knob, and in
fact having this discussion, is way more time than I have spent on the
capture feature in the last few years combined.

> > On the other side of this we have an additional PWM_CAPTURE Kconfig
> > symbol that introduces another combination that needs to be compile-
> > tested for along with the potential to confuse users when they don't
> > get capture support, etc. And that's just not worth it.
>=20
> My (subjective) judgement is obviously different. IMHO compile testing
> isn't a big issue. There are enough auto builders around to catch this
> and should really someone get it wrong, it's easy and trivial to fix.
> And if we had done this change 5 years ago, exactly zero patches since
> then would have had to care about this Kconfig symbol.

Just as a reminder: the whole COMPILE_TEST business that people have
sunk a significant amount of work into, has been to alleviate the pain
that comes from too many Kconfig switches. Keeping things simple and
unconditional in individual subsystems tremendously helps with keeping
the combinatorial explosion in check.

> > If you really think that the counters framework is a better fit, the
> > right way to deprecate this is to add support for equivalent capture
> > functionality to that framework and get everyone to transition to that.
>=20
> I claim everyone already transitioned. I cannot prove it as you cannot
> prove the opposite. Until we make it harder for people to use it.

I don't have to prove the opposite. Also, making it harder for people to
use this isn't necessarily going to get us feedback. You assume that the
people that would be inconvenienced by this getting disabled by default
will be motivated enough to bring this up. I think it's at least equally
likely that they'll get annoyed and stop updating their kernel or switch
operating system to something with more sensible maintainers.

Again, if this were somehow a significant impediment this might be a
good idea. As it is, it is not. Sorry.

Thierry

--PZvoMRxUkj0GnaKV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmM/+FUACgkQ3SOs138+
s6GTTQ/6AwIxZfjQ8U+0rx3NYF09VwICpfrUJeLNmjkS3etY/7LpkIrbjzMRWydD
FunXHWawF6HFC+r4jWqrYTWjo6BNEtq7i7hN/lsCUi8kNBhCk2XVp6uL2QnbaFp4
0dSZQG6hM/lWKe2O4XX+9qhNSNokrdyxc/HBG4hvcAcM99pC6QTt8kzRZ3U4x0Op
IqKhuvtPxcjSrosSYSzsZKwmMn05UrMdUwF3tEkIFyjjdmFYYhfjVYlpGFHdrLnY
Aq4qCheb/9UqzIkf3czDRJWiwjoXsG61m6P2rkvPtF6jU/4Gz0HyHOoPljfxangw
Wlwa9ZRlO2xadc92acO8T1qQ/tgh7HxkbY9etwBdNSUBCTr8lOjHYtUfC9CddmlD
c9hfUnNg8QzzKpWW2ayTTFI2C/SrS1KbzzwuHW3iabN8MgcprD82hBhjA6gi9YSD
1TYiFaJAefeHgYpi15hQdOTRAxK8Zji+/jcY8YdeL1KOvGV+QgAs6bsjCdwQg1kj
FXJn3y9VHIHz5fT3cRQWWmv0soFjrUgKgyw0FbAEaFFwdt3WQ0trr/Qxt+2gQojS
X7wBmbGA14fznjZvrlMGiLhwvAwjVKrF70OtHCLJ24CdrEPtFsyklZytK/wp7C4n
z77Lv9HKeN48hL6wNKb3vBHYWsFyhsYpMNHbSPw3zgVYdBdUZgU=
=LTNf
-----END PGP SIGNATURE-----

--PZvoMRxUkj0GnaKV--
