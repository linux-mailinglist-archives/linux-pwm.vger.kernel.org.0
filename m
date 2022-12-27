Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C622656B79
	for <lists+linux-pwm@lfdr.de>; Tue, 27 Dec 2022 15:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiL0OAs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 27 Dec 2022 09:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiL0OAr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 27 Dec 2022 09:00:47 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6A7FEC
        for <linux-pwm@vger.kernel.org>; Tue, 27 Dec 2022 06:00:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGhHa5SLkTWpn76jkC55e9ctO8qFHMbgvNmavQOfUbZ3E6CgvymMRoBsvRcOBB7+Ij9ukm8R0CKvGYu+GVK2DLw4G+J5NpGO/kB0wVL78Md1A4083YXhQ46vPz7EyB4xsgGyLQrPbgDv4PAN6i9lk+J/Mg1W4XSYnFMgqHkkCR3PuK5b8J/E/HVAgBkbF2zuda6mDoLaGz+5u7keQHjfEcrCJdv0xapVaI0s2MBPSubdhds0NZjGIM4nSVwDWyVWIKIisMEmI6agZj3KnwVFNgwfI5g/JuboYwsdGt78/jYuA+n7tbydVjEl6NIbTn5CJ7eI7+hdzZN+BIikPooZeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAWCTqET23JdUWDpueDzW3PHzjUPt9mADVS+kOBhOBE=;
 b=STtisYF/QH2k42ZgRdE8Pbd/RS3ev4/200ToKaIucL0vCQDpNOr6Y51Tctc5UlYGn49Zo4qOMkQ7Ddh9GwRFbzln8JXa8OXxIjTBeX24s/nW5B3794yRMfNoibQetkC8J2IzPc6t4fpaVzY+WL7OtuLfHhtMewZXu9NWSiIJ1hiMJFp509M1HvuqyP+i/lcu/JQSsdVTvCnksV0leFEVXDm+y2bNgdZBKB86avB9Cvqh1UwUHE45S+FFWkDrICrQFpq+rvcHGcGp+/+RWK/qEKDubujH14EkN16makgK32ZCWshh2REnV2+dRGWf++w+w63LfhH/ASp1UH6Ki4jDTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAWCTqET23JdUWDpueDzW3PHzjUPt9mADVS+kOBhOBE=;
 b=wT7BWnBiH8HqLoBWN6a8t5z93ej/0Tlk9w4P4/LuZXuTJNLyaszrTRtNDFD6k0Yjj0SzLIoGBjMfCUYk2kOUfT/EPIIcpap3L+KO677kor/8s+0qfszk/XVjg3rnJKoUdlmIL1q5vagiAqThJfl8ucyneJDRZNua2IAaAx+6Eoc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by SN4PR0801MB7821.namprd08.prod.outlook.com
 (2603:10b6:806:208::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Tue, 27 Dec
 2022 14:00:43 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::ea42:ebaf:dd18:6a4c]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::ea42:ebaf:dd18:6a4c%6]) with mapi id 15.20.5944.016; Tue, 27 Dec 2022
 14:00:43 +0000
Date:   Tue, 27 Dec 2022 08:00:38 -0600
From:   Jeff LaBundy <jeff@labundy.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     thierry.reding@gmail.com, linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: iqs620a: Replace one remaining instance of
 regmap_update_bits()
Message-ID: <Y6r6ho5++Bg+d+bQ@nixie71>
References: <Y6p8cSYK+QKaKe7B@nixie71>
 <20221227090253.nbck3kkwfpanrcgi@pengutronix.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221227090253.nbck3kkwfpanrcgi@pengutronix.de>
X-ClientProxiedBy: SA0PR11CA0048.namprd11.prod.outlook.com
 (2603:10b6:806:d0::23) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|SN4PR0801MB7821:EE_
