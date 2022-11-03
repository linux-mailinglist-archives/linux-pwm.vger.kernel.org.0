Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3C3617FB5
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Nov 2022 15:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiKCOjF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 3 Nov 2022 10:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiKCOjE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 3 Nov 2022 10:39:04 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DD21126;
        Thu,  3 Nov 2022 07:39:03 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ud5so5843257ejc.4;
        Thu, 03 Nov 2022 07:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qIyKCJxZIuG+RhhbIO3I6/NX9wqTTWIgzBI4Scnntow=;
        b=X+PJ7NLjR55zsmdJrTwNlBoxEeIt65Gvw0z4ZrzHMsUtbyrFmPVo2wK84AAtdPS6+X
         sJ4jYgcf6IbcXpUkRPDAlcyMb1bL66qi7qQ71JttX6zp3GWAL7sV1RE1sllI0czBTmUv
         oamlh8/jLTEr2ijpyVmZwX+SezbQ29ccGGlb+pajytekdsJ+UkEn3jIoXOAH61YWm7ae
         471118CGS7rvn+YsLYUuznxKxHK0iqcwl0IkLF9quvbGkory+k5n2vU20FdXoFr1k4Zf
         0YnNAQctNZjWpiZ3tDVv3X8nnRGpqJfzSRgXKktWR6WheNRUwHYSC8SamGwAAt94fZuB
         o+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qIyKCJxZIuG+RhhbIO3I6/NX9wqTTWIgzBI4Scnntow=;
        b=7Tmrtld6QYik04o9VCEYLjKc9gZ4xO34Jw2+bLjypVeaeiT2imXS9A+rkfh+YByQY1
         dmBMzAdwDENrS3hi3+p/OEQhcZOmMIIDS3RLbaxsMOvAOlVNgSuOW0tItCsEPwsogoTT
         XaKT4tja991/xyuPfBZ8KHMr1Je0Rp5cFxhuPriQnkI6mWuESEHgI/AWBmkDiv+eOOTz
         7o2DIKTUI1HyGEPXFsQqjOyj3D96/lKymbwAhCyXebLM+a+QWecfktGhQAlPftE9Fz6Y
         qHuaagyESYaYe0+9Lk7cWbTtDjtWpXEIlXgNF/EcMRkd5T/oQ+8KihtkOU5aWmcD4A/z
         8Fuw==
X-Gm-Message-State: ACrzQf2cQaIreGTeA3/WefiMV6lknmbWjhdoWDTsvvJOuh/LyVyT5n5+
        CnWmAi1hcsvDXBAFpAZMpak=
X-Google-Smtp-Source: AMsMyM4S+CzD5Jpllv9opC/WA5fBHIeN3TJT0BaCXQR1t4DW8DiiMB/zLHU/POLrWcuy5BmnuFm88g==
X-Received: by 2002:a17:907:2bd7:b0:7ad:9ada:a6f3 with SMTP id gv23-20020a1709072bd700b007ad9adaa6f3mr28419195ejc.355.1667486341683;
        Thu, 03 Nov 2022 07:39:01 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id r13-20020aa7d58d000000b004616cce0a26sm598397edq.24.2022.11.03.07.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 07:39:00 -0700 (PDT)
Date:   Thu, 3 Nov 2022 15:38:59 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: tegra: Convert to json-schema
Message-ID: <Y2PSgwfqZ9BfXSFw@orome>
References: <20221103120137.1467905-1-thierry.reding@gmail.com>
 <18d66cce-64ae-aeaa-e9cf-9426c5d214f5@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yaZ6CGl2KxtPFIjN"
Content-Disposition: inline
In-Reply-To: <18d66cce-64ae-aeaa-e9cf-9426c5d214f5@linaro.org>
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


