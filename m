Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B25A18BCB0
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Mar 2020 17:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgCSQhF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 19 Mar 2020 12:37:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44283 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbgCSQhF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 19 Mar 2020 12:37:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id o12so3380321wrh.11;
        Thu, 19 Mar 2020 09:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NMueQiP9jz9O+z3rNtEF0OHXn/KJHT1fioATarE40G8=;
        b=kRFKQKfEBEqihNIaveyPStDvKrgGhFdZYXEgGipYSaA/2qb6vfhLO+/QfXCyCFXgSF
         4F9OSwGjKC73SFYPFCirtCRMbpEEoDU3RUq+OjredkiZDGPLh5a47GO0D6W+wOc90ph7
         VF9FDlcb17/e3+Ta1efGon4YAfa5fgDS4iEpV+0BmBtdIA1z6lRAepOpcej3xMKWo/ux
         Vg8pKnGn9tr2cb5/j+Mc193lHK4mxDTwsK+cC3L/LI6irZpb0ZVA50uMqMMR//1l7yZB
         kun/1ogBpRNi9sP3YX7gPc3nz4ngJ4FX5E4UnQvyiQODgPw0LbfZxDr7lHa2ya6glUVd
         PhUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NMueQiP9jz9O+z3rNtEF0OHXn/KJHT1fioATarE40G8=;
        b=AcyMOZrdTQTy5dMCUVEFJ4VbqiPCISGFTdevkAZz8OambaAV4PAcYEt5zgPiJb2/gi
         affR6OYLy392mhxhxHzFd/4ptYbxw6R/Ag3qbnGM/TQMTpS7mNQCPWz3PycI0/I+NGJz
         DIqr7+bCcZtlLmAWNUNcI3T75aqv2dKxDCVxW6hHNvNaa++U2LqcrRntHST1Lq0P6mEY
         a/3Kfscmkq/gDNM7RCFmOZP72Eh8aGzp2JHJEwGs6V9hD8ik+/u8oX3qd9qMAM/6T2lZ
         FHYySG8MUqyedAULFuBlq70scU1XTHsiEKKk9MxoAcAesqFR372mc79fCEupMCpqCsOI
         /ZPg==
X-Gm-Message-State: ANhLgQ287A/YJkkbRmZdUEC9TSH1gJYKAoej/7n1nYn8ayC6+MWVG8+e
        fzUCFTpWQNEeGwdaGc1Y38w=
X-Google-Smtp-Source: ADFU+vtoxuuyxX+HT1GPJKiSCaAgThQGtgPWSsP45bIWCEbkNowuDDd0U3X4oTdHznURld4tZlgyhg==
X-Received: by 2002:a05:6000:d0:: with SMTP id q16mr5551345wrx.71.1584635822900;
        Thu, 19 Mar 2020 09:37:02 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id z22sm3851524wmi.1.2020.03.19.09.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 09:37:01 -0700 (PDT)
Date:   Thu, 19 Mar 2020 17:37:00 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        Paul Barker <pbarker@konsulko.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Fabio Estevam <festevam@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Maxime Ripard <mripard@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Ray Jui <rjui@broadcom.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Scott Branden <sbranden@broadcom.com>,
        Shawn Guo <shawnguo@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [RFC PATCH 1/7] pwm: rename the PWM_POLARITY_INVERSED enum
Message-ID: <20200319163700.GA3354541@ulmo>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-2-oleksandr.suvorov@toradex.com>
 <20200317174043.GA1464607@ulmo>
 <20200317210042.ryrof3amr7fxp4w5@pengutronix.de>
 <20200318225953.GA2874972@ulmo>
 <20200319065039.szhh5dm6v3ejwijd@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <20200319065039.szhh5dm6v3ejwijd@pengutronix.de>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2020 at 07:50:39AM +0100, Uwe Kleine-K=C3=B6nig wrote:
