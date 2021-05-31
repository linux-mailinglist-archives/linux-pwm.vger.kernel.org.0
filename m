Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E8D395999
	for <lists+linux-pwm@lfdr.de>; Mon, 31 May 2021 13:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhEaLXV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 31 May 2021 07:23:21 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55916 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbhEaLXS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 31 May 2021 07:23:18 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14VBLWDS114485;
        Mon, 31 May 2021 06:21:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622460092;
        bh=4arE56BMg90xtf+E0VWaXasmwdjrztL6xKs6PSDLTjU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=mhiGgW6bvV/aHIYYlxFlaU+uMdYRmWim4YNKwFJOmfmhZRfo8XXQE4Wx8I5/NS7Br
         c+eT0h67zrQhFMFZKhjQbjxkWZszooSfJxOU877lEWZD7hbeKrCnPE76HGs4eie38h
         jbhU27B7MGseQqpxvSooBWyMSyCp801ipbY60oAc=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14VBLWDZ106441
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 May 2021 06:21:32 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 31
 May 2021 06:21:31 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 31 May 2021 06:21:31 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14VBLSDT059129;
        Mon, 31 May 2021 06:21:29 -0500
Subject: Re: [PATCH 2/4] dt-bindings: pwm: tiehrpwm: Make clock and
 clock-names as required properties
To:     Lokesh Vutla <lokeshvutla@ti.com>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>,
        Vignesh R <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        <linux-pwm@vger.kernel.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>
References: <20210526084306.6534-1-lokeshvutla@ti.com>
 <20210526084306.6534-3-lokeshvutla@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <fd027ac8-e7c3-975c-488c-057f83701725@ti.com>
Date:   Mon, 31 May 2021 14:21:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210526084306.6534-3-lokeshvutla@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 26/05/2021 11:43, Lokesh Vutla wrote:
> Driver fails to probe when 'clock' and 'clock-names' properties are not
> populated in DT. But the binding documentation says these properties are
> optional. Fix this by making 'clock' and 'clock-names' properties as
> required.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
>   Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
> index e124e41418d8..8eae48c9c5cd 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
> @@ -11,8 +11,6 @@ Required properties:
>     the cells format. The only third cell flag supported by this binding is
>     PWM_POLARITY_INVERTED.
>   - reg: physical base address and size of the registers map.
> -
> -Optional properties:
>   - clocks: Handle to the PWM's time-base and functional clock.
>   - clock-names: Must be set to "tbclk" and "fck".
>   
> @@ -38,6 +36,8 @@ ehrpwm0: pwm@1f00000 { /* EHRPWM on da850 */
>   	compatible = "ti,da850-ehrpwm", "ti,am3352-ehrpwm";
>   	#pwm-cells = <3>;
>   	reg = <0x1f00000 0x2000>;
> +	clocks = <&psc1 17>, <&ehrpwm_tbclk>;
> +	clock-names = "fck", "tbclk";
>   };
>   
>   ehrpwm0: pwm@4843e200 { /* EHRPWM on dra746 */
> 

Here also, many text bindings missed standard props or miss-define them comparing to code,
which is accumulated over years. Now, thanks to .yaml conversation, we can catch them.

So, I ,personally, do not see reasons for separate patch here and think it can be done as part of
Patch 3.


-- 
Best regards,
grygorii
