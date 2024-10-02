Return-Path: <linux-pwm+bounces-3439-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFBC98E3C0
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Oct 2024 21:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88C791F242D1
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Oct 2024 19:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18427216A12;
	Wed,  2 Oct 2024 19:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CBBTzj3x"
X-Original-To: linux-pwm@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2076.outbound.protection.outlook.com [40.107.22.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A34216A06;
	Wed,  2 Oct 2024 19:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727899085; cv=fail; b=eissGWdXiurHXmAU6ZLuxtkfbk4CYSDYL9rSLZ+LRguV+5EaDkjr4UiKxPLY778IzcUJa91URa3BrCK0Z877qDv4s2xlBiUbNTJIX397QeX0fdK54yowTNBEopCnccADfYnr8sE+toVBxpZ0s2ROkhXKdHl1I71S8+Kgg2bX/aY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727899085; c=relaxed/simple;
	bh=IEn6fYNYlS+8TRFMs4/spTOAL8XjXimYbqhpoAa6J/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=slj1F2Z8QU5pceSM1cGilCzKi473ozoaWOQpoVAkxsYPtytLMGTkMKiGt38+U66BFz5lZBs6rqkM+FzBTUFt9r8Tuac+dtRm6GO+/HrTaiO+AxjT2mehi1tTkB+vO+P7GJz6wVe7aQRVB1jOTH3Zzprvz3Ct+B2YjTl6UhvfHAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CBBTzj3x; arc=fail smtp.client-ip=40.107.22.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Voua9D1dszc5gl+pfoNraNk5TNjkpV8fxbjY04sXHSmpyuGY0VCRn/minTns9gqARDrkrToPxA2b3mJuWfMEJ92WIpTxPXqmIBWZHfiSnuvDE7vMXqYCRhk6a77fLpZlsMOncmN+DYvYnFp2bPDyyqYTYZRLhCVBqch6PtY7RICLOlQeX7AKh46zQx0A7hQfs9SR4auCyi4tKJSJAXLUYDXfliLiUqoKR3WRWdhDOuF/Y1esEYJE4LWHfCvgNQ+8WMN6MPTI6ZybsNCmrD1odL2ztLSgMIHHLHoM7GhWr0hz98uALhkDiNNx2ZP5Z+zMY+P+r8LIqiXDxnAZcltUuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RK4OR3JLvX1SMHTSbtLt2DYbZM3qwqdrASVRKl29YJE=;
 b=aT8+WRIRyvBH/J9pR1odsvDzxzfDr51FbCB+ehR2V2lgoMLVCGODzKeHr4xfHq25+q83S6Wubp0gnkFAFI5yMJtd3ckQV712qDkAhs+dO7lR46/krEqwe4RhER5t74nPYTwCUzpBAuWDfEVo3mUVyv22rOUwgXbpr6OvJ6mnL5AikANBTDGFTiPpMoZ/ymxftYZ86VrXKmAZvT4ma/ADCs14M4++TpZunyC+6kMxLgBYaC0rD6PzPs+S//CxNFZSok8ab6gDH7b0jZt5T/iM4gvq4mxa+ASKx4VMKVXMkOsgY8IKyBr/F7am5lC6sPmPmlLlPWR32EF6Lay6xEyhcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RK4OR3JLvX1SMHTSbtLt2DYbZM3qwqdrASVRKl29YJE=;
 b=CBBTzj3xtCLT+I18G3H+cGIczISbKN4CnYR4dr8bYIVTeEX/2JYiaqKLmVjWcfJ/6cWBLUtz33eXZUXEyswEbrvUfFE6cZ7vkBDZXRk948PuendDYpxJQPrTx9K7Dej72qoAs8DD3rot+1slbdiumQwqhHIK8Y0EaK9r1rDSnIJVKkXxEfsreQp2CDCtXDyiZ917oyJXgoPV6HRmUtyFhAhUMqSKtdMNhkrCPkDgOwnLSi+anhnU4p7ApImUsuu5WfBFbc2Utk9dPASYdKTMm3Ag8P1iJs3DkRZFJPJNlK+sGpRt3EOLw5amjQAur2lXzCstFMEzA1qErr1kntm5BA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10453.eurprd04.prod.outlook.com (2603:10a6:150:1d2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 19:57:58 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 19:57:58 +0000
Date: Wed, 2 Oct 2024 15:57:48 -0400
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
Message-ID: <Zv2lvPzCdxKNElkr@lizhi-Precision-Tower-5810>
References: <20240917192510.3031493-1-Frank.Li@nxp.com>
 <4bbee009-3985-4679-a85e-76f4259ff8d6@denx.de>
 <Zv2i73MvKASJA+2x@lizhi-Precision-Tower-5810>
 <ab75066d-31ae-4725-b524-9cf6720bc866@denx.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab75066d-31ae-4725-b524-9cf6720bc866@denx.de>
X-ClientProxiedBy: BYAPR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:40::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10453:EE_
X-MS-Office365-Filtering-Correlation-Id: c22ebde9-7311-4518-65a2-08dce31c8334
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sHmYSQ30yzQVSskbRXlkHs407hvWRwBQYOyx4eN8Iw/D20im8+G1ZqM7rDqJ?=
 =?us-ascii?Q?8gRN7D+XHwGwzlWroI4g8lqfVjrdRBkTymRbW3b6BAZROfgKizwZ5ZThNBSj?=
 =?us-ascii?Q?8C55RW0HluvKVEE4cM/hYWbfkJ6nh3fqUCpHyeK7oHb/jJ+K+gJG3RK8uU+x?=
 =?us-ascii?Q?Hy/wyftZdW/laQinXzERx8Ba00O5EJiFJjc+ha8suznM2JzpKOSXU6gzvELf?=
 =?us-ascii?Q?F1yeN7Wtm9VZi83/RS7YwlU7Wvv3R4HvV66Lc+ZM/7gw+XuB7JwiiEqO5kw9?=
 =?us-ascii?Q?LVOJxIoSql/qy8hS9v4YBum+vN2ySi4mrgtWpVpdvvKFr9Heif3Bj0laYDQk?=
 =?us-ascii?Q?6vwkYteqP8YgunMuq//yVIeq7U7Mec6ZkkH7EFEUZyFDmgDwDUAEdW+Dcz8N?=
 =?us-ascii?Q?OCzMiPbxdKKWDXDhtNlUc1CZxNt7KdQ0lckCJLlyqZ6FfxAO96zEaXsGqFfF?=
 =?us-ascii?Q?ULDlcHFrrgptriI59o8RtkIT8jAU7GjaYhsuVNMSUoXPygbRFWF9FK7ohfLE?=
 =?us-ascii?Q?+Wv6cDqGYWqR00ylyj8wpOPNPtH0g3fCMfSvB7/3lAuQh3DRpC93++VHeRyo?=
 =?us-ascii?Q?0yCwQTUpQacl0Lj70kMDOmmnwQEvt9wpMEZuQpF+WlsB+GD211KHzrChalxp?=
 =?us-ascii?Q?Ca5rYwuF7OPHYI0yFSm0WjjmsQ7SR8VYBFq149aIqeYef47VBTJTjiv/FBo1?=
 =?us-ascii?Q?xs90yYauHuUsVh2lFSs00idXJFqGon7HcZk9j2bItk0N7P/rDbkjigK4EdVI?=
 =?us-ascii?Q?LzPHWbi6Swgiy6vsXpYRBtll4siwknKSxiKNU5zUxnajP84G8hklHjcjgIm4?=
 =?us-ascii?Q?W9kGGpLuWrPdN1wDThK/ZCFr8kVlty04bhfeEl5KxVYt+sYBK5DfNbJF1Ow5?=
 =?us-ascii?Q?zM9BdU6ZgDrUmyZVpJeXVzq7DlhuNnYUbrDFR9721K8tgtrf0nESLqF/ltUX?=
 =?us-ascii?Q?r0U8Y4QLemGleJcr+sOgP5bBoFmZ3Or7fC9m9jSscmZy+Z8a2OMeBiDbK82I?=
 =?us-ascii?Q?VQuHAAobM2V+Js5YuEc4dQp/sVFdTsiq4DOlK4iOPYtVE+xZwULvI6AvaQP9?=
 =?us-ascii?Q?nr1DYywkf6uwXvM6i4o7Q8YiD2ROYqszFlSKVpYHtwvgzRKDNcQ8NK2cABq3?=
 =?us-ascii?Q?mwX55df0r9AublAbp5PWv08mFEsEJnc4N6CG4khcSWh4XfaHrJhy8PB4PTel?=
 =?us-ascii?Q?xc+2Ee2CSVtYeYkFscpSJJ17SYqjbHwYhDTlVCZ7jbl1EyD1mxaf6RMLOK1O?=
 =?us-ascii?Q?Fl3qmUPSspjg8OgTJpVMB7jo7h1IOhGvwhbVEEMCud2/mqfcrWMGEJ1ZsIXG?=
 =?us-ascii?Q?WYVY2d3CCTJNuMdrUB/uE7ehQZV95pBr4MIv2kZ+FOVxrA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tqj7OXDz6QOK/o6CRoB7HaZqfuPP5ok74pYiBQ+axL4NyjxenYd7i/WqE7g+?=
 =?us-ascii?Q?hB55kQymtGZ0KeHUzseW/eWFaEdqHjcH0g11voK0a7LsblLHx3rh3hW829kj?=
 =?us-ascii?Q?a5KH2pOr0aTE2ky7yC4XaEEALEojAs6MLsILS4CprlO9T1frnY5opPRvuOVA?=
 =?us-ascii?Q?mVhi1OqoTXDyi094mxTUabSbggmaz+1BhuZUHz9d4zK/2ZKhLpmLXy/naYNX?=
 =?us-ascii?Q?4IBIKzT5CbHR+mT7nyHGar48BTKEDPcql4eb9yGQ+Cgb9dFycRY0uluV6AHN?=
 =?us-ascii?Q?RDhrXbOtwoqKASYBUXz6vAz1NsVQVlqnchOYWldrJHdCdaOiTfMfMDQ/f+T6?=
 =?us-ascii?Q?mTOtHXW/bm41+qBYTEO1KX5aTEAl+DWzrvDU5EDZsQ5oRgVii3k78NpC5+h7?=
 =?us-ascii?Q?dhgmjY3BtBq8kuLvM2m9/LBhJE6EwTHlhCFj2/Y3B2/lO6LefAipG9dcMrkw?=
 =?us-ascii?Q?xLsOryw1gkNULTFv38KJ6bPbPsGFXIUm2gAxnu7FdTlKK5dh3muxQPEzhGgy?=
 =?us-ascii?Q?vtmc/o2HFtkdyqbM9fGN5FtV7bJ38/RziTXi29juSykHX4tjmuP+F/9eRMGV?=
 =?us-ascii?Q?vAtGk/mGLZOnFZXJinijzwzq8NJ9guAe07baPYKLQ7HvTaMGoIKsq2gZPFGF?=
 =?us-ascii?Q?GU6PUKF+wl+ocyDQdoJVTVZrn8nG2grvNLx6IayaGIpOyhE0jvslaHUoBJB9?=
 =?us-ascii?Q?VhLV1t804kcMCpUtuVZ7SKizfJeSPsrdaW+S6a8N61MVTPsH1HrWRvj5P5wl?=
 =?us-ascii?Q?GUrRnjMaKCvoY0W9bgMVsMiS5KrJpopRruQQhfi+uUiJ4gasUQyneG65BNp+?=
 =?us-ascii?Q?Ae7lqEeeFh6L9LLDRUm92cmUI3MoI86DewDLPC7v/mIBkfDhpJrh1k2s/Blp?=
 =?us-ascii?Q?bbnvuH/6J/Jp0Tr6uj17DiwWKM2q35jjJaK4wZiZr9dNgLWxme/CRbmax4PR?=
 =?us-ascii?Q?tvxunDiHcGnNiKjUcdkgi5Wjf85c3AKZcezmzRoTyxYZoOfoYYTHC2M+g+dA?=
 =?us-ascii?Q?Jh6M98O/Y2qHppeRfP6f+DjYiLKx6ak33y7yxAe26KftFY8dDDAw4DEkxOjQ?=
 =?us-ascii?Q?g24/cXUADfuXrNa+RbAgnxgrPpSqtMgUy/gJtgVkHVB/U7Wcq9GlJ2BPZbsb?=
 =?us-ascii?Q?WSnx6Vr0lbKlBe6IQbrzjCI1vzVtV7ufewnDU9xi1eOPp+zIrVDixQVJGYow?=
 =?us-ascii?Q?5eN5G7gDxsI1EIZLOo37YROt+zZaQGCxrfGQtU8hHy5vicrgLrSA0lIzZ4g0?=
 =?us-ascii?Q?iEm933VznIQNhFB6fLzxvcvuvug+dQoAPtYkziYX5UwXBVeS+mA2G8BCk1OE?=
 =?us-ascii?Q?o4dYulXtfWQghSmZFZXop3nI0WXRePEU+6wvZEOnlettYiZWwMmqMLRbHOxO?=
 =?us-ascii?Q?k9uJaDh+F1fcp/Rjv7NVV1qpndmRl72Wvf3vNliF7afUiitFnWtUuAebsLRY?=
 =?us-ascii?Q?Qln6LbU7DfPs9Niyu+xnDaHkaGXXaAYRlcUbVkGnzA0lP3KTwm+09zHAFVEQ?=
 =?us-ascii?Q?DkTtl4OIjVa8ktQUKBaOp+7J4dLw3kcb1uXHfv3EDw+z5Cjgdjn60Mp+Z9tb?=
 =?us-ascii?Q?JoN7wGrRXT1O/7u4Rp0xeVFdL3BcAskU/cfNeu80?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c22ebde9-7311-4518-65a2-08dce31c8334
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 19:57:58.1286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v2+w2ADRqSyS/1U3QB3crpi7F0iu79Qj6GyycPY/7nk9JUceS5y14ykALCW1bIBShF9Oowo0T+VkhYJpQ5w4dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10453

On Wed, Oct 02, 2024 at 09:48:12PM +0200, Marek Vasut wrote:
> On 10/2/24 9:45 PM, Frank Li wrote:
> > On Sun, Sep 22, 2024 at 10:28:02PM +0200, Marek Vasut wrote:
> > > Hi,
> > >
> > > On 9/17/24 9:25 PM, Frank Li wrote:
> > >
> > > [...]
> > >
> > > > @@ -223,6 +224,8 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > > >    	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
> > > >    	unsigned long long c;
> > > >    	unsigned long long clkrate;
> > > > +	unsigned long flags;
> > > > +	int val;
> > > >    	int ret;
> > > >    	u32 cr;
> > > > @@ -263,7 +266,69 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > >
> > > [...]
> > >
> > > > +	c = clkrate * 1500;
> > > > +	do_div(c, NSEC_PER_SEC);
> > > > +
> > > > +	local_irq_save(flags);
> > > > +	val = FIELD_GET(MX3_PWMSR_FIFOAV, readl_relaxed(imx->mmio_base + MX3_PWMSR));
> > >
> > > I think the multi-write I mentioned in v5 for > 500 kHz case could further
> > > improve the patch, let's see what others think:
> > >
> > > if (state->period < 2000) { /* 2000ns = 500 kHz */
> > >     /* Best effort attempt to fix up >500 kHz case */
> > >     udelay(6); /* 2us per FIFO entry, 3 FIFO entries written => 6 us */
> > >     writel_relaxed(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> > >     writel_relaxed(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> > >     /* Last write is outside, after this conditional */
> > > } else if (duty_cycles ...
>
> Can you have a look at this part ?

I can put here and it should be no harmful.

Frank

>
> > > > +	if (duty_cycles < imx->duty_cycle && val < MX3_PWMSR_FIFOAV_2WORDS) {
> > > > +		val = readl_relaxed(imx->mmio_base + MX3_PWMCNR);
> > > > +		/*
> > > > +		 * If counter is close to period, controller may roll over when
> > > > +		 * next IO write.
> > > > +		 */
> > >
> > > c is only used in this if (duty_cycles ...) { } conditional, the do_div()
> > > above can be moved here:
> >
> > It is in local_irq_save(flags) scope, it'd better as less as possible. So
> > I prefer do_div() is outside local_irq_save()
> Good point, either way is fine by me.

