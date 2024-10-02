Return-Path: <linux-pwm+bounces-3437-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F98E98E3AD
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Oct 2024 21:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8162EB23643
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Oct 2024 19:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138992141C6;
	Wed,  2 Oct 2024 19:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZQJz4awo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012055.outbound.protection.outlook.com [52.101.66.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A6518AE4;
	Wed,  2 Oct 2024 19:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727898368; cv=fail; b=pnBGAgS2CNnwD9PfI+qst0skLbn6zEjVaIHjJiBPpUk1PYEu+n0NtCOiTA24FqwJ70Fjj+KTllJFefeav5ODbmziPQZi8uzRDuVQzwnfKNhR+34jymYkp4LM7jCuRBWLbjaXv6ekh4mPIbSqC3kjGZU/mBwC4Voq0oJthO/Kyw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727898368; c=relaxed/simple;
	bh=VfgmBlLuEXPIJ+VEE3u4Wo2K0sNmw+O9JlMiTdGHEi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oli5QemB+PyhaTpHQLfLH9TmzeUeEKe35ejXgYSQU6MVhz5QVtjYl73y/f1kVI0szDgO4iSrApCt/cqaOwkA1hAw7iZ6qBvkwGiYUL5it8aRiUMuUOj97IbsvCHfQ1wPxO6BMKiNJYlpsbFnqDVRD2Jl5dBEL/kdIKKl083ZJuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZQJz4awo; arc=fail smtp.client-ip=52.101.66.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZrhZNbN3K3M6mHJNf9YRY3NYkSxyM16RzgRuGBGrvsa9VQ3JPcIzdDU/yeUnrkKmRrGKZcaGgCiFh5xhVkRCXfE5nb6V0DfzhsamR6lbRIFkQoG6xBVIuTKconO9/cZodjdVuNkQryZLbJnsJH+WE2U54L8arotLvn9Kxw3b8rVDHmHnVySX4K+zTZO6pnC2DGwayLcIRKJIZ2K8xkodjce4r8G/iEvOrSXqm0AWQLAMBVM5oneoz4y3L3GS/GHJPBTEvQflJxKZTsze5H4dYRb4Wqfg6p3U9ebk44dEFwuqZxdSLrWm55HqK6yBDGU4NT1YhpE6x94M+Qu8jVZ2kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NP/mcaLP2NmXQfzFXegZfUyyohQFO5eMVt105iQ/Ch4=;
 b=K7f5CN5faTkie6m4egt1/GoNThRTr8zaTcOFt6I8NLBybeScCVO3AncbPQjFjQxKeZyd9afDLxHK9z2JFr8ASYeZdBbgRKVYYfREURV4TG8Y+XLNKhncHVXX71hWo/B2o862wxHApJPqSPVxviJrCID83Yx2lIccc2Qyj37BvZ65F/XZfy1Pnx08/19ulOvPZ65UvWb8gVTy1YyqtuKgp9U93GQ9GjZmzJkVGveTAkXnoMtcix2s98oKGR/h8aiqgPWv2WcRmAUACodGoUe7MhQDPd2ehL1ijfwuFB9ulROtiPVC5+Y6lAoz7oH9E/ZMhXbSU1fYsyPt9GZFg6AYJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NP/mcaLP2NmXQfzFXegZfUyyohQFO5eMVt105iQ/Ch4=;
 b=ZQJz4awoc4qjUKNxf378saXqiPhllmLKb48DOFh5dZTJ5z7+gG693bEROOqHl1tc53BUk6QXoocqy3HVnqlir5CZafojt5Pxmz8934/cnxJAvusIoNAYMiU+nu4FEL9FmtpTnUao0Gjym5bXCrvx1sOfBkHFXs/VdCDhYB7HHITEx5cO6VK1pG/E/tSIV65h3B+CqKPljWwhcCc+b7Zonwf3yHBIttnAIDm0bKYxKPYQjKwVn/JRAkfYkpcDJbCTj9JOgOgoZYOmlU7hhtldvRryylqgFiudZuQnDOatoMFukv3I9+vo6kbH0SoTg11biuMe+140DDOCPIm6xbz5ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB11040.eurprd04.prod.outlook.com (2603:10a6:150:206::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 19:46:02 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 19:46:02 +0000
Date: Wed, 2 Oct 2024 15:45:51 -0400
From: Frank Li <Frank.li@nxp.com>
To: Marek Vasut <marex@denx.de>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com,
	francesco@dolcini.it, imx@lists.linux.dev, jun.li@nxp.com,
	kernel@pengutronix.de, krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, p.zabel@pengutronix.de,
	pratikmanvar09@gmail.com, robh@kernel.org, s.hauer@pengutronix.de,
	shawnguo@kernel.org, ukleinek@kernel.org, xiaoning.wang@nxp.com
Subject: Re: [PATCH v6 1/1] pwm: imx27: workaround of the pwm output bug when
 decrease the duty cycle
Message-ID: <Zv2i73MvKASJA+2x@lizhi-Precision-Tower-5810>
References: <20240917192510.3031493-1-Frank.Li@nxp.com>
 <4bbee009-3985-4679-a85e-76f4259ff8d6@denx.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bbee009-3985-4679-a85e-76f4259ff8d6@denx.de>
X-ClientProxiedBy: BYAPR05CA0084.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB11040:EE_
X-MS-Office365-Filtering-Correlation-Id: 486c71aa-1596-4c07-a487-08dce31ad8c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fw090IjUjwPRNV1KK5N1Pu42xki3J/3WSEbObz/kZWf6gAIbcYnS+/uHpoAw?=
 =?us-ascii?Q?09C9RHrQ7pUZ3k4tHIwFsDHQ91tyWpYiG8ngVMugcwltDQOo/hOgMV0PNw5D?=
 =?us-ascii?Q?X+83LbT0PVLRRy2yH4LHGWR5vrxoxCXNgk8egUVyGs88HJ4hNropnccsKFC2?=
 =?us-ascii?Q?6q0ojNTxkETW5rXlizgG/f2b87wo/XutGCeHPDgFmX/VthSwbPq2FiK6FyAc?=
 =?us-ascii?Q?qgY6BnAOE0CLRoF68cBtAc5qBr89LyC9fgwhONpF3K5mJsx9/GFM8ksEGXHr?=
 =?us-ascii?Q?QKJBg8ixxyXihfYmNjGRzRnQShJw3tiXuHtABtfSMzB+49uWLoR8BR6+PV+y?=
 =?us-ascii?Q?3kM754EcRyQF/d9xfQAnVrdExNZEv4Fvmgay4T8QzQRGi6riffRDcT7cGBk+?=
 =?us-ascii?Q?ZQ48sibssLkEiUR95IIulASmwwNZ6nnLUKjSTh4GW8DPSDHfis1aXPZhKPro?=
 =?us-ascii?Q?MjpLeT9hNpeR3L2m33S1abmldiG5Pj6HLiJ7QvxY6SaEX9/pKAgJkTNdOSn7?=
 =?us-ascii?Q?XV5r6y1Vf6Zak8NUD/Zkkz/dU/KxNNILAR3HzOgNP+Jw+yglVLzOsSWf8nHP?=
 =?us-ascii?Q?vB4H5sh3vSb7OigVkICzVaZyVy/59re4/hwCPkKvtHEewHiuyXOHiqWu07cR?=
 =?us-ascii?Q?wjsl5zwkVd/y4ktg63dsVTbcR64dDqWjnXkGZWx/b8aGLYppxnmA3D8c9srZ?=
 =?us-ascii?Q?oRWyM5tfOL7kNeb6bziwV8XFvhUQeC/nNRWN9rWympDov3yYZMhqNcZywSsZ?=
 =?us-ascii?Q?pHsidnJ68pVcVfp5vRg7Xv1xFjr85Z48MvM2y0X9GQLQtIBoTtEbrMcho8T3?=
 =?us-ascii?Q?t7LwEt0HwOmLEfsf7+OrJZcQbazlOXv0ZNpKW21b1wIN9iEhsFNg5DMKkBB7?=
 =?us-ascii?Q?+yLuQs+2iFCLUBZF16EJVgc4Dxpeh6B7nUuL+EEuwflJZvvSLrw02kIAQYpr?=
 =?us-ascii?Q?KQIPFBON2nnzIwZ/anAH3RE44Pl4dp6FdyW2UmWz52rFYBH4N2I28zvIRUIh?=
 =?us-ascii?Q?2Q/ZCZHIFkG1jKjr8TCiVSWjnkFJJOFDfp5CXXXLdZZmD5b6h24miluugkls?=
 =?us-ascii?Q?8fpaJHxX71Y4ekYo8+0BTZUpa5hEzxYMsYaYiV/OjYi07lRY6Ui5XABzyCdx?=
 =?us-ascii?Q?JWxsYy2eeTnUyt1wMHjpXepoTguAm1QdgF4dQprEdlI6GC2QyxlvZ2QZppFE?=
 =?us-ascii?Q?lbdd9Mor5clCmOCKBy8fZgz/eVeuaGhJ1aqSqMxkxoYkdiNdZckNx4oYfL7M?=
 =?us-ascii?Q?2M2SG8iM3gxCa1qjdqQQVzpbSdLIXSaz4hsX4I9UzMaad7HYIviu0+jGu1Fg?=
 =?us-ascii?Q?AIEMEAAQj3VjZn3txD6Fa30B0HDn6P9hPKNJ+1yLT2aRSw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iPPJPXQjG3L9bk158eHlaJiZF7bhMArBQ7x6eq0mY7ocZWtPca7IPFLmfG2W?=
 =?us-ascii?Q?/+1CqolnL57i6Y0b/FkSffq+tknlE+BV3lDxcypHW8+UE16snIpV+xEaAiOB?=
 =?us-ascii?Q?3owhyPBlxHWEO2Bf/WdOtDTrFd2ZzIvk+K7QG6W0O3Ck/fSak47PgDCNDmnE?=
 =?us-ascii?Q?k27HSUDfdhxOkxYWT6SgLHffxZVonQa3xBOST2ypriC+iAM1PEY+M174UKFC?=
 =?us-ascii?Q?AZTljlZjvD6l3B+M9H5sVDkcsHpZ2x+ct8MxqdCxwxHTSkdWJjw7yYM8QhXF?=
 =?us-ascii?Q?3qN5DHdyR9Fn8VzGxgbGgqx5RY3sGVEq4yzF7nPArUm9+fMnRikcS48R7o7W?=
 =?us-ascii?Q?Ym6Jm989nFzZPP3Ge3P9ei+ep2cyH0Thgoy/GFia7FJ+5VvQgZgzq4GugxXg?=
 =?us-ascii?Q?t1nd8ryNZR75zNXxqja2A/U0PtPqr1CS8NYGDkLUdCqK29MmoYO4eg65QMdz?=
 =?us-ascii?Q?zboGVQ+MgiFve69dYeMi/nYXOez12mITlaX3pFbzTYM8K+ZHOux+9lesUfGd?=
 =?us-ascii?Q?wMdSv60m3zfEym12p5fMh4FW7Qhqq8HCLGXCCMBFH++XwAilIjWC1dBDya84?=
 =?us-ascii?Q?kfdGZbN6Kuy+1wA4/sNhfwHaU5tcxVr/Qf8+n1cU7PXj5YaFlL8yjXHsP4NH?=
 =?us-ascii?Q?g3B4pmtefEurehsOexLrSGnqbcVsvgkm0kqVjARejWqyYE06GYhUw7uCCkRw?=
 =?us-ascii?Q?2NS5hqJlWngMOagqHzwS3gG6XellifR+/uvXnHyQtP4wqME+Ph5HOdXYTZUs?=
 =?us-ascii?Q?Oz0eGXFelu5tOxrEa28uIVp21R5q0JJr8YGqnttcWrTe1Al7RTvHt2ZQpucL?=
 =?us-ascii?Q?A5FxIk35KgNJn/FOLTu/UOt51940pCdQjS4VwuOn85KsxDreQUM6cP8yPpM/?=
 =?us-ascii?Q?cwdWGP6qGxTExb3pRUR8xQf+Wnv8bypRR6Wm49hiQND6nRXGLOPBea+edXaJ?=
 =?us-ascii?Q?Op1y4UjB1eiBqu6CJwj+iNk3AdzEoxF5T9j/P8vUnTD6UJ2Dge4A75stlDOm?=
 =?us-ascii?Q?oF/OhIXB53AGKrqlKWz3yePFElWcw7ohfnIWrleIXr4rYe4P/pIc6/MR9Fmr?=
 =?us-ascii?Q?i3RSlR4y0spCOTxMG4kXATHW8lhWamgo8KslDMKgO4KaRRpNo+OSVLeHFoSp?=
 =?us-ascii?Q?6cOFFUtoKeTJEOhcdB2bctDt0Mfk4AbFZMyi66BdZw7++lFit1ivw+DY9idz?=
 =?us-ascii?Q?39ee0jyrYPWRRPXGaqxUAgToujGISMwst1KR1xYR1Byjug9kHH2nALLXSfIr?=
 =?us-ascii?Q?12T1bSe+LnlF8iGbmyDGrlraUk7ECGVZFwO32gXe8d41kiCUFR8mMtT8F+2J?=
 =?us-ascii?Q?cia9Xz/PMTgCFgPuuiHuizF6XyN1ER1sBktYObSua4w/vZMkoBY95ykVCxtk?=
 =?us-ascii?Q?iXJrMx0yd6qHaT2088Fclzr4I1uElEVrtiCmBeJF23iW6Kzo9L2KUbKG3Oph?=
 =?us-ascii?Q?M+hhKD33X/PYC6q7Rk3OfaVgHzERnkXZdTXJo81m3Nz9pIXGj7f3AhZE9TEX?=
 =?us-ascii?Q?K5cFd5spSOMSjFRzudIPIXqF9+N91siBg+UUAxNKOXMp+PObMUwTmQmBQbd8?=
 =?us-ascii?Q?lESgCGf4azW7D9qn4TI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 486c71aa-1596-4c07-a487-08dce31ad8c2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 19:46:02.6467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kiNj8lOIVIywu9CkC/+aGSZ7l7oFbZcngcpX2qoVpubmWsGpc6x22PbG4iWuD2IFWTkWUT1woojgUmDepkvfxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11040

On Sun, Sep 22, 2024 at 10:28:02PM +0200, Marek Vasut wrote:
> Hi,
>
> On 9/17/24 9:25 PM, Frank Li wrote:
>
> [...]
>
> > @@ -223,6 +224,8 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> >   	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
> >   	unsigned long long c;
> >   	unsigned long long clkrate;
> > +	unsigned long flags;
> > +	int val;
> >   	int ret;
> >   	u32 cr;
> > @@ -263,7 +266,69 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>
> [...]
>
> > +	c = clkrate * 1500;
> > +	do_div(c, NSEC_PER_SEC);
> > +
> > +	local_irq_save(flags);
> > +	val = FIELD_GET(MX3_PWMSR_FIFOAV, readl_relaxed(imx->mmio_base + MX3_PWMSR));
>
> I think the multi-write I mentioned in v5 for > 500 kHz case could further
> improve the patch, let's see what others think:
>
> if (state->period < 2000) { /* 2000ns = 500 kHz */
>    /* Best effort attempt to fix up >500 kHz case */
>    udelay(6); /* 2us per FIFO entry, 3 FIFO entries written => 6 us */
>    writel_relaxed(duty_cycles, imx->mmio_base + MX3_PWMSAR);
>    writel_relaxed(duty_cycles, imx->mmio_base + MX3_PWMSAR);
>    /* Last write is outside, after this conditional */
> } else if (duty_cycles ...
>
> > +	if (duty_cycles < imx->duty_cycle && val < MX3_PWMSR_FIFOAV_2WORDS) {
> > +		val = readl_relaxed(imx->mmio_base + MX3_PWMCNR);
> > +		/*
> > +		 * If counter is close to period, controller may roll over when
> > +		 * next IO write.
> > +		 */
>
> c is only used in this if (duty_cycles ...) { } conditional, the do_div()
> above can be moved here:

It is in local_irq_save(flags) scope, it'd better as less as possible. So
I prefer do_div() is outside local_irq_save()

Frank

>
> 	c = clkrate * 1500;
> 	do_div(c, NSEC_PER_SEC);
>
> > +		if ((val + c >= duty_cycles && val < imx->duty_cycle) ||
> > +		    val + c >= period_cycles)
> > +			writel_relaxed(imx->duty_cycle, imx->mmio_base + MX3_PWMSAR);
> > +	}
> > +	writel_relaxed(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> > +	local_irq_restore(flags);

