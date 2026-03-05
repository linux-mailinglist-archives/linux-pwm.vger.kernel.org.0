Return-Path: <linux-pwm+bounces-8191-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFTUETzEqWm2EQEAu9opvQ
	(envelope-from <linux-pwm+bounces-8191-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 05 Mar 2026 18:58:20 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F0C216A8D
	for <lists+linux-pwm@lfdr.de>; Thu, 05 Mar 2026 18:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C036031C4F7B
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Mar 2026 17:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DBC3E5EF7;
	Thu,  5 Mar 2026 17:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dm/amFbO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18A626FDBF;
	Thu,  5 Mar 2026 17:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772732771; cv=none; b=fmC3qhbxn88n8FLGfWC0gBSM+/fLgetGFNiBK20LvE4Cn8AAQ4NXACBeGHqUB1JyVEvx0IP4cWw4W01G/MauUWjml3mKQiMNqka3bJTjNiKJIm4g2vVyBIEZwUCuWP9d2VVIMcvOFesvDQJSu/3eZbxe5K4fYu+1p4Jb/t7X0a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772732771; c=relaxed/simple;
	bh=2HAVcfpUtCyECaW0rvig9lyxyuv7rVKUEqPEYkLuDeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MTWo81PXXlAktG4Om7bcgyGUY6VsemIEtgOJG45F+hKYuoLC1v+FY2E/jjHZYLj8jRZpV4scPphWIj95yEVfPDrmYkFZhKYJPIJaDwfgW/u+dFAEGDydWUwG8x37hr1UxiXKS/lFuFiBdgmxVjaQA6O6CSiO3Ji4yKrDCgnCuxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dm/amFbO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C0BC2BCB2;
	Thu,  5 Mar 2026 17:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772732771;
	bh=2HAVcfpUtCyECaW0rvig9lyxyuv7rVKUEqPEYkLuDeQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Dm/amFbOJ28V2MKhtPq1e11XjQ+YEsGi+ex48RrYXrHoNGSB21AxQ3UtXo3lVy7/z
	 jOIM5/tcCzKOLyXvclKL/YL7NhopROcd5yC5LNtUQhGTq+QYBnSqIsXxqEvtbAteDK
	 oxwqReiny+F82V7Rk3Iz9/17jArPdhPYsqW+ITwEYr5EaZma4VvFLuAWu4qpgsx9vT
	 pcfajjM+w8EST9+SC8RY54mbMdl+etKmyJyRAK9yHU0R+YZg6zWczUUINW7pm0K0ec
	 H1zicn1/1UjmIBY1h2xlz8oHUh0qy1S/M+MxoT/IPu89xOg3B728jPvMsMOK1cQNrx
	 N7JZoLxFr+2Mg==
Date: Thu, 5 Mar 2026 17:45:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Linus Walleij
 <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-gpio@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: iio: adc: add bindings for AD4691
 family
Message-ID: <20260305174559.1ded5173@jic23-huawei>
In-Reply-To: <20260305-ad4692-multichannel-sar-adc-driver-v1-1-336229a8dcc7@analog.com>
References: <20260305-ad4692-multichannel-sar-adc-driver-v1-0-336229a8dcc7@analog.com>
	<20260305-ad4692-multichannel-sar-adc-driver-v1-1-336229a8dcc7@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A5F0C216A8D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8191-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[analog.com,metafoo.de,baylibre.com,kernel.org,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,radu.sabau.analog.com,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, 05 Mar 2026 14:23:27 +0200
Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org> wrote:

> From: Radu Sabau <radu.sabau@analog.com>
> 
> Add YAML bindings and dt-bindings header for the Analog Devices AD4691
> family of multichannel SAR ADCs (AD4691, AD4692, AD4693, AD4694).
> 
> The binding describes five operating modes selectable via the
> adi,spi-mode property, optional PWM/clock for CNV Clock and CNV Burst
> modes, GPIO pins, voltage supplies and the trigger-source interface for
> SPI Engine offload operation.
> 
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>

Hi Radu, I'm going to focus on mode... Mostly because things called
mode are usually a sign of mixing up different aspects of the board
design...


> +
> +  adi,spi-mode:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3, 4]
> +    description: |
> +      Selects the ADC operating mode:
> +        0 - CNV Clock Mode: External PWM drives CNV pin, samples at PWM rate.
> +        1 - CNV Burst Mode: PWM triggers burst cycles, internal oscillator
> +            drives conversions within each burst.
> +        2 - Autonomous Mode: Internal oscillator drives conversions, software
> +            starts/stops via register write.
> +        3 - SPI Burst Mode: Similar to Autonomous Mode but optimized for
> +            SPI burst reads.
> +        4 - Manual Mode: CNV is directly tied to SPI CS. Each SPI transfer
> +            triggers a conversion and returns previous result (pipelined).
Which of these are wiring related?

0 and 1 need a PWM wired up.  So describe a PWM. If there is one we need
to figure which we want so indication provided by userspace.

2 and 3 don't need anything beyond bus.

4 probably does need a binding but that's about whether that wire connection
is there or not.

> +
> +  vio-supply:
> +    description: I/O voltage supply (1.71V to 1.89V or VDD).
> +
> +  vref-supply:
> +    description:
> +      External reference voltage supply (2.4V to 5.25V). Mutually exclusive
> +      with vrefin-supply.

Enforce that via a rule as you do below. No need to document it here as well.

> +
> +  vrefin-supply:
> +    description:
> +      Internal reference buffer input supply. Mutually exclusive with
> +      vref-supply.


> +
> +  # AD4694 (20-bit) does not support Manual Mode

That's a driver thing. Not something we want in the binding.

> +  - if:
> +      properties:
> +        compatible:
> +          const: adi,ad4694
> +    then:
> +      properties:
> +        adi,spi-mode:
> +          enum: [0, 1, 2, 3]
> +
> +  # CNV Clock Mode and CNV Burst Mode require PWM and clock
> +  - if:
> +      properties:
> +        adi,spi-mode:
> +          enum: [0, 1]

This is backwards. Define these as optional properties and use that to
limit what the driver can offer as ways it can run. Maybe they
only make sense together in which case add that rule.


> +    then:
> +      required:
> +        - clocks
> +        - clock-names
> +        - pwms
> +        - pwm-names
> +
> +  # Non-Manual modes (0-3) without SPI offload require a DRDY interrupt.
> +  # Offload configurations expose '#trigger-source-cells' instead.
> +  - if:
> +      properties:
> +        adi,spi-mode:
> +          enum: [0, 1, 2, 3]
> +      not:
> +        required:
> +          - '#trigger-source-cells'
> +    then:
> +      required:
> +        - interrupts
> +        - interrupt-names
> +
>

