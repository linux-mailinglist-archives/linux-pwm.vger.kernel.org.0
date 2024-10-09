Return-Path: <linux-pwm+bounces-3575-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DA099705A
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2024 18:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B893028182A
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2024 16:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6291F8915;
	Wed,  9 Oct 2024 15:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ide8S54K"
X-Original-To: linux-pwm@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2055.outbound.protection.outlook.com [40.107.22.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A751CDFDA;
	Wed,  9 Oct 2024 15:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728488294; cv=fail; b=u9h+HjllsQ/X8ZrDsKNb4FGlAPqUHyWomB7F85TfKhP2t+fBemKZDAEYSORsLOe4VN7m3e6Xcj0bXf7Kxa1DZ4rHcbBifvADTSsIsTAfrIfZ/9Mj9gvwBqt41wSqIQwRvu39bdndrIKSkqpu2S0YtYXFTKCxk5p0gLPii9WSY2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728488294; c=relaxed/simple;
	bh=atZUNAtNucVMjIq3Ut37OAJiw02VOvRDao/Yeh4nkjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ehUitAkuH7bJ8nAL9Qzs32V/HjdpIAsNm3NKGLXNDOeDZT9Xd6G76+7ompDGKCsJWyytrLCX8Z5u2U6BXD3FTmBR8Q23XMrqWHLrGZFEkXAqJkmvFiZvL6pKWsKLudvPOw2GRzoFV+e12klSL99qvLNyEyRLBbCK9TUNJUGpeTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ide8S54K; arc=fail smtp.client-ip=40.107.22.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gcJiSyWgmafhk07Uy8dXXPkN0gIKlHNRcOPIpmVxfQ+EFUOpUhyxasdTu0SRFpveSwrztYLMOUK9AvE29/l9vR3WOZOvTzadaIZ4xlA3XXMB9oEDRSsiLqhnhly9w8sTItQ5NVZRq+n45D3z5ztFx1HA8cPCjDv4pKWEhwKpJo/IXsYuoG+kgYjFoea8/bO9mKlABrpS88I9lkrtz6m0zPyGge4YBPzTzuGof3UbwOZeuHBFUQ8LoDwxWhgconh1dUoiUAAEsI8cJLE1cMWKp1jNShdAPUsOWlS7fvgI1tK9wf14djtpvryp7y6+KJlNuJ2CDhqVN+nYwiMTTv05oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0I2+EtTZRtkaqSItCgif93D6eHZqLS6bUIK48dZJtA=;
 b=a1R6lgLJBIiS0QvXIE2EWADX3cb616nHqrFj1yxQ0vxHWc77coM0NVCcRWOIQB9RJEvfBixk50qlYRY2pjG3pwe8vO8As32H1rRKEEoBgf/FKP8GJLZcYQHEOoqUifo5jxp9wYPlU+KTV9ULUV4P8nbGmhFjOVQ1RXSuBUzZvZ8ni3XsPqrhF4MsRhbpasCVAoExjtwYhnjbvPGbkOufV0XRFA1ZD26ROLv3xflLBEO0KCKznCIBKefHy4xeQ4fsPegoRKFcpzqenGwkKidzcV/NwEG3HCNO+Slb03bEng8eSOI+ouzl35OYqUgM4oo0WrtVETK5sF5M0ThjsRoxjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0I2+EtTZRtkaqSItCgif93D6eHZqLS6bUIK48dZJtA=;
 b=ide8S54KFzPvadrpkUPGNofZ5pHDbKgyWr90yoUWYw3Ct1yTjBilN20vTkSYjLFowtTLQ1Xd4wAiDl8sPhfFA79vMd/T62Q+MuByAqg0dmKoRynlqgwzygHuSXNYRb32s0UP7bCaYFI9x3ZtcTwaxsaVU+Sd7ymxnu/iGz1otMU+amRZtsM1YAqSVNGv5qjvhBGheB4kXX8fUgNNJZ/Sb0NoHXhEJmXiOMRrlG4X+t9zoQeO9Py1GecRZKaG8d4r9ab3wJpWrSP/8YL8zcZPLjjLUeurM2HG/Gxvzm6Pu9VhfupB2OFIpZtTmlH4XOVVtXXIaZseuBGMUBdehFwo7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7494.eurprd04.prod.outlook.com (2603:10a6:20b:23f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Wed, 9 Oct
 2024 15:38:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 15:38:08 +0000
Date: Wed, 9 Oct 2024 11:37:57 -0400
From: Frank Li <Frank.li@nxp.com>
To: Marek Vasut <marex@denx.de>
Cc: u.kleine-koenig@baylibre.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, festevam@gmail.com,
	francesco@dolcini.it, imx@lists.linux.dev, jun.li@nxp.com,
	kernel@pengutronix.de, krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, p.zabel@pengutronix.de,
	pratikmanvar09@gmail.com, robh@kernel.org, s.hauer@pengutronix.de,
	shawnguo@kernel.org, xiaoning.wang@nxp.com
Subject: Re: [PATCH v8 1/1] pwm: imx27: workaround of the pwm output bug when
 decrease the duty cycle
Message-ID: <ZwajVXRwDLDg2rc7@lizhi-Precision-Tower-5810>
References: <20241008194123.1943141-1-Frank.Li@nxp.com>
 <41cc47bd-f18f-463b-a0dc-843088ecf91e@denx.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41cc47bd-f18f-463b-a0dc-843088ecf91e@denx.de>
X-ClientProxiedBy: SJ0PR05CA0149.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7494:EE_
X-MS-Office365-Filtering-Correlation-Id: b8afb9b8-009a-4793-82ba-08dce8786016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J8Rv6lQfCqW6oWzGj6O7XRUhDJ6/a+T6/0wSped7suoLFT+w2xMjBCxqIf94?=
 =?us-ascii?Q?PNDs8+RMu06gs2JFsoS29lTGxw44yu9J5UnG3pDID9vbQkX5swA7QGmGflxs?=
 =?us-ascii?Q?LA4TFfVNrTPi8tXAULm7MmAg2JqgiMM2gA3c6yUpPuvID7Uats7PM7TlXHz1?=
 =?us-ascii?Q?jq1d8RhQQokABpXfmJtEQKBZu6YxkQgCJ9pnIHlMnExHC+ydE4RxNJB4IO89?=
 =?us-ascii?Q?7gXTvsyoXOBoQlJ4kbwNmTtOv91tXfRp1OqeGMkhSFVtnCZwZuLOlKdwSnZL?=
 =?us-ascii?Q?FIo7XkSYQunK68p7wxrnX0kDvwsDeGC6Izgg7GXZQ+lfWdW9Rx7xY8NVGZcZ?=
 =?us-ascii?Q?HkSZ3OkUh5iMljaizkRcQoE1iPXChokrT+oJIFZdmm99cUJkIzA44Xb9czCS?=
 =?us-ascii?Q?cQQQ1EMQz7+y8NMexxRNCBIbjIe/LsHH8R9MpJ3co5MpMb+mhlZqjLi37ILd?=
 =?us-ascii?Q?ff7TnZ38fh72QPj2/+4YGtZPfqVUv8MRkPIp5aPbZ790tR9ofBauL65pRhvh?=
 =?us-ascii?Q?wWec1rHKYFAC5cGY9aG4Sqr/QCK1hPU9yoxPXpQMbThGCWQwYumt1NPjz6GP?=
 =?us-ascii?Q?Qj1f/h4AwKJ5IsKnLa0ydrzCdTk4amvoFPCPmcA6bVkzFZAVpofLC2nnKHaZ?=
 =?us-ascii?Q?uuPCMo9MTZb507Hr3MyF75EsABAI+kxL8a5cLnU2uw2OJ0WW959lo07XIT1h?=
 =?us-ascii?Q?sxUTrYzipLYNd+3KnIEbtLRYt3D07ZSDQYcoMtwU8jqrX/Oqseg0VX5iUr+o?=
 =?us-ascii?Q?WzY5wEA6mhnwIyZVgEi7ZQ3yhnaVYey0FtexLq20mc6XxlKoTo8uCOnfxtdI?=
 =?us-ascii?Q?EO1eQridZzf/PnsorxErkQu6SccQEP9h9yfaee7q5jeP8afW0CC3CssWr3L0?=
 =?us-ascii?Q?R0C0tKcKTuBRDwSyAwcp3F0L1H3+2KUVK5R7hAu/PilqRGVtBs4/l7kGQWw8?=
 =?us-ascii?Q?JiB7XVBkUBRWcS33o/yUm9Q4W4/IAk4rFCpppJpG64s4oVuNy7m+NFOOjoLh?=
 =?us-ascii?Q?TEtlZdOhaajvTAjSGnqVTNTLm0mm3GUEfdksYLE1YSRQ3DD6sHAJ/ZcgItzi?=
 =?us-ascii?Q?qcYKOxmBLtowD6crnvgbsrLPtesyT7bqtWYki96X6oGiE55oO3aGOB+FtD3c?=
 =?us-ascii?Q?3ErInikDG2D0lKi2BoY9Gd16oh5G0roMLR4LDsk0MNCi/+1ehW/PyV0S2Tpp?=
 =?us-ascii?Q?AMe51dv16VvAFZ0cEHWiEZWhr0DgFjW8A3PiJjn5cPKZ8N7ZXUcubRgfSkeU?=
 =?us-ascii?Q?qGIZENRx82dHYHpjLY+pHmwXK0K37UCO+KZFX2USko0NDPeUdgUdQA4J7xB3?=
 =?us-ascii?Q?TmKG3tCHJlMKmv/JwJVSa/IThkLeYdq1CxjAmABc8cgMoQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M07kN22e0XzzQklgN2Gf3T9UBZxFSLLyyXUtTwn+cYEgxb9qwFbQZo6/lDVS?=
 =?us-ascii?Q?6aDjQHONd0/YYDBLlgpTFzipNRPnlwTNeeZKLZTJ5Pr7k9eL71BBqdiy+e/7?=
 =?us-ascii?Q?hkquqgwoM+ThIfOYqr8zJiN5+EbHw/lItJBtH71+69dmabVADwWFUcFivYl9?=
 =?us-ascii?Q?fHFcT9bbDpXQ/z+wt5imMl1UStp0UJ6D47ju1AAA2ySfgHyxR3PCqvqTmj1H?=
 =?us-ascii?Q?4nBP4g8VUWbURTEIEYbxFD6Xk2KUJGFxHFVgVEVKt/U439EuZx1vYNYcLnNR?=
 =?us-ascii?Q?IaPVq6cMImEB4txzegCtGI1qlvw+ZlioiBExOFOejz/XtLr06L1ghKtkm02H?=
 =?us-ascii?Q?TAz/LDg79HxY1uuDt8WamI0OWYcU393LDefFcpLCmg+5Fh5YIzGZQSrAcY6k?=
 =?us-ascii?Q?MTJ6mHgswTsPC82CxVYpl/iUA+aYq3X3NskdVtN111IO74yEKJooYGE96QN3?=
 =?us-ascii?Q?botmsOCWLip/bdfOI96sLCJz5MuDqHmYf83dUIBkkvEKew6Bgi9Tv+fwlqxz?=
 =?us-ascii?Q?6dQQ2TKq76VGglaX661NOqRQxyuqaRpRc7rLmNsDzL9Etg+d3TYMv6XK9EDY?=
 =?us-ascii?Q?oLzGi3xvByab4D6/SV2NO0fnwEwCbhL0gFLHv3IezmBtgarYVtiKCD4bG/7x?=
 =?us-ascii?Q?xxUBoJyQmrat5fXr3WZ2LnKViRAzZp98hZBV3zEgR8NrUjiubYxOvkJlc6VS?=
 =?us-ascii?Q?rJJvysbxummu7MuZO/poC5qfbWtiQi5D87Xkcoh2nSzrAoFmM5Us1Xa4FInu?=
 =?us-ascii?Q?jPWp/T6s3t6tN20WAefwy9DWk5hTtJ/B9IjK6sF+LOIfar0Sk9xTVk8kuiyc?=
 =?us-ascii?Q?iDeckThgX7p7bUMWv1bxr8CmgolE2i3VKjuPe9C3/wAEy26OG76B7STYBBiC?=
 =?us-ascii?Q?wpwfE35qMadr9tg/puRraXeU2IAGNNhxQZmrMF2mTkXaX+9qlaW615FtYRWf?=
 =?us-ascii?Q?fhmU3mWtuwAqDMYF4sROokayxkv+kTZoYk31tJ2Jhv1gQLUGO18FjOcQEZGY?=
 =?us-ascii?Q?6EGxfoW04vR5QfjMKVThJEfHfFOo0DbAvEub3kWWLSp4NQo3x7o8q8oI0+7x?=
 =?us-ascii?Q?XlhMDEmmMyCNScvBWwHxs/mgm91cGyOt5Nl5N++oLNqjnmvV2sN6DhVxtP3E?=
 =?us-ascii?Q?YN5Y5TKmtPP1cNxlMeM1K+dHewNPpFQl96tbeFoMfIM4/YDi4Cymj+Kh7zYQ?=
 =?us-ascii?Q?ZU+OVHhi2vlrLsi1lMQF44FFkGQIUNKmLVB2N9FWAxJ5f709xhFt+Lt3vWqE?=
 =?us-ascii?Q?jpmePNC9m1LF1JG5fHgpPsnf88at5F5Yk2mghMnrwwxjVAyy8fBbJyO4L8BM?=
 =?us-ascii?Q?ljqnP9vMtoB8pI9TrKYs6G0gPuZ3en0A2+V1ZuW5Ek2y8mTY5F/MPtDqAUv1?=
 =?us-ascii?Q?+zGQXMDPOhlWAydwN4fzZ0oEFvTSap7Czd8SwpP2hg/Mx0H7VlVBgJ0Rhksd?=
 =?us-ascii?Q?ZNWGqWljEgt5qzl+figktr23nsAOSnqFJU05XiO8LR559Prai6dUVP2GqTP4?=
 =?us-ascii?Q?EZu1cAKFRGmjICHyoODln7hIJrFlWhjMISkFxU3m5mZWyqp0k+hPTznjq8M3?=
 =?us-ascii?Q?Vo+eNOO/X6iWYY4M2ldlt4teXQAxXWjqDuQ7jzli?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8afb9b8-009a-4793-82ba-08dce8786016
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 15:38:08.7465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q0gJqYOAItslnv0mBPuESa/15cs5Kr0fqK7RWUs48xPbsYpKtSNtfNtHZ+1uRLhjCFtiHkGRL2VMwb1smce0ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7494

On Wed, Oct 09, 2024 at 03:55:35AM +0200, Marek Vasut wrote:
> On 10/8/24 9:41 PM, Frank Li wrote:
>
> [...]
>
> > +	c = clkrate * 1500;
> > +	do_div(c, NSEC_PER_SEC);
> > +
> > +	local_irq_save(flags);
> > +	val = FIELD_GET(MX3_PWMSR_FIFOAV, readl_relaxed(imx->mmio_base + MX3_PWMSR));
> > +
> > +	if (duty_cycles < imx->duty_cycle && (cr & MX3_PWMCR_EN)) {
>
> I think you can use state->enabled instead of (cr & MX3_PWMCR_EN).

state->enabled is new state. Need check old state here. If old state is
disable, needn't this workaround at all.

Frank

