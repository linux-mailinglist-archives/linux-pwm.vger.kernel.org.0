Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994F97B31B8
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Sep 2023 13:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbjI2Lse (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 29 Sep 2023 07:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2Lsc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 29 Sep 2023 07:48:32 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37BAE7;
        Fri, 29 Sep 2023 04:48:28 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38TBlwpb026316;
        Fri, 29 Sep 2023 11:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=pYbprmru96TQgVBscH484yU7pq/NVL8IwvEoncpQ9s8=;
 b=MjrFf5KkmvjtVJ2KVaseFiHMAfYW27hfrll1+MCwKi5xqSiupPlWBIYLDpI+kce1X6Rx
 Un88Mqehp7g2yuFctBvOKGngIZfQQ2hVPPra6/Xtfk9mjhGDNqsDtaOGEg1qzPS6m9GT
 IMGI0j/NeRy8KBcflJ4vR+u6rhKmDo0rh3KXXCWKZ1Rnqv7fQw3aMwdhAt+pMvvFapLI
 oqCGG/GF+hQLiDBE8WmKPWCGD7k6aZh6KKfFWa4qNnjq1V7jwELcw7gxpsFNZrcGDdHM
 HtRgol+SZ1WbGLZ5ZAHzquEcntH2832XDyYwd8DNjNrvwy0S84dOCX2MMC+ujk6luffI NA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tdx17g00d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 11:47:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38TBlvtJ032015
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 11:47:57 GMT
Received: from [10.216.56.186] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 29 Sep
 2023 04:47:51 -0700
Message-ID: <9155c1e3-d163-b2ad-8a7b-57ffeca2b122@quicinc.com>
Date:   Fri, 29 Sep 2023 17:17:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH V12 3/3] arm64: dts: ipq6018: add pwm node
Content-Language: en-US
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <ndesaulniers@google.com>,
        <trix@redhat.com>, <baruch@tkos.co.il>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <llvm@lists.linux.dev>
CC:     <linux-pwm@vger.kernel.org>, <u.kleine-koenig@pengutronix.de>,
        <nathan@kernel.org>
References: <20230925065915.3467964-1-quic_devipriy@quicinc.com>
 <20230925065915.3467964-4-quic_devipriy@quicinc.com>
In-Reply-To: <20230925065915.3467964-4-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: x_oUf14Ecfzf7WDlzoVza8JV0VTKXZwi
X-Proofpoint-ORIG-GUID: x_oUf14Ecfzf7WDlzoVza8JV0VTKXZwi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_10,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309290100
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 9/25/2023 12:29 PM, Devi Priya wrote:
> Describe the PWM block on IPQ6018.
> 
> The PWM is in the TCSR area. Make &tcsr "simple-mfd" compatible, and add
> &pwm as child of &tcsr.
> 
> Add also ipq6018 specific compatible string.
> 
> Co-developed-by: Baruch Siach <baruch.siach@siklu.com>
> Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
> v12:
> 
>    No change
> 
> v11:
> 
>    No change
> 
> v10:
> 
>    No change
> 
> v9:
> 
>    Add 'ranges' property (Rob)
> 
> v8:
> 
>    Add size cell to 'reg' (Rob)
> 
> v7:
> 
>    Use 'reg' instead of 'offset' (Rob)
> 
>    Add qcom,tcsr-ipq6018 (Rob)
> 
>    Drop clock-names (Bjorn)
> 
> v6:
> 
>    Make the PWM node child of TCSR (Rob Herring)
> 
>    Add assigned-clocks/assigned-clock-rates (Uwe Kleine-König)
> 
> v5: Use qcom,pwm-regs for TCSR phandle instead of direct regs
> 
> v3: s/qcom,pwm-ipq6018/qcom,ipq6018-pwm/ (Rob Herring)
> 
>   arch/arm64/boot/dts/qcom/ipq6018.dtsi | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> index 47b8b1d6730a..cadd2c583526 100644
> --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> @@ -398,8 +398,21 @@ tcsr_mutex: hwlock@1905000 {
>   		};
>   
>   		tcsr: syscon@1937000 {
> -			compatible = "qcom,tcsr-ipq6018", "syscon";
> +			compatible = "qcom,tcsr-ipq6018", "syscon", "simple-mfd";
>   			reg = <0x0 0x01937000 0x0 0x21000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0x0 0x0 0x01937000 0x21000>;
> +
Hi Krzysztof,
Referring to 
https://lore.kernel.org/all/20220909091056.128949-1-krzysztof.kozlowski@linaro.org/, 
it seems that the TCSR block should
not have any child nodes. Could you pls provide your suggestions on pwm
being added as the child node?

Thanks,
Devi Priya
> +			 pwm: pwm@a010 {
> +				compatible = "qcom,ipq6018-pwm";
> +				reg = <0xa010 0x20>;
> +				clocks = <&gcc GCC_ADSS_PWM_CLK>;
> +				assigned-clocks = <&gcc GCC_ADSS_PWM_CLK>;
> +				assigned-clock-rates = <100000000>;
> +				#pwm-cells = <2>;
> +				status = "disabled";
> +			};
>   		};
>   
>   		usb2: usb@70f8800 {