--yaZ6CGl2KxtPFIjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 03, 2022 at 10:14:04AM -0400, Krzysztof Kozlowski wrote:
> On 03/11/2022 08:01, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Convert the Tegra PWFM bindings from the free-form text format to
> > json-schema.
> >=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  .../bindings/pwm/nvidia,tegra20-pwm.txt       |  77 ----------
> >  .../bindings/pwm/nvidia,tegra20-pwm.yaml      | 144 ++++++++++++++++++
> >  2 files changed, 144 insertions(+), 77 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/pwm/nvidia,tegra2=
0-pwm.txt
> >  create mode 100644 Documentation/devicetree/bindings/pwm/nvidia,tegra2=
0-pwm.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.t=
xt b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
> > deleted file mode 100644
> > index 74c41e34c3b6..000000000000
> > --- a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
> > +++ /dev/null
> > @@ -1,77 +0,0 @@
> > -Tegra SoC PWFM controller
> > -
> > -Required properties:
> > -- compatible: Must be:
> > -  - "nvidia,tegra20-pwm": for Tegra20
> > -  - "nvidia,tegra30-pwm", "nvidia,tegra20-pwm": for Tegra30
> > -  - "nvidia,tegra114-pwm", "nvidia,tegra20-pwm": for Tegra114
> > -  - "nvidia,tegra124-pwm", "nvidia,tegra20-pwm": for Tegra124
> > -  - "nvidia,tegra132-pwm", "nvidia,tegra20-pwm": for Tegra132
> > -  - "nvidia,tegra210-pwm", "nvidia,tegra20-pwm": for Tegra210
> > -  - "nvidia,tegra186-pwm": for Tegra186
> > -  - "nvidia,tegra194-pwm": for Tegra194
> > -- reg: physical base address and length of the controller's registers
> > -- #pwm-cells: should be 2. See pwm.yaml in this directory for a descri=
ption of
> > -  the cells format.
> > -- clocks: Must contain one entry, for the module clock.
> > -  See ../clocks/clock-bindings.txt for details.
> > -- resets: Must contain an entry for each entry in reset-names.
> > -  See ../reset/reset.txt for details.
> > -- reset-names: Must include the following entries:
> > -  - pwm
> > -
> > -Optional properties:
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > -In some of the interface like PWM based regulator device, it is requir=
ed
> > -to configure the pins differently in different states, especially in s=
uspend
> > -state of the system. The configuration of pin is provided via the pinc=
trl
> > -DT node as detailed in the pinctrl DT binding document
> > -	Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
> > -
> > -The PWM node will have following optional properties.
> > -pinctrl-names:	Pin state names. Must be "default" and "sleep".
> > -pinctrl-0:	phandle for the default/active state of pin configurations.
> > -pinctrl-1:	phandle for the sleep state of pin configurations.
> > -
> > -Example:
> > -
> > -	pwm: pwm@7000a000 {
> > -		compatible =3D "nvidia,tegra20-pwm";
> > -		reg =3D <0x7000a000 0x100>;
> > -		#pwm-cells =3D <2>;
> > -		clocks =3D <&tegra_car 17>;
> > -		resets =3D <&tegra_car 17>;
> > -		reset-names =3D "pwm";
> > -	};
> > -
> > -
> > -Example with the pin configuration for suspend and resume:
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > -Suppose pin PE7 (On Tegra210) interfaced with the regulator device and
> > -it requires PWM output to be tristated when system enters suspend.
> > -Following will be DT binding to achieve this:
> > -
> > -#include <dt-bindings/pinctrl/pinctrl-tegra.h>
> > -
> > -	pinmux@700008d4 {
> > -		pwm_active_state: pwm_active_state {
> > -                        pe7 {
> > -                                nvidia,pins =3D "pe7";
> > -                                nvidia,tristate =3D <TEGRA_PIN_DISABLE=
>;
> > -			};
> > -		};
> > -
> > -		pwm_sleep_state: pwm_sleep_state {
> > -                        pe7 {
> > -                                nvidia,pins =3D "pe7";
> > -                                nvidia,tristate =3D <TEGRA_PIN_ENABLE>;
> > -			};
> > -		};
> > -	};
> > -
> > -	pwm@7000a000 {
> > -		/* Mandatory PWM properties */
> > -		pinctrl-names =3D "default", "sleep";
> > -		pinctrl-0 =3D <&pwm_active_state>;
> > -		pinctrl-1 =3D <&pwm_sleep_state>;
> > -	};
> > diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.y=
aml b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml
> > new file mode 100644
> > index 000000000000..9c73e78ff434
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml
> > @@ -0,0 +1,144 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pwm/nvidia,tegra20-pwm.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NVIDIA Tegra PWFM controller
> > +
> > +maintainers:
> > +  - Thierry Reding <thierry.reding@gmail.com>
> > +  - Jon Hunter <jonathanh@nvidia.com>
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - const: nvidia,tegra20-pwm
> > +
> > +      - items:
> > +          - enum:
> > +              - nvidia,tegra30-pwm
> > +              - nvidia,tegra114-pwm
> > +              - nvidia,tegra124-pwm
> > +              - nvidia,tegra132-pwm
> > +              - nvidia,tegra210-pwm
> > +          - enum:
> > +              - nvidia,tegra20-pwm
> > +
> > +      - items:
> > +          - const: nvidia,tegra186-pwm
>=20
> I guess you wanted to keep some order between nvidia,tegra20-pwm and
> nvidia,tegra186-pwm, but this creates impression you will have here more
> items, which of course cannot happen. So either keep this one with
> tegra20 as one enum or drop "items".

Done.

>=20
> > +
> > +      - items:
> > +          - const: nvidia,tegra194-pwm
> > +          - const: nvidia,tegra186-pwm
> > +
> > +      - items:
> > +          - const: nvidia,tegra234-pwm
> > +          - const: nvidia,tegra194-pwm
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: module clock
>=20
> Just maxItems: 1, because description is not really helping.

Okay, seems fine.

