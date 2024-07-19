Return-Path: <linux-pwm+bounces-2866-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19828937D8B
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Jul 2024 23:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98BC91F219D1
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Jul 2024 21:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BA114884D;
	Fri, 19 Jul 2024 21:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="agnANXbk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010019.outbound.protection.outlook.com [52.101.69.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E371B147C96;
	Fri, 19 Jul 2024 21:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721425403; cv=fail; b=M/o9xHdjQZxu+b+K8iKxwOG2BfmpuSHUQpSynC2YtH6dUaUCeASjAiY/mlcCycs6N6A9Erhp8MFrUeJS2X2qsbfx6rjvdBmQjgQ2i3xhGrBy85gPhceGvrOyNVrgIQfDkn/WNeNZTad1In7160y5mV5a4UEjRcli07Ky4I6ROCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721425403; c=relaxed/simple;
	bh=qaQNJGN1oNIXVMoL3NI4fEdgX7SbD6uSwJ157ByVuMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d8Mq++HhgdVHph+jHW+9LnAsCK0sIU/4gzRC31rjdUoIlpPlL59Z6W6rzY0qRrXSHNeipEAv2bMAsf2MFOcVjwijyV8bDzRKe1xC2gX4Ybx7kQoX2aYaMUNtnqiLImY630uQT2JK1ox89lMcyWkfqriMPd8XePZuECS/QozV7NQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=agnANXbk; arc=fail smtp.client-ip=52.101.69.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8GL+j47+8PUpIz2zElDOhuiG0gA1zbA3ut1WBRvuT+iq2BwAZ0nQ4qA8CcORAPfWATLrqtdbC7Q05eLQTttmkXQjag5jnzlWSt6VRXdTafVy1gyeUFRfOj7k9BqWPeSLqdVHO63C4VNWAXWPmP0/iyuZ7LrrgVuAemwz8PIM7I/zzYRJ27ohKZXN+lRDfwLiS+sYi1sWbeTIndaM2bir/xbU8jM7uz98phQBlIUST03CUrI9q/BJbaJDnahS/DHHQWujWa7q+ZdaHMWNdht2WqdDp7aZJukZYT+Hopi9TGyLdp0fm6IFmafh2goSQ6YRVZaS86ryWh5yYZSCtE8qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AinYF4OWLOMbPpLeSCH88dm1kieWJiKAGo9d5ap1STY=;
 b=Mz5CGN7DjQsLHrezHmNuvNLc0R38kVbMIGCZ6pNtPt8xrTOENyhPJ9k7tdw19XrW3IShCAdOfS3D3z3FRQ8zNIBqPEuEKrkXXJQIjxnsmiY+GW4pvR0VxCIkn8t7RJaED6XfCfBkZDNEop6Gf6c+9HaK48OMvL5ADqBtz9PO0vR+n5HOI+RW8Tb4ihAQn1s1lLBTKOAcKIi5nXn/76Ekwly4gNJ/xjUj1TeOxjaQjjyMa78lmBFa/pCBuShz9+OnQaBU9pJRcUg7no1uUvDxHLPKHPblxzFTco00zteJC1Tga+BquUudVSRGmm4JlK/pDK5qW39n9RuJPGDqmzU28Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AinYF4OWLOMbPpLeSCH88dm1kieWJiKAGo9d5ap1STY=;
 b=agnANXbkTMXj6abIK72q2oMSEtr3gbFNpyFs7tv0dNJYi7AuSg5B4hWMExYHhJ1NZkKovZJNIOA9UY3skuSE8mF525PcqHJP32+40RVS6YzBDtxzngjWoH8P5zbh5f1p0EZA62Os8ZhCQZJ3/hTojn7elQW/xeigqoHRSy7m+8s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10783.eurprd04.prod.outlook.com (2603:10a6:800:267::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Fri, 19 Jul
 2024 21:43:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7784.017; Fri, 19 Jul 2024
 21:43:17 +0000
Date: Fri, 19 Jul 2024 17:43:09 -0400
From: Frank Li <Frank.li@nxp.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Haibo Chen <haibo.chen@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>
Subject: Re: [PATCH v5 4/4] pwm: adp5585: Add Analog Devices ADP5585 support
Message-ID: <Zprd7cdIQujwrwcJ@lizhi-Precision-Tower-5810>
References: <20240719203946.22909-1-laurent.pinchart@ideasonboard.com>
 <20240719203946.22909-5-laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719203946.22909-5-laurent.pinchart@ideasonboard.com>
X-ClientProxiedBy: BY5PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:a03:180::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10783:EE_
X-MS-Office365-Filtering-Correlation-Id: cce6e689-003a-4904-132c-08dca83bcd05
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?2QEBwS0A5m8NTKTkaXR0BsPbdbKfO/EvA239ax2dH6k/8USABuTtl4YbvhQv?=
 =?us-ascii?Q?UWaF1oZAkaIwQTfpwDaCo529k+7n4gyJMhY7uDUkrVBN8labQz2tG/lk76rZ?=
 =?us-ascii?Q?HJgWgxDioA5AZXiqzZEQDoSNg/YZMc01Z13MGl/5VqfqMMBzPHaLu3FxrP5V?=
 =?us-ascii?Q?D/ZMK1bXjzXizeSYwcTxFMh2kQvRpnbmhSAvWUlj/gr1sizXRei+aD9eZ2tg?=
 =?us-ascii?Q?Vhi8uRho+dsCGtIUAIkphwc40IWpFThVSX2joPbFDoCVSxk2e4x/fmJjkzKi?=
 =?us-ascii?Q?/gaUVg1mDYb2e7PWYr5JFLZrPUnZREWIrPpR6oRpVicTyp0ssI8uedg3dAeL?=
 =?us-ascii?Q?YY1O8Jmv128zxQN8Hz3+2WyWthal/Gd3+DFCnllrGW52mYd0xhAjac67vssw?=
 =?us-ascii?Q?GuB4aG4exdLQ1Z6YQ9wTpIS6bBmyrE8Eb12mkHymq0JGAXxiS067I6KKaU48?=
 =?us-ascii?Q?zOZ5w/CPgvLfIbKMXALsbdS0zxJDdA4fYnx1OfjYhSxULzafe3hC73kIE8hz?=
 =?us-ascii?Q?UkFho4t5REQ0bkrpBgaWkf98JumMnwwh2A4vbafI4jPHLZMhFzrAoSJipHdb?=
 =?us-ascii?Q?EzaBYjoR3h4ei0k0iQcMZkmYLm6KPjxtIQyHES/PwVi1/j01WfCE1XzaJjCz?=
 =?us-ascii?Q?RI5XVKr+0Uw/QAwrPXWwblGxqrZWs03PBGXMfixtahMC7BWJG/a5xkJk2QRL?=
 =?us-ascii?Q?X+9mpKZX+BCbU3f5iWgYPuDwAirr+hXtN4oOG6lL4x4fZRQGai0aMmDyIXy8?=
 =?us-ascii?Q?NIKotkQUfiB9MUgjyVvrJwzGqjZ1CjuAbqxKmArAVG4kSgUeTUuN8t/tyb9D?=
 =?us-ascii?Q?HEpbFMxS3z1AxR8bGGtJyG6Bm/9DO16PH8QaJaiaAMgfax4isu+/jMNosl4B?=
 =?us-ascii?Q?fdNGBU6v8CLsXgj7g2ak8BrE++3BNf1oiO6eDsy+nygk46eS8RzxqvdIx2Dc?=
 =?us-ascii?Q?U4JICNpeywbJjRCQe55R+/jaFOMOMbiRWyalUYsur415rpm73GcY6Nx1/5vJ?=
 =?us-ascii?Q?ZFWt5yxqPFQIXAOduaEN8OIDathRs+ntNKKyn9Dz1Un1ojy+reLOTLdejTjr?=
 =?us-ascii?Q?J219XiJOWgn1wNjxehWYVPhYh7b8aGAoiDl9QRtKt8M6ig0Ba+6kqWCtwz56?=
 =?us-ascii?Q?VgRebhP0v08AkrJPfjrJuzBGmGRILicXagrJcvGUUjeIeQs69wccEYYr0e8H?=
 =?us-ascii?Q?1taaiTmSipbPbdpASvlnbz4lEKaqaVzlw+SSETpLQE3ymJx5SCWggYyQIDPf?=
 =?us-ascii?Q?5grslygsfETEZOSUk0gAgLaiFGoa6u3WpXV42DsuO/BinJINmL55+PTnlEJx?=
 =?us-ascii?Q?Q9r/IsbcEqZDG4vZmW33fIW2h8ICm3BpYUdCy4FInfAWeWtezRV5PPNAm57u?=
 =?us-ascii?Q?icBAiZOnTupHqENOn6hsO+4lvvBxPQNF5Q6tGW6hr0U7H/IFHQ=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?x4+aNcil3jAayrEQMnF3ilDRVCntehM94t+YP4ZqoBDyQ1kljE8dY6yhjgp1?=
 =?us-ascii?Q?DqXfn8mkPIsMbIXo8xcHoKxRjVZAaTaJAWvjs5Bjs0j35+OuYN/TKbi70dE5?=
 =?us-ascii?Q?6P5ZcbxBpjq3T/kt+3NvbIWDf+3O+WBHjh+BdqFBGd/1POBOt2Y0alGA2XO3?=
 =?us-ascii?Q?gjFgap5N+8rhs+T3WLsHxkIg96xSdSN79RogzQ6fGeaIirZszwsXtrR2z4qW?=
 =?us-ascii?Q?P8BlcodmhiWXLDg7uyYYk27899uuACoQxp9T+uVW71baCJ7nbiIAKS/EmOC6?=
 =?us-ascii?Q?IOtnoXZuZfvsO1aeMWiRziTBtXSp4B6dk2oKM/pigO7945qUIrMbF8Px3Oxp?=
 =?us-ascii?Q?SiBeVt0Hmd2VePLFRfX0ZO7UkXaYkpuJuhx8lkXh3pyykm1nSdPqdQAJxc02?=
 =?us-ascii?Q?+58cc+sclk5cJjKfxJjlzx/S7o2o/kxwroqhvrvudmTvO23jL3Bj+xms6mHy?=
 =?us-ascii?Q?u1nF34DnsUmvEeVcrK1grIlTbq+NJQBJhyJmRNrQs+0vQI5kB9zgKygdeoB7?=
 =?us-ascii?Q?7Gu7VAIGLGhjeCpAEn9rWCrRx/bQh2zvQ+0UL0peNyR2AtUpGp8JfpnD6TPk?=
 =?us-ascii?Q?vFOLNDvGYEDobspZ3SIqKqLwvv0oBuVSL0ZdCemZ8PKTAkIPvA5kx2hNrkgO?=
 =?us-ascii?Q?HXpRsdR6xnnTN7r8rBYTnKCkAupVFeccOBdOWpHVIRp92I2vbM4io7Um3qQd?=
 =?us-ascii?Q?NIoUHdQ03V1DgIiq/7e/SEsjyTmnqikayqtqFZmdnyqLGJrkYCpPB7HNtChN?=
 =?us-ascii?Q?0XjS2O7ppIaXT14V2FwbJfRaiGwRnykisKTIIftHYF8uOd5LGNy2INnMhhtU?=
 =?us-ascii?Q?obKkTX6z5k5njo/DdjVHiwiKaM0wUfAJQG80wiCU6fvqEHdp1B30YHxVwVcU?=
 =?us-ascii?Q?8ahnODb4lfjQ5NLkevIAMsnFtedMrD1EZCpbMP+fWwX4gEy4BEbHcQ5cw5nd?=
 =?us-ascii?Q?LilMlw4oWZL7fLeMPS6twd7yzBltbP3x6yO7/3TLn/cepfPWzJa2TLYIFZFO?=
 =?us-ascii?Q?eVImnSikMfWHJ5B+OSnG1fc1pfCml1k3Ogou3e/THtL/U9U/XX9UhsrFewQ4?=
 =?us-ascii?Q?OG+RnQrnHneNx13xkG3E8NubQOGL13lKDxCvA7U77l6UT05rN579s6Y1UwRN?=
 =?us-ascii?Q?wthTeXijVzI9k1iEd+Zq7/rjQa4mmk81s5J1sGCnNc/RMugek6rsKbuwU2Gr?=
 =?us-ascii?Q?t6ZrE/NDzCCM96LNJ6rv5fGoH3YtTkInTdCZ+8zMzbGRNRthoN40CP6929VG?=
 =?us-ascii?Q?fVEMGfm/mKsAoi+NenMGpXShL8vH1iV24ZM5D84hLdvQqzVGurF/9Qpb9suU?=
 =?us-ascii?Q?yLPv33yVV2wlHvnzjEWK6B01EhqcVUoYBEPxynvovJDtYFXQSAGbibE99sf6?=
 =?us-ascii?Q?PHf8OR7G8aTx6clvHLFRLxb7ER8glcuFOpyeMJhPX+1UxTUQNZInIq0aZgeR?=
 =?us-ascii?Q?Uk7skYI81pLaFkpPMK555LWZXQu1k78k9KEx1aoBiARd8WBMSa+2yS7dAU0j?=
 =?us-ascii?Q?Ja7MQmc7qXs5XlXA6W0zvkB05PLVdT0d6Jy/Fd3/fp7SrszprZ3uEXFAFt6J?=
 =?us-ascii?Q?witvgbJFPKLB2XXFZnguP6ZNaiNl41F8fmr2YI/4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cce6e689-003a-4904-132c-08dca83bcd05
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 21:43:17.7031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CzEUc6jWDBa5AvkcJ873umE02iMMCRht+UajKV/I2CbhTuu+0vF51szFAAkkfubuhbnE8tS5bEsZXjyws5BWmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10783

On Fri, Jul 19, 2024 at 11:39:46PM +0300, Laurent Pinchart wrote:
> From: Clark Wang <xiaoning.wang@nxp.com>
> 
> The ADP5585 is a 10/11 input/output port expander with a built in keypad
> matrix decoder, programmable logic, reset generator, and PWM generator.
> This driver supports the PWM function using the platform device
> registered by the core MFD driver.
> 
> The driver is derived from an initial implementation from NXP, available
> in commit 113113742208 ("MLK-25922-1 pwm: adp5585: add adp5585 PWM
> support") in their BSP kernel tree. It has been extensively rewritten.
> 
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Just some small thing by using regmap_set(clear)_bits to reduce a args.
But it is not big deal. so

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
> Changes since v4:
> 
> - Use the regmap bulk API
> 
> Changes since v2:
> 
> - Add missing headers
> - Sort headers
> 
> Changes since v1:
> 
> - Drop mutex
> - Restore R3 pinconfig to known value
> - Simplify error check in pwm_adp5585_request()
> - Don't fake PWM_POLARITY_INVERSED
> - Fix rounding of period and duty cycle
> - Drop OF match table
> - Drop empty .remove() handler
> - Allocate pwm_chip dynamically
> - Document limitations
> - Add platform ID table
> - Set struct device of_node manually
> - Merge child DT node into parent node
> 
> Changes compared to the NXP original version
> 
> - Add MAINTAINERS entry
> - Drop pwm_ops.owner
> - Fix compilation
> - Add prefix to compatible string
> - Switch to regmap
> - Use devm_pwmchip_add()
> - Cleanup header includes
> - White space fixes
> - Drop ADP5585_REG_MASK
> - Fix register field names
> - Use mutex scope guards
> - Clear OSC_EN when freeing PWM
> - Reorder functions
> - Clear PWM_IN_AND and PWM_MODE bits
> - Support inverted polarity
> - Clean up on/off computations
> - Fix duty cycle computation in .get_state()
> - Destroy mutex on remove
> - Update copyright
> - Update license to GPL-2.0-only
> ---
>  MAINTAINERS               |   1 +
>  drivers/pwm/Kconfig       |   7 ++
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm-adp5585.c | 189 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 198 insertions(+)
>  create mode 100644 drivers/pwm/pwm-adp5585.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b748af2acf9f..a2087f6647e8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -534,6 +534,7 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/*/adi,adp5585*.yaml
>  F:	drivers/gpio/gpio-adp5585.c
>  F:	drivers/mfd/adp5585.c
> +F:	drivers/pwm/pwm-adp5585.c
>  F:	include/linux/mfd/adp5585.h
>  
>  ADP5588 QWERTY KEYPAD AND IO EXPANDER DRIVER (ADP5588/ADP5587)
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 1dd7921194f5..b778ecee3e9b 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -47,6 +47,13 @@ config PWM_AB8500
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-ab8500.
>  
> +config PWM_ADP5585
> +	tristate "ADP5585 PWM support"
> +	depends on MFD_ADP5585
> +	help
> +	  This option enables support for the PWM function found in the Analog
> +	  Devices ADP5585.
> +
>  config PWM_APPLE
>  	tristate "Apple SoC PWM support"
>  	depends on ARCH_APPLE || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 90913519f11a..f24d518d20f2 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_PWM)		+= core.o
>  obj-$(CONFIG_PWM_AB8500)	+= pwm-ab8500.o
> +obj-$(CONFIG_PWM_ADP5585)	+= pwm-adp5585.o
>  obj-$(CONFIG_PWM_APPLE)		+= pwm-apple.o
>  obj-$(CONFIG_PWM_ATMEL)		+= pwm-atmel.o
>  obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+= pwm-atmel-hlcdc.o
> diff --git a/drivers/pwm/pwm-adp5585.c b/drivers/pwm/pwm-adp5585.c
> new file mode 100644
> index 000000000000..472a4c20b7a9
> --- /dev/null
> +++ b/drivers/pwm/pwm-adp5585.c
> @@ -0,0 +1,189 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Analog Devices ADP5585 PWM driver
> + *
> + * Copyright 2022 NXP
> + * Copyright 2024 Ideas on Board Oy
> + *
> + * Limitations:
> + * - The .apply() operation executes atomically, but may not wait for the
> + *   period to complete (this is not documented and would need to be tested).
> + * - Disabling the PWM drives the output pin to a low level immediately.
> + * - The hardware can only generate normal polarity output.
> + */
> +
> +#include <asm/byteorder.h>
> +
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/math64.h>
> +#include <linux/mfd/adp5585.h>
> +#include <linux/minmax.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +#include <linux/time.h>
> +#include <linux/types.h>
> +
> +#define ADP5585_PWM_CHAN_NUM		1
> +
> +#define ADP5585_PWM_OSC_FREQ_HZ		1000000U
> +#define ADP5585_PWM_MIN_PERIOD_NS	(2ULL * NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ)
> +#define ADP5585_PWM_MAX_PERIOD_NS	(2ULL * 0xffff * NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ)
> +
> +static int pwm_adp5585_request(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct regmap *regmap = pwmchip_get_drvdata(chip);
> +	int ret;
> +
> +	ret = regmap_update_bits(regmap, ADP5585_PIN_CONFIG_C,
> +				 ADP5585_R3_EXTEND_CFG_MASK,
> +				 ADP5585_R3_EXTEND_CFG_PWM_OUT);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(regmap, ADP5585_GENERAL_CFG,
> +				  ADP5585_OSC_EN, ADP5585_OSC_EN);

regmap_set_bits()

> +}
> +
> +static void pwm_adp5585_free(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct regmap *regmap = pwmchip_get_drvdata(chip);
> +
> +	regmap_update_bits(regmap, ADP5585_PIN_CONFIG_C,
> +			   ADP5585_R3_EXTEND_CFG_MASK,
> +			   ADP5585_R3_EXTEND_CFG_GPIO4);
> +	regmap_update_bits(regmap, ADP5585_GENERAL_CFG,
> +			   ADP5585_OSC_EN, 0);

regmap_clear_bits()

> +}
> +
> +static int pwm_adp5585_apply(struct pwm_chip *chip,
> +			     struct pwm_device *pwm,
> +			     const struct pwm_state *state)
> +{
> +	struct regmap *regmap = pwmchip_get_drvdata(chip);
> +	u64 period, duty_cycle;
> +	u32 on, off;
> +	__le16 val;
> +	int ret;
> +
> +	if (!state->enabled)
> +		return regmap_update_bits(regmap, ADP5585_PWM_CFG,
> +					  ADP5585_PWM_EN, 0);
> +
> +	if (state->polarity != PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
> +	if (state->period < ADP5585_PWM_MIN_PERIOD_NS)
> +		return -EINVAL;
> +
> +	period = min(state->period, ADP5585_PWM_MAX_PERIOD_NS);
> +	duty_cycle = min(state->duty_cycle, period);
> +
> +	/*
> +	 * Compute the on and off time. As the internal oscillator frequency is
> +	 * 1MHz, the calculation can be simplified without loss of precision.
> +	 */
> +	on = div_u64(duty_cycle, NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ);
> +	off = div_u64(period, NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ) - on;
> +
> +	val = cpu_to_le16(off);
> +	ret = regmap_bulk_write(regmap, ADP5585_PWM_OFFT_LOW, &val, 2);
> +	if (ret)
> +		return ret;
> +
> +	val = cpu_to_le16(on);
> +	ret = regmap_bulk_write(regmap, ADP5585_PWM_ONT_LOW, &val, 2);
> +	if (ret)
> +		return ret;
> +
> +	/* Enable PWM in continuous mode and no external AND'ing. */
> +	ret = regmap_update_bits(regmap, ADP5585_PWM_CFG,
> +				 ADP5585_PWM_IN_AND | ADP5585_PWM_MODE |
> +				 ADP5585_PWM_EN, ADP5585_PWM_EN);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int pwm_adp5585_get_state(struct pwm_chip *chip,
> +				 struct pwm_device *pwm,
> +				 struct pwm_state *state)
> +{
> +	struct regmap *regmap = pwmchip_get_drvdata(chip);
> +	unsigned int on, off;
> +	unsigned int val;
> +	__le16 on_off;
> +	int ret;
> +
> +	ret = regmap_bulk_read(regmap, ADP5585_PWM_OFFT_LOW, &on_off, 2);
> +	if (ret)
> +		return ret;
> +	off = le16_to_cpu(on_off);
> +
> +	ret = regmap_bulk_read(regmap, ADP5585_PWM_ONT_LOW, &on_off, 2);
> +	if (ret)
> +		return ret;
> +	on = le16_to_cpu(on_off);
> +
> +	state->duty_cycle = on * (NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ);
> +	state->period = (on + off) * (NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ);
> +
> +	state->polarity = PWM_POLARITY_NORMAL;
> +
> +	regmap_read(regmap, ADP5585_PWM_CFG, &val);
> +	state->enabled = !!(val & ADP5585_PWM_EN);
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops adp5585_pwm_ops = {
> +	.request = pwm_adp5585_request,
> +	.free = pwm_adp5585_free,
> +	.apply = pwm_adp5585_apply,
> +	.get_state = pwm_adp5585_get_state,
> +};
> +
> +static int adp5585_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct adp5585_dev *adp5585 = dev_get_drvdata(dev->parent);
> +	struct pwm_chip *chip;
> +	int ret;
> +
> +	chip = devm_pwmchip_alloc(dev, ADP5585_PWM_CHAN_NUM, 0);
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +
> +	device_set_of_node_from_dev(dev, dev->parent);
> +
> +	pwmchip_set_drvdata(chip, adp5585->regmap);
> +	chip->ops = &adp5585_pwm_ops;
> +
> +	ret = devm_pwmchip_add(dev, chip);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to add PWM chip\n");
> +
> +	return 0;
> +}
> +
> +static const struct platform_device_id adp5585_pwm_id_table[] = {
> +	{ "adp5585-pwm" },
> +	{ /* Sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(platform, adp5585_pwm_id_table);
> +
> +static struct platform_driver adp5585_pwm_driver = {
> +	.driver	= {
> +		.name = "adp5585-pwm",
> +	},
> +	.probe = adp5585_pwm_probe,
> +	.id_table = adp5585_pwm_id_table,
> +};
> +module_platform_driver(adp5585_pwm_driver);
> +
> +MODULE_AUTHOR("Xiaoning Wang <xiaoning.wang@nxp.com>");
> +MODULE_DESCRIPTION("ADP5585 PWM Driver");
> +MODULE_LICENSE("GPL");
> -- 
> Regards,
> 
> Laurent Pinchart
> 

