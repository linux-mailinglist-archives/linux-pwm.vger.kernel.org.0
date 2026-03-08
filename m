Return-Path: <linux-pwm+bounces-8211-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLXlCHjArWnq6wEAu9opvQ
	(envelope-from <linux-pwm+bounces-8211-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 08 Mar 2026 19:31:20 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B582231AAC
	for <lists+linux-pwm@lfdr.de>; Sun, 08 Mar 2026 19:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29AB9302BB8D
	for <lists+linux-pwm@lfdr.de>; Sun,  8 Mar 2026 18:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA8E395249;
	Sun,  8 Mar 2026 18:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGZ1YOW/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011B739448C;
	Sun,  8 Mar 2026 18:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772994532; cv=none; b=K5ST7bIVBl3FT6Q3Yr0wLQs2Iigraok8vt0L69RjkoB/B69KKOfRZYPidapo8Y/QOsKuyZ+rXra3yC/6On2Y7lBsRzUA+0vZtYL+COYWEdDZkT9qj6kk9NAsphcONClUvgqdZRcpQJrkPSglXadXJR0PAfn0E4c/BR0Okd46uBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772994532; c=relaxed/simple;
	bh=AbZ2VMFdeOP37VjLR8TQ3qomr0Qrf1mNdZHRI7FOsjI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZS7Y+YvgRWJTJlQTBGmEh7kYnSfUx9XdX4EZzliOcnI6C5w0ZyRlZsws0jroCEwsbe04aKSD3AL7Ij2b7qM8Uw07u2uCEjdbr1x01RKCMFVWeQySW18jSWWnrUIoSnSz9/GFdLex5ViUYFD/aI+AAPPN/5aeTo6dMfxeFZs8mBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGZ1YOW/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA070C2BC86;
	Sun,  8 Mar 2026 18:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772994531;
	bh=AbZ2VMFdeOP37VjLR8TQ3qomr0Qrf1mNdZHRI7FOsjI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MGZ1YOW/qsgNg0RzngBxjg0yJgjBa2R2LOujqjn8gWZCF8N/mJhxihLqusGTrTS8q
	 GBF7hjByYDc4KHMn9B7H6CEHV42+EJC5Gr7TM8GglPXHAhE//hnee2+cyVQ8JUJphc
	 I8B+rmylibYq/kNSRDvtYT9QNZKuvtDZd5uZrI5P0DWp8yGkuJzn+MeAlxIr1k5xsM
	 MNNuxeWn0cb/4n8L3/24uZGIPEoZivxkYVdZ+q0inBEhJVAFqwkd2n0BCxOHhcEY1O
	 K2tyYUReoieAsa3Ln/cWl5hQcfOVB+n4fKeEQElUIiZ/YglEcIWRbAL7GaA8sdI9+b
	 JTWIIUDyJy6Iw==
Date: Sun, 8 Mar 2026 18:28:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>, Radu Sabau via B4 Relay
 <devnull+radu.sabau.analog.com@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 "Sa, Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <ukleinek@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>, Bartosz
 Golaszewski <brgl@kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org"
 <linux-pwm@vger.kernel.org>, "linux-gpio@vger.kernel.org"
 <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: iio: adc: add bindings for AD4691
 family
Message-ID: <20260308182839.19587743@jic23-huawei>
In-Reply-To: <08717cd6-a732-4f06-a6f1-8cbdaa755b78@baylibre.com>
References: <20260305-ad4692-multichannel-sar-adc-driver-v1-0-336229a8dcc7@analog.com>
	<20260305-ad4692-multichannel-sar-adc-driver-v1-1-336229a8dcc7@analog.com>
	<20260305174559.1ded5173@jic23-huawei>
	<LV9PR03MB84149F32D4CABA4D2827D85BF77AA@LV9PR03MB8414.namprd03.prod.outlook.com>
	<08717cd6-a732-4f06-a6f1-8cbdaa755b78@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7B582231AAC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8211-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[analog.com,kernel.org,metafoo.de,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.988];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,radu.sabau.analog.com,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,analog.com:email]
X-Rspamd-Action: no action

On Sat, 7 Mar 2026 12:48:39 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 3/6/26 5:55 AM, Sabau, Radu bogdan wrote:
> >=20
> >  =20
> >> -----Original Message-----
> >> From: Jonathan Cameron <jic23@kernel.org>
> >> Sent: Thursday, March 5, 2026 7:46 PM
> >> To: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
> >> Cc: Sabau, Radu bogdan <Radu.Sabau@analog.com>; Lars-Peter Clausen <la=
rs@metafoo.de>; Hennerich, Michael
> >> <Michael.Hennerich@analog.com>; David Lechner <dlechner@baylibre.com>;=
 Sa, Nuno <Nuno.Sa@analog.com>; Andy Shevchenko