>=20
> [Dropped Tony Prisk from recipients as the address bounces]
>=20
> Hello,
>=20
> On Wed, Mar 18, 2020 at 11:59:53PM +0100, Thierry Reding wrote:
> > On Tue, Mar 17, 2020 at 10:00:42PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > Hello,
> > >=20
> > > On Tue, Mar 17, 2020 at 06:40:43PM +0100, Thierry Reding wrote:
> > > > On Tue, Mar 17, 2020 at 02:32:25PM +0200, Oleksandr Suvorov wrote:
> > > > > The polarity enum definition PWM_POLARITY_INVERSED is misspelled.
> > > > > Rename it to PWM_POLARITY_INVERTED.
> > > >=20
> > > > It isn't misspelled. "inversed" is a synonym for "inverted". Both
> > > > spellings are correct.
> > >=20
> > > Some time ago I stumbled about "inversed", too. My spell checker does=
n't
> > > know it and I checked some dictionaries and none of them knew that wo=
rd:
> > >=20
> > > https://www.lexico.com/search?utf8=3D%E2%9C%93&filter=3Ddictionary&di=
ctionary=3Den&query=3Dinversed
> > > https://de.pons.com/%C3%BCbersetzung/englisch-deutsch/inversed
> > > https://dictionary.cambridge.org/spellcheck/english-german/?q=3Dinver=
sed
> > >=20
> > > https://en.wiktionary.org/wiki/inverse#Verb mentions "inverse" as a v=
erb
> > > having "inversed" as past participle.
> >=20
> > Here are the first three results from a Google query:
> >=20
> > 	https://www.yourdictionary.com/inversed
>=20
> There is something fishy. In the Verb section it says indeed, that it is
> the past participle and simple past of inverse. The entry for inverse
> however only has sections that identify this word as adjective or noun;
> not a verb.
>=20
> > 	https://www.dictionary.com/browse/inversed
>=20
> Not sure I'd count this as hint that inversed exists. The entry shown to
> me under this URL is about "inverse" and it has
>=20
> 	verb (used with object), in=C2=B7versed, in=C2=B7vers=C2=B7ing.
> 		? to invert.
>=20
> Does this mean: "Did you mean invert instead?"
>=20
> > 	https://en.wiktionary.org/wiki/inversed
>=20
> Yeah, that's the one I found, too.
>=20
> I still have the impression that "inversed" is in use because people
> don't know better and understand the intended meaning. And this results
> in leaking of this word into the references.
>=20
> > > Having said this I think (independent of the question if "inversed"
> > > exists) using two similar terms for the same thing just results in
> > > confusion. I hit that in the past already and I like it being address=
ed.
> >=20
> > I don't know. It's pretty common to use different words for the same
> > thing. They're called synonyms.
>=20
> In literature yes, I agree. In a novel it is annoying to repeat the same
> words over and over again and some variation is good. In programming
> however the goal is a different one. There the goal should be to be
> precise and consistent.

We also need to make sure that things don't break. It's a very bad idea
to have a macro with the same name as an enum value for reasons I stated
before. I think that's the most important thing here.

Also, if inversed is a synonym of inverted, we don't loose any precision
at all. All you have to remember is that you're dealing with a device
tree constant in one case and an API enumeration in the other.

So I think the current form is actually more precise, though I guess it
could be confusing if you don't care about the difference.

