Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF40A45015E
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Nov 2021 10:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237406AbhKOJbJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 15 Nov 2021 04:31:09 -0500
Received: from mail-mw2nam10on2057.outbound.protection.outlook.com ([40.107.94.57]:20545
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237373AbhKOJaj (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 15 Nov 2021 04:30:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ce8Lh56MTIiySJmnQaK829+egpiShcHDjgRPKzPUoVAvGJZlbE1LS9scFTlLN2Vj517kP8j2tnlfhiPJlXfCJG52eSHeGhN1gkn8+5QDQeGCvJumUi+5G+xxmRImOorXIY69IF/nx88bJwf93HDZafSgVa5sX/q0jxt8yubOE0zailOpMy9BaCNfPpW5ZaSt7xipHWSn79vZzwKNYjF049C8ftnincYK1FWCWSg8uFkc+/AAoY0b4zfpFI+T62m49Juvbrqui/xrmfjoQxlnBvJCSUXjZR2301wpSEkcSGJP2psas2GmqF4DJ49VSSetBScKDGyDQg9TOM51l9DuUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6gGfMreQTDGGaiTeH1vkZqS7r2TMddLfePQoCn4820Q=;
 b=aNgKahqyE3SdGctgxOVdpHFlzr7PQ6ZoArr+HsYFOZ29SoLEsxIIaP4ZRGnk25FXCgG25ZmC0sGeF+uA6fCCRKfzGTSI9jCZdVinr/uVyJwSLLrLL7hma4WqX+1wEk8ovR2Nx+RlQMlfYNrEn15CP/Nw7GlC/QT4tYWhtNqRMmtIpE8b0jfDYCxb77mk5/C8rhQspRwebGuYZWHxeEgG+03IXCG8BSoPeztc/qgo1AcZWCoG4ozdE42dfSvLgKOWqDkxSCley7ZPExRQz78sGJ7x5pxvm6yuhkQpObnQ8tEH4o3c7ZtSrTWsXh8Pr29G0CfWFXT9887nygexBKPU9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=seco.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6gGfMreQTDGGaiTeH1vkZqS7r2TMddLfePQoCn4820Q=;
 b=SLetnEgYmj3dBNSG4gJL/H0T1MONXSE7RAJb9XMsB0+R9QCY1jx0MXk+BSL7NDSHQ/V+RnLWIklcWjqNtLPEeIAT7PYflngPJKgG4xXDiRKQeHgP8yhoVGIEnWZZ4RD/AlVLfBkNJMPp1GAHMqlYTfFbOO4BjZngLiMtoSnO14c=
Received: from DM3PR12CA0110.namprd12.prod.outlook.com (2603:10b6:0:55::30) by
 SJ0PR02MB7837.namprd02.prod.outlook.com (2603:10b6:a03:327::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.17; Mon, 15 Nov
 2021 09:27:39 +0000
Received: from DM3NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2603:10b6:0:55:cafe::c5) by DM3PR12CA0110.outlook.office365.com
 (2603:10b6:0:55::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16 via Frontend
 Transport; Mon, 15 Nov 2021 09:27:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT037.mail.protection.outlook.com (10.13.4.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Mon, 15 Nov 2021 09:27:38 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 15 Nov 2021 01:27:36 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 15 Nov 2021 01:27:36 -0800
Envelope-to: sean.anderson@seco.com,
 linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org,
 thierry.reding@gmail.com,
 u.kleine-koenig@pengutronix.de,
 lee.jones@linaro.org,
 linux-arm-kernel@lists.infradead.org,
 alvaro.gamez@hazent.com,
 linux-kernel@vger.kernel.org,
 robh@kernel.org
Received: from [10.254.241.49] (port=57400)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1mmYH2-000GiK-6w; Mon, 15 Nov 2021 01:27:36 -0800
Message-ID: <be09f273-d8eb-7d23-c1de-58c38ccbb421@xilinx.com>
Date:   Mon, 15 Nov 2021 10:27:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v10 1/3] microblaze: timer: Remove unused properties
Content-Language: en-US
To:     Sean Anderson <sean.anderson@seco.com>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        <linux-kernel@vger.kernel.org>, <michal.simek@xilinx.com>,
        Rob Herring <robh@kernel.org>
References: <20211112185504.1921780-1-sean.anderson@seco.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20211112185504.1921780-1-sean.anderson@seco.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b191a9f-d501-41e0-d05d-08d9a81a2ac6
X-MS-TrafficTypeDiagnostic: SJ0PR02MB7837:
X-Microsoft-Antispam-PRVS: <SJ0PR02MB783743B6D7C9FB068E503171C6989@SJ0PR02MB7837.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ID2Rr0/4OHaSAXGs8LxHFJ7VzpV+Pw9sACyHhZGEjAuXYlZondsyiZLFLmSiSQG5O7ltsgSDtZQ0CmCfb1ClUKR0h3/qw5C+FnEtbxedqhUN3IG9lQNhqFHVDa4k7ayVgktBplxsTgu6tmln151kdFZKDqKlJhMxYNrcMG3pQ+eQ7eWdXmiAVgnE8cWr+hQ3RGvB192Mg0Vwv8EnG7CL10XToOgGrAos0GIIur3JU8j8e2yTw7GFguF8/cjYP9rgS0ueosVVjRVoLaV7zW9JmAtCtrJioGrZnkdouNqC6KYy0dVbyxAiPscYSJZn5OdgtiTvktMtBUN3ykoqnoqweoKA27P+EAMRCcrk2SVIdWWfq/gs1wvHDgnclMUUseDfH3hzCasZq9lsd6RKfj4cRmWHZXllT976JkHuyWWRHznGKiQPZqDwyUDu8pPGMRH57cpgErBJ/IfbrjD6qGekRAGi4p+/67CKTY+EvWAP+yoNzoyAPgdlODImxZB+WxFVW0AXiGbg/vq5iUfAyjQb/R3zROToGwsWactyPi3IR3dm+EwZdK2s8pj+AagOXpuR2w/8hG8NfQ1DXKr4ebm/L7JmoCMqs3juCInmHV02P1Evz/svNlWkp8NljS1/Y8Hms0JBDvpL5D7CU+k7e4p2fhK1WAPcWW1txGKYKBFkDjyja2bhFoKXYvnEdEcFpj3b+xMhNGWxwoJJtFeNNqX2ndL+lh2kKKOkcrhi5plNXe6sF4i6BJ6WLGh0CkV16Uqs
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(5660300002)(2616005)(36756003)(9786002)(53546011)(36860700001)(31696002)(31686004)(336012)(426003)(44832011)(7416002)(316002)(186003)(47076005)(356005)(7636003)(8676002)(4326008)(83380400001)(2906002)(36906005)(508600001)(82310400003)(26005)(8936002)(6666004)(70206006)(54906003)(110136005)(70586007)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 09:27:38.9014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b191a9f-d501-41e0-d05d-08d9a81a2ac6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT037.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7837
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 11/12/21 19:55, Sean Anderson wrote:
> This removes properties not used by either the PWM or timer drivers.
> This lets us set additionalProperties: false.
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> Acked-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> (no changes since v8)
> 
> Changes in v8:
> - Remove additional properties from microblaze device tree
> 
>   arch/microblaze/boot/dts/system.dts | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/arch/microblaze/boot/dts/system.dts b/arch/microblaze/boot/dts/system.dts
> index b7ee1056779e..22252451ec09 100644
> --- a/arch/microblaze/boot/dts/system.dts
> +++ b/arch/microblaze/boot/dts/system.dts
> @@ -347,12 +347,7 @@ xps_timer_1: timer@83c00000 {
>   			interrupts = < 3 2 >;
>   			reg = < 0x83c00000 0x10000 >;
>   			xlnx,count-width = <0x20>;
> -			xlnx,family = "virtex5";
> -			xlnx,gen0-assert = <0x1>;
> -			xlnx,gen1-assert = <0x1>;
>   			xlnx,one-timer-only = <0x0>;
> -			xlnx,trig0-assert = <0x1>;
> -			xlnx,trig1-assert = <0x1>;
>   		} ;
>   	} ;
>   }  ;
> 


FYI: This is merged to Linus tree already. It means you can remove this 
patch from this series.

M
