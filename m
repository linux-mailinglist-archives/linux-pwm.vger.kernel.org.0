Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD5E68B445
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Feb 2023 03:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjBFC4f (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 5 Feb 2023 21:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjBFC4e (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 5 Feb 2023 21:56:34 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D399196BE
        for <linux-pwm@vger.kernel.org>; Sun,  5 Feb 2023 18:56:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBMr68lXcF12Axt2UKyoM0u9ggEHnRFLU+PZLhPefbNa4foV7ytBrCuLCKOJFhV0Oue2yEQL9dOWPIBDiVOn2CObM/XOlnhs0yyfmH5lPZbWm7w33m9qvA6XERMoZw79Rz163ZvGupwq6UOeGh4pldH6E9WIOd1XJyhxQyyFNMD6t7a83SK2XGz062w2churBV3msur6IbNHFCWauH6ztwBZ1G9gv7uiDDhCl035eHtZj1aSYn46F2B4xcefLl6DhgUO49lm1OcyAXxv/RpA3KElteKJLxM8lLL/kQUWqGtceRRLsZ/SDUklqxbYBOWEVu9muQDrXBwCgpskAEA3DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+8LWmMnNGdAZc9zWkL42dmjBoumXRiJSaAGOs/jLEw=;
 b=Jg/T9+KqXjysMeZnGWyutqIrXAQ5ayIFglG52u0x1ej4+d/q28TciCPM+Qf8PcncJxvXwP69K5fcDhiJJWLeZbogaOOjCvHV7NCf8QLBHUe34Ktzccos35vxZJti+0Z0w2QLP9ZCpAmaadjMJHIBalfxs1253SDwXjVewt5lZxviwLXQNMTyBqe1m51vf92BsOzJbNXQ3U8r5r5Dh0L1Rb1LNlYUl3NQ2M/Wjv0MVUZLcpBngIbCrGr1ggEaeELMmgtWv195BXoD2LAu3S8Uj/r2I5bZMkHhVM5jX+D+SV3UWjgPyonmP+LF40Gd3IebY+9sXwzBxP7JANSYmQIBxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+8LWmMnNGdAZc9zWkL42dmjBoumXRiJSaAGOs/jLEw=;
 b=RtDkmIEP1ukxPkvaye1zhK1bA3au8B9NW/P0tvDSmvjYeswo14B1LsXt7r1K60Ir9QYPFzZE8+uBQm7ZDrBl48SAvy2L7Xz1JnMmMeUzwr6twUTYOTV+dya5n0/Vw27R58ZjWWRzss7WySyHOxprf5sNfsnmcJ8lY4GGWo4xKQc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by DM4PR08MB8652.namprd08.prod.outlook.com
 (2603:10b6:8:180::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 02:56:28 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::4e0c:f94b:5d28:66e4]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::4e0c:f94b:5d28:66e4%6]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 02:56:28 +0000
Date:   Sun, 5 Feb 2023 20:56:22 -0600
From:   Jeff LaBundy <jeff@labundy.com>
To:     thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        jeff@labundy.com
Subject: [RESEND v2] pwm: iqs620a: Replace one remaining instance of
 regmap_update_bits()
Message-ID: <Y+BsVlLp8Xqvg3ui@nixie71>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0022.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::19) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|DM4PR08MB8652:EE_
X-MS-Office365-Filtering-Correlation-Id: 65f6d804-57d1-469c-0295-08db07edbdd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vZr58AqmLfM9rMtwV0lSpz/xJ6E6IvdbRStY/SFi3W/mQeosiZaSGQU6BgCR2cV7h57738aNhxaa3ptbwLHiyTLNf9I0tiApC5osxlNYE3xkvbbt0tjvtU6sS5QoLwVP+EoSKiuJIxPweCAdytyhE3wtHegGL/SNOCf3OHmKFxM8hdzQinVkavc187zJaC+i4STbSEOHjZSoUI/IEBnE5UAv2iiKmTt0V/00wuNLB+ixKsHeOua0CYZotzjYGoxz58HKri4U9ddayCAFAq71TV3+NY+XYEsGN4KdVd64NdVYztonN6Mr+eTbwB6r17UYt+YE5LPS3OtUuL0JTX2EuPRkxlzWSQzQPnh+XSrG6a9L5sCx/rnhY5jYoX+Q8LDvWlFaEXpZZzjno+HO2QD72gleRXnsL4WfpcQo0lUC/vfyqp6jqf4gl1wy8m5trSkEUdU8QnE3x2TzNRhUn9ny4n123SnRky/hCoofgHC8kmfjYVR4YMABH3NoaV5pxPJsyOAYIXqY4PZKEljObo01EJ8Z4j8qnuBA3U3b+8z6WuRFuG1qdI2ttLEJ7jbaQpJ7Do/rdVxrO5kYcrtTi/0gMy6579s5zZhNRJgujHQTu6/WIPDGJzmhv+bO8XaO6Ih7QrtobcHWCHdNmBEKgnZgnlAZqQTDTPNeetCIf3XE2/lophAQXZfUKt73yNEJZRkS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(396003)(39830400003)(366004)(376002)(346002)(136003)(451199018)(316002)(107886003)(6666004)(6506007)(8676002)(478600001)(6486002)(5660300002)(2906002)(66476007)(66556008)(6916009)(4326008)(66946007)(41300700001)(8936002)(6512007)(26005)(86362001)(38100700002)(66574015)(83380400001)(33716001)(186003)(9686003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?/XV4ICqoSCsyurDBzkOtCLK2bOJGCG16tE+GkzybYx5wrZyJUXG/Ry9zd2?=
 =?iso-8859-1?Q?YkiOz9w6fM+XsM/NMbvCI+7Ph7ZrBt1D9iEjtSxMh4OJyi+IMH3Nq1xW+N?=
 =?iso-8859-1?Q?0dzGCex9YeKKKpf77QpZ01G6c99OfGD+z0IvsDnmrfhGqv1jpg94CqmZJI?=
 =?iso-8859-1?Q?qOQGtdqt463PsYU0kWQAuf1Hmy0Wq6Woxm1gUJuvo/GjmXU6j2bEuPg3V3?=
 =?iso-8859-1?Q?yudg6Bir83/Ozu+TRN3BNPCb3ai3AB2CFCV9Xh2vgRWfsEO64e4I4BAyuQ?=
 =?iso-8859-1?Q?R4ccm+xzgk6L5JSUkgdj2BHTXAHjUhNpufKUAG1M/luLNE3Fu40iuUn/gD?=
 =?iso-8859-1?Q?Pjb1em0PoH7tLFCuYngeATCg2AhkFPSdynVl+Tytpd8ZxfJMQlX06yKH+h?=
 =?iso-8859-1?Q?6Gk2JW5yLUsQQxPnL0yXHYJYt17F7ZYWeI/2cXzohZ71mkpaZeWTOvrcm/?=
 =?iso-8859-1?Q?pvsB4HES4lLPRPSXFxLp7umfMkHvynaORzuFlnlgazbJSV8owSlUc/P/XZ?=
 =?iso-8859-1?Q?VvLhLZ37+W1YsrKJRJEf/HH9H+1FbZUdjVQTBQ1jDuxVHAyMx48nbUaJti?=
 =?iso-8859-1?Q?CbsNoM5d9U7atRTPrHbwtr/KzznGyp+oFRWwS9x3XaH+epGUsbNijB4QLc?=
 =?iso-8859-1?Q?BRo+IQGRk0sb5/BgI8zCuMxercxne2A+FeruiI7mmT0q1b6iUcecm1nGs7?=
 =?iso-8859-1?Q?NugsAl3UbrlnwQYOgc+w/fSQIiaLBl43+wVMC0Qc3TBaSR0Gge/sC0rmVw?=
 =?iso-8859-1?Q?L4iPBq518EXFMW/d6XDnUIb7oqrSDWmd3cyG0TpEZIJt46zYAjpHnTav4a?=
 =?iso-8859-1?Q?B+JosDXo/qWiKnTWZxwG3WM5U0OYJU0c5/ZLQPmG56jzi4QS0eC6z6auyw?=
 =?iso-8859-1?Q?5hUHpNte6iI3Sbc5BCWaoD8EB2sLxYoPW9l78Zvj7FLrgXZOZL/1lkoRhs?=
 =?iso-8859-1?Q?4KJZ2HcpsHI5yOyqQF7MlVdYNlBgX24SsVaU7Z2dL2z3XrYX5+gkN4CauO?=
 =?iso-8859-1?Q?xeaiSZqMfKHOeeHOdxr+E44k8KfTjhfMCsVhmGvvE2k6e/GecqqVtkizTx?=
 =?iso-8859-1?Q?UV7tKPlYPCHtIPYoGtpSfD5xh8wgdaPZZYk9qdOumARI0dNFBTEduj5z8C?=
 =?iso-8859-1?Q?Xb+isuoTtZrSRv04Um134/ogQD5Kh6xAIRemJYEYXpeTw3qPW5jScVMF9V?=
 =?iso-8859-1?Q?8sE9bIupT3/d8RUnn9D6ybzuP5zDmZ3vdZSVgTZT52Ff+u5m2dv2j0Dp6c?=
 =?iso-8859-1?Q?nObQ/N7sFzj2mN1SnSz01USVxVGEU4/LAFGVXRDU+yg/hAcDVFqbkr2dlt?=
 =?iso-8859-1?Q?fILhoOq21T4GH+D96eg6wfKedNbo+KfgAvfAUDWrhnMrEiIRYuOblf/icL?=
 =?iso-8859-1?Q?2A1N+ctVv1f7kmB0XC/UcISvwvwQCjNJhbjGpg1+GijDNMzxu/j8ol8ZJS?=
 =?iso-8859-1?Q?IzT5/HAfq0TVAqTibOdp+wL030qwucxRP5h2FaGsBYBSNnA7jKhSmnZMys?=
 =?iso-8859-1?Q?gl5XvLPIn7Tuw1hpzYxYHL29gFPtRuziN/fiHAL3se5ZG8uazHmYP06yR0?=
 =?iso-8859-1?Q?T8Sdb8o2zFb7gM5zTHZa+Uz7W6XNZUEB1WcN1ZOc0bHIBVQqzP959VrNZi?=
 =?iso-8859-1?Q?baM8lMhq8ksOoB8SlKcBADYCbp4lZeIFl1?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f6d804-57d1-469c-0295-08db07edbdd8
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 02:56:28.4875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4qmS74nysEiUa1su/mwiVG/CxPp2cGQCMrSmOsl7NnMxMrNex6PP02MY34CxK7rCiLdMECPeHTaYfbI/S14row==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR08MB8652
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The call to regmap_update_bits() which was responsible for clearing
the PWM output enable register bit was recently dropped in favor of
a call to regmap_clear_bits(), thereby simplifying the code.

Similarly, the call to regmap_update_bits() which sets the same bit
can be simplified with a call to regmap_set_bits().

Signed-off-by: Jeff LaBundy <jeff@labundy.com>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Changes in v2:
 - Dropped Fixes tag

 drivers/pwm/pwm-iqs620a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
index 4987ca940b64..8362b4870c66 100644
--- a/drivers/pwm/pwm-iqs620a.c
+++ b/drivers/pwm/pwm-iqs620a.c
@@ -55,8 +55,8 @@ static int iqs620_pwm_init(struct iqs620_pwm_private *iqs620_pwm,
 	if (ret)
 		return ret;
 
-	return regmap_update_bits(iqs62x->regmap, IQS620_PWR_SETTINGS,
-				  IQS620_PWR_SETTINGS_PWM_OUT, 0xff);
+	return regmap_set_bits(iqs62x->regmap, IQS620_PWR_SETTINGS,
+			       IQS620_PWR_SETTINGS_PWM_OUT);
 }
 
 static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-- 
2.34.1

