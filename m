Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64A83C8877
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Jul 2021 18:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbhGNQRO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Jul 2021 12:17:14 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:54595 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbhGNQRL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Jul 2021 12:17:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626279260; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=3m3ujPPUr/nzfZFzuGmZxwg1jheYBx6zT3o3L19ELMs=;
 b=xNnMhjf+AncSS/eeC3zeFM3qQO1BXpWz53cQqu8Ul/vrF/RQHZmU994upk/wzBBY16ijwxr4
 qwxL51JEz7I7kH6d96h8exH9P2MXCpMEIpgkDug4ktOERmpC3pMV8EmEH1xzNzT+oMoU8AcA
 aDZz8cLUdNrXTqT3099zRikUgYE=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyJkZWM1ZCIsICJsaW51eC1wd21Admdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 60ef0d4696a66e66b2bb2366 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 14 Jul 2021 16:13:58
 GMT
Sender: kathirav=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1B18BC4323A; Wed, 14 Jul 2021 16:13:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kathirav)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E31AAC433F1;
        Wed, 14 Jul 2021 16:13:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 14 Jul 2021 21:43:55 +0530
From:   Kathiravan T <kathirav@codeaurora.org>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K?= =?UTF-8?Q?=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 1/4] arm64: dts: ipq6018: correct TCSR block area
In-Reply-To: <f79128fa287e37ee59cb03ae04b319ecb3d68c29.1626176145.git.baruch@tkos.co.il>
References: <f79128fa287e37ee59cb03ae04b319ecb3d68c29.1626176145.git.baruch@tkos.co.il>
Message-ID: <6c28d9dbf5d3a4d7c543fc7b0308eb20@codeaurora.org>
X-Sender: kathirav@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 2021-07-13 17:05, Baruch Siach wrote:
> According to Bjorn Andersson[1], &tcsr_q6 base is 0x01937000 with size
> 0x21000. Adjust qcom,halt-regs offsets (add 0x8000) to match the new
> syscon base.
> 
> [1] https://lore.kernel.org/r/YLgO0Aj1d4w9EcPv@yoga
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> v5: New patch in this series
> ---
>  arch/arm64/boot/dts/qcom/ipq6018.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> index 6ee7b99c21ec..72ac36c1be57 100644
> --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> @@ -270,9 +270,9 @@ tcsr_mutex_regs: syscon@1905000 {
>  			reg = <0x0 0x01905000 0x0 0x8000>;
>  		};
> 
> -		tcsr_q6: syscon@1945000 {
> +		tcsr_q6: syscon@1937000 {

We can remove the q6 reference and make it as just 'tcsr'?

>  			compatible = "syscon";
> -			reg = <0x0 0x01945000 0x0 0xe000>;
> +			reg = <0x0 0x01937000 0x0 0x21000>;
>  		};
> 
>  		blsp_dma: dma-controller@7884000 {
> @@ -615,7 +615,7 @@ q6v5_wcss: remoteproc@cd00000 {
>  			clocks = <&gcc GCC_PRNG_AHB_CLK>;
>  			clock-names = "prng";
> 
> -			qcom,halt-regs = <&tcsr_q6 0xa000 0xd000 0x0>;
> +			qcom,halt-regs = <&tcsr_q6 0x12000 0x15000 0x8000>;

This seems to be not correct. 0x01945000 - 0x01937000 = 0xE000 but here 
the values are adjusted with 0x8000 not with 0xE000.

> 
>  			qcom,smem-states = <&wcss_smp2p_out 0>,
>  					   <&wcss_smp2p_out 1>;

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of Code Aurora Forum, hosted by The Linux Foundation