X-MS-Office365-Filtering-Correlation-Id: b96eee32-3c47-4b94-cc95-08dae812bebe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NWAAHXDm22HKgmrhinvglhQl9oI9C9///f+OmcBK3NB9VXznxhDjFIoHGIL2lv16umQpVHVeZvecB/vgEYLqckW3im1hBFVIHHPnXMb+7gnMR4T192tDxo0lxQe+g/LtUGFmjPT9C5MdOsC06hnD7XVGnt4dCv8thdL9z5D1HzD06M3caAk54ZahGDvXr1/Bb5R6L6cMgYWljo3KHKFR9lEJ57+l9CbdA0DeAVvvmj9r0Xn+3wPovSt/9XE4Prgk/AsWc9H4hDLnZpOSrDicDAhrft5CWQ0ef+5zGcWsvfuWZUiAo19Vaeim99K4vSNh3fEcFyal6Nvy29EZ227tIDKtRm0koyU5ncD9B5ykIxMGayZWcFHirQ+gspRKeWG32ko/s1iikNetNSNQeQJo+7DU4bdbbjD6ZIpWEoqin794gso7gXnBDrZAcO5O55F7jvLihL1FIeGeVmHnCv4rtI7sTmaYswcqfXEgxTps2UuD1wTRApiPtqI3WLKfl3XE5YQBZJAn46aRQy9cdd3yhRshSk/T74aMwgXWpSSjmltCIFJgnlgS3zlLYqdI27d5C9sKFE3PIMuV8fU+DvqWckpkhA+heLp6ZqegeAS3XGw0SVTJjceMBu1LUStTdJd2Vzsq5sskrl5WAxESANggWDThAmzZIX9pAXwEdN1GtHo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(376002)(366004)(136003)(39830400003)(396003)(451199015)(38100700002)(41300700001)(8676002)(33716001)(4326008)(8936002)(83380400001)(5660300002)(66476007)(66556008)(66946007)(66574015)(6512007)(186003)(26005)(478600001)(966005)(6486002)(6506007)(9686003)(6916009)(6666004)(2906002)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?t7q2CeQnYiRMcgDz0o62deKFx1t6zj9qODf3R51wuJJsvF6yZEC1+KLimG?=
 =?iso-8859-1?Q?dYMm7yEU2zuJ8xzFI1/M+LF2mbA50GB37FucWHEZj6+uNv1G1dOWPkQBAJ?=
 =?iso-8859-1?Q?ogMH2vnb1CyansL7bHnIGOFmxsMF1r61/a7h1bl7Wwrrnun4DtkTsOJ+RR?=
 =?iso-8859-1?Q?v8FzqWkvKNilTd+B8RSvABczcKDMkiX5SDlocifleKy0f8OHAwedJk2+iU?=
 =?iso-8859-1?Q?8F5htUwG6IPUIlGv1TmsYxM0u7J4oozkgheCAMeVztwSHgAycVA0H7JxDm?=
 =?iso-8859-1?Q?Yto1Yd7byO4WCBrQgHaRytcVg4nalVTPzWv7XBLKxXf7vzugO4lCuDoL2M?=
 =?iso-8859-1?Q?t6FFFqp79RQbHUFtqkrmcCCHjVa3aD6U9GgOq0HPZZ77FzMlKYM03gtAXa?=
 =?iso-8859-1?Q?74W7dx9FOQQcrU6+af85c1Ki5h/doyeLKBTUvIbKqvkxSKfYi+9b6nlPk5?=
 =?iso-8859-1?Q?X+HMMQBMMBHPfblF0m7XTNeq1OXYxgWfCIS+fRcxEeEsa+lZU76nqrYNGm?=
 =?iso-8859-1?Q?qHy2BMzH1cS1uAJQYcy+ijTOJRe2EvD3xnp2TvZRR2PMlpMnmulqE85IUu?=
 =?iso-8859-1?Q?alUbN78coazSYLwblU1plcXoPjYVHTwkgqonmw2+KlTzIr1joHUkp8u9qx?=
 =?iso-8859-1?Q?TUo5Sr4SZfzbn+Y/6jvnluwT5OKyt26+qQJbX5Bse0oJed7RG8Qxo4ubQm?=
 =?iso-8859-1?Q?OzlGzChMznUJ3tFbntHXwszQt9eQ2eTC45VB407RQiykQyhZg8E0quYQF1?=
 =?iso-8859-1?Q?5bFfihPsOCuw6dFkPYyXSDsoKgBR2gTltkyuvui3JseN7vFwUUOqAlwEOc?=
 =?iso-8859-1?Q?LnUR2kpJcNtCtv2LtvKkCz3UNdmzjcU2zx+4zmzZnX5RV1QfEUcVO6VB3q?=
 =?iso-8859-1?Q?Aq6owrXrl1UD5Ry6jx6z3NzUmPPOMs72qDgC84YfEoZaYwqGpGzDuVldhA?=
 =?iso-8859-1?Q?VxJ4xqtbTRwdlQWN2ajI8nvwNpIcF4Vd8GkOw8jPSeL7SXE7yx72RvUwSP?=
 =?iso-8859-1?Q?QQpH09LBdsVJ0uTGKH5WSVHKxod5kN91bwvk8jxSn6lH5ZeOmL4u73fNhG?=
 =?iso-8859-1?Q?sXxD2AunJdWm0QfpAbiFvauofbF7DhKda2XeaP9F/lYKIni7h0tmZ9gmaU?=
 =?iso-8859-1?Q?KmivivqcNFl7cPoHWgqHPLGzEWImG++x6MGnlTJBmTFg1GxnLtdlKZ18FR?=
 =?iso-8859-1?Q?yfWE5HogBKPgOjHx1muABE03cwTcepvos/Mr5GP3cMNGUXBRdI+KvdQFvB?=
 =?iso-8859-1?Q?/jDan55VO4eHfSZJjMagib34FccuSM9/QFZdOTkK7Ygt0ej9Xe1ykah+XR?=
 =?iso-8859-1?Q?0G+ehcwwU34XnPYTufTsN2txiqWfyZ7rEWBOT5URz4c1frC54C62wBKG/M?=
 =?iso-8859-1?Q?r9B2Lkb3nmIiOl+b6Cp8wWuVQ/WgJ4FeABLAZohoxU8UzIGWdIouZVln5u?=
 =?iso-8859-1?Q?zqWcfEqVHuNu7RKX3BfmW4E8N7sq9yRBCJy+IVX+ul0JCrpBP/mIE5foGI?=
 =?iso-8859-1?Q?H2LS3THjHb+qyJCfBJfhAmGwUivwm/5YANcTKGiwZSrX1QgAYQfiP9qZKt?=
 =?iso-8859-1?Q?nhHBwnmRcEgnXOLnbumGidOfsnPIJybHKndMRpDNHjZe8sEXBg5boATdj7?=
 =?iso-8859-1?Q?F2v4NmCGwZMWi4avgBP5NnPYveQ87+fEYC?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b96eee32-3c47-4b94-cc95-08dae812bebe
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2022 14:00:43.5764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IN96a8P2wK1JyXLmv47OdFVw5q61SHCcz2PiDJWWCUeszyh/QEaWIbuaXbEuCoA+YdZVlVlVfTx4f0mDJzpV1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0801MB7821
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Thank you for taking a look!

