Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D246A9FD4
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Mar 2023 19:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjCCS7I (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Mar 2023 13:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjCCS7G (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Mar 2023 13:59:06 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01hn2226.outbound.protection.outlook.com [52.100.5.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942D5166FC
        for <linux-pwm@vger.kernel.org>; Fri,  3 Mar 2023 10:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2feZ6fMEjRKJ+ReMBsObOSyICB4ggEsEWxUifUZ4I0=;
 b=EdHmtvZsq7EI6QE6ympSzpJAd/VG/lBpj07EQmaOT1+TwRQWNDgYFowzNIm4L+dStPmvsbvwq/KsQs5+Th10rzfYrDtkFFaUYfD43i9rtRg+Ot00b87WmlpygLKjGpZslf/Jjsb49zq1EePfcvc8SrvY8gKnYqQcIVMgg5sUqaJKPyQ1A5F0LAScnhgPMTkuEMhEEDgYNdLbO9Kxu4sM6dtTMq/wbB6cVeVCsXYFRc75nit8vHMnKK4TBgOALJEh0QrJtUy9cLkP68vKw7jgoY2yS2jfr7F8KeSDBwQNzdcSm35IAWpT3CNBUsE2OMsNHPEZDr1YDlIKd+1klUUyxg==
Received: from AS9PR06CA0181.eurprd06.prod.outlook.com (2603:10a6:20b:45d::10)
 by PAXPR03MB7965.eurprd03.prod.outlook.com (2603:10a6:102:218::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.21; Fri, 3 Mar
 2023 18:59:01 +0000
Received: from AM6EUR05FT028.eop-eur05.prod.protection.outlook.com
 (2603:10a6:20b:45d:cafe::25) by AS9PR06CA0181.outlook.office365.com
 (2603:10a6:20b:45d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22 via Frontend
 Transport; Fri, 3 Mar 2023 18:59:01 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 20.160.56.86)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Fail (protection.outlook.com: domain of seco.com does not
 designate 20.160.56.86 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.86; helo=inpost-eu.tmcas.trendmicro.com;
Received: from inpost-eu.tmcas.trendmicro.com (20.160.56.86) by
 AM6EUR05FT028.mail.protection.outlook.com (10.233.240.253) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.18 via Frontend Transport; Fri, 3 Mar 2023 18:59:01 +0000
Received: from outmta (unknown [192.168.82.135])
        by inpost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id 53A5D2008088D;
        Fri,  3 Mar 2023 18:59:01 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (unknown [104.47.18.104])
        by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id EF9AB20080074;
        Fri,  3 Mar 2023 18:58:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kavlxXpWiudkVMCh+0Ols8ICGqoqOwpSUME6RB8aJuHrSsGAPRMAIhURCK1a6iCNBakveJQL//LlBrCbf187jVJGNaxy/zeRDOfgQ9ErUNhwV6da/5/gXm4xvSCYbrXkpnY3YAc9QqWLi0zvii0qu7iGcu4CDA4V2ICI4xYWOmU7HuAk9AHJMmaineyKm1BQhvgiX+SVcMjtWoxdOJvDwerKmhy9oPKLQChQKiu7liliZ2CLevqLP//4tYUibfqxUluaXiptTGGLTZ/pE5VOTLSLpzZra4ENNuMX7j7z4TPQAZU2NLajFWJNDVUiZkolUR6E4l2UpGphMQ6KMpS0fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2feZ6fMEjRKJ+ReMBsObOSyICB4ggEsEWxUifUZ4I0=;
 b=NgxzS6s68e/IlLxa9rg+jRmlckhXOIZfBxojtdmanoNdck7QsyvIfrM62jP5qcuUDwwc5OwX4rPI3plQRRdvvOwQeUY38Wl6deQB2e39X6FGfW2cdizfCmCHA5f9uhxTnuLadyNwpuqWHlAxmaKafWVNxjFEYZL/Ukii+cqXHZbLqBFev6Ds03tRQaD85GPT0EFnFxtwJ2/KuSSimjkyDPHAFZEiBB8geyATpMmf3qTKz1CM4MDe0bh1fxzgZECRC7m/RM50ItaqHUWo1GurFgtR1UFTtIVzl5kRFtSX8w9L9Dl6Fs2uM0csDQ9pSz4cQnBqWtgaG6cT/I6Gjpxu2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2feZ6fMEjRKJ+ReMBsObOSyICB4ggEsEWxUifUZ4I0=;
 b=EdHmtvZsq7EI6QE6ympSzpJAd/VG/lBpj07EQmaOT1+TwRQWNDgYFowzNIm4L+dStPmvsbvwq/KsQs5+Th10rzfYrDtkFFaUYfD43i9rtRg+Ot00b87WmlpygLKjGpZslf/Jjsb49zq1EePfcvc8SrvY8gKnYqQcIVMgg5sUqaJKPyQ1A5F0LAScnhgPMTkuEMhEEDgYNdLbO9Kxu4sM6dtTMq/wbB6cVeVCsXYFRc75nit8vHMnKK4TBgOALJEh0QrJtUy9cLkP68vKw7jgoY2yS2jfr7F8KeSDBwQNzdcSm35IAWpT3CNBUsE2OMsNHPEZDr1YDlIKd+1klUUyxg==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by AM9PR03MB7804.eurprd03.prod.outlook.com (2603:10a6:20b:414::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Fri, 3 Mar
 2023 18:58:52 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::dbcf:1089:3242:614e]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::dbcf:1089:3242:614e%5]) with mapi id 15.20.6156.022; Fri, 3 Mar 2023
 18:58:52 +0000
Message-ID: <88ce0863-c950-afcb-da53-7c7d9175a475@seco.com>
Date:   Fri, 3 Mar 2023 13:58:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 30/30] pwm: xilinx: Convert to platform remove callback
 returning void
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     kernel@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
 <20230303185445.2112695-31-u.kleine-koenig@pengutronix.de>
From:   Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20230303185445.2112695-31-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0393.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::8) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|AM9PR03MB7804:EE_|AM6EUR05FT028:EE_|PAXPR03MB7965:EE_
X-MS-Office365-Filtering-Correlation-Id: d3854a32-d148-4a6b-d1a1-08db1c195a1b
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: r+6CA4uIqE2vEnuLBeoS5TZgKEB5oJG6fu29Bcg6nm2yxGRtbyQsid3uRy8UVObTGsnTVlvA+D65xJhx1H/W1SQZ6R5+lgOuxArHCOEtNSAKdQ4k4WavlfTDsiKS+LK38BBs/3Ou2AIn4HH0ows/xqe7jtuIwk2inX/oYnRpex3AN+zcte9AjspFNrSi/YjzBNDMUG8zPImlu/+xY8JQDXMWXdKuUo6Vbp4evN3I7uSI5RI7ndJQa9xms/zGgtmpcDmesm02QP/QxCWENg2eDNo9zv5Gq7Dv1V2RpBgGhAAMou+tZy2wQjrnRyV/ScbOYrTLGlnLVM4SQ1ZEDFqico5MY2qnGhfaBVIF/C5mv4k6bA5Lrm3lObBN14NdXvIZLkKiNe07AXqv7PM8Wn4DP1j//ILBDXwMNX923NlsxgcpqH2yp2X10U5+4kSN7BvJPunaHNHqknWKrmCSii1U1zrelhzEUn17/SHLcZAw3UCxHP67uqJMi7f5cN7/WIZfX0mnuzzZ1cv2YfjLNDelmYijkJ0G4Y/p0PKNSHSY/8SkE6sRo0E+J+6N6ph+7uSLBnWJppVCLfl0zmCzCMkxQNiJPyrkxprGNynkwPpypSh8qkETAdFJIK0QOMQgHxB/x9MsaRvK2RDCu5pCsAfDXZpKbuuUN4XG1Oz+Wv+l3NbOlvkyko/lC4XKSfghum+ladWg5P3qv6ZoDlPQuHKhWceGoNqsYr/nyF/wy5LTReV+XWrILr8fRJsIv5yjZ4q5oOvn3OUO7hCBsm9eB02Spg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(376002)(136003)(39850400004)(366004)(451199018)(316002)(36756003)(478600001)(83380400001)(5660300002)(6666004)(52116002)(6506007)(186003)(26005)(2616005)(6486002)(53546011)(6512007)(8936002)(2906002)(41300700001)(31696002)(44832011)(66556008)(66946007)(38100700002)(8676002)(38350700002)(4326008)(110136005)(86362001)(66476007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7804
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM6EUR05FT028.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: ad6a2953-8e34-426e-5213-08db1c19546a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ilZmbxMNte6VmRLfu4hMHvx6Cb5uzah8ROq3aS8lRmeV+knJtr6LtBlRLieQW7Mg42fiTs6xMrmkhFA3in/DaYZL55gmSlCQLTOqbYdzE3C0ydl8mzLTMp7ecGzekJdxwFHX8ooX5PTIk3RyvjzjpqbJZeJO03ibMb2gHBWN3tLE9YYSJtd2ntILeqrtcxNfN0LYdgkXqrrHF+gRwt5UwV6rAwE+fdjfeA+RXVAYRf7RWhCbOQvR7PqWVa+RCPceE4z9v+dMlVuukwM6VDzgsJbSJ56DP6UGqhlbPES7P6gZNrELUfXcOT956dSGuhZATNxB6R3mrzBF3sl9/C7iXEB0/pfEIgQh9yeXJDk/lTQh0Flbu0poXQXgR/bC7lKEyfwvIWMpttdZQorhSwgA3E8bMOp8L1Kxv7vMrHHmDOa5s61JVIFsde/FScRCCfG0XHeVgopmxVuJ98oeqGu6MoVYb60ctSDId5TCj/9Q6m7Rqrat6peGgJYfjL2qfc2aA1Twf7LdizbKwYAUxc3Mj5sMECnzCyHIQpcvr5Vi8ehXEZAicuE/2GtNH+OPG2GrHz0v4a1wxhn5YKkaxp0EsuZJS0yWokg77o8i1yI7Zg0+Njwg2kS32m65b7itKZuxpCKprosuZ6+Mm81FmTtqdr3pXPSc41HYyEAafBZ0+vZ40mUbulJkFxSXCQECDsmtiL5CJLD0EzHwr8qfAVf6k264PPccQbwd3NO2nYyrk04IF05cjzwzEIJN49RPq0nHvPRJV+ByLQR+lnx3UHsMeLMFnoyvrs2FKIDcLnuDFuE=
X-Forefront-Antispam-Report: CIP:20.160.56.86;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:inpost-eu.tmcas.trendmicro.com;PTR:inpost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230025)(346002)(136003)(376002)(39850400004)(396003)(451199018)(5400799012)(46966006)(36840700001)(36860700001)(6512007)(186003)(47076005)(31686004)(82740400003)(7596003)(26005)(7636003)(356005)(8936002)(8676002)(34070700002)(4326008)(70586007)(41300700001)(70206006)(2906002)(44832011)(478600001)(2616005)(53546011)(6506007)(6666004)(336012)(110136005)(316002)(31696002)(36756003)(82310400005)(83380400001)(40480700001)(86362001)(5660300002)(6486002)(43740500002)(45980500001)(12100799021);DIR:OUT;SFP:1501;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 18:59:01.4277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3854a32-d148-4a6b-d1a1-08db1c195a1b
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.86];Helo=[inpost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: AM6EUR05FT028.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7965
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 3/3/23 13:54, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-xilinx.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-xilinx.c b/drivers/pwm/pwm-xilinx.c
> index f7a50fdcd9a5..85153ee90809 100644
> --- a/drivers/pwm/pwm-xilinx.c
> +++ b/drivers/pwm/pwm-xilinx.c
> @@ -292,14 +292,13 @@ static int xilinx_pwm_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static int xilinx_pwm_remove(struct platform_device *pdev)
> +static void xilinx_pwm_remove(struct platform_device *pdev)
>  {
>  	struct xilinx_pwm_device *xilinx_pwm = platform_get_drvdata(pdev);
>  
>  	pwmchip_remove(&xilinx_pwm->chip);
>  	clk_rate_exclusive_put(xilinx_pwm->priv.clk);
>  	clk_disable_unprepare(xilinx_pwm->priv.clk);
> -	return 0;
>  }
>  
>  static const struct of_device_id xilinx_pwm_of_match[] = {
> @@ -310,7 +309,7 @@ MODULE_DEVICE_TABLE(of, xilinx_pwm_of_match);
>  
>  static struct platform_driver xilinx_pwm_driver = {
>  	.probe = xilinx_pwm_probe,
> -	.remove = xilinx_pwm_remove,
> +	.remove_new = xilinx_pwm_remove,
>  	.driver = {
>  		.name = "xilinx-pwm",
>  		.of_match_table = of_match_ptr(xilinx_pwm_of_match),

Reviewed-by: Sean Anderson <sean.anderson@seco.com>
