Return-Path: <linux-pwm+bounces-7100-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9473B2C797
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Aug 2025 16:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66D741BC322D
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Aug 2025 14:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5958627F18F;
	Tue, 19 Aug 2025 14:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdzC9lTx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE1321772D;
	Tue, 19 Aug 2025 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755615074; cv=none; b=roSGSQ7Nmkq556rsHpFIaw7vETOslsIbAR7hmWj2Fa8oACsWeRARHBV6w/sHJr80zkjDuPeQonx2qOme36YkZhHLQbYyQK8c1j4BErGXRIecneGCfmjP+u1HPG15srlm4E1m6Lx+yLsoIqXRpoKsNVLGrcYhmzbHnY4S1vDuRi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755615074; c=relaxed/simple;
	bh=eKOwK0qY0XlIYHG/mfv6JRGT834tGvbpGugdoJwXfiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XwJS/bUCRfST0w9SjKUZXWc7naqayJ1tYAzk5o7knUxNVAgm4Ycdti2y5thh6e7+jeferJKzcQvWeIT1DikL4R+b/rOCjYishrnwOF2KkmISlgoXY29F1Dvjb63LgTeoQfrB1sm9b6Ii715Yer4Jap0Ffd8m4suYiTD7AWh1iJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdzC9lTx; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-32326de9f4eso4716286a91.2;
        Tue, 19 Aug 2025 07:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755615072; x=1756219872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84JBC/K4prfKTVHBWmcQiE2Ae580xZlTp9zQ8TNTSNA=;
        b=XdzC9lTxcPRY7N+Kabkp7vSPBem3WSlSNOEshPU6GORd84T7ObUDPJQbzgEytlWIpZ
         b8EAwnVXR7bGkffTMlkb8tztOUw5qDAXsr/+VcU2wwyw7u2dbbtEnH3bR36RyK0WdZa8
         N+fOxO1iViF9QOPFQZe9iyYHXmcWtrA4+CenTC2/qnIYkJlqK0z/QUF6Itr5VggV378M
         FezOun4VLyRTIP19W3VHpcOAbVZXSp68ZbqxHhhBMwCSf1JyvjV+zSEtBFxnXRFFOs0I
         Y6xX9bOdGRmpVcv+dZWzQJV6YZY/BPWga+KsXXvML0q30Pa+FT7pRk7/bt/zoJmY5UfD
         OOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755615072; x=1756219872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=84JBC/K4prfKTVHBWmcQiE2Ae580xZlTp9zQ8TNTSNA=;
        b=PrW47UPbb+4uCfby/Km8RJ/8e4Jj25Ns0KsJiV5bTFlqlJAE+6VD7wyrhf+5ZiMejs
         ah6sw9tjx2bMwTYWUpnSZzE1kZmiVSRm6OSh91/MbB67iackG49WT5wkTap6YSvNUlvP
         +YCTUeVA2qinrPK9NZr1c8fIO2+nnTptyrOTetOp11geFoMYZmG6PH4KTJPiEEIrJdj2
         NBsHhs6dR1tpVlX12JpOFfDEud/pNTDJbvN9Vr+wEDU0t4MM6Yqrx60fbOXY3rmOxR/i
         BEe7S5/BPPa18Oc1Fb/7PUKqElKl/jhSggrovo4g+V6mpsV22TmITAkBiMlpvAjZClzO
         yLzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8F+0vySOpamRbWB4WbZtvAx0RUfP1tNdKcW4fd8NHoWzZGKpr3SRTCw/dlFDO3VnQ2BnHgPrZK9vm@vger.kernel.org, AJvYcCUMNPxlV51SSjs6jpID71dv2sq22lHK+zojmLiEdp3VqvstDlFzfpNJmTghlt+/sQIBSmjUzGREQCGG@vger.kernel.org, AJvYcCUXjKHFQxEh5Ry5NN6Evab2oE/TbrELeRdyihiPyMZ7AMrRLfFd349m/5SGz3OpiFBMjmD0geX5xM7hTg==@vger.kernel.org, AJvYcCUYVY3KNv8qU+LxsO3Vx8e+1n6w5FCpbW+WcQv0TSi6cPInA35WEAaFYG+D3aNf4v2f7G+P6pSfNkXYFZk=@vger.kernel.org, AJvYcCUqPgxIZK/i5BDL1sVPFnK5nVPL16xgGmw4cbngadDHXr5mbkM/90CQvALt175V/rdFVI22PdKeplr2@vger.kernel.org, AJvYcCWlwrj5HW9N/eGnok0i4T6KZGSgVF9VWVDMPWUd57SRxXN7GMA34DG2JEG3rlepwcTMu/aZirJJHhrLPLI=@vger.kernel.org, AJvYcCXscHSGQ+VNKQ1wVg11zKwO8hdefrj1pMJF2qdXJzjU/NFjoAhPvsKZcrupM1IUnrWHIHh9oDFMeDu59g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdpbGzsX4148l3IfsL/y1j+4+/bAyR9TN6H/HT7ST+UnL5m4E9
	P+3OuIINNQiuecbqVsllY45dk9xArQu3mertCZk8rxRTitkC7Z7VYBq1cRq8hVBYJCLgcSTvtFJ
	sEN0/h+i4XRH44/LLOoLL3o0k50da2w==