On Tue, Dec 27, 2022 at 10:02:53AM +0100, Uwe Kleine-König wrote:
> Hello Jeff,
> 
> On Mon, Dec 26, 2022 at 11:02:41PM -0600, Jeff LaBundy wrote:
> > The call to regmap_update_bits() which was responsible for clearing
> > the PWM output enable register bit was recently dropped in favor of
> > a call to regmap_clear_bits(), thereby simplifying the code.
> > 
> > Similarly, the call to regmap_update_bits() which sets the same bit
> > can be simplified with a call to regmap_set_bits().
> > 
> > Fixes: 2c85895bf3d2 ("pwm: iqs620a: Use regmap_clear_bits and regmap_set_bits where applicable")
> 
> I wouldn't call this a fix. This trailer triggers the stable guys to
> backport the commit for stable. I wouldn't support that.

My naive assumption was this commit would get ignored by stable for the
foreseeable future, since the original commit itself is not yet in any
stable trees. Rather, the intent was to complete the good intentions of
a recent commit and provide some context.

That being said, there is no functional change or bug to be addressed,
so the argument to not call this a fix is valid as well. I will update
the commit message.

> 
> > Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> > ---
> >  drivers/pwm/pwm-iqs620a.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
> > index 4987ca940b64..8362b4870c66 100644
> > --- a/drivers/pwm/pwm-iqs620a.c
> > +++ b/drivers/pwm/pwm-iqs620a.c
> > @@ -55,8 +55,8 @@ static int iqs620_pwm_init(struct iqs620_pwm_private *iqs620_pwm,
> >  	if (ret)
> >  		return ret;
> >  
> > -	return regmap_update_bits(iqs62x->regmap, IQS620_PWR_SETTINGS,
> > -				  IQS620_PWR_SETTINGS_PWM_OUT, 0xff);
> 
> This is strange, because val has more bits set than mask
> (IQS620_PWR_SETTINGS_PWM_OUT == 0x80).

Right, the intent was to make it blatantly obvious that all masked bits
are to be set, prior to being aware that regmap_set_bits() was recently
introduced at the time. Both are functionally equivalent to each other
as well as regmap_update_bits(regmap, reg, mask, ~0), the last of which
still exists in a handful of places. Granted I'm responsible for a few
of them ;)

> 
> > +	return regmap_set_bits(iqs62x->regmap, IQS620_PWR_SETTINGS,
> > +			       IQS620_PWR_SETTINGS_PWM_OUT);
> >  }
> 
> The change looks fine however.
> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |

Kind regards,
Jeff LaBundy