> > +
> > +  clock-names:
> > +    items:
> > +      - const: pwm
>=20
> This wasn't in original binding and does not look needed. Mention
> changes from pure conversion.

At some point (looks like with the switch to 64-bit ARM) we started
adding these for consistency because we were noticing that sometimes
either we were missing clock entries or newer SoC generations gained
additional clocks. Whenever that happened it would become somewhat
cumbersome to describe this in device tree bindings and/or driver
code, so consistently adding a clock-names property preventively
even if only a single clock was used in the first iteration seemed a
prudent thing to do.

So these are not technically necessary, but many device tree files will
have these entries, so this is here for those to pass validation.

Note that the property doesn't show up along the "clocks" property in
"required:" below.

>=20
> > +
> > +  resets:
> > +    items:
> > +      - description: module reset
> > +
> > +  reset-names:
> > +    items:
> > +      - const: pwm
> > +
> > +  "#pwm-cells":
> > +    const: 2
> > +
> > +  pinctrl-names:
> > +    items:
> > +      - const: default
> > +      - const: sleep
> > +
> > +  pinctrl-0:
> > +    description: configuration for the default/active state
> > +
> > +  pinctrl-1:
> > +    description: configuration for the sleep state
> > +
> > +  operating-points-v2:
> > +    $ref: "/schemas/types.yaml#/definitions/phandle"
>=20
> Drop quotes. We should actually define it in some common schema.

Yeah, good idea. I'll drop the quotes for now and see if I can find a
good place to add this in dt-schema.

> > +
> > +  power-domains:
> > +    items:
> > +      - description: phandle to the core power domain
> > +
> > +allOf:
> > +  - $ref: pwm.yaml
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - resets
> > +  - reset-names
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/tegra20-car.h>
> > +
> > +    pwm: pwm@7000a000 {
> > +        compatible =3D "nvidia,tegra20-pwm";
> > +        reg =3D <0x7000a000 0x100>;
> > +        #pwm-cells =3D <2>;
> > +        clocks =3D <&tegra_car TEGRA20_CLK_PWM>;
> > +        resets =3D <&tegra_car 17>;
> > +        reset-names =3D "pwm";
> > +    };
> > +
> > +  # Example with the pin configuration for suspend and resume:
> > +  # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +  # Suppose pin PE7 (On Tegra210) interfaced with the regulator device=
 and it requires PWM output
> > +  # to be tristated when system enters suspend.
> > +  - |
> > +    #include <dt-bindings/clock/tegra210-car.h>
> > +    #include <dt-bindings/pinctrl/pinctrl-tegra.h>
> > +
> > +    pinmux@700008d4 {
> > +        compatible =3D "nvidia,tegra210-pinmux";
> > +        reg =3D <0x700008d4 0x29c>, /* Pad control registers */
> > +              <0x70003000 0x294>; /* Mux registers */
> > +
> > +        pwm_active_state: pwm_active_state {
>=20
> No underscores in node names.

I've dropped the entire example, but I may want to put it back once the
pinmux conversion is done, in which case I'll make sure to replace the
underscores.

Thanks,
Thierry

--yaZ6CGl2KxtPFIjN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNj0oAACgkQ3SOs138+
s6FcoQ//ULkcBhhyh6sOEeam6JT70izc3ITIqW8iNAgcYaWVN4672F7M3bucUyIO
sq/b4GYV+2G8KoRkk5+NIudEWxoSTaStDPKPWeSAG5gY+gSiU1kmsGRYy83yVNwf
nyVUa0zUoQxL/wmsYM8D2VVHSFmTEwroA+XFrFHm1G3B7jlLxo2AELTe4TORA7MX
Oeg4oMl1diJgDkVr33p629OMGmG36H30HC6+c6YvGysyCmfKJxsGBRQH2oycaufL
4yz58M1ohNl9guYkgSRkhCH9+GbzCziSM9fQT5l+YvlY1X0KKcoNBLQ+i4L1hfrZ
R4jZKylfB4Vn+ZsRQzx+1AIMGFv5MKdTD2UFaf0Q0gmza+/BvGIXst2px6yBQxhV
x3OjvAXKggRoSu3U2iZKIzEhwPfA8ANZ+4N/SLilLoamVeiNxZ0mjXvDJ+LYP0Tu
8MYCg4JHLEfCA13fC5u6mE6dK+cHLnriuTT+JjmIM+SVvTfGtx6pGk9xu/Kby2cP
mqoJBrjGp4tBTpY4hN3Qq+spI2bE4g1nr0KonPcxPScPKJOaRv8kVSptGtBs3i0r
9eGi8ZbOYqHajUPKMZlIbTWlGohtkio/YKur30cwBuQTsUqz0MH4BHuELQ1jlK0l
gLYeb1fDAQ5X/wEv7ErHsru9q5o6UEYWE2e3V3pEuRVuQ5HfC2M=
=PaY0
-----END PGP SIGNATURE-----

--yaZ6CGl2KxtPFIjN--
