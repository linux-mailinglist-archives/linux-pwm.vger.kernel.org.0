Return-Path: <linux-pwm+bounces-156-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D6D7F51DB
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Nov 2023 21:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4552814F7
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Nov 2023 20:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C928A1643E;
	Wed, 22 Nov 2023 20:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTZKN5o8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F231A587;
	Wed, 22 Nov 2023 20:47:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE42C433C7;
	Wed, 22 Nov 2023 20:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700686039;
	bh=iOGqsjNrxAouz3AJJHZo7n5yudWeQ8nrq1vq3zxtsBE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JTZKN5o8vBbSuTJ3zDm40Y+bDC/o4pO62dv6Qdw7wjjfuIvXz850E2mN4N0glDyAQ
	 I24R1FewFREzbe6rsAaoxOszJT3HRAS9FwQcOgcd7p5330hxLb25O+yIbsQjwCTtsn
	 +UFBAeZhqin2ubNn0OiBQfTXJ3vuEL5ciC2berJUgxbcBx4Aia14ioQrjV7DiaUVSR
	 st50n8JxEhvGIa27YvK0jqgESrKFfDzRghsbGqbgZ3ITGcJLSxCRtKlTKGWtCMUBqj
	 XpnKWid20FYJZBoiCILBrxO3xwRpU60BIQ28102Xv1iodp9t4T9w+AQKOUaZTyPQCD
	 Ac2OW6LMM00DQ==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2c874286f4dso13653841fa.0;
        Wed, 22 Nov 2023 12:47:19 -0800 (PST)
X-Gm-Message-State: AOJu0YzNuFrwlviDvPvddGrRdGaDalVIHy/mfWHxVn2LmdnpHuqkbVYK
	7/OccFJZzvNVT1vxx0DuCC4GpJp5X2i1XwC4KQ==
X-Google-Smtp-Source: AGHT+IGTjq0mZD9i+eUzTXzP28Wi1Bo+2Bm1FI9n8vEQBS5kPkO5fcu9os4HymBwAvrwCsgVBASyxd59bRZr+JZsdyc=
X-Received: by 2002:a05:6512:3e20:b0:509:4792:25eb with SMTP id
 i32-20020a0565123e2000b00509479225ebmr249053lfv.17.1700686037339; Wed, 22 Nov
 2023 12:47:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231107105025.1480561-1-billy_tsai@aspeedtech.com>
 <20231107105025.1480561-3-billy_tsai@aspeedtech.com> <20231108182135.GA2698015-robh@kernel.org>
 <SG2PR06MB33655734700697E8F6FD0D1B8BB2A@SG2PR06MB3365.apcprd06.prod.outlook.com>
In-Reply-To: <SG2PR06MB33655734700697E8F6FD0D1B8BB2A@SG2PR06MB3365.apcprd06.prod.outlook.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 22 Nov 2023 13:47:04 -0700
X-Gmail-Original-Message-ID: <CAL_JsqL=2-dD5yFWWDDHu1svcCF-EMZqcYz92Pr7L5ntppNQVA@mail.gmail.com>
Message-ID: <CAL_JsqL=2-dD5yFWWDDHu1svcCF-EMZqcYz92Pr7L5ntppNQVA@mail.gmail.com>
Subject: Re: [PATCH RESEND v10 2/3] dt-bindings: hwmon: Support Aspeed g6 PWM
 TACH Control
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: "jdelvare@suse.com" <jdelvare@suse.com>, "linux@roeck-us.net" <linux@roeck-us.net>, 
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>, "joel@jms.id.au" <joel@jms.id.au>, 
	"andrew@aj.id.au" <andrew@aj.id.au>, "corbet@lwn.net" <corbet@lwn.net>, 
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>, 
	"u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, 
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, 
	"naresh.solanki@9elements.com" <naresh.solanki@9elements.com>, 
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, BMC-SW <BMC-SW@aspeedtech.com>, 
	"patrick@stwcx.xyz" <patrick@stwcx.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 8:11=E2=80=AFPM Billy Tsai <billy_tsai@aspeedtech.c=
om> wrote:
>
> > > Document the compatible for aspeed,ast2600-pwm-tach device, which can
> > > support up to 16 PWM outputs and 16 fan tach input.
> > >
> > > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> > > ---
> > >  .../bindings/hwmon/aspeed,g6-pwm-tach.yaml    | 69 +++++++++++++++++=
++
> > >  1 file changed, 69 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,g6=
-pwm-tach.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-ta=
ch.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
> > > new file mode 100644
> > > index 000000000000..c615fb10705c
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
> > > @@ -0,0 +1,69 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +# Copyright (C) 2023 Aspeed, Inc.
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/hwmon/aspeed,g6-pwm-tach.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: ASPEED G6 PWM and Fan Tach controller
> > > +
> > > +maintainers:
> > > +  - Billy Tsai <billy_tsai@aspeedtech.com>
> > > +
> > > +description: |
> > > +  The ASPEED PWM controller can support up to 16 PWM outputs.
> > > +  The ASPEED Fan Tacho controller can support up to 16 fan tach inpu=
t.
> > > +  They are independent hardware blocks, which are different from the
> > > +  previous version of the ASPEED chip.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - aspeed,ast2600-pwm-tach
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    maxItems: 1
> > > +
> > > +  resets:
> > > +    maxItems: 1
> > > +
> > > +  "#pwm-cells":
> > > +    const: 3
> > > +
> > > +patternProperties:
> > > +  "^fan-[0-9]+$":
> > > +    $ref: fan-common.yaml#
> > > +    unevaluatedProperties: false
> > > +    required:
> > > +      - tach-ch
> > > +
> > > +required:
> > > +  - reg
> > > +  - clocks
> > > +  - resets
> > > +  - "#pwm-cells"
> > > +  - compatible
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/clock/aspeed-clock.h>
> > > +    pwm_tach: pwm-tach-controller@1e610000 {
> > > +      compatible =3D "aspeed,ast2600-pwm-tach";
> > > +      reg =3D <0x1e610000 0x100>;
> > > +      clocks =3D <&syscon ASPEED_CLK_AHB>;
> > > +      resets =3D <&syscon ASPEED_RESET_PWM>;
> > > +      #pwm-cells =3D <3>;
> > > +
> > > +      fan-0 {
>
> > I assume there's a PWM connection here? How do you know which PWM? You
> > said the tach channel is independent, so it is not that.
>
> > It should not be 0 from 'fan-0' because that's just a meaningless index=
.
>
> > You either need 'pwms' here or you can use 'reg' and the reg value is
> > the PWM channel.
>
> Hi Rob, this binding is used to export the PWM provider and the Fan monit=
or (i.e., Tach).
> If the user wants to add the PWM connection for the fan, it can be done a=
s follows:
>
> fan0: pwm-fan0 {
>         compatible =3D "pwm-fan";
>         pwms =3D <&pwm_tach 0 40000 0>;
>         cooling-min-state =3D <0>;
>         cooling-max-state =3D <3>;
>         #cooling-cells =3D <2>;
>         cooling-levels =3D <0 15 128 255>;
> };
>
> This will reuse the existing PWM fan driver (e.g., pwm-fan.c).

I'm confused now. So what are the child nodes you have? You are
defining the fan in 2 places? The "pwm-fan" driver supports a tach via
an interrupt, so how would this work in your case?

Rob

