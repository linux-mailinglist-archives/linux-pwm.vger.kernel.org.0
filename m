Return-Path: <linux-pwm+bounces-8168-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Nb2IafgoGk4nwQAu9opvQ
	(envelope-from <linux-pwm+bounces-8168-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Feb 2026 01:09:11 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E4A1B1250
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Feb 2026 01:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9D9B303F565
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Feb 2026 00:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1451A9F88;
	Fri, 27 Feb 2026 00:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ct7ascL6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA62619F121
	for <linux-pwm@vger.kernel.org>; Fri, 27 Feb 2026 00:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772150947; cv=none; b=rJsFm9BOn2FPhbqwfRtxZqZoxLLi48vgF2DmzSpIo/S8lUAzFd8pldCDws0Pbud8RLjMxP7b8I89GJY7H3tTPbcbfsBjEldL7m0U5l5A6k2AsmOrpbLtSlU/J56Re3V07BsveBpjKtnFFgSiHk62B6kJpNTTk8kl6X/f9nMq9PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772150947; c=relaxed/simple;
	bh=r6qVb5SrXuzRJCtJ7X6ToRmUEo3A0bpvC7Y2m9g6kOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RU+Tn0IJFJa9opHre+SWptGzKR2q/LgVeoDTTBMy2dpAA9rTWXBLerJ08JH+H0SpR0G8ycAzKpsFeBs9RoYP2vItaO55uCYtodhnxeF42iR70GdQoXsi8ku3jkC5nyqVSvIqOemEwtvTsxYD11hZYtoqKnzaHApTOsn5GAgRfsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ct7ascL6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569EBC2BCB2
	for <linux-pwm@vger.kernel.org>; Fri, 27 Feb 2026 00:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772150947;
	bh=r6qVb5SrXuzRJCtJ7X6ToRmUEo3A0bpvC7Y2m9g6kOI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ct7ascL65MrGly/h7ROGbp7KR0MHgGiNlY7qk2yDC8sSvyz2LbPefw/iL3zlqyZII
	 MisuNiQhVBJlJlzYZbGdDM1fOT0fey8RRW82OKQUajp7aIdX2RwmBz3GjRADZ3OpOn
	 1XkxY+Qrqb/qmv3LrOos3X8QIyWyJdmqRIPU17SAR+CkqN7RnR3eIWkosaaByxAE3z
	 EEaWoSVTQr0uYo9XluEIbIUqOFnAT8UAam3aO0tMyBT64DkS2UtjZqlQhIXNaxjPXc
	 t/svSRlpgCJ3bMsWgzkKNu5zBbG6PDK0DfTi6bqeULa1467ruYAWSlNAudvNJjwBmo
	 99U9OAFDZ+zUw==
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7982c3b7da9so17368507b3.1
        for <linux-pwm@vger.kernel.org>; Thu, 26 Feb 2026 16:09:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW0uCkYhiPcokPlYqNVdNylFK5pZsvgeP8a0GrBxIWPbMedqJ08zQi2bp6kQjuhOBIP6QF/GCeYOFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzHR8DnDnaoJ87BZgtN2wxNYynHTtSZdsNGhmlZ6vbGtvEBdh0
	Ab4rhButumNt+EyDhAmWCuCePCdfk+P4BGeh5UDcykR/PSNtyOaI3nJyWRJDHTZPXJY22ehWe+I
	cd+B5672Xc8QqD0Uc2I/mUVFqfY2wpeU=
X-Received: by 2002:a05:690c:6501:b0:794:dfcd:5eac with SMTP id
 00721157ae682-798855c640bmr10709197b3.40.1772150946572; Thu, 26 Feb 2026
 16:09:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128033936.27642-1-eleanor.lin@realtek.com>
 <20260128033936.27642-6-eleanor.lin@realtek.com> <CAD++jL=445wx467ZKE3-qm_BaVzKYXE-7zmReTFZA0KUAaSNyw@mail.gmail.com>
 <d5be357c14b84155adfa8a9f00a64d83@realtek.com>
In-Reply-To: <d5be357c14b84155adfa8a9f00a64d83@realtek.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 27 Feb 2026 01:08:55 +0100
X-Gmail-Original-Message-ID: <CAD++jLnwZAEOCh2Ax6U_dRV7=zs8e9cyS3WFKwKm-YDMy9UTrg@mail.gmail.com>
X-Gm-Features: AaiRm51SabMRAY6QbP4WyvD-aiWUX9VKIEXMzR3ZCpfbbteoPrpN-39hhQW4_CU
Message-ID: <CAD++jLnwZAEOCh2Ax6U_dRV7=zs8e9cyS3WFKwKm-YDMy9UTrg@mail.gmail.com>
Subject: Re: [PATCH 5/8] dt-bindings: pinctrl: realtek: add RTD1625 pinctrl binding
To: =?UTF-8?B?WXUtQ2h1biBMaW4gW+ael+elkOWQm10=?= <eleanor.lin@realtek.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"brgl@kernel.org" <brgl@kernel.org>, =?UTF-8?B?SmFtZXMgVGFpIFvmiLTlv5fls7Bd?= <james.tai@realtek.com>, 
	=?UTF-8?B?Q1lfSHVhbmdb6buD6Ymm5pmPXQ==?= <cy.huang@realtek.com>, 
	=?UTF-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= <stanley_chang@realtek.com>, 
	=?UTF-8?B?VFlfQ2hhbmdb5by15a2Q6YC4XQ==?= <tychang@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8168-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,linux-pwm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realtek.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 08E4A1B1250
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 10:30=E2=80=AFAM Yu-Chun Lin [=E6=9E=97=E7=A5=90=E5=
=90=9B]
<eleanor.lin@realtek.com> wrote:

> > > +      realtek,drive-strength-p:
> > > +        description: |
> > > +          Some of pins can be driven using the P-MOS and N-MOS
> > transistor to
> > > +          achieve finer adjustments.
> >
> > Finer compared to what? Compared to the overall setting for slew-rate o=
r
> > drive-strength, or both?
>
> It provides finer pad driving capability compared to the generic drive-st=
rength
> property. This property allows for higher resolution control.
(...)
> > > +      realtek,drive-strength-n:
> > > +        description: |
> > > +          Similar to the realtek,drive-strength-p, the
> > realtek,drive-strength-n
> > > +          is used to control the driving strength of the N-MOS outpu=
t.
> > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > +        minimum: 0
> > > +        maximum: 7
> >
> > These two are really interesting. But what do these settings represent?
> >
> > I would *guess* it represents the number of transistors used, simply, s=
o 0
> > means just one P/N transistor is driving and 7 means 8 transistors are =
driving.
> >
> > Can you provide details here?
> >
> > In this case, maybe we want a generalized property such as drive-stages=
-p =3D
> > <n>; drive-stages-n =3D <n>;
> >
> > in the generic bindings, if this will appear from more vendors?
> >
>
> These values are not a simple count of transistors (so 0 is not 1 transis=
tor).
>
> Instead, the 3-bit value represents like a weighted configuration. There =
is a base
> driving capability (even at value 0), and each bit adds a different weigh=
t to the
> total strength (e.g., Bit 0 adds a small weight, Bit 2 adds a larger weig=
ht).
>
> The resulting current is non-linear and also varies significantly based o=
n the IO
> voltage (1.8V vs 3.3V) and the specific pad group (e.g., eMMC vs SDIO).
>
> Given this complexity, I am not sure if this implementation is suitable f=
or a
> generic binding shared with other vendors.

Yes I agree. Fair enough! Add some of the above description to the
binding document for these two properties so it is clear what they
represent and keep them proprietary.

> > > +      realtek,duty-cycle:
> > > +        description: |
> > > +          An integer describing the level to adjust output duty cycl=
e,
> > > +          controlling the proportion of positive and negative wavefo=
rms
> > in
> > > +          nanoseconds.
> > > +          Valid arguments are described as below:
> > > +          0: 0ns
> > > +          2: + 0.25ns
> > > +          3: + 0.5ns
> > > +          4: -0.25ns
> > > +          5: -0.5ns
> > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > +        enum: [0, 2, 3, 4, 5]
> >
> > This is a bit dubious.
> >
> > Isn't this one of those cases where you should be using the PWM binding=
s,
> > directly in this node? Just slam in #pwm-cells =3D <...> etc, I think t=
his is what you
> > really want.
> >
> > Please consult/reference:
> > Documentation/devicetree/bindings/pwm/pwm.yaml
> > consumers would not use pinctrl phandles but something like pwms =3D
> > <&pwm ....>;
> >
> > It's maybe a bit trixy to use two generic bindings in the node but it s=
hould be
> > just fine.
> >
> > I don't feel confident mergeing this without Uwe Kleine-K=C3=B6nig's re=
view.
> >
>
> This hardware block is not a PWM generator. It does not generate a signal=
 with a
> specific frequency and duty ratio.
>
> Instead, it provides a fixed nanosecond-level adjustment to the rising/fa=
lling edges
> of an existing signal. It is used for Signal Integrity tuning (adding/sub=
tracting
> delay to fine-tune the high/low duration).
>
> To avoid confusion with PWM bindings, would you suggest a name like
> realtek,pulse-width-adjust?

Yes that sounds much better. Also copy the text above into the
binding making it clear what this custom property does.

> > > +      realtek,high-vil:
> > > +        type: boolean
> > > +        description: |
> > > +          Select the input receiver with a higher LOW recognition
> > threshold
> > > +          (VIL) to improve detection for sources with weak pull-down=
 or
> > slow
> > > +          falling edges.
> >
> > Isn't this supposed to be input-schmitt-microvolt?
> >
> > Or is this something else than a schmitt trigger?
> >
> > In either case, try to figure out the typical recognition threshold in =
microvolt
> > and use that, please.
>
> This is not a configuration for the Schmitt trigger hysteresis window, bu=
t rather
> a selection of the input low voltage level (VIL) to address a specific HD=
MI I2C
> compatibility issue.
>
> We have encountered some HDMI sinks (TVs) with weak pull-down capabilitie=
s.
> These devices fail to pull the I2C bus voltage below the standard VIL thr=
eshold
> (~0.7V), causing the SoC to fail to recognize the LOW state.
>
> This property enables a specialized input receiver mode that raises the e=
ffective
> VIL threshold to approximately 1.1V.
>
> The hardware design only supports these two discrete levels (Standard ~0.=
7V and
> High-VIL ~1.1V).
>
> Since the hardware acts as a discrete switch between these two levels, do=
 you prefer
> we replace this boolean with a value-based property,
> such as realtek,high-vil-microvolt =3D <1100000>?

Wow excellent description!

I understand it now and certainly this should be custom.

Also copy in the explanation into the binding document!

Yours,
Linus Walleij

