Return-Path: <linux-pwm+bounces-8005-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KD25GBcDemku1gEAu9opvQ
	(envelope-from <linux-pwm+bounces-8005-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Jan 2026 13:37:43 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE245A1576
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Jan 2026 13:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D62C302D5F3
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Jan 2026 12:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1222D2EA151;
	Wed, 28 Jan 2026 12:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1YyseJn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1112290D81
	for <linux-pwm@vger.kernel.org>; Wed, 28 Jan 2026 12:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769603592; cv=none; b=fzovczxu3HFudgwJKpw1luHFL5k4TEI3rcs6OOqBqfJRHMCjLxZYYOmcffHpM0+juaP59v3+FrLfKf4iTar7ksI+nm5z5KxDdHVqHBtsi+KFL/OiArzIkYcL5ht/MR9v2uUofTzOM0m/Y0ChBC9/Cc+cY7iP9Tks7yL7U+eTae8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769603592; c=relaxed/simple;
	bh=jmuMIS9wtX/dZfFDJahTmMCs3yg9HN6+ZtD9s0KTwRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rOQ0UXaLSRI79qKxX/p2AnqoB2ubPPtixiWNSsI4B8y4JhGxYG4ndkeA4M6HSqma7r6JDIUmji9xT6IiBO9hWqq1SIWuXrTT/6DmWRQcc62a82RMDIpBW52WPhETpO/JtTjK+p5LRwPduRg4psJGd6qVbvexaB9KzZ5yuxicRFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1YyseJn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF0FC4CEF1
	for <linux-pwm@vger.kernel.org>; Wed, 28 Jan 2026 12:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769603591;
	bh=jmuMIS9wtX/dZfFDJahTmMCs3yg9HN6+ZtD9s0KTwRs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=G1YyseJny3uvkryklZtQjbMt1Vz+oheZYebYiLCFR+FO9avv4ER7I6vpsW4VEQLDk
	 K04NBuyTqEstOr5DioJ9zLZJw8Jbm5WEhbYNNf1hZih5Q5EOBrCusQIIhropu2YPB8
	 TnEbIY/uXU9ZA6BWJsnheRNxRi6JsN9S4ZJH3oP8Tnyeu52AmtngGmjMR8YcmoGfG2
	 fPeMoITbsKrnvcz78b3YqIA2dUPMDCOl8Eku8xOOhe27hwUvRyyV3WqaQTo2mYu7ET
	 jMYbEiCHL5eqZglXUzNhV+Pfpz9yAPN+yXeNuVhhzSZ6gzedw6GY7oNv2NUe3rC4xd
	 FcdJkuKxrMY4Q==
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6446c924f9eso5920985d50.1
        for <linux-pwm@vger.kernel.org>; Wed, 28 Jan 2026 04:33:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXeG151G92iSQWOOkPp22Okr2kjh9/TYhc7twP4JEtqZMG0osYiG9peXHlqkwH/GOk54RzBzzDORvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzgALKZEsL33e6T4sx/M8c4yU1yJ8/wDtIodVyzMAxEb1/7euu
	FDdrWyWnCFlZcgIWQs0SBA5QlLyRr1jeicjv9uByzeRO2rcSaw6sMDftgTgKoIGRKxTtxn022eN
	CuOzqPhjcoAxa+nWB2zxpiX3EaJcwFmM=
X-Received: by 2002:a05:690e:1918:b0:649:4f65:bff9 with SMTP id
 956f58d0204a3-6498fbf9856mr3287591d50.42.1769603590902; Wed, 28 Jan 2026
 04:33:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128033936.27642-1-eleanor.lin@realtek.com> <20260128033936.27642-6-eleanor.lin@realtek.com>
In-Reply-To: <20260128033936.27642-6-eleanor.lin@realtek.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 28 Jan 2026 13:33:00 +0100
X-Gmail-Original-Message-ID: <CAD++jL=445wx467ZKE3-qm_BaVzKYXE-7zmReTFZA0KUAaSNyw@mail.gmail.com>
X-Gm-Features: AZwV_QgfOnd-isQn6MnRkv3cGqrLlmsh0nRuYAlXYLsiWZlNo-_cZBDGdLVdJVw
Message-ID: <CAD++jL=445wx467ZKE3-qm_BaVzKYXE-7zmReTFZA0KUAaSNyw@mail.gmail.com>
Subject: Re: [PATCH 5/8] dt-bindings: pinctrl: realtek: add RTD1625 pinctrl binding
To: Yu-Chun Lin <eleanor.lin@realtek.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-pwm@vger.kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, brgl@kernel.org, 
	james.tai@realtek.com, cy.huang@realtek.com, stanley_chang@realtek.com, 
	tychang@realtek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-8005-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,linux-pwm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: AE245A1576
X-Rspamd-Action: no action

Hi Yu-Chun,

thanks for your patch!

[Uwe, can you check this a bit down!]

On Wed, Jan 28, 2026 at 4:39=E2=80=AFAM Yu-Chun Lin <eleanor.lin@realtek.co=
m> wrote:

> From: Tzuyi Chang <tychang@realtek.com>
>
> Add device tree bindings for RTD1625.
>
> Signed-off-by: Tzuyi Chang <tychang@realtek.com>
> Co-developed-by: Yu-Chun Lin <eleanor.lin@realtek.com>
> Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>

Overall this looks good!

> +      power-source:
> +        description: |
> +          Valid arguments are described as below:
> +          0: power supply of 1.8V
> +          1: power supply of 3.3V
> +        enum: [0, 1]

OK...

> +      slew-rate:
> +        description: |
> +          Valid arguments are described as below:
> +            0: ~1ns falling time
> +            1: ~10ns falling time
> +            2: ~20ns falling time
> +            3: ~30ns falling time
> +        enum: [0, 1, 2, 3]

Slew rate is usually something like volts/second in SI units, I would
expect that this differs depending on which power-source is selected?
I.e. are these values for 1.8V or 3.3V?

> +      realtek,drive-strength-p:
> +        description: |
> +          Some of pins can be driven using the P-MOS and N-MOS transisto=
r to
> +          achieve finer adjustments.

Finer compared to what? Compared to the overall setting for slew-rate or
drive-strength, or both?

> The block-diagram representation is as
> +          follows:
> +                         VDD
> +                          |
> +                      ||--+
> +               +-----o||     P-MOS-FET
> +               |      ||--+
> +          IN --+          +----- out
> +               |      ||--+
> +               +------||     N-MOS-FET
> +                      ||--+
> +                          |
> +                         GND

Nice picture!

> +          The driving strength of the P-MOS/N-MOS transistors impacts th=
e
> +          waveform's rise/fall times. Greater driving strength results i=
n
> +          shorter rise/fall times. Each P-MOS and N-MOS transistor offer=
s
> +          8 configurable levels (0 to 7), with higher values indicating
> +          greater driving strength, contributing to achieving the desire=
d
> +          speed.
> +
> +          The realtek,drive-strength-p is used to control the driving st=
rength
> +          of the P-MOS output.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 7
> +
> +      realtek,drive-strength-n:
> +        description: |
> +          Similar to the realtek,drive-strength-p, the realtek,drive-str=
ength-n
> +          is used to control the driving strength of the N-MOS output.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 7

These two are really interesting. But what do these settings represent?

I would *guess* it represents the number of transistors used, simply,
so 0 means just one P/N transistor is driving and 7 means 8 transistors
are driving.

Can you provide details here?

In this case, maybe we want a generalized property such as
drive-stages-p =3D <n>;
drive-stages-n =3D <n>;

in the generic bindings, if this will appear from more vendors?

> +      realtek,duty-cycle:
> +        description: |
> +          An integer describing the level to adjust output duty cycle,
> +          controlling the proportion of positive and negative waveforms =
in
> +          nanoseconds.
> +          Valid arguments are described as below:
> +          0: 0ns
> +          2: + 0.25ns
> +          3: + 0.5ns
> +          4: -0.25ns
> +          5: -0.5ns
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 2, 3, 4, 5]