> > > > And as you noted in the cover letter, there's a conflict between the
> > > > macro defined in dt-bindings/pwm/pwm.txt. If they end up being incl=
uded
> > > > in the wrong order you'll get a compile error.
> > >=20
> > > There are also other symbols that exist twice (GPIO_ACTIVE_HIGH was t=
he
> > > first to come to my mind). I'm not aware of any problems related to
> > > these. What am I missing?
> >=20
> > There's currently no problem, obviously. But if for some reason the
> > include files end up being included in a different order (i.e. the
> > dt-bindings header is included before linux/pwm.h) then the macro will
> > be evaluated and result in something like:
> >=20
> > 	enum pwm_polarity {
> > 		PWM_POLARITY_NORMAL,
> > 		1,
> > 	};
> >=20
> > and that's not valid C, so will cause a build error.
>=20
> I admit I didn't look closely here and I assume you are right. If I
> understand Oleksandr right this is only an intermediate step and when
> the series is applied completely this issue is gone. Still it might be
> worth to improve the series here.

	$ gcc -o /dev/null -x c - <<- EOF
	>     #define PWM_POLARITY_INVERTED (1 << 0)
	>
	>     enum pwm_polarity {
	>         PWM_POLARITY_NORMAL,
	>         PWM_POLARITY_INVERTED,
	>     };
	> EOF
	<stdin>:1:35: error: expected identifier before =E2=80=98(=E2=80=99 token
	<stdin>:5:9: note: in expansion of macro =E2=80=98PWM_POLARITY_INVERTED=E2=
=80=99

Q.E.D.

> My original question was about similar problems with GPIO_ACTIVE_HIGH.
> Are you aware of problems there?

The problem exists there equally. We're probably not running into it
because drivers don't end up including dt-bindings/gpio/gpio.h and
include/linux/gpio/machine.h at the same time. Or they end up always
including them in the right order.

For PWM the situation is slightly more complicated because we only have
one header for the kernel API, so the likelihood of including it along
with the dt-bindings header is increased compared to GPIO.

> > > > Note that DT bindings are an ABI and can
> > > > never change, whereas the enum pwm_polarity is part of a Linux inte=
rnal
> > > > API and doesn't have the same restrictions as an ABI.
> > >=20
> > > I thought only binary device trees (dtb) are supposed to be ABI.
> >=20
> > Yes, the DTB is the ABI. dt-bindings/pwm/pwm.h is used to generate DTBs,
> > which basically makes it ABI as well.
>=20
> We disagree here. With this argument you could fix quite some things as
> ABI.

I don't understand what you're trying to say.

> > Yes, the symbol name may not be part of the ABI, but changing the
> > symbol becomes very inconvenient because everyone that depends on it
> > would have to change.
>=20
> Oleksandr adapted all in-tree users, so it only affects out-of-tree
> users. In my book this is fine.

There used to be a time when it was assumed that eventually device tree
sources would live outside of the kernel tree. Given that they are a HW
description, they really ought not to be relying on the Linux kernel
tree as a way of keeping them consistent. That's really only out of
convenience.

> > Why bother?
>=20
> To make the API more precise and consistent. That's a good goal in my
> eyes.

PWM_POLARITY_INVERTED is not part of the API. It doesn't exist for
anything other than to make the device tree more readable.

I now regret that we ever introduced this in the first place. Perhaps it
would've been better to just deal with raw numbers instead.

Thierry

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl5zn6kACgkQ3SOs138+
s6G0qA//TRbmBTBaIgA8loJnEh1oNwlzPblJdiH8lXKLSVxfyTXfaFGDQcOzMyBg
DkLtpO51Rah1o+3yB/j6b8TXA9amdpD65SP2FBL2dFLyBn8K5Ot5ZWuvTapyclcz
2TI8cG1Du/xLWxMDDX+Rylj+9XTlQxu3lGssuCM56hF0VXmhyvEzD3/aLlA/MjeY
QQky3apxaRT+lnGsAzRLGbLHZufTV+OaZ9ZYZZGTlsXR1VAUsyR44TGM+290Ut6p
Ds8bLPjI3xTa6uy66MlsUcYAAo1/jCQMAS+Nr/B0XGRPJdtK2G+MY3vtTZENSvqr
VKDulCTAEGE/uP+7qZVOmxOZIhX7n1zBdwSdZS5FgjCok6QjfOUa9SlT77O4bGAM
lGaeG9h8gBYpE2wk+9Wd6V9vm8UoJXPujpsyJXRHpQa5nJhgqr/VNYCeHlYhKXuQ
ymd6V9cwXRk/0xoRKR8WnRl5ZgfZtTYDfh/dGD7CdUBcyfCFZVcYEI01iO54m5Dr
/kakaDhUXRLv+xBGk4CocrSgo92DQeFUWyb2QnoW/5yYbHEOYEsfz+pWUicxin/y
Yf9ZNfDh5MPRidZyJ5b/wy3xz2OHEkyGKGGIb2em5E5AwvDZiDXhQkjhf5hzb2fD
xgjBAa+LbbBZYCs2a4Y85i+tpsJpp72cE4Xamu4rr3Pz7URiAnw=
=VES6
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