X-Gm-Gg: ASbGnctYsyNVABx2OZB/+S+40W7KAvM/mNaFjqaGC0p0d1Jjw8BCTuvpR4UUNMsEA1F
	BZYtqdRvQU9iKar9ahHJl3r5m5HhRLi4AWzFZMczblUSW2LymVG3jODtWqPcyRpyO5YQAZORFq0
	Wo8nScz5QHYa8sVQpjF02ZNoJerNDBEmMXEqCEWRuDGPmrX251YY0qOVyQOSmtl/RYEP5U6baHW
	A92Faw=
X-Google-Smtp-Source: AGHT+IGFX3Kpa1nizieMl3Ixu9nhO8VijjVmgDz/D33VTEV/CrtZhkKtRMf84sQy3fytu82eKOQOb3mHib8daIX2DhE=
X-Received: by 2002:a17:90b:134e:b0:311:df4b:4b7a with SMTP id
 98e67ed59e1d1-32497102910mr3896605a91.29.1755615071705; Tue, 19 Aug 2025
 07:51:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250816021523.167049-1-jihed.chaibi.dev@gmail.com>
 <20250816021523.167049-2-jihed.chaibi.dev@gmail.com> <20250819-humongous-muscular-curassow-5accd5@kuoka>
In-Reply-To: <20250819-humongous-muscular-curassow-5accd5@kuoka>
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Date: Tue, 19 Aug 2025 16:51:00 +0200
X-Gm-Features: Ac12FXwysxyGsjAabyXw5_P1WV9yLN_7McwriOwmRdAXImPNCo-sOD4JlUKkl3s
Message-ID: <CANBuOYr9Kmj7n664CSRuORKfxx70w+DHzO5kToyBnHyBv0SjNg@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: mfd: twl: Add missing sub-nodes for
 TWL4030 & TWL603x
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, andreas@kemnade.info, 
	peter.ujfalusi@gmail.com, dmitry.torokhov@gmail.com, robh@kernel.org, 
	krzk+dt@kernel.org, lgirdwood@gmail.com, tiwai@suse.com, conor+dt@kernel.org, 
	lee@kernel.org, ukleinek@kernel.org, broonie@kernel.org, 
	gregkh@linuxfoundation.org, linus.walleij@linaro.org, brgl@bgdev.pl, 
	aaro.koskinen@iki.fi, khilman@baylibre.com, rogerq@kernel.org, 
	tony@atomide.com, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-omap@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 10:13=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On Sat, Aug 16, 2025 at 04:15:18AM +0200, Jihed Chaibi wrote:
