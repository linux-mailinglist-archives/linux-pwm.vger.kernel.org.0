Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B9B37240E
	for <lists+linux-pwm@lfdr.de>; Tue,  4 May 2021 03:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhEDBCM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 3 May 2021 21:02:12 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:53298 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhEDBCL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 3 May 2021 21:02:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620090077; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=Sf1IA5KGLxfu7/pbQAM+7HtpAgTzFf9dQ0YwIdLLSVU=; b=cHjd+vE5H5yTHOYDlE3nNN7fBYAdApL5Y0Gqf8qj4Q+fdUHk9TzS5qxB5xsb1Hx75xZS4pKg
 KWlrMZRzu48ywK8SKdR0MxK1NkZuTz+HoBJVsYrUv5aBz61R53fUFoBgpm64dgycCl8BU8j9
 oNXPfv3KtiYjZ5XFeMhegfktkTE=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyJkZWM1ZCIsICJsaW51eC1wd21Admdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 60909cdd9a9ff96d95e7d384 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 04 May 2021 01:01:17
 GMT
Sender: subbaram=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 29064C43144; Tue,  4 May 2021 01:01:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [10.46.162.93] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: subbaram)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C8C8BC433F1;
        Tue,  4 May 2021 01:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C8C8BC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=subbaram@codeaurora.org
Subject: Re: [PATCH v7 1/6] dt-bindings: leds: Add Qualcomm Light Pulse
 Generator binding
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Luca Weiss <luca@z3ntu.xyz>
References: <20210429211517.312792-1-bjorn.andersson@linaro.org>
 <20210429211517.312792-2-bjorn.andersson@linaro.org>
From:   Subbaraman Narayanamurthy <subbaram@codeaurora.org>
Message-ID: <635d3f2c-d3a8-c0d6-7659-c22e44103901@codeaurora.org>
Date:   Mon, 3 May 2021 18:01:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210429211517.312792-2-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 4/29/21 2:15 PM, Bjorn Andersson wrote:
> This adds the binding document describing the three hardware blocks
> related to the Light Pulse Generator found in a wide range of Qualcomm
> PMICs.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> Changes since v6:
> - Backed qcom,dtest out of the child nodes again, as it's useful to be able to
>   route pwm signals through dtest lines as well (and pwm channels aren't
>   described as children).
> - Added pm8150[bl] compatibles
> - Dropped quotes around qcom,dtest
> - Fixed indentation errors in subnode definition
>
>  .../bindings/leds/leds-qcom-lpg.yaml          | 158 ++++++++++++++++++
>  1 file changed, 158 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
>
> diff --git a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
> new file mode 100644
> index 000000000000..2998598e8785
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
> @@ -0,0 +1,158 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/leds-qcom-lpg.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Light Pulse Generator
> +
> +maintainers:
> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> +
> +description: >
> +  The Qualcomm Light Pulse Generator consists of three different hardware blocks;
> +  a ramp generator with lookup table, the light pulse generator and a three
> +  channel current sink. These blocks are found in a wide range of Qualcomm PMICs.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,pm8150b-lpg
> +      - qcom,pm8150l-lpg
> +      - qcom,pm8916-pwm
> +      - qcom,pm8941-lpg
> +      - qcom,pm8994-lpg
> +      - qcom,pmi8994-lpg
> +      - qcom,pmi8998-lpg
> +
> +  "#pwm-cells":
> +    const: 2
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  qcom,power-source:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      power-source used to drive the output, as defined in the datasheet.
> +      Should be specified if the TRILED block is present
> +
> +  qcom,dtest:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: >
> +      A list of integer pairs, where each pair represent the dtest line the
> +      particular channel should be connected to and the flags denoting how the
> +      value should be outputed, as defined in the datasheet. The number of
> +      pairs should be the same as the number of channels.
> +
> +  multi-led:
> +    type: object
> +    $ref: leds-class-multicolor.yaml#
> +    properties:
> +      "#address-cells":
> +        const: 1
> +
> +      "#size-cells":
> +        const: 0
> +
> +      "^led@[0-9a-f]$":
> +        type: object
> +        $ref: common.yaml#
> +


Just a question more than a comment. From what I can see, when this device is specified as a multi-color device or an individual device (e.g. "red", "green" and "blue"), the user can only set "pattern" and "repeat" under the corresponding device after setting "pattern" to "trigger". Would you be planning to add a way (e.g. another set of DT properties) for the user to specify such patterns via the devicetree itself?


> +patternProperties:
> +  "^led@[0-9a-f]$":
> +    type: object
> +    $ref: common.yaml#
> +
> +    properties:
> +      reg: true
> +
> +    required:
> +      - reg
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/leds/common.h>
> +
> +    lpg {
> +      compatible = "qcom,pmi8994-lpg";
> +
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      qcom,power-source = <1>;
> +
> +      qcom,dtest = <0 0
> +                    0 0
> +                    0 0
> +                    4 1>;
> +
> +      led@1 {
> +        reg = <1>;
> +        label = "green:user1";
> +      };
> +
> +      led@2 {
> +        reg = <2>;
> +        label = "green:user0";
> +        default-state = "on";
> +      };
> +
> +      led@3 {
> +        reg = <3>;
> +        label = "green:user2";
> +      };
> +
> +      led@4 {
> +        reg = <4>;
> +        label = "green:user3";
> +      };
> +    };
> +  - |
> +    #include <dt-bindings/leds/common.h>
> +
> +    lpg {
> +      compatible = "qcom,pmi8994-lpg";
> +
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      qcom,power-source = <1>;
> +
> +      multi-led {
> +        color = <LED_COLOR_ID_MULTI>;
> +        label = "rgb:notification";
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        led@1 {
> +          reg = <1>;
> +          color = <LED_COLOR_ID_RED>;
> +        };
> +
> +        led@2 {
> +          reg = <2>;
> +          color = <LED_COLOR_ID_GREEN>;
> +        };
> +
> +        led@3 {
> +          reg = <3>;
> +          color = <LED_COLOR_ID_BLUE>;
> +        };
> +      };
> +    };
> +  - |
> +    lpg {
> +      compatible = "qcom,pm8916-pwm";
> +      #pwm-cells = <2>;
> +    };
> +...


-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

