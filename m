Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F7336E877
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Apr 2021 12:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbhD2KPK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 29 Apr 2021 06:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbhD2KPK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 29 Apr 2021 06:15:10 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA4DC06138B;
        Thu, 29 Apr 2021 03:14:21 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id n2so99013102ejy.7;
        Thu, 29 Apr 2021 03:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S4yG2fi+UcSVw0GAJVZLN6MnOqhUUjkPFwRoh2SCzns=;
        b=m3VAglieYd1KZvGhGUm9+5aDZIKoHnaN6enC3RB5XjqNwoqgu31ktt0EwzxRzlG1xk
         mjOt5P0S9U4NC5YH/fQ9jXpqJJIWnuj/KOsOQ0lVxf8wdll1CNQ/2mKsf3hVg9K6xb7/
         URvfRCv/REBZaLBEM2aRM/qQzhZ4ksIknz5DUW8AsSMeUXJB/TL+FDS5EFwthCUoLBQ+
         SEXfsg/UlOBDWzkjtBtT2/R/NHgBTPc5NqLIuBDTxIQai4mIzhy8wDaNu4O4D7WF+k0h
         na5JLAiCsBp40ig6nK7A6AcszoZewBTT8WMkDNAxf/kGb8OxH2U/IXEHpZETyf7IJNa8
         rG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S4yG2fi+UcSVw0GAJVZLN6MnOqhUUjkPFwRoh2SCzns=;
        b=kCXWWFO1ftAo7RXsb2a4T/CFTDTL0NE5NzOQCuchjv/kWPbVxcJVXG/m3WhZ3D7CwA
         PVw+zeJjhDilKIzaDQBvwvBpVWBwgQg2QglsCtUju5l1qqi/t5KXTiIahXmb3TuOsOAO
         aQjeLG9XGNzC1IrFOoFZ92QxvRhRTs6sdATs9vk9JRbEiZ5tlGb97elhUACtj67h3uT9
         XratrMl7g8K+ookEmKXL4EVIxFZ+qOYyuSFqwQys/8+gthYoNxLmhJRdKLdXbtpkragg
         LP89AsegPa3Xu/8tFmNJq/heMr40xcfy6OfRWjsMpabQ3MfScpsNuQ6gibn8UU79gecs
         LsxQ==
X-Gm-Message-State: AOAM533oeghncrgCXSnidnVZWcNmDwJKb+Hom6gzB6ZnlY2dN8Z5k1bR
        rdGwJQCcQ9iD6T/E40eE5k4=
X-Google-Smtp-Source: ABdhPJxh2d0DqqKGAty7LL3QSKbQcmC+MGRvZj3dYJFoDtO4jKXN4vqvD03Pc/HlkHpwQP6SDe0R/Q==
X-Received: by 2002:a17:907:16a9:: with SMTP id hc41mr34622201ejc.84.1619691260433;
        Thu, 29 Apr 2021 03:14:20 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id r10sm1540317ejd.112.2021.04.29.03.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 03:14:18 -0700 (PDT)
Date:   Thu, 29 Apr 2021 12:15:14 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Fenglin Wu <fenglinw@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        subbaram@codeaurora.org, collinsd@codeaurora.org,
        aghayal@codeaurora.org
Subject: Re: [PATCH 2/2] pwm: pwm-qcom: add driver for PWM modules in QCOM
 PMICs
Message-ID: <YIqHMuKhkVkcp6ir@orome.fritz.box>
References: <20210427102247.822-1-fenglinw@codeaurora.org>
 <20210427102247.822-3-fenglinw@codeaurora.org>
 <20210427170748.wglupc6zwrndalxs@pengutronix.de>
 <YImfkM/ll1nCmopq@orome.fritz.box>
 <20210429065213.inajpznvfxa2xsld@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qjfQOg7BRpB4kEso"
Content-Disposition: inline
In-Reply-To: <20210429065213.inajpznvfxa2xsld@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--qjfQOg7BRpB4kEso
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 29, 2021 at 08:52:13AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Wed, Apr 28, 2021 at 07:46:56PM +0200, Thierry Reding wrote:
> > On Tue, Apr 27, 2021 at 07:07:48PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > I would like to see the register definition to use a common prefix (l=
ike
> > > QCOM_PWM_) and that the names of bit fields include the register name.
> > > So something like:
> > >=20
> > > 	#define QCOM_PWM_PWM_SIZE_CLK		0x41
> > > 	#define QCOM_PWM_PWM_SIZE_CLK_FREQ_SEL 		GENMASK(1, 0)
> > >=20
> > > even if the names are quite long, its usage is less error prone. Maybe
> > > it makes sense to drop the duplicated PWM (but only if all or no
> > > register contains PWM in its name according to the reference manual).
> > > Also maybe QCOM_PWM_PWMSIZECLK_FREQSEL might be a good choice. I let =
you
> > > judge about the details.
> >=20
> > Please stop requesting this. A common prefix is good for namespacing
> > symbols, but these defines are used only within this file, so there's no
> > need to namespace them.
>=20
> I do consider it important. The goal of my review comments is to improve
> the drivers according to what I consider sensible even if that might not
> fit your metrics.=20
>=20
> Consistent name(space)ing is sensible because the names of static
> functions are used in backtraces.