> > Update the TI TWL family Device Tree binding to include additional
> > subnodes for TWL4030, TWL6030, and TWL6032 devices.
> >
> > The simple power and PWM bindings (ti,twl4030-power, ti,twl-pwm, and
> > ti,twl-pwmled) are now defined directly within this binding.
> >
> > Other child node definitions (audio, gpio, keypad, usb, etc.) are also
> > added to the schema. These additions fix 'unevaluated properties'
> > errors found during dtbs_check for boards like the omap3-beagle
> > and improve the binding's overall completeness.
> >
> > Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
> >
> > ---
> > Changes in v3:
> >  - New patch to consolidate simple bindings (power, pwm) and add
> >    definitions for all child nodes to fix dtbs_check validation
> >    errors found in v2.
> > ---
> >  .../devicetree/bindings/mfd/ti,twl.yaml       | 191 ++++++++++++++++++
> >  .../devicetree/bindings/mfd/twl4030-power.txt |  48 -----
> >  .../devicetree/bindings/pwm/ti,twl-pwm.txt    |  17 --
> >  .../devicetree/bindings/pwm/ti,twl-pwmled.txt |  17 --
> >  4 files changed, 191 insertions(+), 82 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/mfd/twl4030-power=
.txt
> >  delete mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwm.tx=
t
> >  delete mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwmled=
.txt
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/ti,twl.yaml b/Docume=
ntation/devicetree/bindings/mfd/ti,twl.yaml
> > index f162ab60c..b0f1cb7b5 100644
> > --- a/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> > @@ -76,6 +76,98 @@ allOf:
> >            properties:
> >              compatible:
> >                const: ti,twl4030-wdt
> > +
> > +        audio:
> > +          type: object
> > +          $ref: /schemas/sound/ti,twl4030-audio.yaml#
> > +          unevaluatedProperties: false
> > +
> > +        keypad:
> > +          type: object
> > +          $ref: /schemas/input/ti,twl4030-keypad.yaml#
> > +          unevaluatedProperties: false
> > +
> > +        pwm:
> > +          type: object
> > +          $ref: /schemas/pwm/pwm.yaml#
> > +          unevaluatedProperties: false
> > +          description: |
> > +            TWL4030 series: PWMA and PWMB (connected to LEDA and LEDB =
terminals)
> > +          properties:
> > +            compatible:
> > +              enum:
> > +                - ti,twl4030-pwm
> > +            '#pwm-cells':
> > +              const: 2
> > +          required:
> > +            - compatible
> > +            - '#pwm-cells'
> > +
> > +        pwmled:
> > +          type: object
> > +          $ref: /schemas/pwm/pwm.yaml#
> > +          unevaluatedProperties: false
> > +          description: |
> > +            TWL4030 series: PWMA and PWMB (connected to LEDA and LEDB =
terminals)
> > +          properties:
> > +            compatible:
> > +              enum:
> > +                - ti,twl4030-pwmled
> > +            '#pwm-cells':
> > +              const: 2
> > +          required:
> > +            - compatible
> > +            - '#pwm-cells'
> > +
> > +        'twl4030-usb':
>
> No need for quotes.
>
> > +          type: object
> > +          $ref: /schemas/usb/ti,twlxxxx-usb.yaml#
>
> Are you sure your patchset is bsiectable? Apply this patch and test. You
> will see errors and you must fix these. Even after fixing you have
> strict dependencies so your cover letter must explain these (or merging
> constraints)...
>
> I suggest listing here only compatible with additionalProperties:true
> and splitting entire patchset per different maintainers.

Hi Krzysztof,

Thank you for the review. That additionalProperties
suggestion is definitely helpful in this scenario.

I will split (in v4) the patchset into smaller & independent
series for each subsystem as recommended.

Thanks again for your guidance.
Jihed

