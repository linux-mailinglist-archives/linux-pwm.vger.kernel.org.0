Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 105F4188657
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2020 14:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgCQNur (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Mar 2020 09:50:47 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52112 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgCQNuq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Mar 2020 09:50:46 -0400
Received: by mail-wm1-f68.google.com with SMTP id a132so21534346wme.1
        for <linux-pwm@vger.kernel.org>; Tue, 17 Mar 2020 06:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=weGSHusuD3aKifnaFA/EzOIoqClxmTlaJmSpzpOoxs0=;
        b=QSiI3s0YoV7n7/tnYog9oUBP3Cc6GxHGUCwCh0UhqjNIkn6pKoWxwDwIc7ZHfuKyt1
         kEdvFCQ6j7+Noa9+D0kVSXd1O/Rq0h4ff0AABiKfQ0W9cNhse4SjTXrrb27FQeHJRpqX
         rIA1fPNgK6D/F/8d3tqP2UVTDNrxXWhDA5E8X6jidyynaIZ0Cy+aY7WG7NpXiQONb4V8
         LujVukcDZrWz+C7PF5bEhVfs5Bz/2BHH9zTE0HxRpIGKa2vvxtylEPZVlwnF7tZUgTXY
         0rCI7jvUsKgzmx+R0sfFe10N4oWZb67+facmOeYl3vGzjeHlueh6TX64XNpmNRTf9oox
         +L4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=weGSHusuD3aKifnaFA/EzOIoqClxmTlaJmSpzpOoxs0=;
        b=R4SZCIURvwZ/iBLeafyhykhMXjtYhtoNDbSCXbWyVOUxLJ9mx7TT0CJ6tFmPAElPK4
         6rNzhJPxS/M7pOLWlCcIByvF7l4S1IULQemhi2bhEA9i4upYD2Jr4PNJNI47hGRWML/g
         ThPwQX5VvTOgjbrhfvh+qqNbSHFsIF1EBSsNB/DLkSkGgRofNNdcDEqd0z9jJ7j/frmk
         Hm/pgivaDum/PHIloIs1FLs0Pq+FdWR4tnO3TlaT7I+97J9iDrqbBorUe2/N+2SnHoH9
         cK+9bdqQOP10130FwmOle6V1hIr/hd89RIY4Qna3o35vSqYzJYRnE8tJLkT5ANVcVskp
         IEBQ==
X-Gm-Message-State: ANhLgQ3PwYZ9LYZtTBtcE9Kz/X6jMWuF4P1SjwC3e2QeevZBxM82O2Oa
        l10phszI4C+DHE4YtvTuFmNeQJi7B6qwodFyD+APNQ==
X-Google-Smtp-Source: ADFU+vusa/y0ClrKHxHtyBDmZj1O+rMx8uu0qjHobSSS5JQecz+zDpUKEEddBu5XlbGpEmdbaIvM2nWs+JrNOWL77kQ=
X-Received: by 2002:a05:600c:21d1:: with SMTP id x17mr5249108wmj.3.1584453043184;
 Tue, 17 Mar 2020 06:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1584450500.git.mchehab+huawei@kernel.org> <cf60ef88712e4f46f4e4bf40b2c646451d921827.1584450500.git.mchehab+huawei@kernel.org>
In-Reply-To: <cf60ef88712e4f46f4e4bf40b2c646451d921827.1584450500.git.mchehab+huawei@kernel.org>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 17 Mar 2020 14:50:32 +0100
Message-ID: <CAMpxmJUPA2qDwDu-LUh-RtXt66NhQUdjnPOCSaaBZ9xEm0C5LQ@mail.gmail.com>
Subject: Re: [PATCH 05/12] docs: dt: fix references to ap806-system-controller.txt
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Ben Peled <bpeled@marvell.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-pwm@vger.kernel.org, linux-gpio <linux-gpio@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        linux-pm <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

wt., 17 mar 2020 o 14:10 Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> napisa=C5=82(a):
>
> ap806-system-controller.txt was renamed to ap80x-system-controller.txt.
>
> Update its references accordingly.
>
> Fixes: 2537831bbc19 ("dt-bindings: ap80x: replace AP806 with AP80x")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/devicetree/bindings/gpio/gpio-mvebu.txt        | 2 +-
>  Documentation/devicetree/bindings/thermal/armada-thermal.txt | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt b/Docu=
mentation/devicetree/bindings/gpio/gpio-mvebu.txt
> index 2e097b57f170..0fc6700ed800 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
> +++ b/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
> @@ -14,7 +14,7 @@ Required properties:
>
>      "marvell,armada-8k-gpio" should be used for the Armada 7K and 8K
>      SoCs (either from AP or CP), see
> -    Documentation/devicetree/bindings/arm/marvell/ap806-system-controlle=
r.txt
> +    Documentation/devicetree/bindings/arm/marvell/ap80x-system-controlle=
r.txt
>      for specific details about the offset property.
>
>  - reg: Address and length of the register set for the device. Only one
> diff --git a/Documentation/devicetree/bindings/thermal/armada-thermal.txt=
 b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> index f3b441100890..b0bee7e42038 100644
> --- a/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> @@ -12,7 +12,7 @@ Required properties:
>
>  Note: these bindings are deprecated for AP806/CP110 and should instead
>  follow the rules described in:
> -Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.tx=
t
> +Documentation/devicetree/bindings/arm/marvell/ap80x-system-controller.tx=
t
>  Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.tx=
t
>
>  - reg: Device's register space.
> --
> 2.24.1
>

For GPIO:

Acked-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