I've said this elsewhere, and I specifically didn't comment on that
request, that I think namespacing for static functions does make sense
because they may show up in backtraces.

Register definitions, however, are never going to show up in a
backtrace. The only place where you will ever see them is within the
source file where the context is already plenty clear. The same goes
for locally scoped variables.

>                                   It is sensible because tools like
> ctags, etags and cscope work better when names are unique.

But those tools are primarily useful to find cross-references of
symbols. If you have symbols that are local to a single file, then it's
much easier to open that file in an editor than run the tools.

>                                                            It is
> sensible because it's harder than necessary to spot the error in
>=20
> 	writel(PWM_EN_GLITCH_REMOVAL_MASK, base + REG_ENABLE_CONTROL);

I don't think it's sensible to rely on naming to detect errors in this
kind of construct. Either you write it correctly and the code does what
it's supposed to, or it isn't correct and the code will be broken.

> . It is sensible because the rule "Use namespacing for all symbols" is
> easier than "Use namespacing for symbols that might conflict with
> (present or future) names in the core or that might appear in user
> visible messages like backtraces or KASAN reports".

Yes, sure, if you consider everyone incapable of making reasonable
decisions, then by all means, let's make it as easy as possible. Maybe
while at it you want to go and propagate those rules across the entire
kernel. Good luck with that.

>                                                     It's sensible
> because then it's obvious when reading a code line that the symbol is
> driver specific. It is useful to have a common prefix for driver
> functions because that makes it easier to select them for tracing.

Again, functions are an exception where the prefix makes sense.

> > Forcing everyone to use a specific prefix is just going to add a bunch
> > of characters but doesn't actually add any value.
>=20
> That's your opinion and I disagree. I do see a value and the "burden" of
> these additional characters is quite worth its costs. In my bubble most
> people also see this value. This includes the coworkers I talked to,
> several other maintainers also insist on common prefixes[1] and it
> matches what my software engineering professor taught me during my
> studies. I also agree that longer names are more annoying than short
> ones, but that doesn't outweigh the advantages in my eyes and a good
> editor helps here.

Well, I'm sure I could find plenty of examples of maintainers *not*
requesting common prefixes because they disagree with your opinion.
Maybe you should think about why it's called a "bubble".

This is totally subjective and there aren't any clear rules. As such I
don't think we should enforce it. The one exception that we all seem to
agree on is static functions because they can show up in traces, but for
the rest I'm not going to enforce the common prefix.

Thierry

--qjfQOg7BRpB4kEso
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmCKhy8ACgkQ3SOs138+
s6HNkw//TMJDUdvWi+QsUhFmthvLPdP0Ifps0JgEMYIfP0DIkDIpg0Qp2jauA3nl
KeBb1+G52ziYDe1agqGJYNTNlQN6WcEt+M6/cGYV9SCE3PQiDx+JybnV1x8/vIHb
mTkLQDZ94cOri/tEhh7TPmDK/Q8W9Lp7JM97KVMr/I4kmUQ0f5efvWaCGxpi5AoI
HjO0xg1btLE8O1jrnWFlWkE5OKrM4AxMYZQA27bLmhjNby7Yrr016/aTZVVZLr8R
YyluQGYTnCVBDisz+LLDGAdmnQDDwZw6gYZUFrKEU+dk76VG/A0kez237icQoKOD
T0DX9NgCkIVz5czludlTguJ9zPXGVXVx6YSo53rzzEDAeTEq5rNUGqs0D8Xx80B2
wfL5zpkSdJ4DPwa5dITtYSL/vP5WisHT4Nsymo4Of3Ij1UkftBZigSDi3vN0aFvu
fmL2EZQPRt/oZWQ871Gaj+9TKalErPzt5lvFVu7tJyyBfteBAOnOFem25Th3cMCm
k8juO5wzhmH2PaucwiI7PbcSpfgF+su0qaZpDrncy/e0g5nhdzN/zKQ2wQQBVq1H
ZEj/Rz39F6jdMAeBtzER5LvarK458q0GVXUTUNsEmjtTnrbFBt3wpjR0XIYO08m7
0egzE8pCcBshNntJpNmv5MR5c87UhVFD65XMdV1EYB79INmNdkQ=
=VkNK
-----END PGP SIGNATURE-----

--qjfQOg7BRpB4kEso--