This is a bit dubious.

Isn't this one of those cases where you should be using the PWM
bindings, directly in this node? Just slam in #pwm-cells =3D <...> etc,
I think this is what you really want.

Please consult/reference:
Documentation/devicetree/bindings/pwm/pwm.yaml
consumers would not use pinctrl phandles but something like
pwms =3D <&pwm ....>;

It's maybe a bit trixy to use two generic bindings in the
node but it should be just fine.

I don't feel confident mergeing this without Uwe Kleine-K=C3=B6nig's review=
.

> +      realtek,input-voltage:
> +        description: |
> +          Select the input receiver voltage domain for the pin (1.8V or =
3.3V).
> +          This defines the reference for VIH/VIL and must match the exte=
rnal
> +          signal level.
> +
> +          This does not control the output drive voltage, which is handl=
ed by
> +          the standard generic 'power-source' property.
> +
> +          Valid arguments are described as below:
> +          0: 1.8V input logic level
> +          1: 3.3V input logic level
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1]

This looks very generic. Can you please just add input-voltage to
pincfg-node.yaml with a custom format and reference that?

> +      realtek,high-vil:
> +        type: boolean
> +        description: |
> +          Select the input receiver with a higher LOW recognition thresh=
old
> +          (VIL) to improve detection for sources with weak pull-down or =
slow
> +          falling edges.

Isn't this supposed to be input-schmitt-microvolt?

Or is this something else than a schmitt trigger?

In either case, try to figure out the typical recognition threshold in micr=
ovolt
and use that, please.

Yours,
Linus Walleij