> >> <andy@kernel.org>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski =
<krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>;
> >> Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>; Liam Girdwood <lgirdwood@=
gmail.com>; Mark Brown <broonie@kernel.org>; Linus Walleij
> >> <linusw@kernel.org>; Bartosz Golaszewski <brgl@kernel.org>; linux-iio@=
vger.kernel.org; devicetree@vger.kernel.org; linux-
> >> kernel@vger.kernel.org; linux-pwm@vger.kernel.org; linux-gpio@vger.ker=
nel.org
> >> Subject: Re: [PATCH 1/4] dt-bindings: iio: adc: add bindings for AD469=
1 family
> >>
> >> [External]
> >>
> >> On Thu, 05 Mar 2026 14:23:27 +0200
> >> Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org> wro=
te:
> >> =20
> >>> From: Radu Sabau <radu.sabau@analog.com>
> >>>
> >>> Add YAML bindings and dt-bindings header for the Analog Devices AD4691
> >>> family of multichannel SAR ADCs (AD4691, AD4692, AD4693, AD4694).
> >>>
> >>> The binding describes five operating modes selectable via the
> >>> adi,spi-mode property, optional PWM/clock for CNV Clock and CNV Burst
> >>> modes, GPIO pins, voltage supplies and the trigger-source interface f=
or
> >>> SPI Engine offload operation.
> >>>
> >>> Signed-off-by: Radu Sabau <radu.sabau@analog.com> =20
> >>
> >> Hi Radu, I'm going to focus on mode... Mostly because things called
> >> mode are usually a sign of mixing up different aspects of the board
> >> design...
> >> =20
> > Hi Jonathan, Krysztof,
> >=20
> > Thank you guys so much for your review.
> >=20
> > Regarding 'mode', I agree that it should be something that could be mod=
ified
> > at run-time, especially since all register modes (CNV_CLOCK, CNV_BURST,
> > AUTONOMOUS and SPI_BURST) rely on the same principles of reading the
> > ADC result from the registers, the main difference being that PWM on the
> > CNV pin is required for CNV_CLOCK and CNV_BURST, but the board design
> > stays the same. Perhaps this PWM can be initialized at start-time and o=
nly
> > be used when CNV modes are being used. This would mean mode can
> > become an IIO attribute that could be set by the user at run-time. =20
>=20
> More likely, it would be two different ways of doing a buffered read,
> so maybe two different buffers? Or just pick the "best" one and only
> implement that mode.

I 'think' burst mode is really an oversampling thing as you read back from
either the output of an averaging filter or an accumulator.=20
I doubt there is reason to support both the oversampled and raw
readings at the same time.

>=20
> >=20
> > However for MANUAL, modifications of jumper resistors on the physical
> > board is required for proper functionality, since the CNV pin needs to =
be
> > tied to CS in this mode. Would it be preferred if bindings would have a
> > 'register-mode' attribute (the name could be better) which can have val=
ues
> > like 1(register modes are used) and 1(manual mode is used), and for
> > register modes, have a global IIO attribute that can switch between
> > them?
> >  =20
>=20
> The binding should describe how the chip is wired up. So rather than thin=
king
> about modes, try thinking in terms of connections. Based on what the devi=
cetree
> says is connected, the driver can then infer which modes are actually pos=
sible.
>=20
> Bringing back some context that was trimmed:
>=20
> +  adi,spi-mode:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3, 4]
> +    description: |
> +      Selects the ADC operating mode:
> +        0 - CNV Clock Mode: External PWM drives CNV pin, samples at PWM =
rate.
> +        1 - CNV Burst Mode: PWM triggers burst cycles, internal oscillat=
or
> +            drives conversions within each burst.
> +        2 - Autonomous Mode: Internal oscillator drives conversions, sof=
tware
> +            starts/stops via register write.
> +        3 - SPI Burst Mode: Similar to Autonomous Mode but optimized for
> +            SPI burst reads.
> +        4 - Manual Mode: CNV is directly tied to SPI CS. Each SPI transf=
er
> +            triggers a conversion and returns previous result (pipelined=
).
>=20
>=20
> It sounds like there are 3 ways that the CNV pin could be wired up:
>=20
> 1. Wired to PWM
> 2. Not connected
> 3. Wired to CS
>=20
> On some other chips we've seen where CNV could be wired up different ways,
> "not connected" was not an option. In those cases, we could infer that if
> that no other properties indicated what CNV was connected to, then we wou=
ld
> assume CNV was connected to SPI CS.
>=20
> In this case, if "not connected" is an option, we might need a bool/flag
> property adi,cnv-is-cs to describe that the CNV pin is wired to the CS pi=
n.
> And we already have the pwms property to know when CNV is connected to a
> PWM.
>=20
>=20
> > Please let me know your thoughts on this before addressing the other
> > Comments and preparing other patches.
> >=20
> > Best regards,
> > Radu
> >  =20


