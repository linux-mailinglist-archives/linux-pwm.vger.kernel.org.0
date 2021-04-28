Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17DAA36DE6E
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Apr 2021 19:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242358AbhD1Rii (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 28 Apr 2021 13:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242350AbhD1Rig (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 28 Apr 2021 13:38:36 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7631DC061573;
        Wed, 28 Apr 2021 10:37:51 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id i24so15671314edy.8;
        Wed, 28 Apr 2021 10:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AIfsZgg1HsW4TEdEIVvWGsH3VIdwHBCrm9xAObzp+6Y=;
        b=mbHQDZo6h6K68IduuZ+vV7kkpYkYvrrL5oTweDxhKVAxVWF8WJqA9mUvsTwCpoujHk
         8DCVNFCfinaIZN5iKfGF6LFmCZyBQ3FRms333RjyvwWrrqNlHZ9edBqMnEAMOsGxOfVN
         R4v0hpsPs9Hr8RYrrV8DsvdUE4s5B9/oeRQqECF8VonOTRsluB3SozhGvYsBcDtcddBr
         9Lbqyu/Yg1NoMLDvDdDQ0jbi5RCmNO1p5rVJipUp7zyyL+PS2bkUVQ/oXrWriM9LDzFw
         2g7tD/TJnHaQAHNaBva+gk5BegDnCtAfc22fP3ukE5EbPGlO5urcM8UkNA/9VVel3PxH
         d8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AIfsZgg1HsW4TEdEIVvWGsH3VIdwHBCrm9xAObzp+6Y=;
        b=UR1gs7+NSg2n7Yzao6fU+WwOP45aHCtR8/xesuTXnw/AuhU9Z9AoxpO+/OhtEyggmB
         oKWor11ozn8u4rgEAMkMGDCXCF+WlX8ImGrGyZC8r+5Hs6wDdF7ujcFa2HormKIuK1wx
         DkD+LWvUFLHNNuGZGBvGW5rOQ1i6tN2KyjqO911A2pnGoalq/uvQCSh0MJIBn6Jqw665
         XuWBZXXoBZoS3pGwh42y3D5e+JyHk2FeqEodCHRbUnwOlKl6zeTlpHmo0SwyK2nh5R9a
         /ZV9fqyyODjP0xvoFMe3G+CQ8aME0jC4Q8BYxSKFYf3x8cC6gpLk/tI9RVBEk4EM4RIw
         w4JQ==
X-Gm-Message-State: AOAM533gAQ/V8C7LsRWJfIeyoZ6vU+axnI3I3zSY21Mg3DX0fZZYj5th
        7SQPHnx1iJMyHcEMGXn9YhY=
X-Google-Smtp-Source: ABdhPJz0FFFGi7jX+jI6NILR3UI/RdjFLnbXjAlV3rcJ6kNfEy3twP0XAaW7XcPEI18wKNHJiI9pLQ==
X-Received: by 2002:aa7:d915:: with SMTP id a21mr739775edr.357.1619631470262;
        Wed, 28 Apr 2021 10:37:50 -0700 (PDT)
Received: from localhost (p2e5be10e.dip0.t-ipconnect.de. [46.91.225.14])
        by smtp.gmail.com with ESMTPSA id j10sm296682ejk.93.2021.04.28.10.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 10:37:49 -0700 (PDT)
Date:   Wed, 28 Apr 2021 19:38:44 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Fenglin Wu <fenglinw@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, subbaram@codeaurora.org,
        collinsd@codeaurora.org, aghayal@codeaurora.org
Subject: Re: [PATCH 1/2] dt-bindings: pwm: add bindings for PWM modules
 inside QCOM PMICs
Message-ID: <YImdpBE+8LIu9rIq@orome.fritz.box>
References: <20210427102247.822-1-fenglinw@codeaurora.org>
 <20210427102247.822-2-fenglinw@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Rl6xxuSZCAayz1wt"
Content-Disposition: inline
In-Reply-To: <20210427102247.822-2-fenglinw@codeaurora.org>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--Rl6xxuSZCAayz1wt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 27, 2021 at 06:22:09PM +0800, Fenglin Wu wrote:
> Add bindings for QCOM PMIC PWM modules which are accessed through SPMI
> bus.
>=20
> Signed-off-by: Fenglin Wu <fenglinw@codeaurora.org>
> ---
>  .../devicetree/bindings/pwm/pwm-qcom.yaml          | 51 ++++++++++++++++=
++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-qcom.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-qcom.yaml b/Docume=
ntation/devicetree/bindings/pwm/pwm-qcom.yaml
> new file mode 100644
> index 0000000..e8d8ed6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-qcom.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/pwm-qcom.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies, Inc. PMIC PWM bindings
> +
> +maintainers:
> +  - Fenglin Wu <fenglinw@codeaurora.org>
> +
> +description:
> +  PWM modules inside Qualcomm Technologies, Inc. PMICs can be accessed t=
hrough
> +  SPMI bus and normally one PMIC would have multiple PWM modules with ad=
jacent
> +  SPMI address space.
> +
> +Properties:
> +  compatible:
> +    const: qcom,pwm

This seems a bit vague. What if Qualcomm ever designs a different PWM?
How are you going to tell them apart? Typically this would include some
sort of ID for the SoC family, or the first SoC that this was introduced
on. That way you can more easily distinguish between different designs
later on.

> +
> +  reg:
> +    description:
> +      The SPMI address base of the PWM module, if there are multiple PWM
> +      modules present with adjacent SPMI address space, only need to spe=
cify
> +      the address base of the 1st PWM module.

That seems like an odd way to define these. It looks like this is a bus
with #address-cells =3D <1> and #size-cells =3D <0>. Such busses are usually
assumed to have a single address per device (see for example I2C). How
does the SPMI addressing work? Is there a specification somewhere?

Actually, Documentation/devicetree/bindings/spmi/spmi.yaml says that
SPMI child devices should have two address cells, so this seesm to be at
odds with that specification.

Thierry

--Rl6xxuSZCAayz1wt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmCJnaIACgkQ3SOs138+
s6FgmQ//VuVwjokE9jtiAEimFWqqanQrH1hywO01eTDIxCdIo7U+KPepZb4d90bp
/+MbVGE8IKcwbFV+a00v9PP0vEzeJR8hpGTxt1k52M/ht/lTfc5iS8UAapTISlZR
9keuykMewiBvZSzdkTcv+2Q4wsH8JTKud2t4coeMTT8AVEoutHBc12eke7rui4SH
373cBqMp2JLrMtz9oWYp1bFXUDluqthaSWWjzvb71Y7wFk7LUE2Md7swgEmo97zo
D6dUiX4khZ6H3Do/cvTIAf4V4yROvZDecPq17AZsi/Zun1JBG4KkJkInz8536tV0
qJ3Iv8YgrqJ9f0rqZQq/1jW+NQj9PE/jYph4HqJzVH3M7VHYvlrkiUbxxl8BkSDm
i6D5Sfi+i2GKa7cWg7HMO9NRaME6jArFADsT50DYAbbk7JjonccNmpR5lfqPC3Wl
kM7nA0ldAzXIv7EgCwtkc50XKD3J6HLx5T87YHurZpAPhH6D54Xf7Fto8UQjyHxF
sXsAhxG0xxJZl1ZdXD9kTn4OjE1OwPafCILlmihX/ynsrbg+ahvR4xMbvhO6weDl
QubqdgDjXu4+L5pPQ9LrO4rWRdrwAfUItKm9VEb2/7945hQPtrEaAJMwpZBT9lja
LKtFqt1qCkiAF4GNwgeLb00Dq4MSAyVOkxNitNcT/KhT4ec+kus=
=UZeF
-----END PGP SIGNATURE-----

--Rl6xxuSZCAayz1wt--
