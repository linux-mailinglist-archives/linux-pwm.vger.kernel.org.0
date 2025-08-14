Return-Path: <linux-pwm+bounces-7058-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA22B26911
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 16:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E05EE7BA727
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 14:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECC2194C75;
	Thu, 14 Aug 2025 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="sLESdke4"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DE5321425;
	Thu, 14 Aug 2025 14:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755181348; cv=none; b=DEsU8OkCYoLDVxszHoNgmI0tDj8EMWh2gOHPcAsZ9pPX/bEh6XFnr123y03uCal0vboxon6tEzoR3QCjUxSZFAJTcPxh2i6LtsLY6eBOB07bEQX1KHNGXOPJc8vaqaKhqwR6nBQV6ExJZqYHhi97e9Z9lqHuXPqS9LwMu3EQQqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755181348; c=relaxed/simple;
	bh=/XNYpGekW5FTkck9vkxbycrYIDktpqRjcH0lEJ1R/bY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qSecMYCW5yNDSGc2AKTSvCXJYzIgcseIT3viuoTJszkLEgCFRRhPBG4jYHNtGmZlCVIUzsqfPNjcOJUCc+aqp89BVlnlgGjix2BUq5YdrBV9YWQsLROIGYiOUCIoeorbFL3Eua2DkXBRFq5OWma5aPpXbMI0n5UWpzYoRqq9YQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=sLESdke4; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=yBVHQGnzgNju8paCixuYP7SJ47LWZfp4e7tehQ9v+jU=; b=sLESdke4jcvzMSZyS2XuOK9j0f
	LGePkEsEt9Gyie3xmH0z39G50LcNZwydVway9tZtd7tHGKzNbSxYnpYROrUTNdfVCs4+H9/x0lnHl
	dthaY+JBajtTijeiE3BfVeAI+NnMxVXml7Cu8nvSqbZsIjLqxRDolPjCAG3I90PQSNClmekFN4n+X
	eILTr2tQRYXei9nFktUA9AWkoAlu6Y4dgyuxeqacJkHmTklLT4Qfui1HESI2HAKLFblz6fMwmOxxu
	OR7Y4aEcqokM6v788Ka6Hbe4YmGN/QmQXpKL/xUHChlDIKT4PNUOSoo1slPiCKjDBMZ1V2ONoN4oG
	qslh++qA==;
Date: Thu, 14 Aug 2025 16:22:22 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: linux-kernel@vger.kernel.org, peter.ujfalusi@gmail.com,
 dmitry.torokhov@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 lgirdwood@gmail.com, tiwai@suse.com, conor+dt@kernel.org, lee@kernel.org,
 ukleinek@kernel.org, broonie@kernel.org, gregkh@linuxfoundation.org,
 linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-usb@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v2 9/9] dt-bindings: mfd: twl: Add missing sub-nodes for
 TWL4030 & TWL603x
Message-ID: <20250814162222.4173e3e8@akair>
In-Reply-To: <20250814132129.138943-10-jihed.chaibi.dev@gmail.com>
References: <20250814132129.138943-1-jihed.chaibi.dev@gmail.com>
	<20250814132129.138943-10-jihed.chaibi.dev@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Am Thu, 14 Aug 2025 15:21:29 +0200
schrieb Jihed Chaibi <jihed.chaibi.dev@gmail.com>:

> Update the TI TWL family Device Tree binding to include additional
> subnodes for TWL4030, TWL6030, and TWL6032 devices.
> 
> This patch enhances the schema by adding support for audio, GPIO, power,
> keypad, PWM, PWM LED, and USB subnodes, referencing their respective YAML
> schemas where applicable. These additions improve the schema's
> completeness, enabling better validation and documentation of the
> TWL multi-function device's capabilities.
> 
> The changes ensure proper handling of TWL4030-specific features (audio,
> keypad, PWM, PWM LED, USB, GPIO, and power) and TWL6030/TWL6032-specific
> features (PWM, PWM LED, and USB), with appropriate schema references to
> prevent unevaluated properties.
> 
> Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
> ---
>  .../devicetree/bindings/mfd/ti,twl.yaml       | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,twl.yaml b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> index f162ab60c..81f9d8f72 100644
> --- a/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> +++ b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> @@ -76,6 +76,38 @@ allOf:
>            properties:
>              compatible:
>                const: ti,twl4030-wdt
> +
> +        audio:
> +          type: object
> +          $ref: /schemas/sound/ti,twl4030-audio.yaml#
> +          unevaluatedProperties: false
> +
> +        keypad:
> +          type: object
> +          $ref: /schemas/input/ti,twl4030-keypad.yaml#
> +          unevaluatedProperties: false
> +
> +        pwm:
> +          type: object
> +          $ref: /schemas/pwm/ti,twl-pwm.yaml#
> +          unevaluatedProperties: false
> +
> +        pwmled:
> +          type: object
> +          $ref: /schemas/pwm/ti,twl-pwmled.yaml#
> +          unevaluatedProperties: false
> +
I think the pwm stuff is so simple, that it can go in here directly.

> +        'twl4030-usb':
> +          type: object
> +          $ref: /schemas/usb/ti,twlxxxx-usb.yaml#
> +          unevaluatedProperties: false
> +
> +        gpio:
> +          type: object
> +
$ref it to restrict compatibles.

> +        power:
> +          type: object
> +
just list the compatibles allowed here.


Regards,
Andreas

